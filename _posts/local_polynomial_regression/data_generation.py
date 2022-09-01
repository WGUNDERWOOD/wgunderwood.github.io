import numpy as np


class Data:

  def __init__(self, n_train, n_test):

    self.n_train = n_train
    self.n_test = n_test


  def __repr__(self):

    desc_title = f"Data object for non-parametric regresssion"
    desc_n_train = "\nNumber of training samples: n_train = " + str(self.n_train)
    desc_n_test = "\nNumber of testing samples: n_test = " + str(self.n_test)

    desc = desc_title + desc_n_train + desc_n_test
    return desc


  def generate_x_deterministic(self, x_min, x_max):

    self.x_train = np.linspace(x_min, x_max, self.n_train)
    self.x_test = np.linspace(x_min, x_max, self.n_test)


  def generate_x_uniform_random(self, x_min, x_max):

    x_range = x_max - x_min
    x_train = x_min + (x_range * np.random.random(size=self.n_train))
    x_test = x_min + (x_range * np.random.random(size=self.n_test))

    self.x_train = np.sort(x_train)
    self.x_test = np.sort(x_test)


  def generate_mu_polynomial(self, coeffs):

    assert hasattr(self, "x_train"), "Must generate x values before mu values"

    n_coeffs = len(coeffs)
    monomials_train = np.zeros((self.n_train, n_coeffs))
    monomials_test = np.zeros((self.n_test, n_coeffs))

    for k in range(len(coeffs)):
      monomials_train[:,k] = self.x_train ** k
      monomials_test[:,k] = self.x_test ** k

    self.mu_train = np.sum(monomials_train * coeffs, axis=1)
    self.mu_test = np.sum(monomials_test * coeffs, axis=1)


  def generate_mu_topologist_sine_curve(self):

    x_min = min(np.amin(self.x_train), np.amin(self.x_test))
    x_max = max(np.amax(self.x_train), np.amax(self.x_test))
    x_range = x_max - x_min

    x_train_scaled = (self.x_train - x_min) / x_range
    x_test_scaled = (self.x_test - x_min) / x_range

    self.mu_train = 0.5 + 0.5 * np.sin((x_train_scaled+1)**6)
    self.mu_test = 0.5 + 0.5 * np.sin((x_test_scaled+1)**6)


  def generate_y_gaussian(self, sigma):

    self.eps_train = np.random.normal(scale=sigma, size=self.n_train)
    self.eps_test = np.random.normal(scale=sigma, size=self.n_test)

    self.y_train = self.eps_train + self.mu_train
    self.y_test = self.eps_test + self.mu_test


  def loo(self, index):

    loo_data = Data(self.n_train - 1, 1)

    loo_data.x_train = np.delete(self.x_train, [index])
    loo_data.mu_train = np.delete(self.mu_train, [index])
    loo_data.eps_train = np.delete(self.eps_train, [index])
    loo_data.y_train = np.delete(self.y_train, [index])

    loo_data.x_test = self.x_train[index]
    loo_data.mu_test = self.mu_train[index]
    loo_data.eps_test = self.eps_train[index]
    loo_data.y_test = self.y_train[index]

    return loo_data


  def k_fold(self, k_fold, index):

    np.random.seed(23049234)
    random_order = np.random.permutation(self.n_train)
    part_size = self.n_train // k_fold
    k_fold_partition = [i * part_size for i in range(k_fold)] + [self.n_train]
    k_fold_start = k_fold_partition[index]
    k_fold_end = k_fold_partition[index + 1]
    k_fold_n_train = self.n_train - (k_fold_end - k_fold_start)
    k_fold_n_test = k_fold_end - k_fold_start
    k_fold_test_indices = random_order[list(range(k_fold_start, k_fold_end))]

    k_fold_data = Data(k_fold_n_train, k_fold_n_test)

    k_fold_data.x_train = np.delete(self.x_train, k_fold_test_indices)
    k_fold_data.mu_train = np.delete(self.mu_train, k_fold_test_indices)
    k_fold_data.eps_train = np.delete(self.eps_train, k_fold_test_indices)
    k_fold_data.y_train = np.delete(self.y_train, k_fold_test_indices)

    k_fold_data.x_test = self.x_train[k_fold_test_indices]
    k_fold_data.mu_test = self.mu_train[k_fold_test_indices]
    k_fold_data.eps_test = self.eps_train[k_fold_test_indices]
    k_fold_data.y_test = self.y_train[k_fold_test_indices]

    return k_fold_data
