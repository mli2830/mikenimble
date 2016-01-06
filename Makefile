
### Hooks for the editor to set the default target
current: target
	 less nimblep1.wrapR.rout

target pngtarget pdftarget vtarget acrtarget: nimblep1.Rout

##################################################################


# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
# include stuff.mk
# include $(ms)/perl.def

##################################################################

## Content

jags.Rout:	params.R code.bug jags.sim.R
		$(run-R)

nimblep1.Rout:	jags.Rout nimcode.R nimblep1.R
		$(run-R)



######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include makestuff/git.mk
-include makestuff/visual.mk

 -include makestuff/wrapR.mk
 -include makestuff/oldlatex.mk


makestuff: 
	   git clone https://github.com/dushoff/makestuff.git