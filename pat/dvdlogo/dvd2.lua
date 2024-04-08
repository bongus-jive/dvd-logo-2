local speed = 1
local moving_down = math.random() > 0.5
local moving_left = math.random() > 0.5

function init()
  if not window then
    sb.logWarn("'dvd logo 2' requires StarExtensions - https://github.com/StarExtensions/StarExtensions/releases")
    script.setUpdateDelta(0)
    update = nil
    return
  end

  local screenSize = window.screenSize()
  local windowSize = window.size()
  window.setSize({
    math.min(math.floor(screenSize[1] * 0.67), windowSize[1]),
    math.min(math.floor(screenSize[2] * 0.67), windowSize[2])
  })
end

local function flash()
  window.flash("briefly")
end

function update()
  if window.grabbed() then return end
  
  local screenSize = window.screenSize()
  local windowSize = window.size()
  local max_X = math.max(0, screenSize[1] - windowSize[1])
  local max_Y = math.max(0, screenSize[2] - windowSize[2])

  local pos = window.position()
  pos[1] = pos[1] + (moving_left and -speed or speed)
  pos[2] = pos[2] + (moving_down and -speed or speed)

  if pos[1] <= 0 then
    pos[1] = 0
    moving_left = false
    flash()
  elseif pos[1] >= max_X then
    pos[1] = max_X
    moving_left = true
    flash()
  end

  if pos[2] <= 0 then
    pos[2] = 0
    moving_down = false
    flash()
  elseif pos[2] >= max_Y then
    pos[2] = max_Y
    moving_down = true
    flash()
  end

  window.setPosition(pos)
end
