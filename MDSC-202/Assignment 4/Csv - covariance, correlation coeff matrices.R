# Import csv file, collect numerical columns & store it in another matrix then find var, covariance and correlation matrix

# Importing the Dataset
dataset = read.csv("E:/Siva/SSSIHL/MSc Data Science/2nd Sem/202/Lab/Assignments/Walmart_sales.csv",header = TRUE)
rownames(dataset) <- seq(1,nrow(dataset))
str(dataset)

# selecting the numerical columns and storing them in data matrix
sub_df = dataset[1000:1100,c("Weekly_Sales","Temperature","Fuel_Price","CPI","Unemployment")]
data_matrix <- as.matrix(sub_df)
rownames(data_matrix) <- NULL
colnames(data_matrix) <- NULL
data_matrix

# COVARIANCE
# Number of observations for finding Variance-Covariance matrix
n <- nrow(data_matrix)
print(n)

# Mean of each variable
means <- colMeans(data_matrix)
print(means)

#1s column vector
one_matrix <- matrix(1, ncol = 1, nrow = nrow(data_matrix))
print(one_matrix)

xminusxbar <- data_matrix - one_matrix %*% means
xminusxbar

final <- t(xminusxbar) %*% xminusxbar
final <- 1/(n-1) * final
final # Co variance matrix

sd <- sqrt(diag(final))
cor <- final / (sd %*% t(sd))
print(cor)

# Inferences:
# If unemployment rate is less then the weekly sales are more - negatively correlated (1,5)
# If CPI rate is high then there are more weekly sales - positively correlated (1,4)
# Temp and Weekly sales are negatively correlated - so if temp is high, there may not be more weekly sales