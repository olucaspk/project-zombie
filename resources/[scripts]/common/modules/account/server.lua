---@param source number
---@param steam string
---@param discord string
local function checkAccount(source,steam,discord)
    local accountQuery <const> = exports.oxmysql:executeSync("SELECT `id`,`allowlist` FROM `accounts` WHERE `steam` = @steam",{ steam = steam })
    if #accountQuery > 0 then
        return accountQuery[1].id,accountQuery[1].allowlist
    end

    exports.oxmysql:execute([[
        INSERT INTO `accounts`(`steam`,`discord`,`endpoint`,`created_at`,`last_login`) 
        VALUES(@steam,@discord,@endpoint,NOW(),NOW())
    ]],{
        steam = steam,
        discord = discord,
        endpoint = GetPlayerEndpoint(source)
    })
    return false,false
end

return {
    checkAccount = checkAccount
}