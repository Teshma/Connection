local enemy = {
    new = function (self, colour, speed, hits)
        local table = {
            x = 400,
            y = 200,
            w = 64,
            h = 64,
            health = hits,
            colour = colour,
            speed = speed * Map.tilesize,
            movement = 0,
            print(speed),
            update = function (self, dt)
                if (self.health <= 0) then
                    Map:deleteEntity(self)
                    return
                end
                self.movement = self.movement + self.speed * dt
                if self.movement >= Map.tilesize then
                    Map:moveEntity(self, -self.movement, 0)
                    self.movement = 0
                end
            end,

            draw = function (self)
                love.graphics.setColor(colour)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
                love.graphics.print(self.health, self.x - 10, self.y, 0, 1, 1, 0, 0, 0, 0)
                love.graphics.setColor(1, 1, 1, 1)
            end,

            onScreenBounds = function (self)
                Map:deleteEntity(self)
            end,

            resolveCollision = function (self, entity)

                if entity:__tostring() == "bullet" then
                    self.health = self.health - 1;
                end
            end,

            __tostring = function (self)
                return "enemy"
            end
        }
        return table
    end,
}
return enemy