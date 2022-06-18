local Font = require "font"

local wakuwaku = nil

function love.load()
  wakuwaku = Font.new(
    "assets/wakuwaku.otf",
    { sm = 16, md = 24, lg = 32, xl = 48, xxl = 72 }
  )
  wakuwaku:hook()
end

function love.draw()
  love.graphics.print("Hello, World", wakuwaku:get())
end
