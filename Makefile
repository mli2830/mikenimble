
current: target
	 less nimblep1.Rout

target:	 nimblep1
##################################################################

jags.sim:	params.R code.bug jags.sim.R
		R CMD BATCH params.R
		R CMD BATCH jags.sim.R

nimblep1:  jags.sim jags.sim.RData nimcode.R nimblep1.R
		R CMD BATCH nimcode.R
		R CMD BATCH nimblep1.R



######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

 -include $(ms)/wrapR.mk
 -include $(ms)/oldlatex.mk

makestuff:	
		git clone https://github.com/dushoff/makestuff.git