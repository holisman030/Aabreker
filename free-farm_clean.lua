-- Recovered Luau source by ZeroVector
local lib = loadstring(game:HttpGetAsync("https://script.panduhub.com/PanduUiLibrary.lua"))()

local tbl = {
    EnableAutoFarm = false,
    ServerHop = false,
    AutoExecute = false,
    EnableWebhook = false,
    WebhookLink = "",
}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
game:GetService("VirtualUser")
game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local flag = false

local tbl2 = {
    LastFinishPos = nil,
    BeatSurvivorDone = false,
    LastRole = nil,
}

local flag2 = false
local flag3 = false
local n = 0
local tbl3 = {}
local v = nil
local jobId = nil
local flag4 = false
local flag5 = false
local flag6 = false
local flag7 = false
tick()

local function fn(arg, arg2, arg3)
    local now = os.clock()
    if now - n < 2.5 then
        return
    end
    n = now
    local notify = lib.Notify
    local tbl4 = {Title = arg, Description = arg2}
    local duration = arg3 or 3
    tbl4.Duration = duration
    notify(lib, tbl4)
end

local function fn2()
    local team = localPlayer.Team
    if not team then
        return "Unknown"
    end
    local name = team.Name
    if name == "Killer" then
        return "Killer"
    end

    if name == "Survivors" then
        return "Survivor"
    end

    if name ~= "Spectator" and name ~= "Spectators" then
        return "Lobby"
    end
    return "Spectator"
end

local function fn3()
    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    return humanoidRootPart
end

local function fn4(arg)
    local v2 = syn
    local request_ = v2 and syn.request

    if not request_ then
        local v3 = http
        request_ = v3 and http.request
    end

    if not request_ then
        request_ = http_request
    end

    if not request_ then
        request_ = request
    end

    if not request_ then
        local v3 = fluxus
        request_ = v3 and fluxus.request
    end

    if not request_ then
        local v3 = krnl
        request_ = v3 and krnl.request
    end

    local v3 = request_ and request_(arg)
    return v3
end

local function fn5()
    local v2 = identifyexecutor
    local str = v2 and identifyexecutor()

    if not str then
        local v3 = getexecutorname
        str = v3 and getexecutorname()
    end

    if not str then
        str = "Unknown Executor"
    end

    return str
end

local function fn6(arg)
    if not writefile then
        return false
    end

    local tbl4 = {
        UserId = localPlayer.UserId,
        KillerChance = arg.KillerChance,
        EXP = arg.EXP,
        Screws = arg.Screws,
        Gears = arg.Gears,
        UpdatedAt = os.time(),
    }

    return pcall(function()
        writefile("VD_AutoFarm_Attributes.json", HttpService:JSONEncode(tbl4))
    end)
end

local function fn7(arg, arg2)
    local num = tonumber(arg)
    local n2 = num or 0
    local v2 = n2
    if arg2 == nil then
        return 0
    end
    local num2 = tonumber(arg2)
    local n3 = num2 or 0
    return v2 - n3
end

local tbl4 = (function()
    if not isfile or not readfile or not isfile("VD_AutoFarm_Attributes.json") then
        return nil
    end

    local ok, result = pcall(function()
        return HttpService:JSONDecode(readfile("VD_AutoFarm_Attributes.json"))
    end)

    if ok and type(result) == "table" and tonumber(result.UserId) == localPlayer.UserId then
        return {
            KillerChance = tonumber(result.KillerChance),
            EXP = tonumber(result.EXP),
            Screws = tonumber(result.Screws),
            Gears = tonumber(result.Gears),
        }
    end

    return nil
end)()

local function fn8(arg)
    local flag8 = arg ~= "" and string.find(arg, "discord.com/api/webhooks")
    return flag8
end

local function fn9(arg, description, arg2)
    if not arg2 and not tbl.EnableWebhook then
        return false, "Disabled"
    end
    local webhookLink = tbl.WebhookLink
    if not fn8(webhookLink) then
        return false, "Invalid URL"
    end
    local attributes = localPlayer:GetAttributes()
    local num = tonumber(attributes.KillerChance)
    local n2 = num or 0
    local num2 = tonumber(attributes.EXP)
    local n3 = num2 or 0
    local num3 = tonumber(attributes.Screws)
    local n4 = num3 or 0
    local num4 = tonumber(attributes.Gears)
    local n5 = num4 or 0
    local num5 = tonumber(attributes.Level)
    local n6 = num5 or 0

    if not tbl4 then
        tbl4 = {KillerChance = n2, EXP = n3, Screws = n4, Gears = n5}
    end

    local tbl5 = {}
    local embeds = {}
    local tbl6 = {}
    local title = arg or string.format("%s · Level %d", localPlayer.DisplayName, n6)
    tbl6.title = title
    tbl6.url = string.format("https://www.roblox.com/users/%d/profile", localPlayer.UserId)
    tbl6.description = description
    tbl6.color = 3638942
    local fields = {}

    local tbl7 = {
        name = "💀 SIN",
        value = string.format("%s (**%+d**)", n2, fn7(n2, tbl4.KillerChance)),
        inline = false,
    }

    local tbl8 = {
        name = "🧪 EXP",
        value = string.format("%s (**%+d**)", n3, fn7(n3, tbl4.EXP)),
        inline = false,
    }

    local tbl9 = {
        name = "🔩 Screws",
        value = string.format("%s (**%+d**)", n4, fn7(n4, tbl4.Screws)),
        inline = false,
    }

    local tbl10 = {
        name = "⚙️ Gears",
        value = string.format("%s (**%+d**)", n5, fn7(n5, tbl4.Gears)),
        inline = false,
    }

    local tbl11 = {name = "🆔 Server ID"}
    local format = string.format
    local jobId2 = game.JobId ~= "" and game.JobId or "Singleplayer"
    tbl11.value = format("```\n%s\n```", jobId2)
    tbl11.inline = false
    fields[1] = tbl7
    fields[2] = tbl8
    fields[3] = tbl9
    fields[4] = tbl10
    fields[5] = tbl11
    tbl6.fields = fields
    tbl6.footer = {text = string.format("Oxio Auto Farm · %s", fn5())}
    tbl6.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
    embeds[1] = tbl6
    tbl5.embeds = embeds

    local v2 = fn4({
        Url = webhookLink,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(tbl5),
    })

    if v2 and (v2.StatusCode == 200 or v2.StatusCode == 204) then
        tbl4 = {KillerChance = n2, EXP = n3, Screws = n4, Gears = n5}
        fn6(tbl4)
        return true, "OK"
    end

    local v3 = tostring
    local statusCode = v2 and v2.StatusCode or "No Response"
    return false, "Status: " .. v3(statusCode)
end

local function fn10(arg, arg2)
    return false
end

local function fn11(arg)
    local position = nil

    pcall(function()
        if not arg:FindFirstChild("RooftopHitbox") and not arg:FindFirstChild("Rooftop") then
            if not arg:FindFirstChild("HooksMeat") then
                if not arg:FindFirstChild("churchbell") then
                    local finishline = arg:FindFirstChild("Finishline")
                    local finishLine = finishline or arg:FindFirstChild("FinishLine") or arg:FindFirstChild("Fininshline")

                    if not finishLine then
                        for i, descendant in ipairs(arg:GetDescendants()) do
                            if descendant.Name:lower():find("finish") then
                                if not descendant:IsA("BasePart") then
                                    if not descendant:IsA("Model") then
                                        continue
                                    end
                                    local basePart = descendant:FindFirstChildWhichIsA("BasePart")
                                    if basePart then
                                        position = basePart.Position
                                        break
                                    end
                                    continue
                                end

                                position = descendant.Position
                                break
                            end

                            continue
                        end

                        if position then
                            return
                        end

                        for i, descendant in ipairs(arg:GetDescendants()) do
                            if descendant:IsA("MeshPart") and descendant.Material == Enum.Material.Limestone then
                                position = Vector3.new(-947.9, 152.12, -7579.52)
                                break
                            end
                        end

                        if position then
                            return
                        end

                        for i, descendant in ipairs(arg:GetDescendants()) do
                            if descendant:IsA("MeshPart") and descendant.Material == Enum.Material.Leather then
                                position = Vector3.new(1546.12, 152.21, -796.72)
                                break
                            end
                        end

                        return
                    end

                    if finishLine:IsA("BasePart") then
                        position = finishLine.Position
                    elseif finishLine:IsA("Model") then
                        local basePart = finishLine:FindFirstChildWhichIsA("BasePart")

                        if basePart then
                            position = basePart.Position
                        end
                    end

                    return
                end

                position = Vector3.new(760.98, -20.14, -78.48)
                return
            end

            position = Vector3.new(1546.12, 152.21, -796.72)
            return
        end

        position = Vector3.new(3098.16, 454.04, -4918.74)
    end)

    return position
end

local function fn12()
    if not tbl.EnableAutoFarm then
        tbl2.BeatSurvivorDone = false
        tbl2.LastFinishPos = nil
        return
    end

    local v2 = fn2()

    if tbl2.LastRole ~= v2 then
        if v2 == "Survivor" then
            fn("🟢 Survivor!", "Ready to farm.")
        end

        tbl2.LastRole = v2
    end

    if v2 ~= "Survivor" then
        return
    end

    if not fn3() then
        fn("⏳ Waiting", "Character not loaded")
        return
    end
    local map = Workspace:FindFirstChild("Map")
    if not map then
        fn("⚠️ No Map", "Waiting for map")
        return
    end
    local v3 = fn11(map)
    if not v3 then
        fn("⚠️ Finish Not Found", "Map unsupported")
        return
    end

    if tbl2.LastFinishPos and (v3 - tbl2.LastFinishPos).Magnitude > 50 then
        tbl2.BeatSurvivorDone = false
    end

    if tbl2.BeatSurvivorDone then
        return
    end
    fn("📍 Finish Found", "Waiting 6s...")
    task.wait(6)
    if not tbl.EnableAutoFarm then
        fn("⛔ Cancelled", "Toggle turned off")
        return
    end

    if fn2() == "Survivor" then
        local v4 = fn3()
        if not v4 then
            fn("⛔ Cancelled", "Character missing")
            return
        end
        fn("🚀 Teleporting", "Moving to finish...")
        v4.CFrame = CFrame.new(v3)
        tbl2.BeatSurvivorDone = true
        tbl2.LastFinishPos = v3
        fn("✅ Teleport Success", "Round completed!")

        if not flag2 then
            flag2 = true

            task.spawn(function()
                local now = os.clock()

                while os.clock() - now < 5 do
                    if not tbl.EnableAutoFarm then
                        flag2 = false
                        return
                    end

                    if fn2() == "Spectator" then
                        flag2 = false
                        fn("👁️ Match Completed", "Role changed to Spectator.")
                        return
                    end

                    task.wait(0.5)
                end

                if fn2() == "Survivor" then
                    fn("🔴 Match Stuck", "Still Survivor after finish. Hopping...")

                    pcall(function()
                        fn10("🔴 Match Stuck", string.format("Role remained `%s` after %ds.\nServer: `%s`", tostring(fn2()), 5, tostring(game.JobId)))
                    end)

                    if tbl.ServerHop then
                        flag3 = true
                    end
                end

                flag2 = false
            end)
        end

        task.wait(5)
        fn9()
        return
    end

    fn("⛔ Cancelled", "Not Survivor anymore")
end

local function fn13()
    if not isfile or not readfile or not isfile("ServerHop.txt") then
        return {}
    end
    local ok, result = pcall(readfile, "ServerHop.txt")
    if not ok then
        return {}
    end
    local now = os.time()
    local tbl5 = {}

    for i, part in ipairs(result:split("\n")) do
        local match, v2 = part:match("^([^|]+)|(%d+)$")
        local num = tonumber(v2)

        if match and match ~= "" and num and now < num then
            tbl5[match] = num
        end
    end

    return tbl5
end

local function fn14(arg)
    if not writefile then
        return
    end
    local now = os.time()
    local tbl5 = {}

    for k, v2 in pairs(arg) do
        if k and v2 and now < v2 then
            table.insert(tbl5, k .. "|" .. v2)
        end
    end

    pcall(function()
        writefile("ServerHop.txt", table.concat(tbl5, "\n"))
    end)
end

local function fn15(arg, arg2)
    if not arg then
        return
    end
    local n2 = os.time() + arg2
    tbl3[arg] = n2
    fn14(tbl3)
end

local function fn16(arg)
    local v2 = tbl3[arg]
    if not v2 then
        return false
    end

    if v2 > os.time() then
        return true
    end
    tbl3[arg] = nil
    fn14(tbl3)
    return false
end

local function fn17()
    if not flag7 then
        return false
    end
    local v2 = fn2()
    local flag8 = v2 == "Spectator" or v2 == "Killer"
    return flag8
end

local function fn18()
    v = nil
    jobId = nil
    flag4 = false
    flag5 = false
end

local function fn19(arg)
    v = arg
    jobId = game.JobId
    flag4 = true
    flag5 = false
end

local function fn20(arg)
    fn19(arg)

    local ok, result = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, arg, localPlayer)
    end)

    if ok then
        return true
    end
    flag4 = false
    fn15(arg, 600)
    fn("❌ Teleport Error", "Call failed, retrying later")

    pcall(function()
        fn10("🐛 Teleport Call Failed", string.format("Server: `%s`\nError: `%s`", arg, tostring(result)))
    end)

    fn18()
    return false
end

local function fn21()
    local now = os.clock()

    while flag4 and not flag5 and os.clock() - now < 6 do
        if game.JobId ~= jobId then
            return "Success"
        end
        task.wait(0.1)
    end

    if flag5 then
        return "Failed"
    end

    if game.JobId == jobId then
        return "Timeout"
    end
    return "Success"
end

TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
    if arg ~= localPlayer or not flag4 then
        return
    end
    local v2 = v
    flag5 = true

    if v2 then
        fn15(v2, 600)
        fn("❌ Teleport Failed", string.format("Server %s blacklisted 10m", v2:sub(1, 8)))

        pcall(function()
            fn10("🐛 Teleport Failed", string.format("Server: `%s`\nCode: `%s`\nError: `%s`", v2, tostring(arg2), tostring(arg3)))
        end)
    end
end)

local function fn22()
    local str, v2, v3, str2, ok, result, v4, v5, str3, ok2, result2, v6, str4, ok3, result3, v7, str5, ok4, result4, v8
    local str6, ok5, result5, jobId2, flag8, v9, v10, v11, v12, v13, v14, id, v15, v16, nextPageCursor, str7, n2
    n2 = 1

    while true do
        if n2 == 1 then
            if flag6 then
                n2 = 2
            else
                n2 = 3
            end
        elseif n2 == 2 then
            return
        elseif n2 == 3 then
            flag6 = true
            tbl3 = fn13()
            fn18()
            str = ""
            n2 = 4
        elseif n2 == 4 then
            if tbl.ServerHop and not flag then
                n2 = 6
            else
                n2 = 5
            end
        elseif n2 == 5 then
            fn18()
            flag6 = false
            return
        elseif n2 == 6 then
            v2 = flag3
            v3 = v2
            flag3 = false

            if not v2 and not fn17() then
                n2 = 52
            else
                n2 = 7
            end
        elseif n2 == 7 then
            str2 = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", game.PlaceId, HttpService:UrlEncode(str))

            ok, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(str2))
            end)

            v4 = result

            if ok and result and type(result.data) == "table" then
                n2 = 33
            else
                n2 = 8
            end
        elseif n2 == 8 then
            task.wait(2.5)
            n2 = 9
        elseif n2 == 9 then
            if tbl.ServerHop and not flag then
                n2 = 11
            else
                n2 = 10
            end
        elseif n2 == 10 then
            fn18()
            flag6 = false
            return
        elseif n2 == 11 then
            v5 = flag3
            v3 = v5
            flag3 = false

            if not v5 and not fn17() then
                n2 = 32
            else
                n2 = 12
            end
        elseif n2 == 12 then
            str3 = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", game.PlaceId, HttpService:UrlEncode(str))

            ok2, result2 = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(str3))
            end)

            v4 = result2

            if ok2 and result2 and type(result2.data) == "table" then
                n2 = 33
            else
                n2 = 13
            end
        elseif n2 == 13 then
            task.wait(2.5)
            n2 = 14
        elseif n2 == 14 then
            if tbl.ServerHop and not flag then
                n2 = 16
            else
                n2 = 15
            end
        elseif n2 == 15 then
            fn18()
            flag6 = false
            return
        elseif n2 == 16 then
            v6 = flag3
            v3 = v6
            flag3 = false

            if not v6 and not fn17() then
                n2 = 31
            else
                n2 = 17
            end
        elseif n2 == 17 then
            str4 = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", game.PlaceId, HttpService:UrlEncode(str))

            ok3, result3 = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(str4))
            end)

            v4 = result3

            if ok3 and result3 and type(result3.data) == "table" then
                n2 = 33
            else
                n2 = 18
            end
        elseif n2 == 18 then
            task.wait(2.5)
            n2 = 19
        elseif n2 == 19 then
            if tbl.ServerHop and not flag then
                n2 = 21
            else
                n2 = 20
            end
        elseif n2 == 20 then
            fn18()
            flag6 = false
            return
        elseif n2 == 21 then
            v7 = flag3
            v3 = v7
            flag3 = false

            if not v7 and not fn17() then
                n2 = 30
            else
                n2 = 22
            end
        elseif n2 == 22 then
            str5 = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", game.PlaceId, HttpService:UrlEncode(str))

            ok4, result4 = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(str5))
            end)

            v4 = result4

            if ok4 and result4 and type(result4.data) == "table" then
                n2 = 33
            else
                n2 = 23
            end
        elseif n2 == 23 then
            task.wait(2.5)
            n2 = 24
        elseif n2 == 24 then
            if tbl.ServerHop and not flag then
                n2 = 26
            else
                n2 = 25
            end
        elseif n2 == 25 then
            fn18()
            flag6 = false
            return
        elseif n2 == 26 then
            v8 = flag3
            v3 = v8
            flag3 = false

            if not v8 and not fn17() then
                n2 = 29
            else
                n2 = 27
            end
        elseif n2 == 27 then
            str6 = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&sortOrder=Asc&excludeFullGames=true&cursor=%s", game.PlaceId, HttpService:UrlEncode(str))

            ok5, result5 = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(str6))
            end)

            v4 = result5

            if ok5 and result5 and type(result5.data) == "table" then
                n2 = 33
            else
                n2 = 28
            end
        elseif n2 == 28 then
            str = ""

            pcall(function()
                fn10("API Error", "Reset pagination after 5 failures")
            end)

            task.wait(2.5)
            n2 = 4
        elseif n2 == 29 then
            fn18()
            task.wait(0.5)
            n2 = 24
        elseif n2 == 30 then
            fn18()
            task.wait(0.5)
            n2 = 19
        elseif n2 == 31 then
            fn18()
            task.wait(0.5)
            n2 = 14
        elseif n2 == 32 then
            fn18()
            task.wait(0.5)
            n2 = 9
        elseif n2 == 33 then
            jobId2 = game.JobId
            flag8 = false
            v9, v10, v11 = ipairs(v4.data)
            v12 = v11
            n2 = 34
        elseif n2 == 34 then
            v13, v14 = v9(v10, v12)

            if v13 == nil then
                n2 = 46
            else
                n2 = 35
            end
        elseif n2 == 35 then
            v12 = v13

            if tbl.ServerHop and not flag and (v3 or fn17()) then
                n2 = 36
            else
                n2 = 46
            end
        elseif n2 == 36 then
            if v14.id and v14.id ~= jobId2 and v14.playing == 2 and not fn16(v14.id) then
                n2 = 37
            else
                n2 = 34
            end
        elseif n2 == 37 then
            flag8 = true
            id = v14.id
            fn15(id, 180)
            fn("📡 Teleporting", string.format("%d player | %s", v14.playing, id:sub(1, 8)))

            if fn20(id) then
                n2 = 38
            else
                n2 = 45
            end
        elseif n2 == 38 then
            v15 = fn21()

            if v15 == "Success" then
                n2 = 44
            else
                n2 = 39
            end
        elseif n2 == 39 then
            if v15 == "Failed" then
                n2 = 43
            else
                n2 = 40
            end
        elseif n2 == 40 then
            v16 = v

            if v16 then
                n2 = 41
            else
                n2 = 42
            end
        elseif n2 == 41 then
            fn15(v16, 600)

            pcall(function()
                fn10("🐛 Teleport Timeout", string.format("Server %s no response in %ds", v16, 6))
            end)

            n2 = 42
        elseif n2 == 42 then
            fn("⚠️ Timeout", "Server didn't respond, trying next")
            fn18()
            task.wait(1)
            n2 = 34
        elseif n2 == 43 then
            fn18()
            task.wait(1)
            n2 = 4
        elseif n2 == 44 then
            fn18()
            flag6 = false
            return
        elseif n2 == 45 then
            task.wait(1)
            n2 = 4
        elseif n2 == 46 then
            if flag8 then
                n2 = 4
            else
                n2 = 47
            end
        elseif n2 == 47 then
            nextPageCursor = v4.nextPageCursor
            str7 = nextPageCursor

            if nextPageCursor then
                n2 = 49
            else
                n2 = 48
            end
        elseif n2 == 48 then
            str7 = ""
            n2 = 49
        elseif n2 == 49 then
            if str7 == "" then
                n2 = 51
            else
                n2 = 50
            end
        elseif n2 == 50 then
            str = str7
            task.wait(0.5)
            n2 = 4
        elseif n2 == 51 then
            str = ""
            fn("⚠️ Server Hop", "No 1-3 player server available")
            task.wait(1.5)
            n2 = 4
        elseif n2 == 52 then
            fn18()
            task.wait(0.5)
            n2 = 4
        end
    end
end

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local statusUpdateEvent = remotes:WaitForChild("StatusUpdateEvent")
local timeUpdateEvent = remotes:WaitForChild("TimeUpdateEvent")

statusUpdateEvent.OnClientEvent:Connect(function(arg)
    if arg == "WaitingForPlayers" or arg == "IntermissionStarting" or arg == "Intermission" then
        flag7 = false
        tbl2.BeatSurvivorDone = false
    end
end)

timeUpdateEvent.OnClientEvent:Connect(function(arg)
    if arg == "Round" then
        flag7 = true
    end
end)

local v2 = lib:CreateWindow({
    Title = "Oxio Auto Farm",
    Subtitle = "Violence District (FREE)",
    SubtitleColor = Color3.fromRGB(190, 140, 255),
    Logo = "rbxassetid://118755181202304",
    LogoSize = 32,
    SphereText = false,
    SphereWords = "VD",
    SphereImage = "rbxassetid://118755181202304",
    SphereIconSize = 38,
})

local Overview = v2:CreateTab("Dashboard", true, false):CreatePage("Overview")
local Welcome = Overview:CreateSection("Welcome")
local addProfile = Welcome.AddProfile
local displayName = localPlayer.DisplayName
local str = displayName or "User"
addProfile(Welcome, "Hello, " .. str, "Auto Farm Ready | @VD")
local v3 = Overview:CreateSection("Premium Features")

v3:AddToggle("Anti AFK", false, function(arg)
    print("Anti AFK is premium only")
end, {Locked = true, LockText = "Premium Only"}):AddKeyPicker()

v3:AddToggle("NoClip", false, function(arg)
    print("NoClip is premium only")
end, {Locked = true, LockText = "Premium Only"}):AddKeyPicker()

v3:AddToggle("Invisible", false, function(arg)
    print("Invisible is premium only")
end, {Locked = true, LockText = "Premium Only"}):AddKeyPicker()

local Attributes = Overview:CreateSection("Attributes")
local Level = Attributes:AddStat("Level", "0")
local v4 = Attributes:AddStat("💀 SIN", "0")
local v5 = Attributes:AddStat("🧪 EXP", "0")
local v6 = Attributes:AddStat("🔩 Screws", "0")
local v7 = Attributes:AddStat("⚙️ Gears", "0")
local v8 = Overview:CreateSection("Server Info")
local Role = v8:AddStat("Role", fn2())
local Health = v8:AddStat("Health", "0")
local Players2 = v8:AddStat("Players", "0/0")
local Ping = v8:AddStat("Ping", "0ms")
local Main = v2:CreateTab("Auto Farm", false, false):CreatePage("Main")
local v9 = Main:CreateSection("Farm Settings")

v9:AddToggle("Survivor Farm", tbl.EnableAutoFarm, function(enableAutoFarm)
    tbl.EnableAutoFarm = enableAutoFarm

    if not enableAutoFarm then
        tbl2.BeatSurvivorDone = false
        tbl2.LastFinishPos = nil
    end
end):AddKeyPicker("F")

v9:AddToggle("Server Hop", tbl.ServerHop, function(serverHop)
    tbl.ServerHop = serverHop

    if serverHop then
        task.spawn(fn22)
    end
end):AddKeyPicker("H")

v9:AddToggle("Auto Execute", false, function(arg)
    print("Auto Execute is premium only")
end, {Locked = true, LockText = "Premium Only"})

local Webhook = Main:CreateSection("Webhook")

Webhook:AddToggle("Enable Webhook", tbl.EnableWebhook, function(enableWebhook)
    tbl.EnableWebhook = enableWebhook
end)

Webhook:AddTextbox("Webhook URL", "https://discord.com/api/webhooks/...", function(webhookLink)
    tbl.WebhookLink = webhookLink
end)

Webhook:AddButton("Test Webhook", function()
    local v10, v11 = fn9("🔔 Webhook Test", "Test from Oxio Auto Farm", true)

    if v10 then
        fn("Webhook Success", "Test message sent!")
    else
        fn("Webhook Failed", v11, 5)
    end
end)

local ui = v2:CreateTab("Settings", false, false):CreatePage("UI")
local Appearance = ui:CreateSection("Appearance")

Appearance:AddKeybind("Menu Keybind", "RightShift", function(arg)
    v2:SetMenuKey(arg)
end)

Appearance:AddToggle("Custom Cursor", true, function(showCustomCursor)
    lib.ShowCustomCursor = showCustomCursor
end)

Appearance:AddToggle("Transparency", false, function(arg)
    local setTransparency = v2.SetTransparency
    local n2 = arg and 0.2 or 0
    setTransparency(v2, n2)
end)

Appearance:AddToggle("Lock GUI", false, function(arg)
    v2:SetLocked(arg)
end)

local Config = ui:CreateSection("Config")
Config:AddConfigManager("VDFarmFree/Configs")

Config:AddButton("Unload Script", function()
    flag = true
    lib:Unload()
    fn("Unloaded", "Script stopped successfully.")
end)

task.spawn(function()
    while not flag do
        task.wait(1)

        pcall(function()
            local v10 = fn2()
            Role.Set(v10)
            local character = localPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local n2 = humanoid and math.floor(humanoid.Health) or 0
            Health.Set(tostring(n2))
            local str2 = #Players:GetPlayers() .. "/" .. Players.MaxPlayers
            Players2.Set(str2)
            local str3 = math.floor(localPlayer:GetNetworkPing() * 1000) .. "ms"
            Ping.Set(str3)
            local attributes = localPlayer:GetAttributes()
            local set = Level.Set
            local v11 = tostring
            local level = attributes.Level
            local n3 = level or 0
            set(v11(n3))
            local set2 = v4.Set
            local v12 = tostring
            local killerChance = attributes.KillerChance
            local n4 = killerChance or 0
            set2(v12(n4))
            local set3 = v5.Set
            local v13 = tostring
            local exp = attributes.EXP
            local n5 = exp or 0
            set3(v13(n5))
            local set4 = v6.Set
            local v14 = tostring
            local screws = attributes.Screws
            local n6 = screws or 0
            set4(v14(n6))
            local set5 = v7.Set
            local v15 = tostring
            local gears = attributes.Gears
            local n7 = gears or 0
            set5(v15(n7))
        end)
    end
end)

task.spawn(function()
    while not flag do
        pcall(fn12)
        task.wait(1)
    end
end)

print("✅ Oxio Auto Farm (FREE) Loaded Successfully!")
print("🔒 Premium features are locked. Upgrade to VIP to unlock.")
