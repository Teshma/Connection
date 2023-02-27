local Bullet = {
    new = function(self, x_pos, y_pos)
        self.x = x_pos
        self.y = y_pos
        self.w = 32
        self.h = 4
        self.v = 500
        return self
    end,

}

function Bullet:update(dt)
    self.x = self.x + Bullet.v * dt
end

return Bullet