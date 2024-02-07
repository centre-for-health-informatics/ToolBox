#Generates adjusted survival curves by the Mean of Covariates Method
#also generates unadjusted survival curves for comparison

library(survival)
library(survminer)
library(ggplot2)

data <- read.csv("C:/Users/zhaoyu.liu/OneDrive - University of Calgary/chi survival/data.csv", header = T,sep = " ")

res.cox_adjusted <- coxph(Surv(CATHTIME,CENSORED==0)~ FCREAT+FCHF+FDIAB+MALE,data=data)
summary(res.cox_adjusted)

res.cox_unadjusted <- coxph(Surv(CATHTIME,CENSORED==0)~ FDIAB,data=data)
summary(res.cox_unadjusted)


mean <- with(data,
               data.frame(FDIAB = c(0, 1), 
                          FCHF = rep(0.136, 2),
                          FCREAT = rep(0.022, 2),
                          MALE = rep(0.711, 2)
               )
)
mean

inrisk <- data.frame(FDIAB = c(0,1))
inrisk

fit_adjusted <- survfit(res.cox_adjusted, newdata = mean)
fit_unadjusted <- survfit(res.cox_unadjusted, newdata = inrisk)

#plot
time <- data.frame(fit_adjusted$time)
surmn0 <- data.frame(fit_adjusted$surv[,1])
surmn1 <- data.frame(fit_adjusted$surv[,2])
surcrd0 <- data.frame(fit_unadjusted$surv[,1])
surcrd1 <- data.frame(fit_unadjusted$surv[,2])
sur <- cbind(time,surmn0,surmn1,surcrd0,surcrd1)

Length_of_survival <- fit_adjusted$time

g <-ggplot(sur,aes(x=Length_of_survival))+ geom_line(aes(y=fit_adjusted.surv...1.,color="2")) + geom_line(aes(y=fit_adjusted.surv...2.,color="3"))+geom_line(aes(y=fit_unadjusted.surv...1.,color="4"))+geom_line(aes(y=fit_unadjusted.surv...2.,color="5"))  

g + ggtitle("Average Covariate Method")+scale_colour_discrete(labels=c("no diabetes-Adjusted", "diabetes-Adjusted","no diabetes", "diabetes"))
