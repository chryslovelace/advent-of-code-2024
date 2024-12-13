local lefts = {}
local rights = {}
for line in io.lines("inputs/day01.txt") do
  for left, right in string.gmatch(line, "(%w+)%s+(%w+)") do
    table.insert(lefts, tonumber(left))
    table.insert(rights, tonumber(right))
  end
end
table.sort(lefts)
table.sort(rights)
local total = 0
local score = 0
for i = 1, #lefts do
  total = total + math.abs(lefts[i] - rights[i])
  for j = 1, #rights do
    if lefts[i] == rights[j] then
      score = score + lefts[i]
    elseif lefts[i] < rights[j] then
      break
    end
  end
end
io.write("*  ", total, "\n** ", score)
