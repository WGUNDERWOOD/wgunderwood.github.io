function make_xs(d) {
    let xs = math.zeros(d);
    for (let i = 0; i < d; i++) {
        xs.set([i], i / (d-1));
    }
    return xs.toArray();
}

function make_Sigma_OU(l, d) {
    let xs = make_xs(d);
    let Sigma = math.zeros(d, d);
    for (let i = 0; i < d; i++) {
        for (let j = 0; j < d; j++) {
            Sigma.set([i, j], math.exp(-math.abs(xs[i]-xs[j]) / l));
        }
    }
    return Sigma;
}

function make_Sigma_RBF(l, d) {
    let xs = make_xs(d);
    let Sigma = math.zeros(d, d);
    for (let i = 0; i < d; i++) {
        for (let j = 0; j < d; j++) {
            Sigma.set([i, j], math.exp(-((xs[i]-xs[j])**2) / (2*(l**2))));
        }
    }
    return Sigma;
}

function random_gaussian(Sigma) {

    let d = Sigma.size()[0];
    let ys = new Array(d);

    for (let j = 0; j < d; j++) {
        let u = Math.random();
        let v = Math.random();
        ys[j] = Math.sqrt(-2.0 * Math.log(u)) * Math.cos(2.0 * Math.PI * v);
    }

    zs = math.multiply(math.sqrt(Sigma), ys);
    return zs.toArray();
}

function resampleRBF(l, d) {
    let Sigma = make_Sigma_RBF(l, d);
    let ys = random_gaussian(Sigma);
    Plotly.restyle('plot_RBF', 'y', [ys]);
}

function resampleOU(l, d) {
    let Sigma = make_Sigma_OU(l, d);
    let ys = random_gaussian(Sigma);
    Plotly.restyle('plot_OU', 'y', [ys]);
}
