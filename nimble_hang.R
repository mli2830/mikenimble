require(nimble)
load("jags.RData")
source("nimcode.R")

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

modxx <- nimbleModel(code=nimcode
                   , constants = nimconstants
                   , data = nimdata
                   , inits = niminits)

suite <- function(type){
  mod <- MCMCsuite(code=nimcode
                  , data=nimdata
                  , inits=niminits
                  , constants=nimconstants
                  , MCMCs=type
                  , monitors=c("R0")
                  , MCMCdefs = list(
                    mikenim = quote({
                      mcmcspec <- configureMCMC(modxx, useConjugacy = FALSE)
                      mcmcspec
                    })
                  )
                  , calculateEfficiency=TRUE
                  , makePlot=FALSE
                  , savePlot=FALSE
                  , niter=iterations)
  return(mod)
}

options(error=recover)
mod3 <- suite(c("mikenim"))
## select frame '27' (deepest level)

class(Robject)
## https://stevencarlislewalker.wordpress.com/s3-s4-dictionary/
ls(Robject)
fxnVecName ## [1] "model_node_nodeFxnVector_includeData_TRUE"
Robject[[fxnVecName]] ## Error during wrapup: object 'nodes' not found
fxnVecName %in% ls(Robject)  ## TRUE
for (i in ls(Robject)) {
    print(i)
    try(print(Robject[[i]]))
}

Robject[[fxnVecName]]$model$CobjectInterface$.nodeFxnPointers_byGID
Robject[[fxnVecName]]$model$CobjectInterface
Robject[[fxnVecName]]$model



mod1 <- suite(c('jags'))
print(mod1$summary)

#Jags work and initializing the model works, but nimble MCMC hangs
mod2 <- suite(c("jags","nimble_noConj"))



mod <- nimbleModel(code=nimcode
                   , constants = nimconstants
                   , data = nimdata
                   , inits = niminits)

#build and configure MCMC hangs

modconfig <- configureMCMC(mod, useConjugacy = FALSE)
modconfig$getSamplers()
modbuild <- buildMCMC(modconfig)

modbuild <- buildMCMC(mod, useConjugacy = FALSE)


# 
# modxx <- MCMCsuite(code=nimcode
#                  , data=nimdata
#                  , inits=niminits
#                  , constants=nimconstants
#                  , MCMCs=c("jags","mikenim")
#                  , MCMCdefs = list(
#                    mikenim = quote({
#                      mcmcspec <- configureMCMC(mod, useConjugacy = FALSE, onlySlice=TRUE)
#                      mcmcspec
#                    })
#                  )
#                  , monitors="R0"
#                  , calculateEfficiency=TRUE
#                  , makePlot=FALSE
#                  , savePlot=FALSE
#                  , niter=iterations)
