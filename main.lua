function love.load()
    Class = require "libs.class"
    Vector = require "libs.vector"
    Bullet = require "bullet"
    Player = require "player"
    Enemy = require "enemy"
    Width, Height = love.graphics.getDimensions()
    Dimensions = Vector(Width, Height)
end

function love.update(dt)
    Player:update(dt)
end

function love.draw()
    Player:draw()
    Enemy:draw()
end

function love.keypressed(key)
    Player:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end