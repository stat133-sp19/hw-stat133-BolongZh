context("tests for private auxiliary functions")

#test function aux_mean()
test_that("check if aux_mean() behaves as expected",{
  expect_equal(aux_mean(10,0.3),3)
  expect_equal(aux_mean(100,0),0)
  expect_true(is.numeric(aux_mean(3,0.1)))})

#test function aux_variance()
test_that("check if aux_variance() behaves as expected",{
  expect_equal(aux_variance(10,0.3),2.1)
  expect_equal(aux_variance(100,0),0)
  expect_true(is.numeric(aux_variance(3,0.1)))})

#test function aux_mode()
test_that("check if aux_mode() behaves as expected",{
  expect_equal(aux_mode(10,0.3),3)
  expect_equal(aux_mode(100,0),0)
  expect_equal(aux_mode(3,0.5),c(1,2))
  expect_length(aux_mode(5,0),1)})

#test function aux_skewness()
test_that("check if aux_skewness() behaves as expected",{
  expect_error(aux_skewness(10,1))
  expect_equal(aux_skewness(10,0.3), 0.4/sqrt(2.1))
  expect_error(aux_skewness(3,0))
  expect_length(aux_skewness(5,0.2),1)})

#test function aux_kurtosis()
test_that("check if aux_kurtosis() behaves as expected",{
  expect_error(aux_kurtosis(10,1))
  expect_equal(aux_kurtosis(10,0.3), (1-1.8*0.7)/2.1)
  expect_error(aux_kurtosis(3,0))
  expect_length(aux_kurtosis(5,0.2),1)})


