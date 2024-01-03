-- Get the addon's namespace and name
local _, GoofyAddon = ...

-- Play a sound function
--  @param soundFile The filename of the sound to play.
function GoofyAddon.PlaySound(soundFile)

    -- Construct the full path to the sound file.
    local soundPath = "Interface\\AddOns\\GoofyAahNoises\\" .. soundFile

    -- Play the sound using the PlaySoundFile function.
    PlaySoundFile(soundPath, "Master")

end

-- Create a frame for handling events
local frame = CreateFrame("Frame")

-- Function to check the name of the target
local function CheckTargetName()

    -- Get the name of the target
    local targetName = UnitName("target")

    -- Check if the target has a name
    if targetName then

        -- Convert the target name and substring to lowercase
        local lowercaseTargetName = string.lower(targetName)

        local lowercaseSubstring = "auctioneer"

        -- Check if the target name contains a specific substring
        if string.find(lowercaseTargetName, lowercaseSubstring) then

            GoofyAddon.PlaySound("Pricemaster.wav")

        end

    end

end

-- Event handler function
function frame:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        -- Get the name of the addon that was loaded
        local addonName = ...

        if addonName == "GoofyAahNoises" then

            print("GoofyAahNoises addon loaded!")

            -- Register events when the addon is loaded
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:RegisterEvent("PLAYER_TARGET_CHANGED")

        end

    elseif event == "PLAYER_TARGET_CHANGED" then

        -- Check the target name when the player's target changes
        CheckTargetName()

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then

        -- Get relevant information from the combat log event
        local _, subevent, _, sourceGUID, _, _, _, _, destName, _, _, _, _, spellId = CombatLogGetCurrentEventInfo()

        -- Check if the event is caused by the player
        if sourceGUID == UnitGUID("player") then

            if subevent == "SWING_DAMAGE" then

                -- select return values of "critical" to see if it's true or false
                _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())

                if critical then

                    GoofyAddon.PlaySound("whiteCrit.wav")

                else

                    -- Randomize between different sounds
                    local randomIndex = math.random(1, 5)
                    local soundFile

                    if randomIndex == 1 then
                        soundFile = "hit.wav"
                    elseif randomIndex == 2 then
                        soundFile = "hit_2.wav"
                    elseif randomIndex == 3 then
                        soundFile = "hit_3.wav"
                    elseif randomIndex == 4 then
                        soundFile = "hit_4.wav"
                    else
                        soundFile = "hit_5.wav"
                    end

                    GoofyAddon.PlaySound(soundFile)

                end

            elseif subevent == "SWING_MISSED" then

                missType = select(12, CombatLogGetCurrentEventInfo())

                if missType == "PARRY" then
                    GoofyAddon.PlaySound("parry.wav")
                elseif missType == "DODGE" then
                    GoofyAddon.PlaySound("dodge.wav")
                elseif missType == "BLOCK" then
                    GoofyAddon.PlaySound("block.wav")
                elseif missType == "MISS" then
                    GoofyAddon.PlaySound("miss.wav")
                end

            elseif subevent == "SPELL_DAMAGE" then

                -- select return values of "critical" to see if it's true or false
                _, _, _, _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())

                if critical then

                    GoofyAddon.PlaySound("critical.wav")

                else

                    -- Randomize between different sounds
                    local randomIndex = math.random(1, 5)
                    local soundFile

                    if randomIndex == 1 then
                        soundFile = "hit.wav"
                    elseif randomIndex == 2 then
                        soundFile = "hit_2.wav"
                    elseif randomIndex == 3 then
                        soundFile = "hit_3.wav"
                    elseif randomIndex == 4 then
                        soundFile = "hit_4.wav"
                    else
                        soundFile = "hit_5.wav"
                    end

                    GoofyAddon.PlaySound(soundFile)

                end

            elseif subevent == "SPELL_MISSED" then

                print("Spell miss")

                -- Get the type of miss
                local missType = select(12, CombatLogGetCurrentEventInfo())

                if missType == "PARRY" then

                    GoofyAddon.PlaySound("parry.wav")

                elseif missType == "DODGE" then

                    GoofyAddon.PlaySound("dodge.wav")

                elseif missType == "BLOCK" then

                    GoofyAddon.PlaySound("block.wav")

                elseif missType == "MISS" then

                    GoofyAddon.PlaySound("miss.wav")

                end

            elseif subevent == "SPELL_PERIODIC_DAMAGE" then

                local randomIndex = math.random(1, 6)

                if randomIndex == 1 then

                    GoofyAddon.PlaySound("dots.wav")

                elseif randomIndex == 2 then

                    GoofyAddon.PlaySound("dots_2.wav")

                elseif randomIndex == 3 then

                    GoofyAddon.PlaySound("dots.wav")

                elseif randomIndex == 4 then

                    GoofyAddon.PlaySound("dots_2.wav")

                elseif randomIndex == 5 then

                    GoofyAddon.PlaySound("dots.wav")

                else

                    GoofyAddon.PlaySound("dots_2.wav")

                end

            elseif subevent == "RANGE_DAMAGE" then

                _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())

                if critical then

                    GoofyAddon.PlaySound("critical.wav")

                else

                    -- Randomize between different sounds
                    local randomIndex = math.random(1, 5)
                    local soundFile

                    if randomIndex == 1 then
                        soundFile = "hit.wav"
                    elseif randomIndex == 2 then
                        soundFile = "hit_2.wav"
                    elseif randomIndex == 3 then
                        soundFile = "hit_3.wav"
                    elseif randomIndex == 4 then
                        soundFile = "hit_4.wav"
                    else
                        soundFile = "hit_5.wav"
                    end

                    GoofyAddon.PlaySound(soundFile)

                end

            elseif subevent == "RANGE_MISSED" then

                print("Ranged miss")

                GoofyAddon.PlaySound("miss.wav")

            end
            -- Check if a unit died
            if subevent == "UNIT_DIED" then

                if destName == UnitName("player") then

                    GoofyAddon.PlaySound("death.wav")

                end

            end

        end

    end

end

-- Register events for the frame
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", frame.OnEvent)
