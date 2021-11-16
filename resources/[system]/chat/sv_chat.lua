-- RegisterServerEvent("chat:messageEntered")
-- AddEventHandler("chat:messageEntered",function(message)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local identity = vRP.getUserIdentity(user_id)
-- 		if identity then
-- 			TriggerClientEvent("chatMessage",source,identity["name"].." "..identity["name2"],{100,100,100},"^3"..message)

-- 			local players = vRPC.nearestPlayers(source,10)
-- 			for k,v in pairs(players) do
-- 				async(function()
-- 					TriggerClientEvent("chatMessage",k,identity["name"].." "..identity["name2"],{100,100,100},"^3"..message)
-- 				end)
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDFALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("__cfx_internal:commandFallback")
AddEventHandler("__cfx_internal:commandFallback",function(command)
	local name = GetPlayerName(source)
	if not command or not name then
		return
	end

	CancelEvent()
end)