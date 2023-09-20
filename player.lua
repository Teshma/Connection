local player = {
    new = function (self, x, y)
        self.x = x
        self.y = y
        self.w = 64
        self.h = 64
        self.v = 64
        self.bullets = {}
        self.bullet_cooldown = 1
        self.move_cooldown = 0.2
        self.move_timer = 0
        return self
    end,
}
    
    
    
function player:update(dt)
    -- Movement
    if self.move_timer <= 0 then
        self.move_timer = 0
        if love.keyboard.isDown("w") then
            Map:moveEntity(self, 0, -Map.tilesize)
            self.move_timer = self.move_cooldown
        end
        if love.keyboard.isDown("s") then
            Map:moveEntity(self, 0, Map.tilesize)
            self.move_timer = self.move_cooldown
        end
    elseif self.move_timer > 0 then
        self.move_timer = self.move_timer - dt
    end
end


function player:keypressed(k)
    -- Shooting
    if k == "space" then
        local bullet = Bullet:new(self.x, self.y)
        table.insert(self.bullets, bullet)
        Map:addEntity(bullet, self.x, self.y)
        if GAMEDEBUG and DEFINES.Player.Bullet then
            print("------------------------------------------------")
            print("fired bullet " .. #self.bullets)
            print("------------------------------------------------") 
            for i,b in ipairs(self.bullets) do
                for k,v in pairs(b) do
                    print(k .. "\t\t", v)
                end
                print("------------------------------------------------")
            end
        end
    end
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function player:__tostring()
    return "player"
end
return player