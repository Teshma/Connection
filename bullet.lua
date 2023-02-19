local Bullet = Class{
    init = function(self, pos)
        self.pos = pos
    end,
    w = 32,
    h = 4,
    v = 1000
}

function Bullet:update(dt)
    self.pos.x = self.pos.x + Bullet.v * dt
end

return Bullet