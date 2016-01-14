# load variable definitions, data, etc.
L <- load('jags.RData')
source('nimcode.R', echo=TRUE) ## define NIMBLE model

namedList <- function (...) 
{
    L <- list(...)
    snm <- sapply(substitute(list(...)), deparse)[-1]
    if (is.null(nm <- names(L))) 
        nm <- snm
    if (any(nonames <- nm == "")) 
        nm[nonames] <- snm[nonames]
    setNames(L, nm)
}


nimdata <- list(obs=obs)
nimconstants <- namedList(lag
             ,foieps
             ,pop
             ,kappa
             ,numobs
             ,effRepHa
             ,effRepHb 
             ,hetShape
             ,hetMean
             ,Rshape 
             ,Rmean
             ,gpShape
             ,gpMean
             ,gsShape 
             ,gsMean
             ,preExp
             ,shapeH
             ,lagvec)

pre <- 1+obs[[1]]
niminits <- list(genPos = gpMean
                   , effRep = maxRep
                   , preInc = c(rep(pre, lag), 1+obs)
                   , repShape=1
                   , incShape=1
                   , alpha=1
                   , RRprop=0.5
                   , R0=1
                   , genShape=1
                   , obsMean=obs
)

suite <- function(type){
  mod <- MCMCsuite(code=nimcode
                  , data=nimdata
                  , inits=niminits
                  , constants=nimconstants
                  , MCMCs=type
                  , monitors=c("R0")
                  , calculateEfficiency=TRUE
                  , makePlot=FALSE
                  , savePlot=FALSE
                  , niter=iterations)
  return(mod)
}

mod1 <- suite(c('jags'))
print(mod1$summary)

#Jags work and initializing the model works, but nimble MCMC hangs
mod2 <- suite(c("jags","nimble"))
mod <- nimbleModel(code=nimcode
                   , constants = nimconstants
                   , data = nimdata
                   , inits = niminits)

#build and configure MCMC hangs

modconfig <- configureMCMC(mod)
modbuild <- buildMCMC(mod)


