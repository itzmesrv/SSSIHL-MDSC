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

def cofactors(mat):
    cofmat = []
    for i in range(len(mat)):
        cof_row = []
        for j in range(len(mat[i])):
            cofactor = ((-1)**(i+j)) * determinant(minor(mat,i,j))
            cof_row.append(cofactor)
        cofmat.append(cof_row)
    return cofmat

def transpose(mat):
    rows=len(mat)
    cols=len(mat[0])

    trans = [[0 for _ in range(rows)] for _ in range(cols)] # empty mat with dim swapped

    for i in range(rows):
        for j in range(cols):
            trans[j][i] = mat[i][j] # filling transposed elements
    
    return trans

def adjoint(mat):
    adj = []
    adjugate = transpose(cofactors(mat))
    adj.append(adjugate)
    return adj

def inverse(mat):
    det = determinant(mat)
    if det == 0:
        return 'Not Invertible!! (Singular)'

    adjugate = adjoint(mat)[0]

    inv = [[0 for _ in range(len(mat))] for _ in range(len(mat))] # empty mat
    for i in range(len(mat)):
        for j in range(len(mat)):
            inv[i][j] = adjugate[i][j] / det

    return inv

if(row!=col):
    print('!ERROR! ~ Not Possible!')
else:
    d = determinant(mat)
    t = transpose(mat)
    c = cofactors(mat)
    a = adjoint(mat)
    i = inverse(mat)
    print('Matrix: ',mat)
    print('Determinant: ',d)
    print('Transpose: ',t)
    print('Cofactors: ',c)
    print('Adjoint: ',a)
    print('Inverse: ',i)