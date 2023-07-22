def newmatrix(r,c):
    Matrix = []

    for i in range(r):
        t = []
        for j in range(c):
            print('Enter',i,j,'values: ')
            t.append(int(input()))
        Matrix.append(t)
    return Matrix

row = int(input('Rows of Matrix: '))
col = int(input('Cols of Matrix: '))

mat = newmatrix(row,col)
print('Matrix is',mat)

def minor(mat, row, col):
    minor_matrix = []
    for i in range(len(mat)):
        if i != row:
            minor_row = []
            for j in range(len(mat[i])):
                if j != col:
                    minor_row.append(mat[i][j])
                    #print('Minor row',minor_row)
            minor_matrix.append(minor_row)
            #print('Minor matrix',minor_matrix)
    return minor_matrix    

def determinant(mat):
    if len(mat) == 2:
        compute = mat[0][0] * mat[1][1] - mat[0][1] * mat[1][0]
        return compute

    else:
        det = 0
        for x in range(len(mat)):
            det += ((-1)**x) * mat[0][x] * determinant(minor(mat,0,x))
        return det

if(row!=col):
    print('!ERROR! ~ Not Possible!')
else: 
    y = determinant(mat)
    print('Determinant of matrix is: ',y)