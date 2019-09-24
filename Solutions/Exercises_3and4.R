### Exercise 3 ###
# Building a Generalized Linear Model (GLM)


## Here we will build a GLM to predict death using the LOS_models dataset from the NHSRdatasets package.

#Load package, install if you don't have it.
#install.packages("COUNT")
library(NHSRdatasets)
data(LOS_model)

#load the dataset 'medpar' using the 'data' function

data(LOS_model)

# Inspect the data. You can use View, summary or other functions.
# Descriptions of the fields are available in the help file: ?medpar
View(LOS_model)
summary(LOS_model)



# Now lets build a glm to predict Death. Add Age to your model.
# What other argument does glm take, compared to lm?

glm1<- glm(Death ~ Age, data=LOS_model, family="binomial")

# Lets look at the model summary
summary(glm1)


# Is age signficant?  How would we intepret it?

# Yes, age is signficant. Hard to interpret on the log scale.
# Log-odds of death increases by 0.02 for every increase in one of age.

# Try this model as a scaled model.



glm2<- glm(Death ~ scale(Age), data=LOS_model, family="binomial")

# Lets look at the model summary
summary(glm2)

## Can you interpret scale now?

# The average log-odds of death is -1.57, incresing by 0.33 for each standard deviation 
# increase in age

# Let make them more interpretable by transforming them back to odd.
# To do this, we can exponetiate the coefficients

exp(coef(glm1))
exp(coef(glm2))

# Interpret now:




## Now add length of stay (LOS) into the model

glm3<- glm(Death ~ Age + LOS, data=LOS_model, family="binomial")

# Lets look at the model summary
summary(glm3)


## How might you compare these two models, with and without LOS?

# AIC:

cbind(glm=AIC(glm1), glm3=AIC(glm3))

# Likelihood ratio test:

anova(glm1, glm3, test="Chisq")

#or 

library(lmtest)
lrtest(glm1, glm3)



# AIC is smaller (difference is >4) suggesting a 'larger' model is signficantly better.
# Likelihood ratios do the same. 



## Are these results what you expect?  Why?
# not really.  LOS is strong predictor, but it suggests age is not.  Surely older people have greater
# chance of dying?  Maybe they are linked, i.e. LOS is more or less predictive for older patietns than
# it is for younger ones... interaction term!

glm4 <- glm(Death ~ Age * LOS, data = LOS_model, family="binomial")

summary(glm4)

## Is this different?  
# Yes! This model suggest they are all signficant, with the combinatino of LOS and age (when increasing)
# showing a negative coefficient.  i.e. both age and LOS important, but it is not as strong as a 
# sum of both


## Is our model any good? Check the AUC, using the ModelMetrics, or yardstick packages

ModelMetrics::auc(glm4)




################ Exercise 4: Prediction ######################

# Let's use our models to predict.  We can predict back onto the same data, or new data, using the
# `newdata` argument.  We will fit back to our data today, so we do not strictly need to specify it, 
# but if we do, it will hadle missing data better.

# First for our lm, we'll add it back into the data.frame, as a column called 'preds' :

framingham$preds <- predict(lm6, newdata=framingham)


# We cam compare them to the original data.  Lets do this in a plot:

ggplot(framingham, aes(y=sysBP, x=preds))+
  geom_point()+
  geom_smooth(col="red")+
  labs(title="Observed vs. Predicted blood pressure", subtitle="Frammingham study data")+
  theme(plot.subtitle = element_text(face="italic"))



# Now let try the same thing for our logistic model. This is different because of the link function.
# We need to specify which scale to predict on:

LOS_model$preds <- predict(glm4, newdata=LOS_model, type="response")


# When visualising it, what happens if we build a scatter plot?
ggplot(LOS_model, aes(y=Death, x=preds))+
  geom_point()+
  geom_smooth(col="red")+
  labs(title="Deaths vs. Probability of death", subtitle="LOS_model")+
  theme(plot.subtitle = element_text(face="italic"))

# Death can only be 0 or 1, so we get two bands on y axis.  This plot isn't very meaningful.


## How else could we visualise it?
# Need to reflect 'Death' in groups: box plot, violin, plot, overlayed histograms or denisties etc.

# Boxplot
ggplot(LOS_model, aes(x=factor(Death), group=Death, y=preds))+
  geom_boxplot()+
  scale_x_discrete(name="", breaks=c(0,1), labels=c("Survived", "Died")) +
  labs(title="Probability of death", subtitle="LOS_model data")+
  theme(plot.subtitle = element_text(face="italic"))

#Violin plot
ggplot(LOS_model, aes(x=factor(Death), group=Death, y=preds))+
  geom_violin()+
  scale_x_discrete(name="", breaks=c(0,1), labels=c("Survived", "Died")) +
  labs(title="Probability of death", subtitle="LOS_model data")+
  theme(plot.subtitle = element_text(face="italic"))

# Histogram
ggplot(LOS_model, aes(x=preds, fill=factor(Death), col=factor(Death), group=factor(Death)))+
  geom_histogram(alpha=0.5, col=1, position="identity", bins=30)+
  geom_hline(aes(yintercept=median(preds)))+
  scale_fill_discrete(name="Died")+
  scale_x_continuous("Probaility of Death")+
  labs(title="Probability of death", subtitle="LOS_model data")+
  theme(plot.subtitle = element_text(face="italic"))

# Density
ggplot(LOS_model, aes(x=preds, fill=factor(Death), col=factor(Death), group=factor(Death)))+
  geom_density(alpha=0.5, col=1)+
  scale_fill_discrete(name="Died")+
  scale_x_continuous("Probaility of Death")+
  labs(title="Probability of death", subtitle="LOS_model data")+
  theme(plot.subtitle = element_text(face="italic"))


# What do your plot(s) suggest?  The highest probabilities oare in the 'died' group.
# There are fewer patients with low probabilities in the died group. The median value looks
# Median probability is higher in Died group.
