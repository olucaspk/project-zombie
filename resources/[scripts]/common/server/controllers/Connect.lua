local userIds = {}
local userSources = {}
local userSteams = {}

local Utils <const> = include("utils") 
local Account <const> = include("account")

Citizen.CreateThread(function()
    while not Queue.IsReady() do
        Citizen.Wait(0)
    end

    Queue.OnJoin(function(source,allow)
        local steam <const> = Utils.getSteam(source)
        local discord <const> = Utils.getDiscord(source)
        if not steam then
            allow("[Zombie] Não encontramos sua conexão com a Steam.")
            return
        end

        if not discord then
            allow("[Zombie] Não encontramos sua conexão com o Discord.")
            return
        end

        local account_id <const>, allowlist <const> = Account.checkAccount(source,steam,discord)
        if not account_id then
            allow("[Zombie] Oi "..(GetPlayerName(source) or "jogador")..", criamos uma conta para você. Reconecte-se!")
            return
        end

        if not allowlist then
            allow("[Zombie] Você não possui allowlist.🤸‍♂️\n\n\n🏌️‍♂️🦽")
            return
        end

        -- Queue.AddPriority(steam,10)

        allow()
    end)
end)