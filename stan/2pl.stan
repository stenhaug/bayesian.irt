data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
}
parameters {
  vector<lower=0>[I] alpha;     // discrimination for item i
  vector[I] beta;               // easiness for item i
  vector[J] theta;              // ability for person j
}
model {
  vector[N] eta;
  alpha ~ lognormal(0, 2);
  beta ~ normal(0, 2);
  theta ~ normal(0, 1); // could replace with boxed uniform like JMLE
  for (n in 1:N)
    eta[n] = alpha[ii[n]] * theta[jj[n]] + beta[ii[n]];
  y ~ bernoulli_logit(eta);
}

