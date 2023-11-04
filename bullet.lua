local Bullet = {
    new = function(self, x_pos, y_pos)
        local table =
        {
            x = x_pos,
            y = y_pos,
            w = Map.tilesize/2,
            h = Map.tilesize/8,
            v = 500,
            movement = 0,
            update = function (self, dt)
                -- Scale
                self.w = Map.tilesize/2
                self.h = Map.tilesize/8
                
                -- Movement
                self.movement = self.movement + self.v * dt
                if self.movement >= Map.tilesize then
                    Map:MoveEntity(self, self.movement, 0)
                    self.movement = 0
                end
            end,
            draw = function (self)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
            end,
            onScreenBounds = function (self)
                Map:DeleteEntity(self)
            end,
            resolveCollision = function (self, entity)
                if entity:__tostring() ~= "player" and entity:__tostring() ~= "bullet" then
                    print(entity:__tostring())
                    Map:DeleteEntity(self)
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