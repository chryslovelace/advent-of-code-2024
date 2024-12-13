local function split(s, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for match in string.gmatch(s, "([^" .. sep .. "]+)") do
    table.insert(t, match)
  end
  return t
end

local function issafe(report)
  local decreasing = true
  local increasing = true
  for i = 2, #report do
    local diff = report[i] - report[i - 1]
    if math.abs(diff) < 1 or math.abs(diff) > 3 then
      return false
    elseif diff > 0 then
      decreasing = false
    elseif diff < 0 then
      increasing = false
    end
  end
  return decreasing or increasing
end

local function shallowcopy(t)
  local copy = {}
  for k, v in pairs(t) do
    copy[k] = v
  end
  return copy
end

local function problemdampener(report)
  for i = 1, #report do
    local dampened = shallowcopy(report)
    table.remove(dampened, i)
    if issafe(dampened) then
      return true
    end
  end
  return false
end

local safecount = 0
local safecount2 = 0
for line in io.lines("inputs/day02.txt") do
  local report = split(line)
  if issafe(report) then
    safecount = safecount + 1
    safecount2 = safecount2 + 1
  elseif problemdampener(report) then
    safecount2 = safecount2 + 1
  end
end
io.write("*  ", safecount, "\n** ", safecount2)
