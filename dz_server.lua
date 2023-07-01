Config = {}
Config.FrameWork = "ESX" -- Used framework
Config.Group = "admin" -- Allowed group
Config.Length = 7500 -- Announce time length (7500 = 7.5 seconds).
Config.Used = false -- Don't touch.

if Config.FrameWork == nil or Config.Group == nil then
    print("[dz-announcements] Config framework information is nil.")
else
    if Config.FrameWork == "QBCore" and Config.Group == "mod" then
        print("[dz-announcements] QBCore isn't include 'mod' group.")
    elseif Config.FrameWork == "ESX" and Config.Group == "god" then
        print("[dz-announcements] ESX isn't include 'god' group.")
    else
        if Config.FrameWork == "ESX" then
            ESX.RegisterCommand({'announce', 'annc'}, 'admin', function(xPlayer, args, showError)
                if not Config.Used then
                    TriggerClientEvent('dz-announce:client:sendNuiMessage', -1, Config.Length, args.text)
                    Config.Used = true
                    Wait(Config.Length + 1000)
                    Config.Used = false
                end
              end, false, {help ='Send an Announcement', arguments = {{name = 'text', help = 'Message', type = 'any'}}
            })
        elseif Config.FrameWork == "QBCore" then
            QBCore = nil
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            QBCore.Commands.Add("announce", "Send a new announce to the server players.", {}, false, function(source, args)
                if not Config.Used then
                    if args ~= nil then
                        TriggerClientEvent('dz-announce:client:sendNuiMessage', -1, Config.Length, tostring(table.concat(args, " ")))
                        Config.Used = true
                    end
                    Wait(Config.Length + 1000)
                    Config.Used = false
                end
            end, Config.Group)
        else
            print("[dz-announcements] Wrong framework name.")
        end
    end
end