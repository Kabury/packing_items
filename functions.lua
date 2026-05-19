local module = {}
function module.pack_icon(item,tier,type)

  local icons = {}
  local topleft = {-8,-8}
  local bottomright = {8,8}
  local topright = {8,-8}

  local arrowshift = topright
  local itemshift = {0,0}
  local boxshift = topleft
  local itemscale = 0.5

  if type ~= nil then
    if type == "pack" then
      itemshift = topleft
      boxshift = bottomright
      itemscale = 0.25
    end
    if type == "unpack" then
      itemshift = bottomright
      boxshift = topleft
      itemscale = 0.25
    end
  end

  if item.icon and item.icon_size then
    table.insert(icons,
    {
      icon = item.icon,
      icon_size = item.icon_size
    }
    )
  elseif item.icon then
    table.insert(icons,
    {
      icon = item.icon,
      icon_size = 64
    }
    )
  elseif item.icons then
    icons = table.deepcopy(item.icons)
  end

  for _,ico in pairs(icons) do
    ico.shift = itemshift
    ico.scale = itemscale
  end

  if tier == 1 then
    table.insert(icons,
      {
        icon = "__base__/graphics/icons/wooden-chest.png",
        icon_size = 64,
        scale = 0.25,
        shift = boxshift
      }
  )
  elseif tier == 2 then
    table.insert(icons,
      {
        icon = "__base__/graphics/icons/iron-chest.png",
        icon_size = 64,
        scale = 0.25,
        shift = boxshift
      }
  )
  elseif tier == 3 then
    table.insert(icons,
      {
        icon = "__base__/graphics/icons/steel-chest.png",
        icon_size = 64,
        scale = 0.25,
        shift = boxshift
      }
    )
  end

  if type ~= nil then
    if type == "pack" then
      table.insert(icons,
        {
          icon = "__packing_items__/graphics/icons/pack.png",
          icon_size = 64,
          scale = 0.33,
          shift = arrowshift
        })
    elseif type == "unpack" then
      table.insert(icons,
        {
          icon = "__packing_items__/graphics/icons/unpack.png",
          icon_size = 64,
          scale = 0.33,
          shift = arrowshift
        })
    end
  end
  return icons
end

return module
