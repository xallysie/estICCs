# Convenience function to estimate ICCs from multilevel (linear mixed-effect) models
# accommodates lmer class of models from lme4 package

# 10/07/2021 Sally Xie
library(lme4)

estICC <- function(model) {             # lmer model object
  ranefs  <- names(getME(model,"cnms")) # get cluster names
  ranef_k <- length(ranefs)             # number of clusters
  
  sigma <- getME(model,"sigma")         # get sigma estimate
  R_ij  <- sigma^2                      # calculate residual variance
  names(R_ij) <- "Residual"
  taus  <- ((getME(model,"theta")*sigma)^2) # get variance components for k clusters
  names(taus) <- gsub("\\s*\\.\\([^\\)]+\\)\\s*$","",names(taus)) # clean up column names
  taus  <- taus[c(ranefs)]              # re-order according to original cluster names
  vars  <- c(taus,R_ij)                 # combine variances into one matrix
  totvar<- sum(vars)                    # calculate Total Variance = Sum of all variances including the residual
  ICCs  <- sapply(c(vars),
                  function(x){x/totvar},   # calculate ICC for each cluster
                  simplify=T, USE.NAMES=T) # formula from Raudenbush & Bryk, 2002
  names(sigma) <- "(Sigma)"
  names(vars)  <- paste0(names(vars), " Variance")
  names(ICCs)  <- paste0(names(ICCs), " ICC")
  return(c(sigma,vars,ICCs))
}

# Usage:

# example dataset
pID_n   <- 200 # number of subjects in this simulated dataset
pID_sd  <- 100 # SD for the subjects' random intercept
p <- data.frame(matrix(c(
  1:pID_n, rnorm(pID_n, 0, pID_sd)), nrow=pID_n, ncol=2))
names(p) <- c("pID", "pID_randint"); p$pID <- as.factor(p$pID)
ggplot(p, aes(pID_randint)) + geom_density()

Stim_n <- 40 # number of stimuli in this simulated dataset
Stim_sd<- 40 # SD for the stimuli's random intercept
s <- data.frame(matrix(c( 
  1:Stim_n, rnorm(Stim_n, 0, Stim_sd)), nrow=Stim_n, ncol=2))
names(s) <- c("Stim", "Stim_randint"); s$Stim <- as.factor(s$Stim)
ggplot(s, aes(Stim_randint)) + geom_density()

t <- expand.grid(pID = p$pID, Stim = s$Stim) # all participants see all stimuli
t <- merge(t, p, by="pID")
t <- merge(t, s, by="Stim")

grand_int <- 400 # grand mean DV
error_sd <- 80   # residual (error) SD

data <- t
data$err <- rnorm(nrow(data),0,error_sd)
data$DV  <- grand_int + data$pID_randint + data$Stim_randint + data$err
 

# build a null cross-classified model from simulated dataset
examplemodel <- lmer(DV ~ 1 + (1 | pID) + (1 | Stim), data=data)
summary(examplemodel)

# Run function, get results
estICC(examplemodel)

estimates <- data.frame(estICC(examplemodel))
names(estimates) <- "Estimates"
print(estimates)
