local player = {
    new = function (self, x, y)
        self.x = x
        self.y = y
        self.w = 64
        self.h = 64
        self.bullets = {}
        self.bullet_cooldown = 1
        self.v = 64
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
            Map:moveEnity(self, 0, -Map.tilesize)
            self.move_timer = self.move_cooldown
        end
        if love.keyboard.isDown("s") then
            Map:moveEnity(self, 0, Map.tilesize)
            self.move_timer = self.move_cooldown
        end
    elseif self.move_timer > 0 then
        self.move_timer = self.move_timer - dt
    end
    -- Bullet Management
    for i, bullet in ipairs(self.bullets) do
        bullet:update(dt)
        if 
        bullet.x > Width or bullet.x < 0 or
        bullet.y > Height or bullet.y < 0
        then
            table.remove(self.bullets, i)
        end
    end
end


function player:keypressed(k)
    -- Shooting
    if k == "space" then
        table.insert(self.bullets, Bullet:new(self.x + self.w/2, self.y + self.h/2))
        if GAMEDEBUG and DEFINES.Player.Bullet then
            print("------------------------------------------------")
            print("fired bullet")
            print("------------------------------------------------") 
            for i,b in ipairs(self.bullets) do
                for k,v in pairs(b) do
                    print(i, k, v)
                end
                print("------------------------------------------------")
            end
        end
    end
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    for _, bullet in ipairs(self.bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.w, bullet.h)
    end
end

function player:__tostring()
    return "player"
end
return player