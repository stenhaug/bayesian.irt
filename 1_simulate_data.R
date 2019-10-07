# all items will have difficulty 0 and discrimination 1.
# the first 9 items will be as usual.
# the order dependence comes from students
# who got the 9th item correct get a 1-unit boost to their ability
# for the 10th item

# setup
library(tidyverse)
library(mirt)
set.seed(1)
n_students <- 1000
dim <- 1
n_items <- 9

# simulate
pars <-
    tibble(
        a1 = rlnorm(n_items * dim, 0, 1),
        d = rnorm(n_items)
    )

full <-
    simdata(
        a = matrix(pars$a1, nrow = n_items, ncol = dim),
        d = matrix(pars$d, ncol = 1),
        guess = rep(0, n_items),
        N = n_students,
        mu = 0,
        sigma = diag(dim),
        itemtype = rep("3PL", n_items),
        returnList = TRUE
    )

# output
pars %>%
    write_rds("data-simulated/1_pars.rds")

full %>%
    write_rds("data-simulated/1_full.rds")

full$data %>%
    as_tibble() %>%
    janitor::clean_names() %>%
    write_rds("data-simulated/1_data.rds")
