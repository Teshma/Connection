Width, Height = love.graphics.getDimensions()
DEFINES = require "defines"
Bullet = require "bullet"
Player = require "player"
Enemy = require "enemy"
Map = require "map"
Collision = require "collision"
GAMEDEBUG = true

function love.load()
    Map:generate()
    Player:new(32, 32)
    Map:addEntity(Player, 64, 0)
    Map:addEntity(Enemy:new(), Width - 64, 64)
    Map:addEntity(Enemy:new(), Width - 64, 64*2)
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