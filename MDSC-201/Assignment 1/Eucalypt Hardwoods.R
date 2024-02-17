# Performing Simple Linear Regression on the Eucalypt Hardwoods Dataset

# Importing the Dataset
dataset = read.csv("E:/Siva/SSSIHL/MSc Data Science/2nd Sem/201/Datasets/eucalypt_hardwoods.csv")

# Splitting the Dataset into Training and Testing set
library(caTools) # loading caTools library
library(ggplot2) # loading ggplot2
set.seed(123) # setting a seed
split = sample.split(dataset$hardness, SplitRatio = 0.8) # predicting hardness based on density
print(split) # printing the split

training_set = subset(dataset, split == TRUE) # creating the training set
test_set = subset(dataset, split == FALSE) # creating the test set

# Fitting the Simple Linear Regression Model using Training Set
regressor = lm(formula = hardness ~ density, data = dataset) # fitting linear regression model using the training set
print(regressor)

# Predicting the Training Set Results
y_train_pred = predict(regressor, training_set)
print(y_train_pred)

# Visualizing the Training Set Results
ggplot() +
  geom_point(aes(x = training_set$density,
                 y = training_set$hardness),
             colour = "red") +
  geom_line(aes(x = training_set$density,
                y = y_train_pred),
            colour = "blue") +
  ggtitle("Regression Line Plot Training Set")+
  xlab("Density") + 
  ylab("Hardness")

# Predicting the Test Set Results
y_test_pred = predict(regressor, test_set)
print(y_test_pred)

# Visualizing the Testing Set Results
ggplot() +
  geom_point(aes(x = test_set$density,
                 y = test_set$hardness),
             colour = "red") +
  geom_line(aes(x = test_set$density,
                y = y_test_pred),
            colour = "blue") +
  ggtitle("Regression Line Plot Testing Set")+
  xlab("Density") + 
  ylab("Hardness")

# Residual Plot
train_residual = y_train_pred - training_set$hardness
test_residual = y_test_pred - test_set$hardness

ggplot() +
  geom_point(aes(x = 1:length(train_residual),
                 y = train_residual),
             colour = "black") + 
  geom_hline(yintercept = 0,
             linetype = "solid",
             color = "red") +
  ggtitle("Residual Line Plot Training Set")+
  xlab("Density") + 
  ylab("Hardness")
  
ggplot() +
  geom_point(aes(x = 1:length(test_residual),
                 y = test_residual),
             colour = "black") + 
  geom_hline(yintercept = 0,
             linetype = "solid",
             color = "red") + 
  ggtitle("Residual Line Plot Testing Set")+
  xlab("Density") + 
  ylab("Hardness")