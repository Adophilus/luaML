-- main class Object(Table)
local Error = require("lib/Error")
local Vector = require("lib/Vector")
local Matrix = require("lib/Matrix")
local numLUA = {
  Error = Error,
  Matrix = Matrix,
  Vector = Vector
}

--util function
function rand(a,xi,c,mod,num)
  arr={}
  for n=1,num,1 do
  xi=(xi*a+c)%mod
  arr[n]=xi/mod
  end
  return arr
end

-- return class/table
return numLUA
