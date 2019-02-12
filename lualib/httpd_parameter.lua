

local M = {}


local function process_parameters(_str, start_index, len)
  local pos = start_index
  local end_index = start + len

  local tmp_name, tmp_val
  
  while pos < end_index
  do
    local name_start = pos
    local name_end = -1
    local val_start = -1
    local val_end = -1

    local parsing_name = true
    local decode_name = false
    local decode_val = false
    local parameter_complete = false

    repeat
      local ch = string.sub(_str, pos, pos)

      if ch == "=" then
        if parsing_name then
          name_end = pos
          parsing_name = false
          val_start = pos + 1
        end

      elseif ch == "&" then
        if parsing_name then
          -- name finished no value
          name_end = pos
        else
          val_end = pos
        end

        parameter_complete = true

      elseif ch == "%" or ch == "+" then
        if parsing_name then
          decode_name = true
        else
          decode_val = true
        end
      end

      pos = pos + 1

     
    until(not parameter_complete and pos < end_index)

    if pos == end_index then
      if name_end == -1 then
        name_end = pos
      elseif val_start > -1 and val_end == -1 then
        val_end = pos
      end
    end

    if name_end <= name_start then
      -- &&  &=foo& err
      -- if val_start == -1 then
        -- &&
       -- goto continue -- lua no continue
      -- end
      goto continue
    end

    tmp_name = string.sub(_str, name_start, name_end)
    if val_start >=0 then
      tmp_val = string.sub(_str, val_start, val_end)
    else
      tmp_val = nil
    end


  ::continue::
  end

end


local function tbl_has_key(tbl, key)
  for v, k in pairs(tbl) do
    if v == key then
      return true
    end
  end
  return false
end


local function explode(_str, seperator)
  local pos, arr = 0, {}
  for st, sp in function() return string.find(_str, seperator, pos, true ) end do
    table.insert(arr, string.sub(_str, pos, st-1))
    pos = sp + 1
  end

  table.insert(arr, string.sub(_str, pos))
  
  return arr

end

local function body_tbl(body)
  local ret = {}
  for k,v in  string.gmatch(body, "(%w*)=(%w*)") do
    
    local key = k
 
    if ret and tbl_has_key(ret, key) then
    
      local val = ret[k]
    
      if type(val) ~= "table" then
        ret[k] = {val, v}
      else
        local size = #val
        ret[k][size+1] = v
      end
    
    else
      ret[k] = v
    end
  end

  return ret
end


local function decode_url(s)
  local ret = s
  ret = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
  return ret
end

local function encode_url(s)
  local ret = s
  ret = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X",string.byte(c)) end)
  return string.gsub(ret," ","+")
end

--local d_url = decode_url("1=0&23=3%24%24%24%26%2611")

--print(d_url)


--local e_url = encode_url("a=a v&dsdd$$$")

--print(e_url)


