# Font

An experiment in font scaling inspired media query like behaviour.

### Motivation

At one point or another, many developers with Love find out that font scaling
via the `sx` and `sy` parameters leave less than desirable effects. Unless
you're using a bitmap font with `nearest` filtering applied, your scaled text
often ends up being blurry.

The common answer is to just create different Font objects at different sizes.
This library seeks to see if it's any use to predefine a series of "breakpoints"
similar to responsive css to just define a consistent font scale throughout
your game.

## Usage

The entrypoint to `Font` is `Font.register` which will take the path to the
font, and a table containing the various sizes at different screen widths.

```lua
local Font = require "path.to.font"

local wakuwaku = nil

function love.load()
  wakuwaku = Font.register(
    "path/to/font/wakuwaku.otf",
    {sm = 16, md = 24, lg = 32, xl = 48, xxl = 72 }
    )

  -- Hook into the `love.resize` event (optional - read the API section)
  wakuwaku:hook()
end

function love.draw()
  love.graphics.print("Hello, World", wakuwaku:get())
end
```

If the screen width **is larger than** the configured with, then it will use
the font size configured. By default these sizes are

- `sm` is 640px
- `md` is 768px
- `lg` is 1024px
- `xl` is 1280px
- `xxl` is 1536px

(These are borrowed from the [Tailwind](https://tailwindcss.com/docs/screens)
configured media queries)

Therefore is the screen is 660px wide, then it shall use the `sm` configured
value. If it's 1100px, then the `lg` will be used, and so on.

## Configuration

These aren't overly helpful without some customisation of behaviour. You can
change the default screen size breakpoints via the `Font.configure` function.

```lua
Font.configure({
    sm  = 640,
    md  = 768,
    lg  = 1024,
    xl  = 1280,
    xxl = 1536
  })
```

You can also set them on the individual results of calling `new` by using
`reconfigure`

```lua
  local wakuwaku = Font.register(
    "path/to/font/wakuwaku.otf",
    {sm = 16, md = 24, lg = 32, xl = 48, xxl = 72 }
    )
  wakuwaku:reconfigure({
    sm  = 200,
    md  = 300,
    lg  = 400,
    xl  = 500,
    xxl = 600
  })
```

## API

### `Font.new(font: string, sizes: Table<string, number>): FontObj`

Takes a path to a `love` supported font, and a table from size to number that
will define the font sizes for each screen size, and returns a new `Font`
object.

### `Font.configure(screenSizes: Table<string, number>): nil`

Takes a table from screen size (`sm`, `md`, `lg`, `xl`, `xxl`) to number to use
as the default set of breakpoints to change the font size.

### `FontObj:get(): love.graphics.Font`

Returns a `love` Font Object for the current size. Note that the current size
won't change unless you've called `FontObj:resize(width)` or `FontObj:hook()`.

### `FontObj:resize(width: number): nil`

Sets the current size value for the given screen size. The current size value
is determined by the default value, or the value configured by `Font.configure`
or `FontObj:reconfigure`

### `FontObj:hook(): nil`

Hooks this FontObj to the `love.resize` event, calling `FontObj:resize`
internally whenever the screen is resized.

### `FontObj:reconfigure(screenSizes: Table<string, number>): nil`

Takes a table from screen size (`sm`, `md`, `lg`, `xl`, `xxl`) to number to use
as the this instance's set of breakpoints to change the font size.

## Contributing

Contributions welcome :) As this is an experiment, there's no doubt flaws or
improvements to be made
