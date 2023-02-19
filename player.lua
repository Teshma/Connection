local player = {
    x = 50,
    y = 50,
    w = 50,
    h = 50,
    bullets = {},
    bullet_cooldown = 1,
    v = 400,
}


function player:update(dt)
    -- Movement
    if love.keyboard.isDown("w") then
        self.y = self.y - self.v * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.v * dt
    end
    --[[ if love.keyboard.isDown("a") then
        self.x = self.x - 100 * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + 100 * dt
    end ]]

    -- Bullet Management
    for i, bullet in ipairs(self.bullets) do
        bullet:update(dt)
        print(i, bullet.pos)
        if bullet.pos > Dimensions or bullet.pos < Vector(0, 0) then
            table.remove(self.bullets, i)
        end
    end
end

function player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    for _, bullet in ipairs(self.bullets) do
        love.graphics.rectangle("fill", bullet.pos.x, bullet.pos.y, bullet.w, bullet.h)
    end
end

function player:keypressed(k)
    -- Shooting
    if k == "space" then
        table.insert(self.bullets, Bullet(Vector(self.x + self.w/2, self.y + self.h/2)))
    end
end


return player