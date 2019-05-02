context("tests for main binomial functions")

#test function bin_choose()
test_that("check if bin_choose() behaves as expected",{
  expect_equal(bin_choose(3,2),3)
  expect_equal(bin_choose(4,0),1)
  expect_equal(bin_choose(4,0:1),c(1,4))
  expect_error(bin_choose(4,5))})

#test function bin_probability()
test_that("check if bin_probability() behaves as expected",{
  expect_equal(bin_probability(2,5,0.5),0.3125)
  expect_equal(bin_probability(0:2,5,0.5),c(0.03125,0.15625,0.31250))
  expect_equal(bin_probability(55,100,0.45),0.01075277)
  expect_error(bin_probability(99,2,0.3))
  expect_error(bin_probability(3,1.2,0.1))})

#test function bin_distribution()
test_that("check if bin_distribution() behaves as expected",{
  expect_equal(class(bin_distribution(1,1)),c("bindist","data.frame"))
  expect_type(bin_distribution(5,0.2),"list")
  expect_error(bin_distribution(4,-0.2))
  expect_length(bin_distribution(3,0.222),2)})

#test function bin_cumulative()
test_that("check if bin_cumulative() behaves as expected",{
  expect_equal(class(bin_cumulative(1,1)),c("bincum","data.frame"))
  expect_type(bin_cumulative(5,0.2),"list")
  expect_error(bin_cumulative(4,-0.2))
  expect_length(bin_cumulative(4,0.3),3)})



