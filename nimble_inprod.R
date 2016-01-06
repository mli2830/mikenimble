require(nimble)

set.seed(2112)
max <- length(obs)
lag <- 5
lagvec <- 1:lag

nimdata2 <- list(obs=obs)
nimconstants2 <- list(max=max
                      , lag=lag
                      , lagvec=lagvec
                      , foieps=foieps
                      , kappa=kappa
                      , preExp=preExp
                      , kerShape=kerShape
                      , kerMean=kerMean
                      , s0 = round(pop*0.5)
)
pre <- 1+obs[[1]]
niminits2 <- list(repMean = 1
                 , repShape = 1
                 , incShape = 1
                 , effProp = 0.5
                 , ker = rep(0.2,5)
                 , inc = c(rep(pre,lag),obs+1)
                 , inca = rep(1,max)
                 , incb = rep(1,max)
                 , repa = rep(1,max)
                 , repb = rep(1,max)
                 , alpha=1
)

noinprodmod <- MCMCsuite(code = nimcode22
                         , data = nimdata2
                         , inits = niminits2
                         , constants = nimconstants2
                         , MCMCs=c("jags","nimble")
                         , monitors=c("alpha")
                         , calculateEfficiency=TRUE
                         , niter=iterations
                         , debug=FALSE
                         , makePlot = FALSE
                         , savePlot = FALSE
)

print(noinprodmod$summary)

inprodmod <- MCMCsuite(code = nimcode2
                       , data = nimdata2
                       , inits = niminits2
                       , constants = nimconstants2
                       , MCMCs=c("jags","nimble")
                       , monitors=c("alpha")
                       , calculateEfficiency=TRUE
                       , niter=iterations
                       , debug=FALSE
                       , makePlot = FALSE
                       , savePlot = FALSE
)

noinprodmod <- MCMCsuite(code = nimcode22
                       , data = nimdata2
                       , inits = niminits2
                       , constants = nimconstants2
                       , MCMCs=c("jags","nimble")
                       , monitors=c("alpha")
                       , calculateEfficiency=TRUE
                       , niter=iterations
                       , debug=FALSE
                       , makePlot = FALSE
                       , savePlot = FALSE
)
