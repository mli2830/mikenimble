require(nimble)

nimdata <- list(obs=obs)
nimconstants <- list(lag=lag
             ,foieps=foieps
             ,pop=pop
             ,kappa=kappa
             ,numobs=numobs
             ,effRepHa=effRepHa
             ,effRepHb=effRepHb 
             ,hetShape=hetShape
             ,hetMean=hetMean
             ,Rshape=Rshape 
             ,Rmean=Rmean
             ,gpShape=gpShape
             ,gpMean=gpMean
             ,gsShape=gsShape 
             ,gsMean=gsMean
             ,preExp=preExp
             ,shapeH=shapeH
             ,lagvec=lagvec)

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
