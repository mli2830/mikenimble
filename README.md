##This is a short test report and reproducible example of nimble glitches I ran into.

#Please follow these instructions to reproduce the glitches
- clone this repo
- make (make makestuff into current repo)

# Hanging problem
I used an empty Jags model to "simulate/generate" data for this example via NA trick.
Initializing the nimble model is not a problem. The problem is it will hang when you want to do nimble MCMC stuff. Jags works fine via MCMCsuite.
- make nimble_hang.Rout (This will hang, but you can see what is going on in nimble_hang.wrapR.rout while it hangs)

# Inprod problem 
CPP inprod problem. I want to use matrix multiplication in the future, but if that doesn't work, I want to fall back to inprod. ATM, inprod doesn't work. It runs nicely if I expand it out myself. 

- make nimble_inprod.Rout (This will produce an error, but you can see the Rout via nimble_inprod.wrapR.rout) 
