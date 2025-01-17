data {
  int<lower=1> G;
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
  int<lower=0, upper=G> gg[N];
}
parameters {
  vector<lower=0>[I] alpha;     // discrimination for item i
  vector[I] beta;               // easiness for item i
  vector[G] theta_mu;
}
model {
  vector[N] eta;

  for (a in 1:G)
    theta_mu[a] ~ normal(0, 5);

  alpha ~ lognormal(0, 1);
  beta ~ normal(0, 2);

  for (n in 1:N)
    eta[n] = alpha[ii[n]] * theta_mu[gg[n]] + beta[ii[n]];
  y ~ bernoulli_logit(eta);
}

