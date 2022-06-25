-- I really miss those golden Kade Engine days....
-- Average4k ftw :D

function start(song) -- do nothing
    bfsinging= true;
    spinLength = 0

    if getProperty('LuaMidscroll') then
        if getProperty('LuaOpponent') then
            for i=0,3 do
                local receptor = _G['receptor_'..i]
                receptor.x = receptor.defaultX + 310.25;
                setOpponentLaneUnderLayOpponentPos(_G['receptor_'..0].x - 25)
            end
        else
            for i=4,7 do
                local playerReceptor = _G['receptor_'..i]
                playerReceptor.x = playerReceptor.defaultX-303.25;
                setLaneUnderLayPos(_G['receptor_'..4].x-25)
            end
        end
    end

end

local function camZoom() --Simulate a camZoom 
    if zoomAllowed then
        camNotes:tweenZoom(camNotes.zoom + 0.12,0.01/rate, 'linear')
        camNotes:tweenZoom(camNotes.zoom,0.5/rate,'elasticout')

        camStrums:tweenZoom(camStrums.zoom+0.12,0.01/rate,'linear')
        camStrums:tweenZoom(camStrums.zoom,0.5/rate,'elasticout')

        camSustains:tweenZoom(camSustains.zoom+0.12,0.01/rate,'linear')
        camSustains:tweenZoom(camSustains.zoom,0.5/rate,'elasticout')

        camHUD:tweenZoom(camHUD.zoom + 0.12,0.01/rate, 'linear')
        camHUD:tweenZoom(camHUD.zoom, 0.5/rate, 'elasticout')

        camGame:tweenZoom(camGame.zoom + 0.12,0.01/rate, 'linear')
        camGame:tweenZoom(camGame.zoom, 0.5/rate, 'elasticout')      
    end
end

local function speedBounce() --Interlope speed notes effect
    setScrollSpeed(1)
    changeScrollSpeed(scrollspeed,0.35/rate,'sineout')
end

local function spin() --Do the endless spin strums 
    for i=0,7 do
        local receptor = _G['receptor_'..i]
        receptor:tweenAngle(receptor.angle+360,0.5/rate,'smootherStepInOut')
    end
end

function update(elapsed) --Sway Strum's X and Y
    --camGame:shake(0.005) -Some screen shake stuff bruh
    --camHUD:shake(0.005)
    if difficulty == 2 and curStep > math.floor(400 * rate) then
        local currentBeat = (songPos / 1000)*(bpm*rate/60)
        if spinLength < 32 then
            spinLength = spinLength + 0.2
        end
        if not getProperty('LuaMidscroll') then
            for i=0,7 do
                local receptor = _G['receptor_'..i]
                receptor.x = receptor.defaultX + spinLength * math.sin((currentBeat + i*0.25) * math.pi)
                receptor.y = (receptor.defaultY+10) + spinLength * math.cos((currentBeat + i*0.25) * math.pi)
            end
        else
            if getProperty('LuaOpponent') then
                for i=0,3 do
                    local receptor = _G['receptor_'..i]
                    receptor.x = (receptor.defaultX+310.25) + spinLength * math.sin((currentBeat + i*0.25) * math.pi)
                    receptor.y = (receptor.defaultY+10) + spinLength * math.cos((currentBeat + i*0.25) * math.pi)
                end
            else
                for i=4,7 do
                    local receptor = _G['receptor_'..i]
                    receptor.x = (receptor.defaultX-303.5) + spinLength * math.sin((currentBeat + i*0.25) * math.pi)
                    receptor.y = (receptor.defaultY+10) + spinLength * math.cos((currentBeat + i*0.25) * math.pi)
                end
            end
        end
    end
end

function beatHit(beat) -- do nothing

end

function stepHit(step) -- do nothing
    if step < math.floor(413*rate) then
        if step % math.floor(8*rate) == math.floor(4*rate) and (step < math.floor(254*rate) or step > math.floor(323*rate)) then
            spin()
            camZoom()
            if difficulty == 2 then
                speedBounce()
            end
        else 
            if step % math.floor(16*rate) == math.floor(8*rate) and (step >= math.floor(254*rate) and step < math.floor(323*rate)) then
                spin()
                camZoom()
                if difficulty == 2 then
                    speedBounce()
                end
            end
        end
    end
end

function playerTwoTurn()

    camGame.tweenZoom(camGame,camGame.zoom+0.3,((crochet * 4) / 1000)/rate, 'smootherStepInOut')
end

function playerOneTurn()

    camGame.tweenZoom(camGame,camGame.zoom-0.3,((crochet * 4)/ 1000)/rate, 'smootherStepInOut')
end