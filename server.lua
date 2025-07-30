local Config = {
    discordLink = "https://discord.gg/yourserver",
    customMessage = "Join our Discord for updates, support, and events!",
    intervalMinutes = 10
}

local function buildMessage()
    return "^5[Server Info]^0 " ..
        (Config.customMessage and (Config.customMessage .. " ") or "") ..
        "Discord: ^4" .. Config.discordLink
end

local function announceDiscord()
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 255, 255 },
        args = { buildMessage() }
    })
end

RegisterNetEvent("discord:sendToPlayer")
AddEventHandler("discord:sendToPlayer", function()
    local src = source
    TriggerClientEvent('chat:addMessage', src, {
        color = { 255, 255, 255 },
        args = { buildMessage() }
    })
end)

RegisterCommand("discord", function(src)
    TriggerClientEvent('chat:addMessage', src, {
        color = { 255, 255, 255 },
        args = { buildMessage() }
    })
end, false)

CreateThread(function()
    Wait(5000)
    while true do
        announceDiscord()
        Wait(Config.intervalMinutes * 60 * 1000)
    end
end)
