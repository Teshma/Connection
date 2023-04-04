local map =
{
    tilesize = 64,
    grid = {},
    entities = {}
}
map.columns = math.floor(Width/map.tilesize)
map.rows = math.floor(Height/map.tilesize)

function map:generate()
    local columns = map.columns
    local rows = map.rows
    for i = 1, rows do
        self.grid[i] = {}
        for j = 1, columns do
            self.grid[i][j] = 0
        end
    end
    if DEFINES and DEFINES.Map then
        print(columns, rows)
        local string = ""
        for y, xtable in ipairs(self.grid) do
            for x, value in ipairs(xtable) do
                string = string.."["..y.."]["..x.."]"..tostring(value).." "
            end
        end
        print(string)
    end
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
    if DEFINES and DEFINES.Map then
        print(x, y)
        print(row, column)
    end
    self.grid[row][column] = entity
    table.insert(self.entities, {entity = entity, x = x, y = y})
end

function map:deleteEntity(entity)
    for i, ent in ipairs(self.entities) do
        if entity == ent.entity then
            table.remove(self.entities, i)
            
        end
    end
end

function map:moveEntity(entity, deltaX, deltaY)
    local columns, rows = self:processDeltas(deltaX, deltaY)
    for i,ent in ipairs(self.entities) do
        if ent.entity == entity then
            local x, y = math.floor(ent.x/self.tilesize), math.floor(ent.y/self.tilesize)
            local newX, newY = x + columns, y + rows
            if GAMEDEBUG and DEFINES.Map then
                print(entity:__tostring()..": +("..columns..","..rows..")".." ==> ".."("..newX..","..newY..")")
            end
            self.grid[math.min(math.max(y, 1), self.rows)][math.min(math.max(x, 1), self.columns)] = 0
            self.grid[math.min(math.max(newY, 1), self.rows)][math.min(math.max(newX, 1), self.columns)] = entity
            if self:checkPosition(newX, newY) then
                self.entities[i] = {entity = entity, x = newX * self.tilesize, y = newY * self.tilesize}
            else
                if self.entities[i].entity.onScreenBounds ~= nil then self.entities[i].entity:onScreenBounds() end
            end
            return
        end
    end
end

function map:processDeltas(deltaX, deltaY)
    local columns, rows
    if deltaX > 0 then
        columns = math.floor(deltaX/self.tilesize)
    else
        columns = math.ceil(deltaX/self.tilesize)
    end
    if deltaY > 0 then
        rows = math.floor(deltaY/self.tilesize)
    else
        rows = math.ceil(deltaY/self.tilesize)
    end
    return columns, rows
end


function map:checkPosition(x, y)
    if x > map.columns - 1 or x < 0 or y > map.rows - 1 or y < 0 then
        return false
    end
    return true
end

function map:update(dt)
    for i, first_ent in ipairs(self.entities) do
        first_ent.entity.x, first_ent.entity.y = first_ent.x, first_ent.y
        for j, second_ent in ipairs (self.entities) do
            if i ~= j then
                local ent1 = first_ent.entity
                local ent2 = second_ent.entity
                if Collision.aabb(ent1, ent2) then
                    if ent1.resolveCollision then ent1:resolveCollision(ent2) end
                    if ent2.resolveCollision then ent2:resolveCollision(ent1) end
                end
            end
        end
        first_ent.entity:update(dt)
    end
end

function map:draw()
    for _, ent in ipairs(self.entities) do
        if ent.entity.draw ~= nil then ent.entity:draw() end
    end
end

return map