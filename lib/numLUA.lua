-- main class Object(Table)
Error=require "lib/Error"
numLUA={ Error = Error }

--util function
function rand(a,xi,c,mod,num)
  arr={}
  for n=1,num,1 do
  xi=(xi*a+c)%mod
  arr[n]=xi/mod
  end
  return arr
end

-- createVector function class
function numLUA:createVector(vector)
  this={
   vec=vector
  }

 -- function to get vector length
  function this:getLength()
    sum_scalars=0
    for scal_indx=1,#self.vec,1 do
       sum_scalars=sum_scalars+math.pow(self.vec[scal_indx],2)
    end
    return math.sqrt(sum_scalars)
  end

-- function to get the dot product of vectors
  function this:dot(vector)
    dot_product=0
    for scal_indx=1,#self.vec,1 do
       dot_product=dot_product+(self.vec[scal_indx]*vector.vec[scal_indx])
    end
    return dot_product
  end

-- function to add vectors
  function this:add(vector)
    sum_vector={}
    for scal_indx=1,#self.vec,1 do
      sum_vector[scal_indx]=(self.vec[scal_indx]+vector.vec[scal_indx])
    end
    return numLUA:createVector(sum_vector)
  end

-- function to subtract vectors
  function this:sub(vector)
    sub_vector={}
    for scal_indx=1,#self.vec,1 do
       sub_vector[scal_indx]=self.vec[scal_indx]-vector.vec[scal_indx]
    end
    return numLUA:createVector(sub_vector)
  end

-- function to divide vectors
  function this:div(vector)
    div_vector={}
    for scal_indx=1,#self.vec,1 do
       div_vector[scal_indx]=self.vec[scal_indx]/vector.vec[scal_indx]
    end
    return numLUA:createVector(div_vector)
  end

-- function to multiply vectors
  function this:mul(vector)
    if #self.vec ~= #vector.vec then
      -- print("Error:vectors must be of the same dimensions")
      -- return nil
       Error:MatchingDimensions(self, vector)
    end
    dot_vector={}
    for scal_indx=1,#self.vec,1 do
       dot_vector[scal_indx]=self.vec[scal_indx]*vector.vec[scal_indx]
    end
    return numLUA:createVector(dot_vector)
  end

-- function to print vector
  function this:print()
    vector_string="{"
    for scal_indx=1,#self.vec,1 do
       vector_string=vector_string..self.vec[scal_indx]
       if scal_indx < #self.vec then
         vector_string=vector_string..","
        end
    end
    vector_string=vector_string.."}"
    print(vector_string)
  end

-- function to scale vector i.e times the vector by a scalar
  function this:scale(scalar)
    scal_vector={}
    for scal_indx=1,#self.vec,1 do
       scal_vector[scal_indx]=self.vec[scal_indx]*scalar
    end
    return numLUA:createVector(scal_vector)
  end

 -- function for cross product of vectors
  function this:cross(vector)
     if #self.vec ~= #vector.vec then
        -- print("Error:vectors must be of the same dimensions")
        -- return nil
       Error:MatchingDimensions(vector1, vector2)
     end
     if #self.vec > 3 or #vector.vec > 3 then
        Error:CrossProduct()
      end

      if #vector.vec < 3 then
         return (self.vec[1]*vector.vec[2])-(self.vec[2]*vector.vec[1])
      else
         cross_vector={
             (self.vec[2]*vector.vec[3])-(self.vec[3]*vector.vec[2]),
             (self.vec[3]*vector.vec[1])-(self.vec[1]*vector.vec[3]),
             (self.vec[1]*vector.vec[2])-(self.vec[2]*vector.vec[1])
           }
           return numLUA:createVector(cross_vector)
       end
  end

  -- set metatables on vector
  setmetatable(this, {
    __add = function (vec1, vec2)
      return vec1:add(vec2)
    end,
    __sub = function (vec1, vec2)
      return vec1:sub(vec2)
    end,
    __mul = function (vec1, vec2)
      return vec1:cross(vec2)
    end,
    __div = function (vec, scalar)
      return vec:div(scalar)
    end,
    __len = function (vec)
      return vec:getLength()
    end,
    -- __index = function (vec, key)
    --   if (type(key) == "number") then
    --     return vec.vec[key]
    --   else
    --     return error("Invalid index!")
    --   end
    -- end,
    -- __newindex = function (vector, key, value)
    --   if (type(key) == "number") then
    --     vector.vec[key] = value
    --   else
    --     return error("Invalid value for index!")
    --   end
    -- end,
    __tostring = function (vector)
      vector_string="{"
      for scal_indx=1,#vector.vec,1 do
         vector_string=vector_string..vector.vec[scal_indx]
         if scal_indx < #vector.vec then
           vector_string=vector_string..","
          end
      end
      vector_string=vector_string.."}"
      return  vector_string
    end
  })

 -- return vector obj(table)
  return this
end

-- function to generate random vectors
function numLUA:randVec(n)
   str=tostring(os.time()-math.random()*10)
   seed=tonumber(string.sub(str,8,10))*10
   local vector=rand(2151,seed,1254,40,n)
   return self:createVector(vector)
end

-- function to get random number
function numLUA:randNumber(x)
  str=tostring(os.time()-math.random()*10)
  seed=tonumber(string.sub(str,8,10))*10
  rand_arr=rand(2151,seed,1254,40,1000)
  new_arr={}
  n_indx=1
  for indx=1,#rand_arr,1 do
    if math.floor(rand_arr[indx]*10) <= x and math.floor(rand_arr[indx]*10) >= 1 then
      return math.floor(rand_arr[indx]*10)
    end
  end
end

-- function to get exponent
function numLUA:exp(n)
   return math.exp(n)
end

-- function to get the dot product of vectors
function numLUA:dot(vector1,vector2)
  if #vector1.vec ~= #vector2.vec then
    -- print("Error:vectors must be of the same dimensions")
    -- return nil
       Error:MatchingDimensions(vector1, vector2)
  end

  dot_product=0
  for scal_indx=1,#vector1.vec,1 do
       dot_product=dot_product+(vector1.vec[scal_indx]*vector2.vec[scal_indx])
  end
  return dot_product
end

-- function for cross product of vectors
function numLUA:cross(vector1,vector2)
    if #vector1.vec ~= #vector2.vec then
       -- print("Error:vectors must be of the same dimensions")
       -- return nil
       Error:MatchingDimensions(vector1, vector2)
    end
    if #vector1.vec > 3 or #vector2.vec > 3 then
       Error:CrossProduct()
    end

    if #vector2.vec < 3 then
        return (vector1.vec[1]*vector2.vec[2])-(vector1.vec[2]*vector2.vec[1])
     else
        cross_vector={
            (vector1.vec[2]*vector2.vec[3])-(vector1.vec[3]*vector2.vec[2]),
            (vector1.vec[3]*vector2.vec[1])-(vector1.vec[1]*vector2.vec[3]),
            (vector1.vec[1]*vector2.vec[2])-(vector1.vec[2]*vector2.vec[1])
          }
          return numLUA:createVector(cross_vector)
      end
  end

function numLUA:createMatrix(matrix)
   this={
     mat=matrix
    }

   -- function to print a matrix
    function this:print()
      mat_str="{"
      for mat_indx=1,#self.mat,1 do
           if mat_indx==1 then
             vector_string="{"
           else
             vector_string="\n {"
            end

           for scal_indx=1,#self.mat[mat_indx],1 do
              vector_string=vector_string..self.mat[mat_indx][scal_indx]
              if scal_indx < #self.mat[mat_indx] then
                vector_string=vector_string..","
              end
           end
           if #self.mat~=mat_indx then
              vector_string=vector_string.."},"
           else
              vector_string=vector_string.."}"
           end
       mat_str=mat_str..vector_string
      end

      mat_str=mat_str.."}"
      print(mat_str)
    end

   -- function to multiply a matrix by a scalar
    function this:scale(scalar)
      scal_mat={}
      for rw_indx=1,#self.mat,1 do
         scal_mat_v={}
         for cl_indx=1,#self.mat[1],1 do
           scal_mat_v[cl_indx]=self.mat[rw_indx][cl_indx]*scalar
         end
         scal_mat[rw_indx]=scal_mat_v
      end
      return numLUA:createMatrix(scal_mat)
    end


    -- function to add a matrix by a scalar
    function this:add(scalar)
      scal_mat={}
      for rw_indx=1,#self.mat,1 do
         scal_mat_v={}
         for cl_indx=1,#self.mat[1],1 do
           scal_mat_v[cl_indx]=self.mat[rw_indx][cl_indx]+scalar
         end
         scal_mat[rw_indx]=scal_mat_v
      end
      return numLUA:createMatrix(scal_mat)
    end


    -- function to subtract a matrix by a scalar
    function this:sub(scalar)
      scal_mat={}
      for rw_indx=1,#self.mat,1 do
         scal_mat_v={}
         for cl_indx=1,#self.mat[1],1 do
           scal_mat_v[cl_indx]=self.mat[rw_indx][cl_indx]-scalar
         end
         scal_mat[rw_indx]=scal_mat_v
      end
      return numLUA:createMatrix(scal_mat)
    end


    -- function to divide a matrix by a scalar
    function this:div(scalar)
      scal_mat={}
      for rw_indx=1,#self.mat,1 do
         scal_mat_v={}
         for cl_indx=1,#self.mat[1],1 do
           scal_mat_v[cl_indx]=self.mat[rw_indx][cl_indx]/scalar
         end
         scal_mat[rw_indx]=scal_mat_v
      end
      return numLUA:createMatrix(scal_mat)
    end

    -- function to multiply a matrix by a vector
    function this:vecMul(vector)
       if  #self.mat[1] ~= #vector.vec then
         -- print("Error:vector and matrix columns must be of the same dimensions")
         -- return nil
         Error:MatchingColumns(self, vector)
       end
       vec_mul_mat={}
       for rw_indx=1,#self.mat,1 do
          mat_vec={}
          for cl_indx=1,#vector.vec,1 do
            mat_vec[cl_indx]=self.mat[rw_indx][cl_indx]*vector.vec[cl_indx]
          end
          vec_mul_mat[rw_indx]=mat_vec
       end
       return numLUA:createMatrix(vec_mul_mat)
    end

    -- function to add a matrix by a vector
    function this:vecAdd(vector)
       if  #self.mat[1] ~= #vector.vec then
         -- print("Error:vector and matrix columns must be of the same dimensions")
         -- return nil
         Error:MatchingColumns(self, vector)
       end
       vec_mul_mat={}
       for rw_indx=1,#self.mat,1 do
          mat_vec={}
          for cl_indx=1,#vector.vec,1 do
            mat_vec[cl_indx]=self.mat[rw_indx][cl_indx]+vector.vec[cl_indx]
          end
          vec_mul_mat[rw_indx]=mat_vec
       end
       return numLUA:createMatrix(vec_mul_mat)
    end

    -- function to divide a matrix by a vector
    function this:vecDiv(vector)
       if  #self.mat[1] ~= #vector.vec then
         -- print("Error:vector and matrix columns must be of the same dimensions")
         -- return nil
         Error:MatchingColumns(self, vector)
       end
       vec_mul_mat={}
       for rw_indx=1,#self.mat,1 do
          mat_vec={}
          for cl_indx=1,#vector.vec,1 do
            mat_vec[cl_indx]=self.mat[rw_indx][cl_indx]/vector.vec[cl_indx]
          end
          vec_mul_mat[rw_indx]=mat_vec
       end
       return numLUA:createMatrix(vec_mul_mat)
    end

    -- function to subtract a matrix by a vector
    function this:vecSub(vector)
       if  #self.mat[1] ~= #vector.vec then
         -- print("Error:vector and matrix columns must be of the same dimensions")
         -- return nil
         Error:MatchingColumns(self, vector)
       end

       vec_mul_mat={}
       for rw_indx=1,#self.mat,1 do
          mat_vec={}
          for cl_indx=1,#vector.vec,1 do
            mat_vec[cl_indx]=self.mat[rw_indx][cl_indx]-vector.vec[cl_indx]
          end
          vec_mul_mat[rw_indx]=mat_vec
       end

       return numLUA:createMatrix(vec_mul_mat)
    end

    -- set metatables on matrix
    setmetatable(this, {
      __add = function (mat, obj)
        if (type(obj) == "number") then
          return mat:add(obj)
        end

        return mat:vecAdd(obj)
      end,
      __sub = function (mat, obj)
        if (type(obj) == "number") then
          return mat:sub(obj)
        end

        return mat:vecSub(obj)
      end,
      __mul = function (mat, obj)
        if (type(obj) == "number") then
          return mat:scale(obj)
        end

        return mat:vecMul(obj)
      end,
      __div = function (mat, obj)
        if (type(obj) == "number") then
          return mat:div(obj)
        end

        return mat:vecDiv(obj)
      end,
      __tostring = function (matrix)
        mat_str="{"
        for mat_indx=1,#matrix.mat,1 do
             if mat_indx==1 then
               vector_string="{"
             else
               vector_string="\n {"
              end

             for scal_indx=1,#matrix.mat[mat_indx],1 do
                vector_string=vector_string..matrix.mat[mat_indx][scal_indx]
                if scal_indx < #matrix.mat[mat_indx] then
                  vector_string=vector_string..","
                end
             end
             if #matrix.mat~=mat_indx then
                vector_string=vector_string.."},"
             else
                vector_string=vector_string.."}"
             end
         mat_str=mat_str..vector_string
        end

        mat_str=mat_str.."}"
        return mat_str
      end
    })

    -- return matrix obj(table)
    return this
end
-- return class/table
return numLUA
