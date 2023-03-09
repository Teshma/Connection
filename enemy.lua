local enemy = {
    new = function (self, colour)
        local table = {
            x = 400,
            y = 200,
            w = 64,
            h = 64,

            update = function (self, dt)
            
            end,

            draw = function (self)
                love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
            end
        }
        return table
    end,
}
return enemy