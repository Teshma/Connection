local Map =
{
    initialTilesize = 128,
    grid = {},
    entities = {}
}

Map.tilesize = Map.initialTilesize
Map.columns = math.floor(Width/Map.tilesize)
Map.rows = math.floor(Height/Map.tilesize)

function Map:UpdateScale()
    self.tilesize = self.initialTilesize / TilesizeScale
    self.columns = math.floor(Width/self.tilesize)
    self.rows = math.floor(Height/self.tilesize)
end

function Map:AddEntity(entity)
    table.insert(self.entities, entity)
end

function Map:DeleteEntity(entity)
    for i,v in ipairs(self.entities) do
        if v == entity then
            table.remove(self.entities, i)
        end
    end

    for i,v in ipairs(Enemies) do
        if v == entity then
            table.remove(Enemies, i)
        end
    end
end

function Map:MoveEntity(entity, deltaX, deltaY)
    local tile_x, tile_y = math.floor(entity.x/self.tilesize), math.floor(entity.y/self.tilesize)
    local collumn_shifts, row_shifts = self:ProcessDeltas(deltaX, deltaY)
    local new_grid_x, new_grid_y = tile_x + collumn_shifts, tile_y + row_shifts
    
    if GAMEDEBUG and DEFINES.Map then
        print(entity:__tostring()..": +("..collumn_shifts..","..row_shifts..")".." ==> ".."("..new_grid_x..","..new_grid_y..")")
    end
    
    if self:CheckPosition(new_grid_x, new_grid_y) then
        local new_pos_x, new_pos_y = entity.x + deltaX, entity.y + deltaY
        entity.x = new_pos_x
        entity.y = new_pos_y
    else
        if entity.onScreenBounds ~= nil then entity:onScreenBounds() end
    end
end

function Map:ProcessDeltas(deltaX, deltaY)
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


function Map:CheckPosition(x, y)
    if x > Map.columns - 1 or x < 0 or y > Map.rows - 1 or y < 0 then
        return false
    end
    return true
end

function Map:Update(dt)
    for i, first_ent in ipairs(self.entities) do
        first_ent:update(dt)
        for j, second_ent in ipairs (self.entities) do
            if i ~= j then
                if Collision.aabb(first_ent, second_ent) then
                    if first_ent.resolveCollision then first_ent:resolveCollision(second_ent) end
                    if second_ent.resolveCollision then second_ent:resolveCollision(first_ent) end
                end
            end
        end
    end
end

function Map:Draw()
    for _, ent in ipairs(self.entities) do
        if ent.draw ~= nil then ent:draw() end
    end
end

return Map