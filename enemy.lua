local enemy = {
    x = 400,
    y = 200,
    w = 50,
    h = 50
}

function enemy:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return enemy