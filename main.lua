DEFINES = require "defines"
Bullet = require "bullet"
Player = require "player"
Enemy = require "enemy"
Map = require "map"

GAMEDEBUG = true
function love.load()
    Width, Height = love.graphics.getDimensions()
    Map:generate()
    --Player:new(Map.grid[2][3][1], Map.grid[2][3][2])
    Player:new(32, 32)
    Map:addEntity(Player, 64, 0)
    Enemies = {}
    table.insert(Enemies, Enemy)
end

function love.update(dt)
    Map:update(dt)
end

function love.draw()
    Map:draw()
    Enemy:draw()
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