data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n

  int<lower=0, upper=1> last[N];   // did that person get the last item correct
}
parameters {
  real boost;
  vector[I] beta;               // easiness for item i
  vector[J] theta;              // ability for person j
}
transformed parameters {
  vector[I] betareal;
  real tmp_sum;
  tmp_sum = 0;
    for(k in 1:I) {
      tmp_sum = tmp_sum + beta[k];
    }
    for(k in 1:I) {
      betareal[k] = beta[k] - tmp_sum/I;
    }
}
model {
  vector[N] eta;

  boost ~ normal(1, 2);
  beta ~ normal(0, 1);
  theta ~ normal(0, 1);

  for (n in 1:N)
    if (last[n] == 1 && ii[n] == 10)
      eta[n] = boost;
    else
      eta[n] = betareal[ii[n]] + theta[jj[n]];
  y ~ bernoulli_logit(eta);
}
