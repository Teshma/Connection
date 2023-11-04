local enemy = {
    new = function (self, colour, speed, hits, x, y)
        local table = {
            x = x or 400,
            y = y or 200,
            w = Map.tilesize,
            h = Map.tilesize,
            health = hits,
            colour = colour,
            speed = speed * Map.tilesize,
            movement = 0,
            
            update = function (self, dt)

                -- Health Check
                if (self.health <= 0) then
                    Map:DeleteEntity(self)
                    return
                end

                -- Movement
                self.movement = self.movement + self.speed * dt
                if self.movement >= Map.tilesize then
                    Map:MoveEntity(self, -self.movement, 0)
                    self.movement = 0
                end
            end,

            draw = function (self)
                love.graphics.setColor(self.colour)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
                --love.graphics.print(self.health, self.x - 10, self.y, 0, 1, 1, 0, 0, 0, 0)
                love.graphics.setColor(1, 1, 1, 1)
            end,

            onScreenBounds = function (self)
                Map:DeleteEntity(self)
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