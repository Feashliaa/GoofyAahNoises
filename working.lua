local _, GoofyAddon = ...

-- Play a sound
function GoofyAddon.PlaySound(soundFile)
    PlaySoundFile("Interface\\AddOns\\GoofyAahNoises\\" .. soundFile, "Master")
end

local frame = CreateFrame("Frame")

local function CheckTargetName()
    local targetName = UnitName("target")

    -- Check if the target has a name
    if targetName then
        local lowercaseTargetName = string.lower(targetName)
        local lowercaseSubstring = "auctioneer"

        -- if target name contains substring
        if string.find(lowercaseTargetName, lowercaseSubstring) then
            GoofyAddon.PlaySound("Pricemaster.wav")
        end
    end
end

function frame:OnEvent(event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "GoofyAahNoises" then
            print("GoofyAahNoises addon loaded!")
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        CheckTargetName()
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subevent, _, sourceGUID, _, _, _, _, destName, _, _, _, _, spellId = CombatLogGetCurrentEventInfo()

        if sourceGUID == UnitGUID("player") then
            if subevent == "SWING_DAMAGE" then
                _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
                if critical then
                    GoofyAddon.PlaySound("critical.wav")
                else
                    local soundFile = (math.random(0, 1) == 0) and "hit.wav" or "hit_2.wav"
                    GoofyAddon.PlaySound(soundFile)
                end
            elseif subevent == "SPELL_DAMAGE" then
                _, _, _, _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
                if critical then
                    GoofyAddon.PlaySound("critical.wav")
                else
                    local soundFile = (math.random(0, 1) == 0) and "hit.wav" or "hit_2.wav"
                    GoofyAddon.PlaySound(soundFile)
                end
            elseif subevent == "SPELL_MISSED" then
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
                GoofyAddon.PlaySound("dot.wav")
            elseif subevent == "RANGE_DAMAGE" then
                _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
                if critical then
                    GoofyAddon.PlaySound("critical.wav")
                else
                    local soundFile = (math.random(0, 1) == 0) and "hit.wav" or "hit_2.wav"
                    GoofyAddon.PlaySound(soundFile)
                end
            elseif subevent == "RANGE_MISSED" then
                GoofyAddon.PlaySound("miss.wav")
            elseif subevent == "UNIT_DIED" then
                if destName == UnitName("player") then
                    GoofyAddon.PlaySound("death.wav")
                end
            end
        end
    end
end

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", frame.OnEvent)
