### Regression Modelling in R ###

### Examining Framingham data

# The Framingham Heart disease study is a long-standing cohort study that is responsible for 
# much of what we know about heart disease and associated conditions.  For more info, see:
#https://en.wikipedia.org/wiki/Framingham_Heart_Study

# We are going to use regression to investigate some of it. So first, load it:

framingham <- read.csv("./data/framingham.csv")

# The columns we have are:
# male            0 = Female; 1 = Male
# age             Age at examination time.
# education       1 = Some High School; 2 = High School or GED;
#                 3 = Some College or Vocational School; 4 = college
# currentSmoker   0 = nonsmoker; 1 = smoker
# cigsPerDay      number of cigarettes smoked per day (estimated average)
# BPMeds          0 = Not on Blood Pressure medications; 1 = Is on Blood Pressure medications
# prevalentStroke
# prevalentHyp
# diabetes        0 = No; 1 = Yes
# totChol         mg/dL
# sysBP           mmHg
# diaBP           mmHg
# BMI             Body Mass Index calculated as: Weight (kg) / Height(meter-squared)
# heartRate       Beats/Min (Ventricular)
# glucose         mg/dL
# TenYearCHD      0 = No CHD at 10-year follow-up; 1 = CHD at 10-year follow-up



####### Part 1: Linear regression with single predictor  ##########

# With the Framingham data, we will examine the relationship between systolic blood 
# pressure and BMI. Lets view the data to see what we are working with.

summary(framingham)

View(framingham)


# A good first step is to visualise the distribution of the outcome (sysBP), and the 
# possible relationship with predictors.

# Firstly, draw a histogram, box-plot or you choice to view the distribution of sysBP.

library(ggplot2)
ggplot(framingham, aes(x=sysBP))+
  geom_histogram(fill="green3", col=1, alpha=0.5)+
  labs(title="Distribution of Systolic Blood Pressure", subtitle="Frammingham study data")+
  theme(plot.subtitle = element_text(face="italic"))



## Is blood pressure relate to BMI?
## Next, visualise this by building a scatter plot of sysBP and BMI:

ggplot(framingham, aes(x=sysBP, y=BMI))+
  geom_point()+
  geom_smooth(method="lm", col="red")+
  labs(title="Systolic Blood Pressure vs. BMI", subtitle="Frammingham study data")+
  theme(plot.subtitle = element_text(face="italic"))



## Now let's build a linear regression model. sysBP is our outcome, and BMI our predictor.
## create an object with a name, using the `lm` function.

lm1 <- lm(sysBP ~ BMI, data = framingham)


## Use the summary function to view the model
## Can you interpret the output?  Where are the coefficients, standard errors and p-values?

summary(lm1)

# For each increase of one in BMI, Systolic blood pressure increases by 1.76 on average, 
# starting from 86.93 

## Is BMI 'significant'?  
# Yes, p-value is very low ( < 0.05 for common 95% criterion)


##  How much variation in sysBP does BMI explain?
# 10.7%, based on the R2




# What happens if we mean-centre and standardised BMI in the regression (using `scale`)

lm2 <- lm(sysBP ~ scale(BMI), data = framingham)

summary(lm2)

#  How do we interpret this?

# The average systolic blood pressure is 132.34, and an increase of 
# one standard deviation increases this by 7.18.







####### Part 2: Multiple regression  ##########

# We established BMI as predictive, but it only explained ~10% of variation.
# Lets consider adding some more variables: currentSmoker, age, education
# Build a model with BMI + age + education as predictors and view the output:

# BMI + currentSmoker
lm3 <- lm(sysBP ~ BMI + currentSmoker, data = framingham)

summary(lm3)

# BMI + age
lm4 <- lm(sysBP ~ BMI + age, data = framingham)

summary(lm4)

# BMI + age + current smoker

lm5 <- lm(sysBP ~ BMI + currentSmoker + age, data = framingham)

summary(lm5)


## How would you interpret these results?
# Age is a strong predictor.  Smoking appears significant, but when age was added, it's effects reduced.
# This suggests that smoking status may be correlated with age, and acted as something of a proxy.
# Removing smoking status improves the model as there is one less 'degree of freedom' used on 
# a non-predictive variable.


# How would you add education into this model and why?

# BMI + age + education
lm6 <- lm(sysBP ~ BMI + age + factor(education), data = framingham)

summary(lm6)

## How do you interpret education's coefficients?
#  1 is our references (0), and each level is difference from 1
# Patients who have had vocational or college education showed lower blood pressure than those who
# had some high school education, and high school / GDE showed higher blood pressure than those
# who attended some high school.

