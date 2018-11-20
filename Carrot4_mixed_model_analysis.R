library(readxl)
library(car)
library(MASS)
library(lme4)
library(ggplot2)
library(multcomp)
setwd('C:/Users/jbai5/OneDrive/First year project/Experiment_Carrot4')
DATA <- read_excel('Carrot4_fit_pertTrials_LOSO12_RMSE_v_2018-8-6-14-45.xlsx')


qqp(DATA$RMSE_v, "norm")

# lnorm means lognormal
qqp(DATA$RMSE_v, "lnorm")

# qqp requires estimates of the parameters of the negative binomial, Poisson
# and gamma distributions. You can generate estimates using the fitdistr
# function. Save the output and extract the estimates of each parameter as I
# have shown below.
nbinom <- fitdistr(DATA$RMSE_v, "Negative Binomial")
qqp(DATA$RMSE_v, "nbinom", size = nbinom$estimate[[1]], mu = nbinom$estimate[[2]])

poisson <- fitdistr(DATA$RMSE_v, "Poisson")
qqp(DATA$RMSE_v, "pois", poisson$estimate)

gamma <- fitdistr(DATA$RMSE_v, "gamma")
qqp(DATA$RMSE_v, "gamma", shape = gamma$estimate[[1]], rate = gamma$estimate[[2]])

lmm0 <- lmer(RMSE_v ~ Model * d0 * dv + (1 | subject), 
             data = DATA, REML = FALSE)
lmm1 <- lmer(RMSE_v ~ Model + d0 + dv + (1 | subject), 
             data = DATA, REML = FALSE)
lmm2 <- lmer(RMSE_v ~ Model * d0 + dv + (1 | subject),
             data = DATA, REML = FALSE)
lmm3 <- lmer(RMSE_v ~ Model * dv + d0 + (1 | subject),
             data = DATA, REML = FALSE) # Model:dv is sig
lmm4 <- lmer(RMSE_v ~ Model + d0 * dv + (1 | subject),
             data = DATA, REML = FALSE) # w:dv is sig

lmm5 <- lmer(RMSE_v ~ Model + d0 + dv + Model:dv + dv:d0 +
               (1 | subject), data = DATA, REML = FALSE)

lmm6 <- lmer(RMSE_v ~ Model + d0 + dv + Model:dv + dv:d0 + Model:d0:dv +
               (1 | subject), data = DATA, REML = FALSE)

summary(lmm9)


Anova(lmm0, type = 3)


anova(lmm1, lmm2)

data <- DATA[c("Model", "d0", "dv", "RMSE_v")]
data$w <- as.character(data$d0)
data$dv <- as.character(data$dv)
# Main effect
ggplot(data) + aes(Model, RMSE_v) + geom_boxplot()
# Interactions
ggplot(data) + aes(Model, RMSE_v) + geom_boxplot() + facet_wrap(~w)

summary(glht(lmm0, linfct = mcp(Model = "Tukey")), test = adjusted("holm"))
