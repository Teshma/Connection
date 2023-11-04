if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    package.loaded["lldebugger"] = assert(loadfile(os.getenv("LOCAL_LUA_DEBUGGER_FILEPATH")))()
    require("lldebugger").start()
end

Width, Height = love.graphics.getDimensions()
Difficulty = 1
TilesizeScale = 1
Enemies = {}

require "maths" 
DEFINES = require "defines"
Bullet = require "bullet"
Player = require "player"
Enemy = require "enemy"
Map = require "map"
Collision = require "collision"
GAMEDEBUG = true
math.randomseed(os.time())

function love.load()

    Player:new(0, 0)
    Map:AddEntity(Player)
    LoadEnemies()

end

function love.update(dt)
    if #Enemies == 0 then
        ChangeDifficulty(1)
        Map:UpdateScale()
        LoadEnemies()
    end

    Map:Update(dt)
    
end

function love.draw()
    Map:Draw()
end

function love.keypressed(k)
    Player:keypressed(k)
    if k == "escape" then
        love.event.quit()
    end
    if k == "f1" then
        GAMEDEBUG = not GAMEDEBUG
    end
    if k == "up" then
        ChangeDifficulty(1)
        Map:UpdateScale()
        LoadEnemies()
    end
    if k == "down" then
        ChangeDifficulty(-1)
        Map:UpdateScale()
        LoadEnemies()
    end
end

function LoadEnemies()
    for i = 1, Map.rows do

        local colour = {}

        if i % 2 == 0 then
            colour = {1, 0, 0, 1}
        else
            colour = {0, 0, 1, 1}
        end

        local speed = math.random(1 , Map.rows/8)
        local health = math.random(1,3)
        local xPosition = Width - Map.tilesize
        local yPosition = Map.tilesize * (i - 1)
        local enemy = Enemy:new(colour, speed, health, xPosition, yPosition)
        table.insert(Enemies, enemy)
        Map:AddEntity(enemy)
    end
end

-- 1, 2, 4, 8, 16
function ChangeDifficulty(difficultyChange)
    Difficulty = Difficulty + difficultyChange

    TilesizeScale = math.pow(2, Difficulty - 1)
end
