local _resName = "common"
local _isServer = IsDuplicityVersion()
local _modules = {}

function include(name)
    if not _modules[name] then
        local path = ("modules/%s/%s"):format(name,_isServer and "server.lua" or "client.lua")
        local resource = LoadResourceFile(_resName,path)
        local func, err = load(resource,"@@"..path,"t")

        assert(func,err == nil or "\n^1"..err.."^7")
        _modules[name] = func()
    end
    return _modules[name]
end