getmetatable('').__index = function(str,i)
  if type(i) == 'number' then
    return string.sub(str,i,i)
  else
    return string[i]
  end
end

local counter = 0
local cursor  = 1

function starts_w(str, cursor, prefix)
  return str:sub(cursor):find("^" .. prefix) ~= nil
end

function isspace(s)
  return string.find(s, '^%s+$') ~= nil
end

function find_arg(a)
  for i, v in pairs(arg) do
    if a == v then return true end 
  end
  return false
end

function read_file(file)
  local file = io.open(file, "rb")
  assert(file, "[error] file path is invalid")
  local content = file:read("*all")
  file:close()
  return content
end

function dump()
  print(counter)
end

assert(arg[1], "[error] no file was specified !")
local file = assert(read_file(arg[1]), "[error] the specified file path does not lead to a valid file !")
local len = file:len()

function skip_spaces()
  while cursor < len and isspace(file[cursor]) do
    cursor = cursor + 1
  end
end

local dump_str = find_arg("--as-str")

while cursor < len do
  skip_spaces()
  if starts_w(file, cursor, "skibidi") or starts_w(file, cursor, "skibidy") then
    counter = counter + 1
  elseif starts_w(file, cursor, "diddy") then
    counter = counter - 1 
  elseif starts_w(file, cursor, "duke") then
    counter = counter * 2
  elseif starts_w(file, cursor, "denis") then
    counter = counter * 3
  elseif starts_w(file, cursor, "sigma") then
    counter = counter * counter
  elseif starts_w(file, cursor, "rizz") then
    counter = 0
  elseif starts_w(file, cursor, "ohio") then
    if not dump_str then 
      print("counter: " .. counter)
    else
      io.write(string.char(counter))
    end
  end
  cursor = cursor + 1
end
