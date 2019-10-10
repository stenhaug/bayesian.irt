data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
}
parameters {
  real mu_beta;
  real<lower=0> sd_beta;

  vector[I] beta;               // easiness for item i
  vector<lower=0>[I] alpha;     // discrimination for item i
  vector[J] theta;              // ability for person j
}
model {
  vector[N] eta;

  mu_beta ~ normal(0, 3);
  sd_beta ~ normal(1, 3);

  beta ~ normal(mu_beta, sd_beta);
  alpha ~ lognormal(0, 2);
  theta ~ normal(0, 1);

  for (n in 1:N)
    eta[n] = alpha[ii[n]] * theta[jj[n]] + beta[ii[n]];
  y ~ bernoulli_logit(eta);
}

