# 15x2 matrix, to find variance covariance matrix & correlation coefficient matrix
rows = 15 
cols = 2
mean = 10
stdev = 10
M = matrix((rnorm(rows*cols, mean=mean, sd=stdev)), nrow=rows, ncol=cols)
print('15x2 Matrix: ')
print(M)

X_bar = colMeans(M) # Mean
print('Mean: ')
print(X_bar)
sub = matrix(c(X_bar), nrow=rows, ncol=cols, byrow=TRUE)
deviations = M - sub

sigma = (t(deviations) %*% deviations)/rows
print('Variance Covariance matrix')
print(sigma)

sqrt_matrix = diag(1/sqrt(diag(sigma)))

corr_coeff_matrix = sqrt_matrix %*% sigma %*% sqrt_matrix
print('Correlation coefficient Matrix')
print(corr_coeff_matrix)