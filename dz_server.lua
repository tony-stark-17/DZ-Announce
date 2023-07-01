Config = {}
Config.Length = 7500 -- Announce time length (7500 = 7.5 seconds).
Config.Used = false -- Don't touch.

ESX.RegisterCommand({'announce', 'annc'}, 'admin', function(xPlayer, args, showError)
    if not Config.Used then
        TriggerClientEvent('dz-announce:client:sendNuiMessage', -1, Config.Length, args.text)
        Config.Used = true
        Wait(Config.Length + 1000)
        Config.Used = false
    end
  end, false, {help ='Send an Announcement', arguments = {{name = 'text', help = 'Message', type = 'string'}}
})