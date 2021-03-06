## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(binomial)

## ------------------------------------------------------------------------
bin_choose(n = 5, k = 2)
bin_choose(5, 0)
bin_choose(5, 1:3)

## ------------------------------------------------------------------------
# 55 heads in 100 tosses of a loaded coin with 45% chance of heads
bin_probability(success = 55, trials = 100, prob = 0.45)
# probability of getting 2 successes in 5 trials
# (assuming prob of success = 0.5)
bin_probability(success = 2, trials = 5, prob = 0.5)
# probabilities of getting 2 or less successes in 5 trials
# (assuming prob of success = 0.5)
bin_probability(success = 0:2, trials = 5, prob = 0.5)

## ------------------------------------------------------------------------
# binomial probability distribution
bin_distribution(trials = 5, prob = 0.5)

## ---- fig.show='hold'----------------------------------------------------
# plotting binomial probability distribution
dis1 <- bin_distribution(trials = 5, prob = 0.5)
plot(dis1)

## ------------------------------------------------------------------------
# plotting binomial cumulative distribution
dis2 <- bin_cumulative(trials = 5, prob = 0.5)
plot(dis2)

## ------------------------------------------------------------------------
bin1 <- bin_variable(trials = 10, p = 0.3)
bin1

## ------------------------------------------------------------------------
bin1 <- bin_variable(trials = 10, p = 0.3)
binsum1 <- summary(bin1)
binsum1

## ------------------------------------------------------------------------
bin_mean(10, 0.3)
bin_variance(10, 0.3)
bin_mode(10, 0.3)
bin_skewness(10, 0.3)
bin_kurtosis(10, 0.3)

