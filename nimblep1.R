
R version 3.2.2 (2015-08-14) -- "Fire Safety"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> require(R2jags)
Loading required package: R2jags
Loading required package: rjags
Loading required package: coda
Linked to JAGS 3.4.0
Loaded modules: basemod,bugs

Attaching package: ‘R2jags’

The following object is masked from ‘package:coda’:

    traceplot

> 
> set.seed(seed)
> obs <- c(5,10,15,NA,NA,NA)
> lag <- 2
> lagvec <- 1:lag
> effRepHa <- effRepHShape/(1-effRepHmean)
> effRepHb <- effRepHShape/effRepHmean
> 
> preExp <- preMean/(lag+preMean)
> 
> numobs <- length(obs)
> 
> #creating the data/inits/ -----
> ## in jags, constants are also data
> data <- list(obs=obs
+             ,lag=lag
+             ,foieps=foieps
+             ,pop=pop
+             ,kappa=kappa
+             ,numobs=numobs
+             ,effRepHa=effRepHa
+             ,effRepHb=effRepHb 
+             ,hetShape=hetShape
+             ,hetMean=hetMean
+             ,Rshape=Rshape 
+             ,Rmean=Rmean
+             ,gpShape=gpShape
+             ,gpMean=gpMean
+             ,gsShape=gsShape 
+             ,gsMean=gsMean
+             ,preExp=preExp
+             ,shapeH=shapeH
+             ,lagvec=lagvec)
> 
> pre <- 1+obs[[1]]
> inits <- list(list(genPos = gpMean
+               , effRep = maxRep
+               , preInc = c(rep(pre, lag), 1+obs)
+               , repShape=1
+               , incShape=1
+               , alpha=1
+               , RRprop=0.5
+               , R0=1
+               , genShape=1
+               , obsMean=c(obs)
+               ))
> 
> params <- c("obs","R0")
> mod <- jags(data=data,
+             inits=inits,
+             model.file="code.bug",
+             n.chains = 1,
+             param = params,
+             n.iter=iterations)
module glm loaded
Compiling model graph
   Resolving undeclared variables
   Allocating nodes
   Graph Size: 247

Initializing model

> print(mod)
Inference for Bugs model at "code.bug", fit using jags,
 1 chains, each with 1000 iterations (first 500 discarded)
 n.sims = 500 iterations saved
         mu.vect sd.vect   2.5%    25%    50%    75%  97.5%
R0         0.766   0.913  0.003  0.114  0.383  1.084  3.236
obs[1]     5.000   0.000  5.000  5.000  5.000  5.000  5.000
obs[2]    10.000   0.000 10.000 10.000 10.000 10.000 10.000
obs[3]    15.000   0.000 15.000 15.000 15.000 15.000 15.000
obs[4]    12.916  23.700  0.000  3.000  8.000 14.000 53.525
obs[5]    12.590  22.839  0.000  2.000  7.000 15.000 56.050
obs[6]    17.582  44.067  0.000  3.000  8.000 18.000 78.525
deviance  15.153   2.599 12.467 13.350 14.439 16.186 21.839

DIC info (using the rule, pD = var(deviance)/2)
pD = 3.4 and DIC = 18.5
DIC is an estimate of expected predictive error (lower deviance is better).
> 
> obs <- round(mod$BUGSoutput$mean$obs)
> 
> save.image(file="jags.sim.RData")
> 
> proc.time()
   user  system elapsed 
  0.544   0.024   0.576 
