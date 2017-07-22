-- Base Neural Network Processor
math.randomseed(os.time())

print("---- ---- BNNP START ---- ----")

neuralFormat = {2,4,3}

-- y: rows / size of previous layer, x: collums / size of new layer
-- random: if true, random values from -2>2, if false, all 0
function newMatrix(y, x, random)
  local newMat = {}
  for i=0,y do
    newMat[i]={}
    for j=0,x do
      if random then
        newMat[i][j]=4*math.random()-2
      else
        newMat[i][j]=0
      end
    end
  end
  return newMat
end

function printMatrix(matrix)
  for i=1,#matrix do
    print(table.concat(matrix[i], " "))
  end
end

-- Plug in both matricies to multiply.
-- Works for multiply a layer by a network.
function matMul(matrix1, matrix2)
  local newMat = {}
  printMatrix(matrix1)
  printMatrix(matrix2)
  for a=1, #matrix1 do
    newMat[a] = {}
    for b=1, #matrix2 do
      local val = 0
      for c=1, #matrix1[1] do
        val = val + (matrix1[a][c] * matrix2[c][b])
      end
      newMat[a][b] = val
    end
  end
  return newMat
end

pringle = {{2, 1}, {1, 10}}
prongle = {{1, 20}, {4, 3}}

printMatrix(matMul(pringle, prongle))

muffins = newMatrix(3, 10, true)


for i=1,#muffins do
  print(table.concat(muffins[i], " "))
end