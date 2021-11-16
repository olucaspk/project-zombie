---@param source number
local function getSteam(source)
    local identifiers = GetPlayerIdentifiers(source)
    for k,v in ipairs(identifiers) do
        if string.match(v,"steam:") then
            return v:gsub("steam:","")
        end
    end
end

---@param source number
local function getDiscord(source)
    local identifiers = GetPlayerIdentifiers(source)
	for k,v in pairs(identifiers) do
        if string.match(v,"discord:") then
            return v:gsub("discord:","")
        end
    end
end

return {
    getSteam = getSteam,
    getDiscord = getDiscord
}