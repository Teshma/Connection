local enemy = {
    new = function (self, colour, speed)
        local table = {
            x = 400,
            y = 200,
            w = 64,
            h = 64,
            colour = colour,
            speed = speed * Map.tilesize,
            movement = 0,
            update = function (self, dt)
                
                self.movement = self.movement + self.speed * dt
                if self.movement >= Map.tilesize then
                    Map:moveEntity(self, -self.movement, 0)
                    self.movement = 0
                end
            end,

            draw = function (self)
                love.graphics.setColor(colour)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
                love.graphics.setColor(1, 1, 1, 1)
            end,
            onScreenBounds = function (self)
                Map:deleteEntity(self)
            end,

            __tostring = function (self)
                return "enemy"
            end
        }
        return table
    end,
}
return enemy