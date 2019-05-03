#private auxiliary function testing if an input prob is a valid probability value (i.e. 0<=p<=1)
check_prob <- function(prob){
  if (is.numeric(prob)==TRUE){
    if ((prob<=1)&&(prob>=0)&&(length(prob)==1)){
      return(TRUE)
    }
    stop("invalid probability value")
  }
  else{
    stop("invalid probability value")
  }
}


#private auxiliary function testing if an input trials is a valid value for number of trials (i.e n is a non-negative integer)
check_trials <- function(trials){
  if ((trials>0) & (trials%%1==0)){
    return(TRUE)
  }
  else{
    stop("invalid trials value")
  }
}


#private auxiliary function testing if an input success is a valid value for number of successes (i.e. 0<=k<=n)
check_success <- function(success,trials){
  if (all((success>=0) & (success<=trials) & (success%%1==0))){
    return(TRUE)
  }
  else if(any(success>trials)) {
    stop("success cannot be greater than trials")
  }
  else{
    stop("invalid success value")
  }
}
