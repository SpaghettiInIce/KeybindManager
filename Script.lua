local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Define a table to store button information
local buttons = {}

-- Function to create a draggable button with a cool design
function CreateDraggableButton(buttonName, keybindName, position)
    local gui = Instance.new("ScreenGui")
    gui.Parent = LocalPlayer.PlayerGui

    local button = Instance.new("TextButton")
    button.Parent = gui
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = position or UDim2.new(0, 10, 0, 10) -- Default position or provided position
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.TextColor3 = Color3.new(1, 1, 1) -- Text color
    button.Font = Enum.Font.SourceSansBold -- Font style
    button.FontSize = Enum.FontSize.Size18 -- Font size
    button.Text = buttonName -- Set the button's text to the button name
    button.BackgroundTransparency = 0.5 -- Make it slightly transparent
    button.Active = true
    button.Selectable = true
    button.Draggable = true

    -- Store button information in the table
    table.insert(buttons, {
        Name = buttonName,
        Keybind = keybindName,
        Position = button.Position,
    })

    -- Handle button click event to simulate a key press
    button.MouseButton1Click:Connect(function()
        -- Simulate the key press, replace 'Enum.KeyCode.<Key>' with the actual key you want
        local Keytosend = Enum.KeyCode[keybindName]
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Keytosend, false, game)
    end)
end

-- Function to create a draggable button using KeyBind("ButtonName", "Key", UDim2.new(x, y, x, y))
function KeyBind(buttonName, keybindName, position)
    CreateDraggableButton(buttonName, keybindName, position)
end

-- Listen for player chat messages
LocalPlayer.Chatted:Connect(function(message)
    local splitMessage = string.split(message, " ")
    if splitMessage[1] == "/e" then
        local buttonName = splitMessage[2]
        local keybindName = splitMessage[3]
        
        -- Execute button creation logic with a cool design using the KeyBind function
        KeyBind(buttonName, keybindName)
    end
end)

-- Create buttons for the initial character, if available
if LocalPlayer.Character then
    for _, buttonInfo in pairs(buttons) do
        CreateDraggableButton(buttonInfo.Name, buttonInfo.Keybind, buttonInfo.Position)
    end
end
