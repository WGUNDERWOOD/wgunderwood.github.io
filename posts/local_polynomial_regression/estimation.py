import numpy as np
from scipy import linalg

import data_generation as dg


class PolynomialRegression:

    def __init__(self, degree, verbose=False):

        self.verbose = verbose
        self.degree = degree


    def fit(self, data):

        assert isinstance(data, dg.Data)

        self.n_train = data.n_train
        self.n_test = data.n_test
        self.x_train = data.x_train
        self.x_test = data.x_test
        self.y_train = data.y_train
        self.y_test = data.y_test

        X_train = np.ones((data.n_train, 1 + self.degree))
        X_test = np.ones((data.n_test, 1 + self.degree))

        for k in range(self.degree):
            X_train[:,k+1] = (data.x_train/3)**(k+1)
            X_test[:,k+1] = (data.x_test/3)**(k+1)

        beta_hat = linalg.pinv(X_train.T @ X_train) @ X_train.T @ data.y_train

        self.fitted_train = X_train @ beta_hat
        self.fitted_test = X_test @ beta_hat





class LocalRegression:

    def __init__(self, kernel, bandwidth, degree,
                 verbose=False):

        assert isinstance(kernel, str)
        assert bandwidth > 0
        assert isinstance(degree, int)
        assert degree >= 0

        self.kernel = kernel
        self.bandwidth = bandwidth
        self.degree = degree
        self.verbose = verbose


    def __eval_kernel_points(self, points):

        if self.kernel == "epanechnikov":
            values = 3 * (1 - points**2) / 4
            return np.maximum(values, 0)

        if self.kernel == "gaussian":
            return np.exp(-points**2 / 2) / np.sqrt(2 * np.pi)


    def fit_single_point(self, eval_point):

        centered_data = self.x_train - eval_point
        centered_scaled_data = centered_data / self.bandwidth

        X = np.zeros((self.n_train, self.degree + 1))
        for k in range(self.degree + 1):
          X[:,k] = centered_scaled_data ** k

        kernel_weights = self.__eval_kernel_points(centered_scaled_data) / self.bandwidth
        W = np.diag(kernel_weights)

        e1 = np.array([1] + self.degree * [0]).T
        hat_matrix = e1 @ np.linalg.pinv(X.T @ W @ X) @ X.T @ W
        fitted_value = hat_matrix @ self.y_train

        return fitted_value


    def fit(self, data):

        assert isinstance(data, dg.Data)

        self.n_train = data.n_train
        self.n_test = data.n_test
        self.x_train = data.x_train
        self.x_test = data.x_test
        self.y_train = data.y_train
        self.y_test = data.y_test

        fit_many_points = np.vectorize(self.fit_single_point)
        self.fitted_train = fit_many_points(self.x_train)
        self.fitted_test = fit_many_points(self.x_test)


    def diagnose(self):

        assert hasattr(self, "fitted_train"), "Must fit model before diagnosis"

        self.errors_train = self.y_train - self.fitted_train
        self.errors_test = self.y_test - self.fitted_test

        self.mse_train = np.sum(self.errors_train**2) / self.n_train
        self.mse_test = np.sum(self.errors_test**2) / self.n_test

        if self.mse_train > 0:
            self.log_mse_train = np.log10(self.mse_train)
        else:
            self.log_mse_train = -np.inf

        if self.mse_test > 0:
            self.log_mse_test = np.log10(self.mse_test)
        else:
            self.log_mse_test = -np.inf




    def fit_mse(self, data, num_bandwidths, search_orders):

        self.get_bandwidths(self.bandwidth, num_bandwidths, search_orders)
        mses = np.zeros(num_bandwidths)

        for r, bandwidth in enumerate(self.bandwidths):

            self.bandwidth = bandwidth

            if self.verbose:
                print(f"Trying bandwidth of {round(bandwidth, 5)}")

            try:
                self.fit(data)
                self.diagnose()
                mses[r] = self.mse_train

            except np.linalg.LinAlgError:
                print("Singular matrix")
                mses[r] = np.inf

            if self.verbose:
                print(f"MSE of {round(mses[r], 5)}")

        self.mses = mses
        self.bandwidth = self.bandwidths[np.argmin(mses)]
        self.fit(data)



    def fit_loo_cv(self, data, num_bandwidths, search_orders):

        self.get_bandwidths(self.bandwidth, num_bandwidths, search_orders)
        loo_cv_mses = np.zeros(num_bandwidths)

        for r, bandwidth in enumerate(self.bandwidths):

            self.bandwidth = bandwidth
            loo_cv_individual_mses = np.zeros(data.n_train)

            if self.verbose:
                print(f"Trying bandwidth of {round(bandwidth, 5)}")

            for i in range(data.n_train):

                loo_data = data.loo(i)

                self.fit(loo_data)
                self.diagnose()
                loo_cv_individual_prediction = self.fit_single_point(data.x_train[i])
                loo_cv_individual_mses[i] = (loo_cv_individual_prediction - data.y_train[i])**2

            loo_cv_mses[r] = np.mean(loo_cv_individual_mses)

            if self.verbose:
                print(f"LOO-CV MSE of {round(loo_cv_mses[r], 5)}")

        self.loo_cv_mses = loo_cv_mses
        self.bandwidth = self.bandwidths[np.argmin(loo_cv_mses)]

        if self.verbose:
            print(f"LOO-CV optimal bandwidth of {round(self.bandwidth, 5)}")

        self.fit(data)


    def get_bandwidths(self, bandwidth, num_bandwidths, search_orders):

        lower_log_bandwidth = np.log10(bandwidth) - search_orders
        upper_log_bandwidth = np.log10(bandwidth)
        self.bandwidths = np.logspace(lower_log_bandwidth, upper_log_bandwidth, num_bandwidths)


    def fit_k_fold_cv(self, data, num_bandwidths, search_orders, k_fold):

        self.get_bandwidths(self.bandwidth, num_bandwidths, search_orders)
        k_fold_cv_mses = np.zeros(num_bandwidths)

        for r, bandwidth in enumerate(self.bandwidths):

            self.bandwidth = bandwidth
            k_fold_cv_individual_mses = np.zeros(data.n_train)

            if self.verbose:
                print(f"Trying bandwidth of {round(bandwidth, 5)}")

            for i in range(k_fold):

                k_fold_data = data.k_fold(k_fold, i)

                try:
                    self.fit(k_fold_data)
                    self.diagnose()
                    k_fold_cv_individual_mses[i] = self.mse_train

                except np.linalg.LinAlgError:
                    k_fold_cv_individual_mses[i] = np.inf


            k_fold_cv_mses[r] = np.mean(k_fold_cv_individual_mses)

            if self.verbose:
                print(f"k-FOLD-CV MSE of {round(k_fold_cv_mses[r], 5)}")

        self.k_fold_cv_mses = k_fold_cv_mses
        self.bandwidth = self.bandwidths[np.argmin(k_fold_cv_mses)]
        self.fit(data)
