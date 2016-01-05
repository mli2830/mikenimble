require(nimble)
nimcode2 <- nimbleCode({
  # Dispersion
  repMean ~ dbeta(1,1)
  repShape ~ dgamma(1, 1)
  incShape ~  dgamma(1, 1)
    
  # Effective population size and response
  alpha ~ dgamma(1, 1)
  effProp ~ dbeta(1, 1)
  S[1] <- s0
    
  # Pre-observation and kernel
  for (j in 1:lag){
    ker[j] ~ dgamma(kerShape, lag*kerShape/kerMean)
    inc[j] ~ dnegbin(preExp, 1)
    S[j+1] <- S[j] - inc[j]
  }
    
  for (j in 1:max){
    foi[j] <- ((ker[1]*inc[j+4] + ker[2]*inc[j+3] + ker[3]*inc[j+2] + ker[4]*inc[j+1] + ker[5]*inc[j+0])*pow(S[lag+j]/S[1], -alpha) + foieps)/S[1]
    incMean[j] <- 1 - pow(1+foi[j]/kappa, -kappa) 
    inca[j] ~ dgamma(1, 1)
    incb[j] ~ dgamma(1, 1)
    inc[lag+j] ~ dbin(inca[j]/(inca[j]+incb[j]), S[lag+j])
      
    S[lag+j+1] <- S[lag+j] - inc[lag+j]
      
      # Observation process
      # rep[j] ~ dbeta(repShape/repMean, repShape/(1-repMean))
    repa[j] ~ dgamma(1, 1)
    repb[j] ~ dgamma(1, 1)
    obs[j] ~ dbin(repa[j]/(repa[j]+repb[j]), inc[lag+j])
  }
    
  R0 <- sum(ker[1:5])
  gtot <- inprod(lagvec[1:5], ker[1:5])
  gen <- (gtot/R0)
  })