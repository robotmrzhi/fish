root = "./"
thread = 8
harbor = 0
logger = nil
logpath = "."
start = "login" -- start logind.lua
bootstrap = "snlua bootstrap"

-- skynet lua service config
luaservice = root .. "skynet/service/?.lua;" .. root .. "skynet/test/?.lua;" .. root .. "skynet/examples/?.lua"
lualoader = root .. "skynet/lualib/loader.lua"
lua_path = root .. "skynet/lualib/?.lua;" .. root .. "skynet/lualib/?/init.lua"
lua_cpath = root .. "skynet/luaclib/?.so"

snax = root .. "skynet/example/?.lua;" .. root .. "skynet/test/?.lua"
cpath = root .. "skynet/cservice/?.so"


-- user lua service config
luaservice = root .. "service/?/logind.lua;" .. luaservice
-- user env
logind_port = 8080
logind_agent = 20
