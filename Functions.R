# maak functie die random gecorreleerde data genereert en de correlatie opslaat
CreatePearson <- function(N = 1000, rho=0.6) {
    x <- matrix(c(1, rho,
                  rho, 1), nrow=2, ncol=2, byrow=T)
    nobs = N
    nvars = 2
    
    L <- chol(x)
    r <- t(L) %*% matrix(rnorm(nobs*nvars), nrow=nvars, ncol=nobs)
    r <- t(r)
    rdata <- as.data.frame(r)
    names(rdata) <- c("x","y")
    cor(rdata$x, rdata$y)
    }

# maak functie herhaaldelijk gegenereerde correlaties samenvoegt in een datatabel
SamplePearson <- function(reps=1000, N =1000, rho=0.6){
  sapply(1:reps, function(reps){CreatePearson(N, rho)})
}

# maak functie die een voorbeeld dataset maakt, zoals bij CreatePearson, 
# maar dan als voorbereiding op de scatterplot
MeanPearsonData <- function(rho=0.6, N = 1000) {
  x <- matrix(c(1, rho,
                rho, 1), nrow=2, ncol=2, byrow=T)
  nobs = N
  nvars = 2
  
  L <- chol(x)
  r <- t(L) %*% matrix(rnorm(nobs*nvars), nrow=nvars, ncol=nobs)
  r <- t(r)
  rdata <- as.data.frame(r)
  names(rdata) <- c("x","y")
  return(rdata)
}

# code om bovenstaande functies te testen
#M <- SamplePearson()
#hist(M, prob=T)
#lines(density(M))

