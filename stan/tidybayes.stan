data {
  int<lower=1> n;
  int<lower=1> n_condition;
  int<lower=1, upper=n_condition> condition[n];
  real response[n];
}
parameters {
  real condition_mean[n_condition];
  real<lower=0> condition_sd[n_condition];
}
model {
  condition_mean ~ normal(0, 5);
  condition_sd ~ normal(3, 1);
  for (i in 1:n) {
    response[i] ~ normal(condition_mean[condition[i]], condition_sd[condition[i]]);
  }
}
