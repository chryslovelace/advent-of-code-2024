local input = io.open("inputs/day03.txt"):read("*all")
local instructions = {}
local total = 0
for i, l, r in string.gmatch(input, "()mul%((%d+),(%d+)%)") do
  local l = tonumber(l)
  local r = tonumber(r)
  if l < 1000 and r < 1000 then
    total = total + l * r
    table.insert(instructions, { idx = tonumber(i), inst = "mul", val = l * r })
  end
end
for i in string.gmatch(input, "()do%(%)") do
  table.insert(instructions, { idx = tonumber(i), inst = "do" })
end
for i in string.gmatch(input, "()don't%(%)") do
  table.insert(instructions, { idx = tonumber(i), inst = "don't" })
end
local function sortbyidx(a, b)
  return a.idx < b.idx
end
table.sort(instructions, sortbyidx)
local total2 = 0
local doing = true
for i = 1, #instructions do
  if instructions[i].inst == "mul" and doing then
    total2 = total2 + instructions[i].val
  elseif instructions[i].inst == "do" then
    doing = true
  elseif instructions[i].inst == "don't" then
    doing = false
  end
end
io.write("*  ", total, "\n** ", total2)
