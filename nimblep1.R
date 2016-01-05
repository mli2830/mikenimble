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


mod1 <- MCMCsuite(code=nimcode
                  , data=nimdata
                  , inits=niminits
                  , constants=nimconstants
                  , MCMCs=c("jags")
                  , monitors=c("R0")
                  , calculateEfficiency=TRUE
                  , niter=iterations)

print(mod1$summary)