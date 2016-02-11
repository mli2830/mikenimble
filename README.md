#This is a short test report and reproducible example of nimble glitches I ran into.

##Please follow these instructions to reproduce the glitches
- clone this repo

## Pointer problem 
Just run nimble_pointer.R any way you want

# FIXED(kinda)
## Hanging problem (DONE, just useConjugency=FALSE)

type "make nimble_hang.Rout
This will cause a hanging problem.

### Description:
I used an empty Jags model to "simulate/generate" data for this example via NA trick.
Initializing the nimble model is not a problem. The problem is it will hang when you want to do nimble MCMC stuff. Jags works fine via MCMCsuite.

# Inprod problem (DONE)
 
CPP inprod problem. I want to use matrix multiplication in the future, but if that doesn't work, I want to fall back to inprod. ATM, inprod doesn't work. It runs nicely if I expand it out myself. 

- make nimble_inprod.Rout (This will produce an error, but you can see the Rout via nimble_inprod.wrapR.rout) 
