local Bullet = {
    new = function(self, x_pos, y_pos)
        local table =
        {
            x = x_pos,
            y = y_pos,
            w = 32,
            h = 4,
            v = 500,
            movement = 0,
            update = function (self, dt)
                self.movement = self.movement + self.v * dt
                if self.movement >= Map.tilesize then
                    Map:moveEntity(self, self.movement, 0)
                    self.movement = 0
                end
                self.x = self.x + Map.tilesize/2
                self.y = self.y + Map.tilesize/2
            end,
            draw = function (self)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
            end,
            onScreenBounds = function (self)
                Map:deleteEntity(self)
            end,
            resolveCollision = function (self, entity)
                if entity:__tostring() ~= "player" then
                    Map:deleteEntity(self)
                end
            end,
            __tostring = function ()
                return "bullet"
            end,
        }
        return table
    end,
}

return Bullet