data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n

  int<lower=0, upper=1> last[N];   // correctness for n - 1
}
parameters {
  vector[I - 1] boost;
  vector[I] beta;               // easiness for item i
  vector<lower=0>[I] alpha;     // discrimination for item i
  vector[J] theta;              // ability for person j
}
model {
  vector[N] eta;

  beta ~ normal(0, 1);
  alpha ~ lognormal(0, 1);
  theta ~ normal(0, 1);
  boost ~ normal(0, 1);

  for (n in 1:N)
    if (last[n] == 1 && ii[n] >= 2)
      eta[n] = beta[ii[n]] + alpha[ii[n]] * (theta[jj[n]] + boost[ii[n] - 1]);
    else
      eta[n] = beta[ii[n]] + alpha[ii[n]] * theta[jj[n]];
  y ~ bernoulli_logit(eta);
}

