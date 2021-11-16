-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatMessage")
AddEventHandler("chatMessage",function(author,color,text)
  local args = { text }
  if author ~= "" then
    table.insert(args,1,author)
  end

  SendNUIMessage({ type = "ON_MESSAGE", message = { color = color, multiline = true, args = args } })
  SendNUIMessage({ type = "ON_SCREEN_STATE_CHANGE", shouldHide = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERPRINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("__cfx_internal:serverPrint")
AddEventHandler("__cfx_internal:serverPrint",function(msg)
	SendNUIMessage({ type = 'ON_MESSAGE', message = { templateId = "print", multiline = true, args = { msg } } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:addMessage")
AddEventHandler("chat:addMessage",function(message)
	SendNUIMessage({ type = "ON_MESSAGE", message = message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:clear")
AddEventHandler("chat:clear",function(name)
	SendNUIMessage({ type = "ON_CLEAR" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARSUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:clearSuggestions")
AddEventHandler("chat:clearSuggestions",function()
	SendNUIMessage({ type = "ON_SUGGESTIONS_REMOVE" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chatResult",function(data,cb)
	SetNuiFocus(false)

	if data.message then
		if data.message:sub(1,1) == "/" then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent("chat:messageEntered",data.message)
		end
	end

	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSUGGESTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:addSuggestion")
AddEventHandler("chat:addSuggestion",function(suggestions)
	for _,suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("loaded",function(data,cb)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openChat",function(source,args)
  SetNuiFocus(true)
  SendNUIMessage({ type = "ON_OPEN" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openChat","Abrir chat","keyboard","t")
