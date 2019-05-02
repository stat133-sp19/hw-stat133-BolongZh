library(binomial)
library(testthat)
context("tests for private checker functions")

#test function check_prob()
test_that("check if check_prob() behaves as expected",{
  expect_true(check_prob(0.3))
  expect_error(check_prob(-0.777))
  expect_error(check_prob(c(0.1,0.1)))
  expect_error(check_prob("one"))})

#test function check_trials
test_that("check if check_trials() behaves as expected",{
  expect_true(check_trials(4))
  expect_error(check_trials(-2))
  expect_error(check_trials(2.2))
  expect_error(check_trials(0))})

#test function check_success
test_that("check if check_success() behaves as expected",{
  expect_true(check_success(c(1,2),4))
  expect_true(check_success(3,5))
  expect_error(check_success(1.1,4))
  expect_error(check_success(c(4,5,7),3))})

