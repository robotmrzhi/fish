local MsgDefine = {}

local _idTbl = 
{
  --login msg protocol
  {name = "login.login" , url_pattern = "^(/login/)%w*"},

}

local _nameTbl = {}

for id, v in ipairs(_idTbl) do
  _nameTbl[v.name] = v.url_pattern
end


function MsgDefine.nameToUrlPattern(name)
  return _nameTbl[name]
end

function MsgDefine.UrlToName(url)
  for k, v in ipairs(_nameTbl) do
    local ind = string.match(url, v.url_pattern)
    if ind ~= nil then
      return k
    end
  end
  return nil
end

return MsgDefine
  
