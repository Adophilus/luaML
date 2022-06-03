
local numlua=require "lib/numLUA"

local vec1 = numlua.Vector({ 1, 0, 1 })
local vec2 = numlua.Vector({ 4, 5, 6 })
local vec3 = numlua.Vector({ 1, 0, 1, 0 })

print(vec1 + vec2)

local mat = numlua.Matrix({
  { 1, 2, 3, 4 },
  { 5, 6, 7, 8 }
})

print(mat - vec3)
print(vec1 * vec3)
