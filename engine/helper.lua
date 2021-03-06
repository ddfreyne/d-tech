local here = (...):match("(.-)[^%.]+$")

local Engine_AssetManager = require(here .. 'asset_manager')
local Engine_Components   = require(here .. 'components')
local Engine_Types        = require(here .. 'types')

local Helper = {}

-- TODO: Move this elsewhere
function Helper.rectForEntity(entity, scaled)
  local position = entity:get(Engine_Components.Position)
  if not position then return nil end

  local size = Helper.sizeForEntity(entity, scaled)
  if not size then return nil end

  local anchorPoint = entity:get(Engine_Components.AnchorPoint)
  local x = anchorPoint and anchorPoint.x or 0.5
  local y = anchorPoint and anchorPoint.y or 0.5

  return Engine_Types.Rect:new(
    position.x - size.width  * x,
    position.y - size.height * y,
    size.width,
    size.height)
end

-- TODO: Move this elsewhere
function Helper.sizeForEntity(entity, scaled)
  local scaleX = 1.0
  local scaleY = 1.0
  if scaled or scaled == nil then
    local scaleComponent = entity:get(Engine_Components.Scale)
    scaleX = scaleComponent and scaleComponent.x or 1.0
    scaleY = scaleComponent and scaleComponent.y or scaleX
  end

  local size = entity:get(Engine_Components.Size)
  if size then
    return Engine_Types.Size:new(
      size.width  * scaleX,
      size.height * scaleY)
  end

  local imageComponent     = entity:get(Engine_Components.Image)
  local imageQuadComponent = entity:get(Engine_Components.ImageQuad)
  local animationComponent = entity:get(Engine_Components.Animation)

  if imageQuadComponent then
    return Engine_Types.Size:new(
      imageQuadComponent.width  * scaleX,
      imageQuadComponent.height * scaleY
    )
  end

  local imagePath
  if imageComponent then
    imagePath = imageComponent.path
  elseif animationComponent then
    imagePath = animationComponent.imagePaths[animationComponent.curFrame]
  end

  local image = imagePath and Engine_AssetManager.image(imagePath)

  if image then
    local w = image:getWidth()
    local h = image:getHeight()

    return Engine_Types.Size:new(w * scaleX, h * scaleY)
  end

  return nil
end

-- TODO: Move this elsewhere

local renderers = {}

function Helper.registerRenderer(name, class)
  renderers[name] = class
end

function Helper.rendererNamed(name)
  return renderers[name]
end

return Helper
