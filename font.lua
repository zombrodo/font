local Font = {
  __order = { "sm", "md", "lg", "xl", "xxl" },
  __screenSizes = {
    sm  = 640,
    md  = 768,
    lg  = 1024,
    xl  = 1280,
    xxl = 1536
  },
}
Font.__index = Font

function Font.configure(screenSizes)
  Font.__screenSizes = screenSizes
end

function Font.new(font, sizes)
  local self = setmetatable({}, Font)
  self.screenSizes = Font.__screenSizes
  self.fontSizes = sizes
  for screenSize, fontSize in pairs(sizes) do
    self.fontSizes[screenSize] = love.graphics.newFont(font, fontSize)
  end
  self.currentSize = "sm"
  return self
end

function Font:get()
  return self.fontSizes[self.currentSize]
end

function Font:reconfigure(screenSizes)
  self.screenSizes = screenSizes
end

function Font:resize(width)
  for _, size in ipairs(Font.__order) do
    if width > self.screenSizes[size] then
      self.currentSize = size
    end
  end
end

function Font:hook()
  local oldCallback = love.resize
  love.resize = function(width, height)
    if (oldCallback) then
      oldCallback(width, height)
    end
    self:resize(width)
  end
end

return Font
