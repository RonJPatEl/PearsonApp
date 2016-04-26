CreatePearson <- function(rho=0.6) {
    x <- matrix(c(1, rho,
                  rho, 1), nrow=2, ncol=2, byrow=T)
    nobs = 1000
    nvars = 2
    
    L <- chol(x)
    r <- t(L) %*% matrix(rnorm(nobs*nvars), nrow=nvars, ncol=nobs)
    r <- t(r)
    rdata <- as.data.frame(r)
    names(rdata) <- c("x","y")
    cor(rdata$x, rdata$y)
    }

SamplePearson <- function(reps=1000, rho=0.6){
  sapply(1:reps, function(reps){CreatePearson(rho)})
}

# code om bovenstaande functies te testen
#M <- SamplePearson()
#hist(M, prob=T)
#lines(density(M))

