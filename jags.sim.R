require(R2jags)

set.seed(seed)
obs <- c(5,10,15,NA,NA,NA)
lag <- 2
lagvec <- 1:lag
effRepHa <- effRepHShape/(1-effRepHmean)
effRepHb <- effRepHShape/effRepHmean

preExp <- preMean/(lag+preMean)

numobs <- length(obs)

#creating the data/inits/ -----
## in jags, constants are also data
data <- list(obs=obs
            ,lag=lag
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
inits <- list(list(genPos = gpMean
              , effRep = maxRep
              , preInc = c(rep(pre, lag), 1+obs)
              , repShape=1
              , incShape=1
              , alpha=1
              , RRprop=0.5
              , R0=1
              , genShape=1
              , obsMean=c(obs)
              ))

params <- c("obs","R0")
mod <- jags(data=data,
            inits=inits,
            model.file="code.bug",
            n.chains = 1,
            param = params,
            n.iter=iterations)
print(mod)

obs <- round(mod$BUGSoutput$mean$obs)

save.image(file="jags.sim.RData")