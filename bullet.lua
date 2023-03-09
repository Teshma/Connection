local Bullet = {
    new = function(self, x_pos, y_pos)
        local table =
        {
            x = x_pos,
            y = y_pos,
            w = 32,
            h = 4,
            v = 500,
            update = function (self, dt)
                Map:moveEntity(self, self.v * dt, 0)
                if self.x > Width or self.x < 0 or self.y > Height or self.y < 0 then
                    Map:deleteEntity(self)
                end
            end,
            draw = function (self)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
            end,
            __tostring = function ()
                return "bullet"
            end

        }
        return table
    end,
}

return Bullet