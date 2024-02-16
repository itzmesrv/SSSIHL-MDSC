# Performing Simple Linear Regression on Walmart Dataset

# Importing the Dataset
dataset = read.csv("Datasets/Walmart.csv")

# Splitting the Dataset into Training and Testing set
library(caTools) # loading caTools library
set.seed(123) # setting a seed
split = sample.split(dataset$Weekly_Sales, SplitRatio = 2/3)
print(split) # printing the split 

training_set = subset(dataset, split== TRUE) # creating the training set
test_set = subset(dataset, split == FALSE) # creating the test set

# Fitting the Simple Linear Regression Model using Training Set
regressor = lm(formula = Weekly_Sales ~ ., data = training_set) # fitting linear regression model using the training set
print(regressor)

# Predicting the Test Set Results
y_pred = predict(regressor, newdata = test_set) # predicting weekly sales for test set
print(y_pred)

# Visualizing the Training Set Results
library(ggplot2) # loading ggplot2
ggplot() + 
  geom_point(aes(x= training_set$CPI, 
                 y = training_set$Weekly_Sales),
             colour = "red") +  # scatter plot of training set data
  geom_line(aes(x= training_set$CPI, 
                y = predict(regressor, newdata = training_set)),
            colour = "blue") +  # regression line
  ggtitle("Weekly Sales Vs CPI (Training Set Results)") + # setting title
  xlab("CPI") + # setting x label
  ylab("Weekly sales") # setting y label

### Visualizing the Testing Set Results
ggplot() + 
  geom_point(aes(x= test_set$CPI, 
                 y = test_set$Weekly_Sales),
             colour = "red") + # scatter plot of test set data
  geom_line(aes(x= test_set$CPI, 
                y = y_pred),
            colour = "blue") + # regression line
  ggtitle("Weekly Sales Vs CPI (Test Set Results)") + # setting title
  xlab("CPI") + # setting x label
  ylab("Weekly sales") # setting y label
