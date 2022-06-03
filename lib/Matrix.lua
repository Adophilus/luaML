local Error = require("lib/Error")

function Matrix(matrix)
   local this = { mat = matrix }

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
      return Matrix(scal_mat)
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
      return Matrix(scal_mat)
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
      return Matrix(scal_mat)
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
      return Matrix(scal_mat)
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
       return Matrix(vec_mul_mat)
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
       return Matrix(vec_mul_mat)
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
       return Matrix(vec_mul_mat)
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

       return Matrix(vec_mul_mat)
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

return Matrix
