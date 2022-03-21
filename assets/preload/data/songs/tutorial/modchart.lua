-- I really miss those golden Kade Engine days....
-- Average4k ftw :D

function start(song) -- do nothing

end

local function camZoom() --Simulate a camZoom 
    if zoomAllowed then
        camHUD:tweenZoom(1.06,0.01, 'linear')
        camHUD:tweenZoom(1, 0.5, 'smootherStepOut')
        if bfsinging then
            camGame:tweenZoom(1.06,0.01, 'linear')
            camGame:tweenZoom(1, 0.5, 'smootherStepOut')
        else
            camGame:tweenZoom(1.36,0.01, 'linear')
            camGame:tweenZoom(1.3, 0.5, 'smootherStepOut')
        end
    end
end

local function speedBounce() --Interlope speed notes effect
    speedshit = scrollspeed
    setScrollSpeed(1)
    changeScrollSpeed(scrollspeed,0.35,'sineout')
end

local function spin() --Do the endless spin strums 
    for i=0,7 do
        local receptor = _G['receptor_'..i]
        receptor:tweenAngle(receptor.angle+360,0.5,'smootherStepInOut')
    end
end

function update(elapsed) --Sway Strum's X and Y
    if difficulty == 2 and curStep > 400 then
        local currentBeat = (songPos / 1000)*(bpm/60)
	    for i=0,7,1 do
            local receptor = _G['receptor_'..i]
	        receptor.x = receptor.defaultX + 32 * math.sin((currentBeat + i*0.25) * math.pi)
	        receptor.y = receptor.defaultY + 32 * math.cos((currentBeat + i*0.25) * math.pi)
        end
    end
end

function beatHit(beat) -- do nothing
    if beat < 100 then
        if beat % 2 == 1 then
            spin()
            camZoom()
            if difficulty == 2 then
                speedBounce()
            end
        end 
    end
end

function stepHit(step) -- do nothing

end

function playerTwoTurn()
    bfsinging = false
    camGame.tweenZoom(camGame,1.3,(crochet * 4) / 1000, 'smootherStepInOut')
end

function playerOneTurn()
    bfsinging = true
    camGame.tweenZoom(camGame,1,(crochet * 4) / 1000, 'smootherStepInOut')
end