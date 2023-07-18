def newmatrix(r,c):
	Matrix = []
	for i in range(0,r):
		t = []
		for j in range(0,c):
			print('Please enter',i,j,'th value: ')
			t.append(int(input()))	
		Matrix.append(t)
	return Matrix

r1 = int(input('Rows of Matrix1: '))
c1 = int(input('Cols of Matrix1: '))
r2 = int(input('Rows of Matrix2: '))
c2 = int(input('Cols of Matrix2: '))

#matrix1
print('Matrix1 values')			
m1 = newmatrix(r1,c1)

#matrix2
print('Matrix2 values')	
m2 = newmatrix(r2,c2)

print('\n Matrix1 is',m1)
print('\n Matrix2 is',m2)

#Addition and Subtraction
if(r1!=r2 or c1!=c2):
	print('Addition and Subtraction is not possible.')

else:
	add=[]
	sub=[]

	for i in range(r1):
		for j in range(c1):
			add.append(m1[i][j]+m2[i][j])
			sub.append(m1[i][j]-m2[i][j])

	print('\n Addition and Subtraction of the two matrices are shown below')
	print('\nAddition of Matrices',add)
	print('\nSubtraction of Matrices',sub)



#Multiplication
if(c1!=r2):
	print('\nMultiplication is not possible')
else:
	mat = []
	for k in range(r1):
		store=[]
		for i in range(c2):
			temp=0
			for j in range(c1): #r2
				temp=temp + m1[k][j]*m2[j][i]
			store.append(temp)
		mat.append(store)
	print('\n Multiplication of the two matrices are shown below')
	print('\nProduct',mat)