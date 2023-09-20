Width, Height = love.graphics.getDimensions()
DEFINES = require "defines"
Bullet = require "bullet"
Player = require "player"
Enemy = require "enemy"
Map = require "map"
Collision = require "collision"
GAMEDEBUG = true
math.randomseed(os.time())

function love.load()
    Map:generate()
    Player:new(32, 32)
    Map:addEntity(Player, 64, 0)
    for i = 1, Map.rows do
        local colour = {1, 1, 1, 1}
        if i % 2 == 0 then
            colour[1] = 1;  colour[2] = 0;  colour[3] = 0;  colour[4] = 1
        else
            colour[1] = 0;  colour[2] = 0;  colour[3] = 1;  colour[4] = 1
        end
        local speed = 1/math.random(1,Map.rows)
        local hits = math.random(1,3)
        Map:addEntity(Enemy:new(colour, speed, hits), Width - 64, 64 * (i - 1))
    end
end

function love.update(dt)
    Map:update(dt)
end

function love.draw()
    Map:draw()
end

function love.keypressed(k)
    Player:keypressed(k)
    if k == "escape" then
        love.event.quit()
    end
    if k == "f1" then
        GAMEDEBUG = not GAMEDEBUG
    end
end