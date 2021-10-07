# Estimate ICCs from lmer models
R convenience function to estimate intra-class correlations (ICCs) from linear mixed-effect models (supports [lme4](https://cran.r-project.org/web/packages/lme4/index.html) package).

Usage:

    estICC(model)
  
 where **model** is an lmer object. Returns a vector of variance components and ICC estimates. R code includes an example. 
