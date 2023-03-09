local collision = {

}

function collision.aabb(first, second)
    -- check if objects overlap
    if  first.x < second.x + second.w and first.x + first.w > second.x and
        first.y + first.h > second.y and first.y < second.y + second.h then
        return true
    end
    return false
end

return collision