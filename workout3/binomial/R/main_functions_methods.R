#' @title number of combinations
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k a vector indicating successes
#' @return \item{comb}{number of combinations}
#' @export
#' @examples
#' #calculate the number of combinations of 2 successes in 5 trials
#' bin_choose(n = 5, k = 2)
#'
#' #calculate the number of combinations of 0 successes in 5 trials
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)

bin_choose <- function(n,k){
  if (any(k>n)){
    stop("k cannot be greater than n")
  }
  else{
    comb <- factorial(n)/(factorial(k)*factorial(n-k))
    return(comb)
  }
}

#' @title probability of getting a given number of successes in a given number of trials
#' @description calculates probability of getting a given number of successes in a given number of trials
#' @param success a vector indicating successes
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return \item{bprob}{probability of getting a given number of successes in a given number of trials}
#' @export
#' @examples
#' # probability of getting 2 successes in 5 trials
#' #(assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#'
#' # probabilities of getting 2 or less successes in 5 trials
#' # (assuming prob of success = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#'
#' # 55 heads in 100 tosses of a loaded coin with 45% chance of heads
#' bin_probability(success = 55, trials = 100, prob = 0.45)

bin_probability <- function(success,trials,prob){
  check_trials(trials)
  check_success(success,trials)
  check_prob(prob)
  bprob <- bin_choose(trials,success)*(prob^success)*((1-prob)^(trials-success))
  return(bprob)
}

#' @title Binomial Distribution Function
#' @description creates a data frame of binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return \item{data}{a data.frame with two classes: c("bindis","data.frame")}
#' @export
#' @examples
#' # binomial probability distribution
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials,prob){
  successes <- 0:trials
  prob_v <- bin_probability(successes,trials,prob)
  data <- data.frame(success=successes,probability=prob_v)
  class(data) <- c("bindist","data.frame")
  return(data)
}

#  Method graphing probability histogram of binomial distribution object "bindis"
#' @export
#' @examples
#' # plotting binomial probability distribution
#' dis1 <- bin_distribution(trials = 5, prob = 0.5)
#' plot(dis1)
plot.bindist <- function(x){
  library(ggplot2)
  ggplot(data=x,aes(x=success,y=probability))+
    geom_histogram(stat="identity")+
    ggtitle("binomial probability distribution")+
    xlab("successes")+
    theme_bw()+
    scale_x_continuous(breaks=x$success)+
    scale_y_continuous(breaks=seq(0,ceiling(max(x$probability)),0.05))
}


#' @title Binomial Cumulative Function
#' @description creates a data frame of cumulative probability of binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return \item{data}{a data.frame with two classes: c("bincum","data.frame")}
#' @export
#' @examples
#' # binomial cumulative distribution
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials,prob) {
  successes <- 0:trials
  prob_v <- bin_probability(successes,trials,prob)
  prob_c <- c(prob_v[1])
  for (i in 2:length(prob_v)){
    prob_c[i] <- prob_v[i]+prob_c[i-1]
  }
  data <- data.frame(success=successes,probability=prob_v,cumulative=prob_c)
  class(data) <- c("bincum","data.frame")
  return(data)
}

#  Method graphing cumulative distribution histogram of binomial distribution object "bincum"
#' @export
#' @examples
#' # plotting binomial cumulative distribution
#' dis2 <- bin_cumulative(trials = 5, prob = 0.5)
#' plot(dis2)

plot.bincum <- function(x){
  library(ggplot2)
  ggplot(data=x,aes(x=success,y=cumulative))+
    geom_line()+
    geom_point(shape=1)+
    ggtitle("cumulative probability distribution")+
    xlab("successes")+
    ylab("probability")+
    theme_minimal()+
    scale_x_continuous(breaks=x$success)+
    scale_y_continuous(breaks=seq(0,1,0.2))
}

#' @title Binomial Random Variable Function
#' @description creates an object of binomial random variable
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return \item{binvar}{an object of class "binvar", that is, a binomial random variable object.}
#' @export
#' @examples
#' bin_variable(trials = 5, prob = 0.5)
bin_variable <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  binvar <- list(trials=trials,prob=prob)
  class(binvar) <- "binvar"
  return(binvar)
}

#  print object "binvar"
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' bin1
print.binvar <- function(x){
  cat('"Binomial variable"\n\n')
  cat("Parameters\n")
  cat("- number of trials: ",x$trials, "\n")
  cat("- prob of success: ",x$prob)
}

#  summarize an object "binvar"
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' summary(bin1)
summary.binvar <- function(x){
  ls <- list(
    trials=x$trials,
    prob=x$prob,
    mean=aux_mean(x$trials,x$prob),
    variance=aux_variance(x$trials,x$prob),
    mode=aux_mode(x$trials,x$prob),
    skewness=aux_skewness(x$trials,x$prob),
    kurtosis=aux_kurtosis(x$trials,x$prob)
  )
  class(ls) <- "summary.binvar"
  return(ls)
}

#  print the contents of an object "summary.binvar"
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' binsum1 <- summary(bin1)
#' binsum1
print.summary.binvar <- function(x){
  cat('"Summary Binomial"\n\n')
  cat("Parameters\n")
  cat("- number of trials: ",x$trials,"\n")
  cat("- prob of success: ",x$prob,"\n\n")
  cat("Measures\n")
  cat("- mean    : ",x$mean,"\n")
  cat("- variance: ",x$variance,"\n")
  cat("- mode    : ",x$mode,"\n")
  cat("- skewness: ",x$skewness,"\n")
  cat("- kurtosis: ",x$kurtosis)
}

#' @title Binomial Mean Function
#' @description computes the expected mean of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return computed mean of a binomial distribution
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mean <- aux_mean(trials,prob)
  return(mean)
}

#' @title Binomial Variance Function
#' @description computes the expected variance of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return computed variance of a binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  variance <- aux_variance(trials,prob)
  return(variance)
}

#' @title Binomial Mode Function
#' @description computes the expected mode of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return computed mode of a binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
bin_mode <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mode <- aux_mode(trials,prob)
  return(mode)
}

#' @title Binomial Skewness Function
#' @description computes the expected skewness of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return computed skewness of a binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  skewness <- aux_skewness(trials,prob)
  return(skewness)
}

#' @title Binomial Kurtosis Function
#' @description computes the expected kurtosis of a binomial distribution
#' @param trials number of trials
#' @param prob probability of success of individual trial
#' @return computed kurtosis of a binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  kurtosis <- aux_kurtosis(trials,prob)
  return(kurtosis)
}
