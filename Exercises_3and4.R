##### Exercise 3:  Building a Generalized Linear Model (GLM) ######


## Here we will build a GLM to predict death using the LOS_models dataset from the NHSRdatasets package.

#Load package, install if you don't have it.
#install.packages("COUNT")
library(NHSRdatasets)


#load the dataset 'medpar' using the 'data' function
data(LOS_model)

# Inspect the data. You can use View, summary or other functions.
# Descriptions of the fields are available in the help file: ?LOS_model
View(LOS_model)
summary(LOS_model)



## Now lets build a glm to predict Death. Add Age to your model.
## What other argument does glm take, compared to lm?



## Lets look at the model summary



## Is age signficant?  How would we intepret it?




## Try this model as a scaled model.



# Lets look at the model summary


## Can you interpret scale now?



## Let make them more interpretable by transforming them back to odd.
## To do this, we can exponetiate the coefficients





## Now add length of stay (LOS) into the model




## Lets look at the model summary



## How might you compare these two models, with and without LOS?






## Are these results what you expect?  Why?






## Is this different?  




## Is our model any good? Check the AUC, using the ModelMetrics, or yardstick packages






################ Exercise 4: Prediction ######################

## Let's use our models to predict.  We can predict back onto the same data, or new data, using the
## `newdata` argument.  We will fit back to our data today, so we do not strictly need to specify it, 
## but if we do, it will handle missing data better.

## First for our lm, we'll add it back into the frammingham data.frame, as a column called 'preds' :





# We can compare them to the original data.  Lets do this in a plot:




## Now let try the same thing for our logistic model. This is different because of the link function.
## We need to specify which scale to predict on:




## When visualising it, what happens if we build a scatter plot?



## How else could we visualise it?
## Need to reflect 'Death' in groups: box plot, violin, plot, overlayed histograms or denisties etc.




## What do your plot(s) suggest?  

