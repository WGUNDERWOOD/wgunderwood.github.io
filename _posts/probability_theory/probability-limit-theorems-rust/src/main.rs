extern crate rand;
extern crate rand_chacha;
use rand::prelude::*;
//use rand_chacha::ChaCha8Rng;

fn main() {
    //let mut rng = ChaCha8Rng::seed_from_u64(314159);
    let mut rng = thread_rng();
    let n: usize = 1000;

    let xs = get_xs(n, &mut rng);
    let xbars = get_xbars(&xs);
    let llns = get_llns(&xbars);

    println!("{:?}", xs);
    println!("{:?}", xbars);
    println!("{:?}", llns);
    //println!("{:?}", xbars[xbars.len() - 1]);
}

fn get_xs(n: usize, rng: &mut ThreadRng) -> Vec<f64> {

    let mut xs = vec![0f64; n];

    for i in 0..n {
        xs[i] = rng.gen_range(0..2) as f64;
    }

    return xs;
}

fn get_xbars(xs: &Vec<f64>) -> Vec<f64> {

    let n = xs.len();
    let mut xbars = vec![0f64; n];
    xbars[0] = xs[0];

    for i in 1..n {
        xbars[i] = (i as f64 * xbars[i - 1] + xs[i]) / (i + 1) as f64;
    }

    return xbars;
}

fn get_llns(xbars: &Vec<f64>) -> Vec<f64> {

    let n = xbars.len();
    let mut llns = vec![0f64; n];

    for i in 1..n {
        llns[i] = xbars[i] - 0.5
    }

    return llns;
}
