iterations <- 4000

# Reporting and effective population hyper-parameters
repHmean <- 0.5
repHShape <- 2.5
effPropHmean <- 0.5
effPropHShape <- 1.5
hetShape <- 1
hetMean <- 0.1

# shape for the broad gammas underlying the beta-binomials
shapeH <- 0.1

# Shape for the kernel priors and mean of their _sum_ (R0)
kerShape <- 0.1
kerMean <- 1

# Prior on mean cases in the pre-reporting period (these cause the first observed cases)
preMean <- 3

pop <- 6e6
foieps <- 0.001
kappa <- 3

mult <- 1:4
maxRep <- 0.75


repHa <- repHShape/(1-repHmean)
repHb <- repHShape/repHmean

effPropHa <- effPropHShape/(1-effPropHmean)
effPropHb <- effPropHShape/effPropHmean

preExp <- preMean/(lag+preMean)


