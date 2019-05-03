#private auxiliary function calculating the mean value given the number of trials and probability
aux_mean <- function(trials,prob){
  result <- trials*prob
  return(result)
}


#private auxiliary function calculating the variance given the number of trials and probability
aux_variance <- function(trials,prob){
  result <- trials*prob*(1-prob)
  return(result)
}


#private auxiliary function calculating the mode given the number of trials and probability
aux_mode <- function(trials,prob){
  momo <- (trials+1)*prob
  if ((prob>0)&&(prob<1)&&(round(momo)==momo)){
    result <- c((trials+1)*prob-1,(trials+1)*prob)
  }
  else{
    result <- trunc(trials*prob+prob)
  }
  return(result)
}


#private auxiliary function calculating the skewness given the number of trials and probability
aux_skewness <- function(trials,prob){
  if ((prob==0)|(prob==1)){
    stop("skewness is undefined")
  }
  else{
    result <- (1-2*prob)/sqrt(trials*prob*(1-prob))
    return(result)
  }
}


#private auxiliary function calculating the kurtosis given the number of trials and probability
aux_kurtosis <- function(trials,prob){
  if ((prob==0)|(prob==1)){
    stop("kurtosis is undefined")
  }
  else{
    result <- (1-6*prob*(1-prob))/(trials*prob*(1-prob))
    return(result)
  }
}

