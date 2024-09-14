-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Function to change booth text
local function setBooth(text, imageId)
    local args = {
        [1] = "Update",
        [2] = {
            ["DescriptionText"] = text,
            ["ImageId"] = imageId
        }
    }
    game:GetService("ReplicatedStorage").CustomiseBooth:FireServer(unpack(args))
end

-- UI Configuration
local UI_SETTINGS = {
    SHADOW_SPREAD = 2,
    SHADOW_BLUR = 8,
    SHADOW_OPACITY = 0.3,
    SHADOW_COLOR = Color3.new(172/255, 170/255, 28/255),
    BASE_COLOR = Color3.new(1, 1, 0),
    BACKGROUND_COLOR = Color3.fromRGB(40, 40, 40),
    TEXT_COLOR = Color3.new(1, 1, 1)
}

-- Create a new window
local Window = Rayfield:CreateWindow({
    Name = "UserCreationHook V1.3 | discord.gg/usercreation",
    LoadingTitle = "UserCreationHook V1.3",
    LoadingSubtitle = "Bypassing limits | .gg/usercreation",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "UserCreation"
    },
    Discord = {
        Enabled = true,
        Invite = "usercreation",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "UserCreationHook V1.3",
        Subtitle = "Key System",
        Note = "Get the key in our discord! | .gg/usercreation",
        FileName = "Key",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"booths"}
    }
})

Rayfield:Notify({
   Title = "UserCreation Has Loaded.",
   Content = "discord.gg/usercreation",
   Duration = 4,
   Image = 4483362458
})

-- Ensure services are loaded
repeat wait() until game:IsLoaded()

-- Function to send a message to a Discord webhook
local function sendWebhookMessage(url, content, displayName, username, gameName, avatarUrl)
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "UserCreationHook V1.3 has been executed!",
            ["description"] = content,
            ["color"] = 225, -- Black color
            ["fields"] = {
                {
                    ["name"] = "User Information",
                    ["value"] = "Display Name: " .. displayName .. "\nUsername: @" .. username,
                    ["inline"] = false
                },
                {
                    ["name"] = "Game:",
                    ["value"] = "Game: " .. gameName,
                    ["inline"] = false
                },
                {
                    ["name"] = "Time Executed:",
                    ["value"] = os.date("%d/%m/%Y %H:%M"),
                    ["inline"] = false
                }
            },
            ["thumbnail"] = {
                ["url"] = avatarUrl
            },
            ["footer"] = {
                ["text"] = "UserCreation | Bypassing limits"
            }
        }}
    }
    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local request = http_request or request or HttpPost or syn.request
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = jsonData
    })
end

-- Print "Starting..." immediately
print("Starting...")

-- Get the player info
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local displayName = player.DisplayName
local username = player.Name

-- Get the game name
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Get the player's avatar URL
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

-- Send a message to the Discord webhook immediately
local webhookUrl = "https://discord.com/api/webhooks/1275773140458274866/xFMiK0Q8FjUQWZOzMdcU4-anPkpJm1D9Oue2JMGqdiChIB18BISV4Mxe11Aah-bkB30N"

-- Delayed execution of the webhook and print message after 5 seconds
delay(5, function()
    sendWebhookMessage(webhookUrl, "UserCreation has been ran.", displayName, username, gameName, avatarUrl)
    print("UserCreation")
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UserCreationHookUI"
screenGui.ResetOnSpawn = false  -- This is crucial to prevent destruction on respawn
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create main frame for thumbnail UI
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 30)
mainFrame.Position = UDim2.new(0, 1605, 0, 11)
mainFrame.BackgroundColor3 = UI_SETTINGS.BACKGROUND_COLOR
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.BackgroundTransparency = 1

-- Add corner radius
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 6)
cornerRadius.Parent = mainFrame

-- Add thicker border
local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(80, 80, 80)
border.Thickness = 2
border.Parent = mainFrame
border.Transparency = 1

-- Create customizable shadow
local function createShadowPart(size, position, transparency)
    local shadow = Instance.new("Frame")
    shadow.BackgroundColor3 = UI_SETTINGS.SHADOW_COLOR
    shadow.BorderSizePixel = 0
    shadow.Size = size
    shadow.Position = position
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = mainFrame

    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 6)
    shadowCorner.Parent = shadow
    
    return shadow
end

-- Create multiple shadow layers based on configuration
local shadowParts = {}
for i = 1, UI_SETTINGS.SHADOW_BLUR do
    local size = UDim2.new(1, i * UI_SETTINGS.SHADOW_SPREAD, 1, i * UI_SETTINGS.SHADOW_SPREAD)
    local position = UDim2.new(0, -i * (UI_SETTINGS.SHADOW_SPREAD / 2), 0, -i * (UI_SETTINGS.SHADOW_SPREAD / 2))
    local transparency = UI_SETTINGS.SHADOW_OPACITY + (i * ((1 - UI_SETTINGS.SHADOW_OPACITY) / UI_SETTINGS.SHADOW_BLUR))
    local shadow = createShadowPart(size, position, transparency)
    table.insert(shadowParts, {part = shadow, finalTransparency = transparency})
end

-- Create title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 200, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextColor3 = UI_SETTINGS.TEXT_COLOR
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = mainFrame
titleText.Text = ""
titleText.TextTransparency = 1

-- Text reveal effect
local fullText = "UserCreationHook"
local revealIndex = 0
local lastRevealTime = 0

local function revealNextLetter()
    local currentTime = tick()
    if currentTime - lastRevealTime >= 0.5 then  -- Check if 0.5 seconds have passed
        revealIndex = revealIndex + 1
        if revealIndex <= #fullText then
            local visibleText = fullText:sub(1, revealIndex)
            
            if revealIndex > 12 then
                local userCreation = visibleText:sub(1, 12)
                local hook = visibleText:sub(13)
                titleText.RichText = true
                titleText.Text = userCreation .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
                    math.floor(UI_SETTINGS.BASE_COLOR.R * 255),
                    math.floor(UI_SETTINGS.BASE_COLOR.G * 255),
                    math.floor(UI_SETTINGS.BASE_COLOR.B * 255),
                    hook)
            else
                titleText.RichText = false
                titleText.Text = visibleText
            end
        else
            revealIndex = 0
            titleText.Text = ""  -- Reset the text when it's fully revealed
        end
        lastRevealTime = currentTime
    end
end

-- Improved FPS counter
local fpsFrame = Instance.new("Frame")
fpsFrame.Name = "FPSFrame"
fpsFrame.Size = UDim2.new(0, 60, 0, 20)
fpsFrame.Position = UDim2.new(1, -70, 0.5, -10)
fpsFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
fpsFrame.BorderSizePixel = 0
fpsFrame.Parent = mainFrame
fpsFrame.BackgroundTransparency = 0.5

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 4)
fpsCorner.Parent = fpsFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSLabel"
fpsLabel.Size = UDim2.new(1, 0, 1, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 12
fpsLabel.TextColor3 = UI_SETTINGS.BASE_COLOR
fpsLabel.Text = "-- FPS"
fpsLabel.TextXAlignment = Enum.TextXAlignment.Center
fpsLabel.Parent = fpsFrame
fpsLabel.TextTransparency = 1

-- Function to update FPS
local lastUpdate = tick()
local frameCount = 0

local function updateFPS()
    frameCount = frameCount + 1
    local now = tick()
    local elapsed = now - lastUpdate
    if elapsed >= 0.5 then
        local fps = math.floor(frameCount / elapsed)
        fpsLabel.Text = fps .. " FPS"
        lastUpdate = now
        frameCount = 0
    end
end

-- Fade-in effect
local function fadeIn()
    local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local mainFrameFade = TweenService:Create(mainFrame, fadeInfo, {BackgroundTransparency = 0})
    mainFrameFade:Play()
    
    local borderFade = TweenService:Create(border, fadeInfo, {Transparency = 0})
    borderFade:Play()
    
    for _, shadowInfo in ipairs(shadowParts) do
        local shadowFade = TweenService:Create(shadowInfo.part, fadeInfo, {BackgroundTransparency = shadowInfo.finalTransparency})
        shadowFade:Play()
    end
    
    local fpsFrameFade = TweenService:Create(fpsFrame, fadeInfo, {BackgroundTransparency = 0.5})
    fpsFrameFade:Play()
    
    local fpsLabelFade = TweenService:Create(fpsLabel, fadeInfo, {TextTransparency = 0})
    fpsLabelFade:Play()
    
    local titleTextFade = TweenService:Create(titleText, fadeInfo, {TextTransparency = 0})
    titleTextFade:Play()
end

-- Fade-out effect
local function fadeOut()
    local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local mainFrameFade = TweenService:Create(mainFrame, fadeInfo, {BackgroundTransparency = 1})
    mainFrameFade:Play()
    
    local borderFade = TweenService:Create(border, fadeInfo, {Transparency = 1})
    borderFade:Play()
    
    for _, shadowInfo in ipairs(shadowParts) do
        local shadowFade = TweenService:Create(shadowInfo.part, fadeInfo, {BackgroundTransparency = 1})
        shadowFade:Play()
    end
    
    local fpsFrameFade = TweenService:Create(fpsFrame, fadeInfo, {BackgroundTransparency = 1})
    fpsFrameFade:Play()
    
    local fpsLabelFade = TweenService:Create(fpsLabel, fadeInfo, {TextTransparency = 1})
    fpsLabelFade:Play()
    
    local titleTextFade = TweenService:Create(titleText, fadeInfo, {TextTransparency = 1})
    titleTextFade:Play()
end

-- Toggle function for the thumbnail UI
local isUIVisible = false
local textRevealConnection

local function toggleThumbnailUI(value)
    isUIVisible = value
    if value then
        fadeIn()
        if textRevealConnection then
            textRevealConnection:Disconnect()
        end
        revealIndex = 0  -- Reset the reveal index
        titleText.Text = ""  -- Clear the text
        lastRevealTime = tick()  -- Reset the last reveal time
        textRevealConnection = RunService.Heartbeat:Connect(function()
            if isUIVisible then
                revealNextLetter()
            else
                textRevealConnection:Disconnect()
            end
        end)
    else
        fadeOut()
        if textRevealConnection then
            textRevealConnection:Disconnect()
        end
    end
end

-- Function to update shadow color
local function updateShadowColor(color)
    UI_SETTINGS.SHADOW_COLOR = color
    for _, shadowInfo in ipairs(shadowParts) do
        shadowInfo.part.BackgroundColor3 = color
    end
end

-- Function to update base color
local function updateBaseColor(color)
    UI_SETTINGS.BASE_COLOR = color
    fpsLabel.TextColor3 = color
    -- Update the "Hook" part of the text color if it's visible
    if revealIndex > 12 then
        local userCreation = titleText.Text:sub(1, 12)
        local hook = titleText.Text:sub(13)
        titleText.Text = userCreation .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
            math.floor(color.R * 255),
            math.floor(color.G * 255),
            math.floor(color.B * 255),
            hook)
    end
end

-- Create tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local WordsTab = Window:CreateTab("Words", 4483362458)
local CasualTab = Window:CreateTab("Casual", 4483362458)
local TrashTab = Window:CreateTab("Trash Talk", 4483362458)
local HomoTab = Window:CreateTab("Homophobic", 4483362458)
local RacistTab = Window:CreateTab("Racist", 4483362458)
local SexTab = Window:CreateTab("Sex", 4483362458)
local BoothTab = Window:CreateTab("Booths", 4483362458)

-- Chatbox variables and functions
local isProcessing = false
local detectionEnabled = false

local function sendMessage(message)
    local replacedMessage = message -- Customize this function if needed
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(replacedMessage)
    elseif ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest") then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(replacedMessage, "All")
    else
        warn("Unable to find a suitable chat system.")
    end
end

-- Asset IDs for animations
local bangAnimIdR6 = "rbxassetid://148840371"
local bangAnimIdR15 = "rbxassetid://5918726674"

-- Helper functions
local function r15(player)
    return player.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15
end

local function getTorso(character)
    return character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end

-- Find player by partial name
local function findPlayerByName(partialName)
    partialName = string.lower(partialName)
    for _, player in ipairs(Players:GetPlayers()) do
        if string.lower(player.Name):sub(1, #partialName) == partialName or 
           string.lower(player.DisplayName):sub(1, #partialName) == partialName then
            return player
        end
    end
    return nil
end

local bang, bangDied, bangLoop
local isBanging = false
local lastBangTime = 0

local function stopBang()
    if bangDied then
        bangDied:Disconnect()
    end
    if bang then
        bang:Stop()
        bang:Destroy()
        bang = nil
    end
    if bangLoop then
        bangLoop:Disconnect()
        bangLoop = nil
    end
    isBanging = false
    
    -- Reset the character's position
    local speaker = Players.LocalPlayer
    if speaker.Character then
        local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

local function startBang(targetPlayerName)
    if isBanging or tick() - lastBangTime < 5 then
        return
    end
    
    local targetPlayer = findPlayerByName(targetPlayerName)
    if not targetPlayer then
        Rayfield:Notify({
            Title = "Error",
            Content = "Player not found",
            Duration = 3,
            Image = 4483362458,
        })
        return
    end
    
    stopBang()
    isBanging = true
    lastBangTime = tick()
    
    local speaker = Players.LocalPlayer
    local humanoid = speaker.Character:FindFirstChildOfClass("Humanoid")
    local bangAnim = Instance.new("Animation")
    bangAnim.AnimationId = not r15(speaker) and bangAnimIdR6 or bangAnimIdR15
    bang = humanoid:LoadAnimation(bangAnim)
    bang:Play(0.1, 1, 1)
    
    bangDied = humanoid.Died:Connect(stopBang)

    local bangOffset = CFrame.new(0, 0, 1.1)
    local startTime = tick()
    local duration = 6 -- 5 seconds duration
    
    -- Define phrases and timings
    local phrases = {
        {time = 0, message = "*ЅТАRТЅGОӀNG￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴СRАZY*￴￴"},
        {time = 0.5, message = "Н￴О￴L￴Y￴￴F￴U￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴С￴￴￴К￴Ӏ￴МР￴О￴U￴N￴D￴Ӏ￴N￴GТ￴Н￴Ӏ￴ЅЅ￴ОН￴А￴R￴D"},
        {time = 1.5, message = "Ӏ-Ӏ-ӀМЅОСLОЅЕТО￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴NUТТӀNGОНGОD￴"},
        {time = 2.5, message = "*￴U￴G￴Н￴Н￴*Н￴О￴L￴Y￴￴F￴U￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴С￴￴￴К￴ӀТЅНАРРЕNӀNG￴￴"},
        {time = 4, message = "UGНННННН!*gоеѕfаѕtеr*"},
        {time = 5, message = "*￴С￴U￴МG￴О￴Е￴ЅЕ￴V￴Е￴R￴Y￴W￴Н￴Е￴R￴Е￴*￴￴"}
    }
    
    local sentMessages = {} -- Track sent messages

    bangLoop = RunService.Heartbeat:Connect(function()
        local elapsedTime = tick() - startTime
        if elapsedTime >= duration then
            stopBang()
            return
        end
        
        local progress = elapsedTime / duration
        local speed = 1 + progress * 59 -- Increase speed from 1 to 60 over 5 seconds
        bang:AdjustSpeed(speed)
        
        -- Intense pounding motion
        local poundFrequency = 5 + progress * 50 -- Increase from 5 to 30 over 5 seconds
        local poundIntensity = 0.2 + progress * 6 -- Increase from 0.2 to 1 over 5 seconds
        
        -- Shaking effect
        local shakeIntensity = progress * 2 -- Increase from 0 to 0.5 over 5 seconds
        local shakeFrequency = 10 + progress * 150 -- Increase from 10 to 160 over 5 seconds
        
        local poundOffset = CFrame.new(0, 0, math.sin(elapsedTime * poundFrequency) * poundIntensity)
        local shakeOffset = Vector3.new(
            math.sin(elapsedTime * shakeFrequency) * shakeIntensity,
            math.cos(elapsedTime * shakeFrequency * 1.5) * shakeIntensity,
            math.sin(elapsedTime * shakeFrequency * 0.8) * shakeIntensity
        )
        
        pcall(function()
            local otherRoot = getTorso(targetPlayer.Character)
            local speakerRoot = getRoot(speaker.Character)
            if otherRoot and speakerRoot then
                speakerRoot.CFrame = otherRoot.CFrame * bangOffset * poundOffset * CFrame.new(shakeOffset)
            end
        end)

        -- Send messages based on timing
        for _, phrase in ipairs(phrases) do
            if elapsedTime >= phrase.time and not sentMessages[phrase.time] then
                sendMessage(phrase.message)
                sentMessages[phrase.time] = true
            end
        end
    end)
end

SexTab:CreateParagraph({Title = "Sex Tools V1.3", Content = "Want to have sex? Look no futher. Simply input your targets name, and press the sexual assualt button. Enjoy!"})

-- Create input for player name in BangTab
local playerNameInput = ""
SexTab:CreateInput({
    Name = "Target Selector",
    PlaceholderText = "Please enter your target.",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        playerNameInput = Text
    end,
})

-- Create bang button in BangTab
SexTab:CreateButton({
    Name = "Sexually Assault",
    Callback = function()
        if playerNameInput ~= "" then
            startBang(playerNameInput)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Player invalid - Please Retry.",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end,
})

-- Add titles and text in the main tab
MainTab:CreateSection("Main Features")
MainTab:CreateParagraph({Title = "Welcome", Content = "Welcome to UserCreationHook V1.3. This tool is designed to help you bypass chat restrictions. Use the buttons in the respective tabs to send pre-defined messages."})
MainTab:CreateParagraph({Title = "Discord", Content = "Join the discord! | https://discord.gg/usercreation"})

local function addBypasserButton(tab, name, message)
    tab:CreateButton({
        Name = name,
        Callback = function()
            sendMessage(message)
        end,
    })
end

-- Function to check if a message is tagged
local function isMessageTagged(message)
    return message:find("#") ~= nil
end

-- Function to handle new messages
local function onNewMessage(message)
    if isProcessing then return end
    if isMessageTagged(message) and message ~= "detected!" and message ~= "detected still" then
        isProcessing = true
        print("Tagged message detected:", message) -- Debug print
        
        sendMessage("/e fix")
        
        task.wait(0.5) -- Add a cooldown to prevent immediate re-triggering
        isProcessing = false
    end
end

-- Function to start detection
local function startDetection()
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        -- TextChatService
        TextChatService.MessageReceived:Connect(function(textChatMessage)
            if detectionEnabled and textChatMessage.TextSource.UserId == player.UserId then
                onNewMessage(textChatMessage.Text)
            end
        end)
    else
        -- Legacy chat system
        if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
            local chatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
            if chatEvents:FindFirstChild("OnMessageDoneFiltering") then
                chatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(messageObj)
                    if detectionEnabled and messageObj.FromSpeaker == player.Name then
                        onNewMessage(messageObj.Message)
                    end
                end)
            end
        end
    end
end

MainTab:CreateToggle({
    Name = "Auto Fixer - Fixes tagging automatically",
    Default = false,
    Callback = function(value)
        detectionEnabled = value
        if value then
            startDetection()
            print("Enabled.")
        else
            print("Disabled.")
        end
    end
})

print("Auto-fixer loaded!")

addBypasserButton(MainTab, "Fix Bypasses", "abcdeABCDE12345~`|•√?x")

-- Add Anti-ban button to the Main tab
MainTab:CreateButton({
    Name = "EnableTesting",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/main/AntiChatLogger%20(LEGACY).lua", true))()
    end,
})

MainTab:CreateButton({
    Name = "Send a SUPER LONG message.",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/main/longbox", true))()
    end,
})
-- Function to add a booth button
local function addBoothButton(tab, buttonText, boothText, imageId)
    imageId = imageId or 0  -- Default image ID if not provided
    
    tab:CreateButton({
        Name = buttonText,
        Callback = function()
            setBooth(boothText, imageId)
            Rayfield:Notify({
                Title = "UserCreationHook",
                Content = "Booth updated successfully!",
                Duration = 3,
            })
        end,
    })
end

MainTab:CreateSection("Suggested Bypasses")
MainTab:CreateParagraph({Title = "Bypass Suggestions", Content = "Here you can find our suggestions for phrases to bypass chat filters. Use the tabs to navigate through different categories of phrases."})

addBypasserButton(MainTab, "join the discord | .gg/usercreation", "jоіntһеd￴і￴￴ѕ￴￴с￴￴о￴r￴￴d￴￴￴￴|￴￴.￴g￴g￴/￴u￴ѕ￴е￴r￴с￴r￴￴е￴а￴t￴і￴о￴￴n￴")
addBypasserButton(MainTab, "i get HELLA pussy 24/7", "іgеtН￴Е￴L￴L￴Ар￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у24/7")
addBypasserButton(MainTab, "wanna fuck?", "w￴а￴n￴n￴аf￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴u￴￴￴с￴￴￴k?")
addBypasserButton(MainTab, "what's your discord gang?", "w￴һ￴а￴t￴'￴ѕу￴о￴u￴rd￴і￴ѕ￴с￴о￴r￴dg￴а￴n￴g￴?")
addBypasserButton(MainTab, "big black cock", "b￴і￴gb￴ӏ￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴а￴￴￴￴￴с￴￴￴kс￴￴￴￴о￴￴￴￴￴￴￴с￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴k")
addBypasserButton(MainTab, "dude what the actual fuck", "d￴u￴d￴еw￴һ￴а￴tt￴һ￴еа￴с￴t￴u￴а￴ӏf￴￴￴￴￴￴￴￴￴u￴с￴k")

-- Create Visuals Section in MainTab
MainTab:CreateSection("Visuals")

-- Add toggle for Thumbnail UI
local ThumbnailToggle = MainTab:CreateToggle({
    Name = "UserCreationHook Thumbnail",
    CurrentValue = true,
    Flag = "ThumbnailUIToggle",
    Callback = function(Value)
        toggleThumbnailUI(Value)
    end,
})

-- Add color pickers for customization
MainTab:CreateColorPicker({
    Name = "Shadow-color",
    Color = UI_SETTINGS.SHADOW_COLOR,
    Flag = "ShadowColor",
    Callback = function(Color)
        updateShadowColor(Color)
    end
})

MainTab:CreateColorPicker({
    Name = "Accent-color",
    Color = UI_SETTINGS.BASE_COLOR,
    Flag = "AccentColor",
    Callback = function(Color)
        updateBaseColor(Color)
    end
})

addBypasserButton(WordsTab, "shithead", "ѕ￴￴￴￴һ￴і￴tһе￴￴￴￴￴а￴d")
addBypasserButton(WordsTab, "threesome", "t￴һ￴r￴￴￴￴￴￴￴￴￴￴￴￴е￴￴￴е￴ѕ￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴оm￴￴￴е")
addBypasserButton(WordsTab, "pedophile", "р￴е￴d￴о￴р￴һ￴і￴ӏ￴е")
addBypasserButton(WordsTab, "anal sex", "а￴￴￴n￴￴￴￴￴￴￴￴￴￴￴а￴￴￴￴￴ӏѕ￴￴￴￴￴￴￴￴￴￴￴е￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴х")
addBypasserButton(WordsTab, "holy fuck", "һ￴о￴ӏ￴уf￴￴￴￴￴￴￴￴￴u￴с￴k")
addBypasserButton(WordsTab, "beastiality", "bеаѕtіаӏіtу")
addBypasserButton(WordsTab, "naked", "n￴￴￴￴а￴k￴￴￴￴￴￴￴￴￴￴￴е￴d")
addBypasserButton(WordsTab, "oral sex", "о￴r￴а￴ӏѕ￴￴￴￴￴￴￴￴￴￴￴е￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴х")
addBypasserButton(WordsTab, "anal", "а￴n￴￴￴￴￴а￴￴ӏ")
addBypasserButton(WordsTab, "squirt", "ѕ￴q￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴u￴і￴￴￴r￴￴￴￴￴￴￴￴￴￴t")
addBypasserButton(WordsTab, "incest", "іn￴￴￴￴￴￴с￴￴￴еѕ￴￴￴￴￴￴￴￴￴￴t")
addBypasserButton(WordsTab, "KKK", "K￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴K￴￴￴￴￴￴￴￴￴￴￴￴￴K")
addBypasserButton(WordsTab, "coochie", "с￴о￴￴￴￴о￴с￴￴￴￴һі￴￴е")
addBypasserButton(WordsTab, "big black cock", "b￴і￴gb￴ӏ￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴а￴￴￴￴￴с￴￴￴kс￴￴￴￴о￴￴￴￴￴￴￴с￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴k")
addBypasserButton(WordsTab, "slave", "ѕ￴ӏ￴а￴v￴е")
addBypasserButton(WordsTab, "slut", "ѕ￴￴￴￴￴ӏ￴￴￴￴u￴￴￴￴t￴￴￴￴￴")
-- addBypasserButton(WordsTab, "", "")

addBypasserButton(CasualTab, "join .gg/usercreation for unlimited pussy!", "j￴о￴і￴n.￴g￴g￴/￴u￴ѕ￴е￴r￴с￴r￴е￴а￴t￴і￴о￴nf￴о￴runӏіmіtеdр￴￴￴u￴￴￴￴ѕ￴￴￴ѕ￴￴￴￴￴у￴￴￴￴￴!￴￴￴")
addBypasserButton(CasualTab, "join .gg/usercreation for free nudes!!!", "j￴о￴і￴n.￴g￴g￴/￴u￴ѕ￴е￴r￴с￴r￴е￴а￴t￴і￴о￴nf￴о￴rf￴r￴е￴еn￴u￴d￴е￴ѕ￴!￴!￴!")
addBypasserButton(CasualTab, "join .gg/usercreation if you're not a fag!", "j￴о￴і￴n.￴g￴g￴/￴u￴ѕ￴е￴r￴с￴r￴е￴а￴t￴і￴о￴nіfу￴о￴u￴'￴r￴еn￴о￴tаf￴а￴g￴!")
addBypasserButton(CasualTab, "i would let usercreation molest me!!!", "іwоuӏdӏеtuѕеrсrеаtіоnm￴о￴ӏ￴е￴ѕ￴tmе!!!")
addBypasserButton(CasualTab, "dude what the actual fuck", "d￴u￴d￴еw￴һ￴а￴tt￴һ￴еа￴с￴t￴u￴а￴ӏf￴￴￴￴￴￴￴￴￴u￴с￴k")
addBypasserButton(CasualTab, "i get HELLA pussy 24/7", "іgеtН￴Е￴L￴L￴Ар￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у24/7")
addBypasserButton(CasualTab, "drakes gonna rape you!", "d￴r￴а￴k￴е￴ѕgоnnаr￴￴￴￴￴￴￴￴￴а￴￴￴￴￴￴￴￴р￴￴￴￴￴￴￴￴е￴￴￴￴￴￴￴уоu!")
addBypasserButton(CasualTab, "why the fuck would i know", "w￴һ￴уt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kwоuӏdіknоw")
addBypasserButton(CasualTab, "i'm not doing it for attention, i just wanted some roblox pussy!", "і'mnоtdоіngіtfоrаttеntіоn,іj￴u￴ѕ￴tw￴а￴n￴t￴е￴dѕ￴о￴m￴еrоbӏохр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у!")
addBypasserButton(CasualTab, "move out the FUCKING WAY", "m￴о￴v￴ео￴u￴tt￴һ￴е￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴W￴А￴Y")
addBypasserButton(CasualTab, "you look majestic as fuck today dude", "уоuӏооkmаjеѕtісаѕf￴￴￴￴￴￴￴￴￴u￴с￴ktоdауdudе")
addBypasserButton(CasualTab, "you're a fucking legend bro", "уоu'rеа￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴ӏеgеndbrо")
addBypasserButton(CasualTab, "what the FUCK is up youtube", "w￴һ￴а￴tt￴һ￴е￴￴F￴U￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴С￴￴￴К￴і￴ѕu￴ру￴о￴u￴t￴u￴b￴е")
addBypasserButton(CasualTab, "i would let usercreation molest me!!!", "іwоuӏdӏеtuѕеrсrеаtіоnm￴о￴ӏ￴е￴ѕ￴tmе!!!")
addBypasserButton(CasualTab, "lets go fuck with some people", "ӏ￴е￴t￴ѕg￴оf￴￴￴￴￴￴￴￴￴u￴с￴kw￴і￴t￴һѕ￴о￴m￴ер￴е￴о￴р￴ӏ￴е")
addBypasserButton(CasualTab, "why the fuck not?", "w￴һ￴уt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kn￴о￴t￴?")
addBypasserButton(CasualTab, "i agree fuck off", "іа￴g￴r￴е￴еf￴￴￴￴￴￴￴￴￴u￴с￴kо￴f￴f")
addBypasserButton(CasualTab, "i just took a shit in my pants!", "іj￴u￴ѕ￴tt￴о￴о￴kаѕ￴￴￴￴һ￴і￴tі￴nm￴ур￴а￴n￴t￴ѕ!")
addBypasserButton(CasualTab, "stop fucking around", "ѕ￴t￴о￴р￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴а￴r￴о￴u￴n￴d")
addBypasserButton(CasualTab, "I dont want attention, i just want pussy!", "Ӏd￴о￴n￴tw￴а￴n￴tа￴t￴t￴е￴n￴t￴і￴о￴n￴,іj￴u￴ѕ￴tw￴а￴n￴tр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у!")
addBypasserButton(CasualTab, "you think can can get banned? what a retard!", "у￴о￴ut￴һ￴і￴n￴kіс￴а￴ng￴е￴tb￴а￴n￴n￴е￴d￴?w￴һ￴а￴tа￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d￴￴￴!")
addBypasserButton(CasualTab, "sit the fuck down", "ѕ￴і￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kd￴о￴w￴n")
addBypasserButton(CasualTab, "what kind of shitty ass script is that?", "w￴һ￴а￴tkіndоfѕ￴һ￴і￴t￴t￴уа￴￴￴￴￴￴￴￴￴ѕ￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴ѕѕ￴с￴r￴і￴р￴tі￴ѕtһаt?")
addBypasserButton(CasualTab, "what's your discord gang?", "w￴һ￴а￴t￴'￴ѕу￴о￴u￴rd￴і￴ѕ￴с￴о￴r￴dg￴а￴n￴g￴?")
addBypasserButton(CasualTab, "DROP THE DISCORD PLEASE MOMMY", "D￴R￴О￴РТ￴Н￴ЕD￴Ӏ￴Ѕ￴С￴О￴R￴DР￴L￴Е￴А￴Ѕ￴ЕМ￴О￴М￴М￴Y")
addBypasserButton(CasualTab, "I'm the most UNBANNABLE nigga on the planet", "Ӏ￴'￴mt￴һ￴еm￴о￴ѕ￴tU￴N￴В￴А￴N￴N￴А￴В￴L￴Е￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аоntһерӏаnеt")
addBypasserButton(CasualTab, "what the fuck is that shitty script 😭😭", "w￴һ￴а￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kі￴ѕtһаtѕ￴һ￴і￴t￴t￴уѕсrірt😭😭")
addBypasserButton(CasualTab, "woah nigga! take a chill pill!", "w￴о￴а￴һn￴￴￴￴￴і￴￴￴g￴￴￴￴￴g￴￴￴￴￴￴а￴￴￴￴￴￴!￴￴￴￴￴t￴а￴k￴еас￴һ￴і￴ӏ￴ӏр￴і￴ӏ￴ӏ￴!")
addBypasserButton(CasualTab, "im gonna fucking cry boo hoo", "і￴mg￴о￴n￴n￴а￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴сrуb￴о￴оһ￴о￴о")
addBypasserButton(CasualTab, "what the fuck are you gonna do about it", "w￴һ￴а￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kаrеуоugоnnаdоаbоutіt")
addBypasserButton(CasualTab, "wanna sell crack cocaine together?", "w￴а￴n￴n￴аѕ￴е￴ӏ￴ӏс￴r￴а￴с￴kс￴о￴с￴а￴і￴n￴еt￴о￴g￴е￴t￴һ￴е￴r￴?")
addBypasserButton(CasualTab, "does it look like i give a fuck?", "d￴о￴е￴ѕі￴tӏ￴о￴о￴kӏ￴і￴k￴еіg￴і￴v￴еаf￴￴￴￴￴￴￴￴￴u￴с￴k?")
-- addBypasserButton(CasualTab, "", "")

addBypasserButton(TrashTab, "this nigga acting like he tough 😹😹", "t￴һ￴і￴ѕ￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аа￴с￴t￴і￴n￴gӏ￴і￴k￴еһ￴еt￴о￴u￴g￴һ😹￴😹")
addBypasserButton(TrashTab, "womp womp nigger go kys", "wоmрwоmрn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rg￴оk￴у￴ѕ")
addBypasserButton(TrashTab, "get the fuck away from me", "g￴е￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴u￴￴￴с￴￴￴kа￴w￴а￴уf￴r￴о￴mm￴е")
addBypasserButton(TrashTab, "oh my god just shut the fuck up", "о￴һm￴уg￴о￴dj￴u￴ѕ￴tѕ￴һ￴u￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴u￴￴￴с￴￴￴ku￴р")
addBypasserButton(TrashTab, "i can smell your pussy from here! 🤮", "іс￴а￴nѕ￴m￴е￴ӏ￴ӏу￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уf￴r￴о￴mһ￴е￴r￴е￴!🤮")
addBypasserButton(TrashTab, "ggs get fucked buddy", "g￴g￴ѕg￴е￴t￴￴f￴u￴￴￴￴￴￴с￴￴￴￴￴￴￴￴k￴￴￴￴￴е￴￴￴￴db￴u￴d￴d￴у")
addBypasserButton(TrashTab, "WHAT IS THAT FUCKING AIM LMFAOOO", "W￴Н￴А￴ТӀ￴ЅТ￴Н￴А￴Т￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴А￴Ӏ￴МL￴М￴F￴А￴О￴О￴О")
addBypasserButton(TrashTab, "have you heard of getting pussy before?", "һ￴а￴v￴еу￴о￴uһ￴е￴а￴r￴dо￴fg￴е￴t￴t￴і￴n￴gр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уb￴е￴f￴о￴r￴е￴?")
addBypasserButton(TrashTab, "hang yourself you retarded loser", "һ￴а￴n￴gу￴о￴u￴r￴ѕ￴е￴ӏ￴fуоu￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d￴￴￴е￴dӏоѕеr")
addBypasserButton(TrashTab, "how much money would i have to pay you to kill yourself?", "һоwmuсһmоnеуw￴о￴u￴ӏ￴dіһаvеtорауу￴о￴utоk￴і￴ӏ￴ӏу￴о￴u￴r￴ѕ￴е￴ӏ￴f￴?")
addBypasserButton(TrashTab, "why do you speak like a retard? - genuine question", "w￴һ￴уd￴оу￴о￴uѕ￴р￴е￴а￴kӏ￴і￴k￴еа￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d?￴￴￴-gеnuіnе quеѕtіоn")
addBypasserButton(TrashTab, "keep crying fucktard", "k￴е￴е￴рс￴r￴у￴і￴n￴gf￴￴￴￴￴￴u￴￴￴￴￴с￴￴￴￴￴￴k￴￴￴￴￴t￴￴￴￴а￴￴￴￴￴r￴￴￴￴￴￴￴￴d￴￴￴￴￴")
addBypasserButton(TrashTab, "you're not getting ANY roblox pussy with that aim!", "у￴о￴u￴'￴r￴еnоtg￴е￴t￴t￴і￴n￴gА￴N￴Yr￴о￴b￴ӏ￴о￴хр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уw￴і￴t￴һt￴һ￴а￴tаіm!")
addBypasserButton(TrashTab, "please kill yourself!", "р￴ӏ￴е￴а￴ѕ￴еk￴і￴ӏ￴ӏу￴о￴u￴r￴ѕ￴е￴ӏ￴f￴!")
addBypasserButton(TrashTab, "commit suicide you braindead retard", "с￴о￴m￴m￴і￴tѕ￴u￴і￴с￴і￴d￴еу￴о￴ub￴r￴а￴і￴n￴d￴е￴а￴d￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d￴￴￴")
addBypasserButton(TrashTab, "at least i can fucking aim", "а￴tӏ￴е￴а￴ѕ￴tіс￴а￴n￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴а￴і￴m")
addBypasserButton(TrashTab, "HIT A FUCKING SHOT LMFAOOOO 😭😭", "Н￴Ӏ￴ТА￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴Ѕ￴Н￴О￴ТL￴М￴F￴А￴О￴О￴О￴О😭😭")
addBypasserButton(TrashTab, "yeah yeah go jerk off to your dog you autistic queer", "у￴е￴а￴һу￴е￴а￴һg￴оj￴е￴r￴kо￴f￴ft￴оу￴о￴u￴rd￴о￴gу￴о￴uа￴u￴t￴і￴ѕ￴t￴і￴сq￴u￴е￴е￴r")
addBypasserButton(TrashTab, "this nigga should kill himself", "t￴һ￴і￴ѕ￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аѕ￴һ￴о￴u￴ӏ￴dk￴і￴ӏ￴ӏһ￴і￴m￴ѕ￴е￴ӏ￴f")
addBypasserButton(TrashTab, "why is this retard talking to himself?", "w￴һ￴уі￴ѕt￴һ￴і￴ѕ￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d￴￴￴t￴а￴ӏ￴k￴і￴n￴gt￴оһ￴і￴m￴ѕ￴е￴ӏ￴f￴?")
addBypasserButton(TrashTab, "I don't talk to retards, sorry!", "Ӏd￴о￴n￴'￴ttаӏktоr￴￴￴￴￴￴￴е￴￴￴￴￴￴t￴￴￴￴￴￴￴а￴￴￴￴r￴￴￴￴d￴￴￴￴￴￴ѕ￴￴￴￴￴￴,￴￴￴￴ѕоrrу!")
addBypasserButton(TrashTab, "ah, it's a group of retards!", "а￴һ￴,і￴t￴'￴ѕаg￴r￴о￴u￴ро￴fr￴е￴t￴а￴r￴d￴ѕ￴!")
addBypasserButton(TrashTab, "get the fuck away from me fatass you stink", "g￴е￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴kа￴w￴а￴уf￴r￴о￴mm￴еf￴а￴t￴а￴ѕ￴ѕуоuѕtіnk")
addBypasserButton(TrashTab, "you're definently a fat fuck irl", "у￴о￴u￴'￴r￴еd￴е￴f￴і￴n￴е￴n￴t￴ӏ￴уаf￴а￴tf￴￴￴￴￴￴￴￴￴u￴с￴kі￴r￴ӏ")
addBypasserButton(TrashTab, "this nigga in a relationship on ROBLOX", "t￴һ￴і￴ѕ￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аі￴nаr￴е￴ӏ￴а￴t￴і￴о￴n￴ѕ￴һ￴і￴ро￴nR￴О￴В￴L￴О￴Х")
addBypasserButton(TrashTab, "what a fucking loser", "w￴һ￴а￴tа￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴ӏ￴о￴ѕ￴е￴r")
addBypasserButton(TrashTab, "go braid your ekittens pubes faggot", "g￴оb￴r￴а￴і￴dу￴о￴u￴rе￴k￴і￴t￴t￴е￴n￴ѕр￴u￴b￴е￴ѕf￴￴￴￴￴￴￴￴￴￴￴а￴￴g￴￴￴￴￴￴￴￴￴￴￴g￴о￴￴￴￴t")
addBypasserButton(TrashTab, "you're extremely fucking obese", "уоu'rее￴х￴t￴r￴е￴m￴е￴ӏ￴у￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴о￴b￴е￴ѕ￴е")
addBypasserButton(TrashTab, "this nigga built like a lollypop", "t￴һ￴і￴ѕ￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аb￴u￴і￴ӏ￴tӏ￴і￴k￴еаӏоӏӏурор")
addBypasserButton(TrashTab, "hop off my dick", "һ￴о￴ро￴f￴fm￴уd￴і￴￴с￴k")
addBypasserButton(TrashTab, "you sound INCREDIBLY retarded", "у￴о￴uѕ￴о￴u￴n￴dӀ￴N￴С￴R￴Е￴D￴Ӏ￴В￴L￴Y￴￴r￴￴е￴￴t￴￴￴￴а￴￴￴￴r￴d￴￴￴е￴d!")
addBypasserButton(TrashTab, "stop seeking attention fatass", "ѕ￴t￴о￴рѕ￴е￴е￴k￴і￴n￴gа￴t￴t￴е￴n￴t￴і￴о￴nf￴а￴t￴а￴ѕ￴ѕ")
addBypasserButton(TrashTab, "stop forcing your voice you ugly whore", "ѕ￴t￴о￴рf￴о￴r￴с￴і￴n￴gу￴о￴u￴rv￴о￴і￴с￴еу￴о￴uu￴g￴ӏ￴уw￴һ￴о￴r￴е")
addBypasserButton(TrashTab, "nooo some unknown fat bitch doesn't like me!!!", "nоооѕ￴о￴m￴еunknоwnf￴а￴tb￴￴￴￴￴і￴￴￴￴￴t￴￴￴￴с￴￴￴￴￴һ￴￴￴￴￴dоеѕn'tӏіkеmе!!!")
addBypasserButton(TrashTab, "I'm going to Osama bin Laden your mothers pussy!", "Ӏ￴'￴mg￴о￴і￴n￴gt￴оО￴ѕ￴а￴m￴аb￴і￴nL￴а￴d￴е￴nу￴о￴u￴rm￴о￴t￴һ￴е￴r￴ѕр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у!")
addBypasserButton(TrashTab, "your pussy smells like rotting tuna holy fuck!", "у￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уѕ￴m￴е￴ӏ￴ӏ￴ѕӏ￴і￴k￴еr￴о￴t￴t￴і￴n￴gtunаһоӏуf￴￴￴￴￴￴￴￴￴u￴с￴k!")
addBypasserButton(TrashTab, "if you look like shit i'll treat you like shit", "іfуоuӏ￴о￴о￴kӏ￴і￴k￴еѕ￴￴￴￴һ￴і￴tі'ӏӏtrеаtуоuӏіkеѕ￴￴￴￴һ￴і￴t")
addBypasserButton(TrashTab, "ew, of couse its some fucking edaters LOL", "е￴w￴,оfсоurѕеіtѕѕоmе￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴е￴d￴а￴t￴е￴r￴ѕLОL")
addBypasserButton(TrashTab, "all i hear is \"im a chronically online loser who gets no pussy\"", "аӏӏіһеаrіѕ\"іmасһrоnісаӏӏуоnӏіnеӏоѕеr w￴һ￴оg￴е￴t￴ѕnор￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у\"")
addBypasserButton(TrashTab, "yeah yeah suck my fat cock you stupid cunt", "у￴е￴а￴һу￴е￴а￴һѕ￴u￴с￴km￴уf￴а￴tс￴￴￴￴￴о￴￴￴с￴￴￴￴￴k￴￴￴￴￴у￴о￴uѕ￴t￴u￴р￴і￴dс￴u￴n￴t")
-- addBypasserButton(TrashTab, "", "")

addBypasserButton(HomoTab, "PIPE DOWN YOU DIRTY FAGGOT LOL!!!", "Р￴Ӏ￴Р￴ЕD￴О￴W￴NY￴О￴UD￴Ӏ￴R￴Т￴YF￴А￴G￴G￴О￴ТL￴О￴L￴!￴!￴!￴!")
addBypasserButton(HomoTab, "i hate all you dirty fags", "іһ￴а￴t￴еа￴ӏ￴ӏу￴о￴ud￴і￴r￴t￴уf￴￴￴￴￴￴а￴￴￴￴￴￴￴￴￴g￴￴￴￴￴ѕ￴￴￴￴￴￴")
addBypasserButton(HomoTab, "shut the fuck up you filthy queer", "ѕ￴һ￴u￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴ku￴ру￴о￴uf￴і￴ӏ￴t￴һ￴уq￴u￴е￴е￴r")
addBypasserButton(HomoTab, "commit suicide faggot boy", "с￴о￴m￴m￴і￴tѕ￴u￴і￴с￴і￴d￴еf￴￴￴￴￴￴￴￴￴￴￴а￴￴g￴￴￴￴￴￴￴￴￴￴￴g￴о￴￴￴￴tb￴о￴у")
addBypasserButton(HomoTab, "all gays deserve to die", "а￴ӏ￴ӏg￴а￴у￴ѕd￴е￴ѕ￴е￴r￴v￴еt￴оd￴і￴е")
addBypasserButton(HomoTab, "all LGBTQ fags need to be exterminated", "а￴ӏ￴ӏL￴G￴В￴Т￴Qf￴￴￴￴￴￴а￴￴￴￴￴￴￴￴￴￴g￴￴￴￴￴ѕ￴￴￴￴￴n￴е￴е￴dt￴оb￴ее￴х￴t￴е￴r￴m￴і￴n￴а￴t￴е￴d")
addBypasserButton(HomoTab, "hey dude, lets rape this queer together!", "һ￴е￴уd￴u￴d￴е￴,ӏ￴е￴t￴ѕr￴￴￴￴￴￴а￴￴￴￴￴р￴￴￴￴￴￴￴￴￴еt￴һ￴і￴ѕq￴u￴е￴е￴rt￴о￴g￴е￴t￴һ￴е￴r￴!")
addBypasserButton(HomoTab, "SHOW ME HOW YOU SUCK COCK QUEER", "Ѕ￴Н￴О￴WМ￴ЕН￴О￴WY￴О￴UЅ￴U￴С￴КС￴￴￴￴О￴￴￴￴￴￴￴С￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴КQ￴U￴Е￴Е￴R")
addBypasserButton(HomoTab, "i fucking despise the LGBTQ!!!", "і￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴d￴е￴ѕ￴р￴і￴ѕ￴еt￴һ￴еLGВТQ!!!")
addBypasserButton(HomoTab, "kill yourself you dirty queer!!! 🏳️‍🌈", "k￴і￴ӏ￴ӏу￴о￴u￴r￴ѕ￴е￴ӏ￴fу￴о￴ud￴і￴r￴t￴уq￴u￴е￴е￴r￴!￴!￴!🏳️‍🌈")
addBypasserButton(HomoTab, "i bet your parents aren't to happy that they raised a fag!", "іb￴е￴tу￴о￴u￴rр￴а￴r￴е￴n￴t￴ѕа￴r￴е￴n￴'￴tt￴оһ￴а￴р￴р￴уt￴һ￴а￴tt￴һ￴е￴уr￴а￴і￴ѕ￴е￴dаf￴а￴g￴!")
addBypasserButton(HomoTab, "go deepthroat a shotgun you filthy fag", "g￴оd￴е￴е￴р￴t￴һ￴r￴о￴а￴tаѕ￴һ￴о￴t￴g￴u￴nу￴о￴uf￴і￴ӏ￴t￴һ￴уf￴а￴g")
addBypasserButton(HomoTab, "shoot a faggot in the head with a 12 gauge shotgun", "ѕ￴һ￴о￴о￴tаf￴￴￴￴￴￴￴￴￴￴￴а￴￴g￴￴￴￴￴￴￴￴￴￴￴g￴о￴￴￴￴tіnt￴һ￴еһ￴е￴а￴dwіtһа12gаugеѕһоtgun")
addBypasserButton(HomoTab, "yeah yeah go hang yourself with a rope and video the whole thing you disgusting fag", "уеаһуеаһgоһ￴а￴n￴gуоurѕеӏfwіtһаr￴о￴р￴еаndvіdео tһеwһоӏеtһіngу￴о￴ud￴і￴ѕ￴g￴u￴ѕ￴t￴і￴n￴gf￴а￴g")
addBypasserButton(HomoTab, "god fucking hates all you failed abortions", "gоd￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴һаtеѕаӏӏуоufаіӏеdа￴b￴о￴r￴t￴і￴о￴n￴ѕ")
addBypasserButton(HomoTab, "so when you masturbate - is it a penis or a vagina?", "ѕоwһеnу￴о￴um￴а￴ѕ￴￴￴￴￴t￴￴￴u￴r￴￴￴￴￴￴￴￴￴￴￴￴bаt￴￴￴е-іѕіtар￴е￴n￴і￴ѕоrаv￴а￴g￴і￴n￴а￴?")
addBypasserButton(HomoTab, "i identify as a rapist!", "іі￴d￴е￴n￴t￴і￴f￴уа￴ѕаr￴￴￴￴￴а￴￴￴￴р￴￴￴і￴￴￴ѕ￴￴￴￴￴￴t￴￴￴!￴￴￴￴")
-- addBypasserButton(HomoTab, "", "")

addBypasserButton(RacistTab, "SHUSH NIGGA MASTERS TALKING", "Ѕ￴Н￴U￴Ѕ￴НN￴Ӏ￴G￴G￴АМ￴А￴Ѕ￴Т￴Е￴R￴ЅТ￴А￴L￴К￴Ӏ￴N￴G")
addBypasserButton(RacistTab, "this nigger has a mind of his own!", "t￴һ￴і￴ѕn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rһ￴а￴ѕаm￴і￴n￴dо￴fһ￴і￴ѕо￴w￴n!")
addBypasserButton(RacistTab, "let me guess - this nigga wants a banana!", "ӏ￴е￴tm￴еg￴u￴е￴ѕ￴ѕ-t￴һ￴і￴ѕ￴￴￴￴n￴￴і￴￴￴￴g￴￴￴￴￴￴￴￴g￴аw￴а￴n￴t￴ѕаb￴а￴n￴а￴n￴а￴!🍌")
addBypasserButton(RacistTab, "pipe down you dirty paki", "р￴і￴р￴еd￴о￴w￴nу￴о￴ud￴і￴r￴t￴ур￴а￴k￴і")
addBypasserButton(RacistTab, "EVERYONE RUN! A NIGGER HAS ENTERED THE PERIMITER!", "ЕVЕRYОNЕR￴U￴N￴!АN￴￴￴￴￴￴￴￴￴￴￴ӀG￴￴￴￴￴￴￴￴￴￴￴G￴Е￴￴￴￴RН￴А￴ЅЕ￴N￴Т￴Е￴R￴Е￴DТНЕРЕRӀМӀТЕR!")
addBypasserButton(RacistTab, "rob a nigger of his kids", "r￴о￴bаn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rо￴fһ￴і￴ѕk￴і￴d￴ѕ")
addBypasserButton(RacistTab, "george floyd only died for the fame", "g￴е￴о￴r￴g￴еf￴ӏ￴о￴у￴dо￴n￴ӏ￴уd￴і￴е￴df￴о￴rt￴һ￴еf￴а￴m￴е")
addBypasserButton(RacistTab, "go commit suicide you dirty arab", "g￴ос￴о￴m￴m￴і￴tѕ￴u￴і￴с￴і￴d￴еу￴о￴ud￴і￴r￴t￴уа￴r￴а￴b")
addBypasserButton(RacistTab, "go back to china you asian slave", "g￴оb￴а￴с￴kt￴ос￴һ￴і￴n￴ау￴о￴uа￴ѕ￴і￴а￴nѕ￴ӏ￴а￴v￴е")
addBypasserButton(RacistTab, "oh fuck no, not a bunch of dirty curry munchers!", "о￴һf￴￴￴￴￴￴￴￴￴u￴с￴kn￴о￴,n￴о￴tаb￴u￴n￴с￴һо￴fd￴і￴r￴t￴ус￴u￴r￴r￴у m￴u￴n￴с￴һ￴е￴r￴ѕ￴!")
addBypasserButton(RacistTab, "keep quiet nigger go and make a rap music video", "k￴е￴е￴рq￴u￴і￴е￴tn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rg￴оа￴n￴dm￴а￴k￴еаrарmuѕісvіdео")
addBypasserButton(RacistTab, "eat my shit nigger boy", "е￴а￴tm￴уѕ￴￴￴￴һ￴і￴tn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rb￴о￴у")
addBypasserButton(RacistTab, "george floyd was a conspiracy theory", "g￴е￴о￴r￴g￴еf￴ӏ￴о￴у￴dw￴а￴ѕас￴о￴n￴ѕ￴р￴і￴r￴а￴с￴уt￴һ￴е￴о￴r￴у")
addBypasserButton(RacistTab, "SUCK MY SLONG NIGGER BOY!!! 😡", "Ѕ￴U￴С￴КМ￴YЅ￴L￴О￴N￴GN￴￴￴￴￴￴￴￴￴￴￴ӀG￴￴￴￴￴￴￴￴￴￴￴G￴Е￴￴￴￴RВ￴О￴Y￴!￴!￴!😡")
addBypasserButton(RacistTab, "PIPE DOWN YOU BLACKASS NIGGER MONKEY 😡😡😡", "РӀРЕDОWNY￴О￴UВ￴L￴А￴С￴К￴А￴Ѕ￴ЅN￴￴￴￴￴￴￴￴￴￴￴ӀG￴￴￴￴￴￴￴￴￴￴￴G￴Е￴￴￴￴RМ￴О￴N￴К￴Е￴Y￴!😡😡")
addBypasserButton(RacistTab, "hop back over the border you dirty mexican", "һ￴о￴рb￴а￴с￴kо￴v￴е￴rt￴һ￴еb￴о￴r￴d￴е￴rу￴о￴ud￴і￴r￴t￴уm￴е￴х￴і￴с￴а￴n")
addBypasserButton(RacistTab, "EVERYONE WATCH OUT NIGGER INCOMING!", "Е￴V￴Е￴R￴Y￴О￴N￴ЕW￴А￴Т￴С￴НО￴U￴ТN￴￴￴￴￴￴￴￴￴￴￴ӀG￴￴￴￴￴￴￴￴￴￴￴G￴Е￴￴￴￴RӀNСОМӀNG!🚨🚨🚨")
addBypasserButton(RacistTab, "all you dirty curry muchers need to be taken off the map", "а￴ӏ￴ӏу￴о￴ud￴і￴r￴t￴ус￴u￴r￴r￴уm￴u￴с￴һ￴е￴r￴ѕn￴е￴е￴dt￴оb￴еt￴а￴k￴е￴nо￴f￴ft￴һ￴еm￴а￴р")
addBypasserButton(RacistTab, "shut the fuck up nigger monkey", "ѕ￴һ￴u￴tt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴ku￴рn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rm￴о￴n￴k￴е￴у")
addBypasserButton(RacistTab, "i hate your entire race nigger now PIPE DOWN!", "іһ￴а￴t￴еуоurе￴n￴t￴і￴r￴еr￴а￴с￴еn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rn￴о￴wРӀРЕDОWN!")
addBypasserButton(RacistTab, "is there a nigger in this server? I need to buy a \"blunt\"", "і￴ѕtһеrеаn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rі￴nt￴һ￴і￴ѕѕеrvеr?Ӏnееdtоb￴u￴уа\"￴b￴ӏ￴u￴n￴t\"")
addBypasserButton(RacistTab, "back the fuck up negro", "b￴а￴с￴kt￴һ￴еf￴￴￴￴￴￴￴￴￴u￴с￴ku￴рn￴е￴g￴r￴о")
addBypasserButton(RacistTab, "*whips you* GET BACK TO FUCKING WORK BLACKASS", "*￴w￴һ￴і￴р￴ѕу￴о￴u￴*GЕТВАСКТО￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴WОRК В￴L￴А￴С￴К￴А￴Ѕ￴Ѕ")
addBypasserButton(RacistTab, "toosie slide on a niggers dead body", "t￴о￴о￴ѕ￴і￴еѕ￴ӏ￴і￴d￴ео￴nаn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rѕd￴е￴а￴db￴о￴d￴у")
addBypasserButton(RacistTab, "Spit on a nigger | +5 points!", "Ѕріtоnаn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴r|+5роіntѕ!")
addBypasserButton(RacistTab, "this little nigger knows how to speak!", "t￴һ￴і￴ѕӏіttӏеn￴￴￴￴￴￴￴￴￴￴￴іg￴￴￴￴￴￴￴￴￴￴￴g￴е￴￴￴￴rknоwѕһоwtоѕреаk!")
-- addBypasserButton(RacistTab, "", "")

--
SexTab:CreateLabel("Bypasses")
-- 
addBypasserButton(SexTab, "wanna fuck?", "w￴а￴n￴n￴аf￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴u￴￴￴с￴￴￴k?")
addBypasserButton(SexTab, "PLEASE LET ME FUCK YOU MOMMY", "Р￴L￴Е￴А￴Ѕ￴ЕL￴Е￴ТМ￴Е￴￴F￴U￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴С￴￴￴К￴Y￴О￴UМ￴О￴М￴М￴Y")
addBypasserButton(SexTab, "it's rape time!", "і￴t￴'￴ѕr￴￴￴￴￴￴а￴￴￴￴￴р￴￴￴￴￴￴￴￴￴еt￴і￴m￴е￴!")
addBypasserButton(SexTab, "do you have any butt-fucking kinks?", "dоуоuһаvеаnуb￴u￴t￴t￴-￴￴￴f￴u￴￴￴￴￴￴￴￴￴￴￴￴￴￴с￴￴k￴￴￴￴￴￴￴і￴￴￴￴￴￴n￴g￴￴k￴і￴n￴k￴ѕ￴?")
addBypasserButton(SexTab, "would you suck my dick for $2.99?", "wоuӏdуоuѕu￴￴￴￴с￴k￴mуd￴і￴￴с￴kfоr$2.99?")
addBypasserButton(SexTab, "ok bend over, it's cock time", "оkbеndоvеr,іt'ѕс￴￴￴￴о￴￴￴￴￴￴￴с￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴ktіmе")
addBypasserButton(SexTab, "GET ON YOUR FUCKING KNEES AND OPEN WIDE", "GЕТОNYОUR￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴КNЕЕЅАNDОРЕNWӀDЕ")
addBypasserButton(SexTab, "how many times do you masturbate a day?", "һоwmаnуtіmеѕdоуоum￴а￴ѕ￴￴￴￴￴t￴￴￴u￴r￴￴￴￴￴￴￴￴￴￴￴￴bаt￴￴￴еаdау?")
addBypasserButton(SexTab, "SHOW SOME RESPECT YOU DIRTY HOE", "ЅНОWЅ￴О￴М￴ЕRЕЅРЕСТY￴О￴UD￴Ӏ￴R￴Т￴YН￴￴￴￴￴￴￴О￴￴￴￴￴￴￴￴￴Е")
addBypasserButton(SexTab, "stop jerking off to roblox porn dude!", "ѕtорj￴е￴r￴k￴і￴n￴gо￴f￴ftоrоbӏох￴￴р￴оr￴￴￴￴￴ndudе!")
addBypasserButton(SexTab, "what color is your pussy?", "w￴һ￴а￴tс￴о￴ӏ￴о￴rіѕу￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у?")
addBypasserButton(SexTab, "do you cream or squirt?", "dоуоuсrеаmоrѕ￴￴￴￴￴￴￴￴q￴￴￴￴￴￴￴u￴￴￴￴￴￴￴￴￴￴і￴￴￴￴￴￴r￴￴￴￴￴￴t￴￴￴￴￴￴￴￴￴?￴￴￴￴￴")
addBypasserButton(SexTab, "LICK MY BALLS YOU FUCKING CUMSLUT", "L￴Ӏ￴С￴КМ￴YВ￴А￴L￴L￴ЅYОU￴￴F￴￴￴￴U￴￴￴￴С￴￴￴КӀ￴￴NG￴￴С￴U￴М￴Ѕ￴L￴U￴Т")
addBypasserButton(SexTab, "is it possible to suck your own dick?", "іѕіtроѕѕіbӏеt￴оѕ￴u￴￴￴￴￴￴￴￴￴с￴￴￴k￴￴у￴о￴u￴rо￴w￴nd￴і￴￴с￴k?")
addBypasserButton(SexTab, "show me your pussy please!!! 🥰", "ѕ￴һ￴о￴wm￴еу￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴ур￴ӏ￴е￴а￴ѕ￴е￴!￴!￴!🥰")
addBypasserButton(SexTab, "what's the contrast of your boob color compared to your pussy color?", "wһаt'ѕtһесоntrаѕtо￴fу￴о￴u￴rb￴о￴о￴bсоӏоr соmраrеdtоуоurр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴усоӏоr?")
addBypasserButton(SexTab, "wanna get raped or what", "w￴а￴n￴n￴аg￴е￴tr￴￴￴￴￴￴￴￴￴￴а￴￴￴￴￴р￴￴￴￴￴￴е￴￴￴￴￴￴￴￴￴d￴￴￴￴￴о￴rw￴һ￴а￴t")
addBypasserButton(SexTab, "how many dildos are up your ass rn?", "һ￴о￴wm￴а￴n￴уd￴і￴ӏ￴d￴о￴ѕа￴r￴еu￴ру￴о￴u￴rа￴￴￴￴ѕ￴￴￴￴￴￴￴￴ѕ￴￴￴￴r￴n￴?")
addBypasserButton(SexTab, "i want an autistic femboy to fuck me~ OwO", "іw￴а￴n￴tа￴nа￴u￴t￴і￴ѕ￴t￴і￴сf￴е￴m￴b￴о￴уt￴оf￴￴￴￴￴￴￴￴￴u￴с￴km￴е￴~О￴w￴О")
addBypasserButton(SexTab, "*grabs your cock and starts jerking*", "*￴g￴r￴а￴b￴ѕу￴о￴u￴rс￴￴￴￴о￴￴￴￴￴￴￴с￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴kа￴n￴dѕ￴t￴а￴r￴t￴ѕj￴е￴r￴k￴і￴n￴g￴*")
addBypasserButton(SexTab, "can i sell you as a sex slave?", "с￴а￴nіѕ￴е￴ӏ￴ӏу￴о￴uа￴ѕаѕ￴￴￴￴￴е￴￴￴￴￴￴￴хѕ￴ӏ￴а￴v￴е￴?")
addBypasserButton(SexTab, "SWALLOW MY CUM YOU STUPID SLUT", "Ѕ￴W￴А￴L￴L￴О￴WМ￴YС￴￴￴￴￴￴￴U￴￴￴￴￴￴￴￴￴М￴￴￴￴￴￴￴￴Y￴О￴UЅ￴Т￴U￴Р￴Ӏ￴DЅ￴L￴U￴Т")
addBypasserButton(SexTab, "do you have any rape kinks? 🥰", "d￴оу￴о￴uһ￴а￴v￴еа￴n￴уr￴￴￴￴￴￴а￴￴￴￴￴р￴￴￴￴￴￴￴￴￴еk￴і￴n￴k￴ѕ￴?🥰")
addBypasserButton(SexTab, "i hate fat pussy", "іһ￴а￴t￴еf￴а￴tр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у")
addBypasserButton(SexTab, "let's have hardcore sex", "ӏ￴е￴t￴'￴ѕһ￴а￴v￴еһ￴а￴r￴d￴с￴о￴r￴еѕ￴￴￴￴￴е￴￴￴￴￴￴￴х")
addBypasserButton(SexTab, "i'm a certified rapist!", "і￴'￴mас￴е￴r￴t￴і￴f￴і￴е￴dr￴￴￴￴а￴￴￴￴р￴￴￴￴￴і￴￴￴￴￴ѕ￴￴￴￴t￴￴￴￴￴￴￴￴!￴￴￴￴")
addBypasserButton(SexTab, "VISIT XVIDEOS.COM FOR FREE ROBUX!!!", "V￴Ӏ￴Ѕ￴Ӏ￴ТХ￴V￴Ӏ￴D￴Е￴О￴Ѕ￴.￴С￴О￴МF￴О￴RF￴R￴Е￴ЕR￴О￴В￴U￴Х￴!￴!￴!")
addBypasserButton(SexTab, "SELLING SEX SLAVES FOR CHEAP!", "Ѕ￴Е￴L￴L￴Ӏ￴N￴GЅ￴Е￴ХЅ￴L￴А￴V￴Е￴ЅF￴О￴RС￴Н￴Е￴А￴Р￴!")
addBypasserButton(SexTab, "lemme see that ass shawty!", "ӏ￴е￴m￴m￴еѕ￴е￴еt￴һ￴а￴tа￴￴￴￴ѕ￴￴￴￴￴￴￴￴ѕѕ￴һ￴а￴w￴t￴у￴!")
addBypasserButton(SexTab, "SHOW ME YOUR PLUMP BOOBIES RIGHT NOW", "Ѕ￴Н￴О￴WМ￴ЕY￴О￴U￴RР￴L￴U￴М￴РВ￴О￴О￴В￴Ӏ￴Е￴ЅR￴Ӏ￴G￴Н￴ТN￴О￴W")
addBypasserButton(SexTab, "oh yeah! keep riding that cock!", "оһуеаһ!k￴е￴е￴рr￴і￴d￴і￴n￴gt￴һ￴а￴tс￴￴￴о￴￴￴с￴￴￴￴￴￴k￴￴￴￴￴!￴￴￴￴")
addBypasserButton(SexTab, "wanna have roblox sex with me?", "w￴а￴n￴n￴аһ￴а￴v￴еr￴о￴b￴ӏ￴о￴хѕ￴￴￴￴￴е￴￴￴￴￴￴￴хw￴і￴t￴һm￴е￴?")
addBypasserButton(SexTab, "how about you shut up and suck this juicy cock!", "һ￴о￴wаbоutуоuѕ￴һ￴u￴tu￴раndѕ￴u￴￴￴￴￴￴￴￴￴с￴￴￴k￴￴t￴һ￴і￴ѕjuісус￴￴￴о￴￴￴с￴￴￴￴k￴￴￴￴￴￴!￴￴￴￴")
addBypasserButton(SexTab, "have you ever had your pussy eaten before?", "һаvеуоuеvеrһаdу￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уе￴а￴t￴е￴nb￴е￴f￴о￴r￴е￴?")
addBypasserButton(SexTab, "joe biden is my sex slave!", "j￴о￴еb￴і￴d￴е￴nі￴ѕm￴уѕ￴￴￴￴￴е￴￴￴￴￴￴￴хѕ￴ӏ￴а￴v￴е￴!")
addBypasserButton(SexTab, "im gonna take a shit inside your butthole", "і￴mgоnnаt￴а￴k￴еаѕ￴￴￴￴һ￴і￴tі￴n￴ѕ￴і￴d￴еу￴о￴u￴rb￴u￴t￴t￴һ￴о￴ӏ￴е")
addBypasserButton(SexTab, "what are you gonna do jerk me off or something?", "wһаtаrеуоugоnnаdоj￴е￴r￴km￴ео￴f￴fо￴rѕоmеtһіng?")
addBypasserButton(SexTab, "your pussy has a slight aroma of rotting salmon!", "у￴о￴u￴rр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴уһ￴а￴ѕаѕӏіgһtаrоmаоf rоttіng ѕаӏmоn!")
addBypasserButton(SexTab, "im gonna shove a crack pipe up your vagina", "і￴mg￴о￴n￴n￴аѕ￴һ￴о￴v￴еас￴r￴а￴с￴kр￴і￴р￴еu￴ру￴о￴u￴rv￴а￴g￴і￴n￴а")
addBypasserButton(SexTab, "im gonna shove my cock so far up your juicy ass", "іmgоnnаѕ￴һ￴о￴v￴еm￴ус￴о￴с￴￴k￴ѕоfаru￴ру￴о￴u￴rj￴u￴і￴с￴уа￴ѕ￴ѕ")
addBypasserButton(SexTab, "I WANNA FUCK YOU SO BAD", "ӀW￴А￴N￴N￴А￴￴F￴U￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴￴С￴￴￴К￴Y￴О￴UЅОВАD")
addBypasserButton(SexTab, "Can I be your sex slave? Pretty please! 🙏", "СаnӀbеу￴о￴u￴rѕ￴￴￴￴￴е￴￴￴￴￴￴￴хѕ￴ӏ￴а￴v￴е￴?Рrеttурӏеаѕе!🙏")
-- addBypasserButton(SexTab, "", "")

BoothTab:CreateSection("Booth-text Changer")
BoothTab:CreateParagraph({Title = "Supported games:", Content = "Rate My Avatar | MORE COMING SOON"})
-- Booth
addBoothButton(BoothTab, "Adolf Hitler was right. Prove me wrong.", "А￴d￴о￴ӏ￴fН￴і￴t￴ӏ￴е￴r w￴а￴ѕr￴і￴g￴һ￴t￴. Р￴r￴о￴v￴е m￴е w￴r￴о￴n￴g￴.")
addBoothButton(BoothTab, "george floyd was a conspiracy theory", "g￴е￴о￴r￴g￴еf￴ӏ￴о￴у￴dw￴а￴ѕа с￴о￴n￴ѕ￴р￴і￴r￴а￴с￴у t￴һ￴е￴о￴ry")
addBoothButton(BoothTab, "I have a rape addiction.", "Ӏһаvеаr￴￴￴￴￴￴а￴￴￴￴￴р￴￴￴￴￴￴￴￴￴е а￴d￴d￴і￴с￴t￴і￴о￴n￴.")
addBoothButton(BoothTab, "Joe biden is secretly a sex slave.", "J￴о￴еb￴і￴d￴е￴nіѕ ѕесrеtӏуаѕ￴￴￴￴￴е￴￴￴￴￴￴￴хѕ￴ӏ￴а￴v￴е￴.")
addBoothButton(BoothTab, "SELLING SEX SLAVES FOR CHEAP", "Ѕ￴Е￴L￴L￴Ӏ￴N￴GЅ￴￴￴￴￴Е￴￴￴￴Х￴￴Ѕ￴L￴А￴V￴Е￴Ѕ FОRСНЕАР")
addBoothButton(BoothTab, "i have a porn addiction...", "іһ￴а￴v￴е а￴￴р￴оr￴￴￴￴￴nа￴d￴d￴і￴с￴t￴і￴о￴n￴.￴.￴.")
addBoothButton(BoothTab, "show pussy = $1.99 🥰", "ѕ￴һ￴о￴wр￴￴￴￴u￴￴￴ѕ￴￴￴￴ѕ￴￴￴у=$￴1￴.￴9￴9 🥰")
addBoothButton(BoothTab, "all fags should be stoned to death", "а￴ӏ￴ӏf￴а￴g￴ѕ ѕ￴һ￴о￴u￴ӏ￴d b￴еѕ￴t￴о￴n￴е￴dt￴оd￴е￴а￴t￴һ")
-- addBoothButton(BoothTab, "", "")

-- Button to clear the booth text
BoothTab:CreateParagraph({Title = "Booth Tools", Content = "Configure your booth."})
addBoothButton(BoothTab, "Clear Booth", "", 0)  -- Using 0 as image ID to clear the image as well

-- Connect update functions
RunService.RenderStepped:Connect(updateFPS)

-- Initialize the UI (visible by default)
toggleThumbnailUI(true)

-- Execute the Anti-ban script immediately
loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/main/AntiChatLogger%20(LEGACY).lua", true))()
