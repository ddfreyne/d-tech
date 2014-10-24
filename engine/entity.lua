local here = (...):match("(.-)[^%.]+$")

local Entity = setmetatable({}, { __index = function() error('Attempted to access non-existant entity attribute') end })

function Entity:toString()
  return "Entity(name = " .. self.name .. ")"
end

function Entity.new(name)
  return setmetatable({ name = name, isDead = false }, { __tostring = Entity.toString, __index = Entity })
end

-- e.g. `ship:add(Engine.Components.Position, true)`
function Entity:add(type, ...)
  if not type then error('Attempted to add a component with nil type') end
  self[type] = type.new(...)
end

-- e.g. `ship:remove(Engine.Components.Position)`
function Entity:remove(type)
  if not type then error('Attempted to remove a component with nil type') end
  self[type] = nil
end

-- e.g. `ship:clone()`
function Entity:clone()
  local e = Entity.new()

  for k, v in pairs(self) do
    e[k] = v
  end

  return e
end

-- e.g. `ship:get(Engine.Components.Position)`
function Entity:get(type)
  if not type then error('Attempted to get a component with nil type') end
  return rawget(self, type)
end

function Entity:markAsDead()
  self.isDead = true
end

return Entity
