### Exercise 2 ###
# Building a Generalized Linear Model (GLM)


## Here we will build a GLM to predict LOS.
# We'll use data from the US Medicare programme in the COUNT package

#Load package, install if you don't have it.
#install.packages("COUNT")
library(COUNT)

#load the dataset 'medpar' using the 'data' function

data(medpar)

# Inspect the data. You can use View, summary or other functions.
# Descriptions of the fields are available in the help file: ?medpar
View(medpar)
summary(medpar)

# A little reformatting is required before modelling.  'provnum' is the provider (hospital) name.
# This should be a `factor`, a categorical variable. Also reformat LOS as a numeric,
# as it's a wierd format here.

medpar$provnum<-factor(medpar$provnum)
medpar$los<-as.numeric(medpar$los)


# Now lets build a glm to predict LOS. Choose your variables, and supply a family of 'poisson.'

mod<- glm(los ~ hmo + died + age80 + factor(type), family="poisson", data=medpar)

# Lets look at the model summary
summary(mod)

#Here is a second model.  How would you compare your models to see which is better?

model2 <-glm(los~death+age80+hmo+type, data=medpar, family="poisson")

summary(mod2)


cbind(mod1=AIC(mod), mod2=AIC(mod2))

# AIC suggest a 'larger' model is better.  Lower AIC means less information loss.


# Can you present the model coefficients as Incident Rate Ratios?

exp(coef(mod))

# Lets plot our predictions
# First, use the predict function to get the predicted values
medpar$preds <- predict(mod, type="response")

with(medpar, plot(los,preds))