# Estimate ICCs from lmer models
R convenience function to estimate intra-class correlations (ICCs) from linear mixed-effect models (supports [lme4](https://cran.r-project.org/web/packages/lme4/index.html) package).

Usage:

    estICC(model)
  
 where **model** is an lmer object. Returns a vector of variance components and ICC estimates. R code includes an example. 
 
 See the [companion paper](https://code.sallyxie.org/files/2019_XieHehmanFlake_JPSP_PerceiverTargetImpressionsRaceGender.pdf) and [our tutorial](https://code.sallyxie.org/files/2019_XieHehmanFlake_JPSP_PerceiverTargetImpressionsRaceGender_SuppMaterials.pdf) for building lmer models.
 
 Formula for calculating ICCs taken from Raudenbush and Bryk (2002):
 
Raudenbush, S. W., & Bryk, A. S. (2002). [Hierarchical linear models: Applications and data analysis methods (Vol. 2).](https://us.sagepub.com/en-us/nam/hierarchical-linear-models/book9230) Sage.
 
 
