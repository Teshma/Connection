local map =
{
    tilesize = 64,
    grid = {},
    entities = {}
}

function map:generate()
    local columns = math.floor(Width/self.tilesize)
    local rows = math.floor(Height/self.tilesize)
    print(columns, rows)
    for i = 1, rows do
        self.grid[i] = {}
        for j = 1, columns do
            self.grid[i][j] = 0
        end
    end
    local string = ""
    for y, xtable in ipairs(self.grid) do
        for x, value in ipairs(xtable) do
            string = string.."["..y.."]["..x.."]"..tostring(value).." "
        end
    end
    print(string)
end

function map:getPos(x, y)
    return (x / self.tilesize), (y / self.tilesize)
end

function map:addEntity(entity, x, y)
    local column = math.floor(x/self.tilesize)
    local row = math.floor(y/self.tilesize)
    if x < self.tilesize or y < self.tilesize then
        row, column = 1, 1
    end
    print(row, column)
    self.grid[row][column] = entity
    table.insert(self.entities, {entity = entity, x = x, y = y})
end

function map:deleteEntity(entity)
    for i, ent in ipairs(self.entities) do
        if entity == ent then
            table.remove(self.entities, i)
        end
    end
end

function map:moveEntity(entity, deltaX, deltaY)
    local columns = math.floor(deltaX/self.tilesize)
    local rows = math.floor(deltaY/self.tilesize)
    for i,ent in ipairs(self.entities) do
        if ent.entity == entity then
            local x, y = math.floor(ent.x/self.tilesize), math.floor(ent.y/self.tilesize)
            local newX, newY = x + columns, y + rows
            if GAMEDEBUG and DEFINES.Map then
                print(entity:__tostring()..": +("..columns..","..rows..")".." ==> ".."("..newX..","..newY..")")
            end
            print(x, y)
            self.grid[math.max(y, 1)][math.max(x, 1)] = 0
            self.grid[newX][newY] = entity
            self.entities[i] = {entity = entity, x = newX * self.tilesize, y = newY * self.tilesize}
            
        end
    end
end

function map:update(dt)
    for i, ent in ipairs(self.entities) do
        ent.entity.x, ent.entity.y = ent.x, ent.y
        if i + 1 <= #self.entities then
            Collision.aabb(self.entities[i].entity, self.entities[i + 1].entity)
        end
        ent.entity:update(dt)
    end
end

function map:draw()
    for _, ent in ipairs(self.entities) do
        if ent.entity.draw ~= nil then ent.entity:draw() end
    end
end

return map