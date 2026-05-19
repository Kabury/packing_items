local meldy = require("meld")
local kl = require("__klib__.klib")
local flib_locale  =  require("__flib__.locale")
local fun = require("functions")
local nblacklist = require("blacklist")
local egfx = require("graphics")

local tier = settings.startup["pi-packing-tier"].value
local hider = settings.startup["pi-packing-hide"].value
local twhitelist = {"ammo", "capsule", "gun", "module", "rail-planner", "tool", "armor", "repair-tool", "item"}
local fluidsize = 50
local i=0
local techlock={tier1={},tier2={},tier3={}}
local pack1,pack2,pack3,packercan
local packeditems={}

local protos={
  {type="item-group",name="packing-items",order="z",icons={{icon = "__base__/graphics/icons/wooden-chest.png",icon_size = 64}}},
  {type="item-subgroup",name="packers",group="production",order="f"},
  {type="item-subgroup",name="wooden-pack",group="packing-items",order="a"},
  {type="recipe-category",name="wooden-pack"},
}
table.insert(protos,
{
    type = "item",
    name = "packer-1",
    icons = {{icon = "__packing_items__/graphics/item/packer-1.png",icon_size = 64}},
    stack_size = 10,
    place_result = "packer-1"
})
table.insert(protos,
{
    type = "item",
    name = "packer-can",
    icons = {{icon = "__packing_items__/graphics/entity/packer-can.png",icon_size = 96}},
    stack_size = 10,
    place_result = "packer-can"
})
pack1=kl.qrecipe("packer-1",{"iron-plate",10,"iron-gear-wheel",5,"copper-plate",10,"electronic-circuit",5},nil,{ret=true})
pack1.subgroup="packers"
table.insert(protos,pack1)
table.insert(techlock.tier1,"packer-1")
packercan=kl.qrecipe("packer-can",{"iron-plate",10,"stone-brick",5,"steel-plate",10},nil,{ret=true})
packercan.subgroup="storage"
packercan.order="z"
table.insert(protos,packercan)

if tier==1 then goto main_loop end

table.insert(protos,{type="item-subgroup",name="iron-pack",group="packing-items",order="b"})
table.insert(protos,{type="recipe-category",name="iron-pack"})
table.insert(protos,
{
    type = "item",
    name = "packer-2",
    icons = {{icon = "__packing_items__/graphics/item/packer-2.png",icon_size = 64}},
    stack_size = 10,
    place_result = "packer-2"
})
pack2=kl.qrecipe("packer-2",{"iron-plate",10,"iron-gear-wheel",5,"copper-plate",10,"advanced-circuit",5,"packer-1",1},nil,{ret=true})
pack2.subgroup="packers"
table.insert(protos,pack2)
table.insert(techlock.tier2,"packer-2")

if tier==2 then goto main_loop end

table.insert(protos,{type="item-subgroup",name="steel-pack",group="packing-items",order="c"})
table.insert(protos,{type="recipe-category",name="steel-pack"})
table.insert(protos,
{
    type = "item",
    name = "packer-3",
    icons = {{icon = "__packing_items__/graphics/item/packer-3.png",icon_size = 64}},
    stack_size = 10,
    place_result = "packer-3"
})
pack3=kl.qrecipe("packer-3",{"iron-plate",10,"iron-gear-wheel",5,"copper-plate",10,"processing-unit",5,"packer-2",1},nil,{ret=true})
pack3.subgroup="packers"
table.insert(protos,pack3)
table.insert(techlock.tier3,"packer-3")

::main_loop::



for _, type in pairs(twhitelist) do
  for name, item in pairs(data.raw[type]) do
    if nblacklist[name] then goto next_item end
    if item.parameter then goto next_item end

    table.insert(protos,
    {
        type = "item",
        name = "wood-packed-"..name,
        icons = fun.pack_icon(item,1),
        localised_name = {"item-name.wood-packed-generic", flib_locale.of_item(item)},
        stack_size = 5
    })
    packeditems["wood-packed-"..name]=500
    local woodpack=kl.qrecipe("wood-packed-"..name,{name,math.ceil(item.stack_size/2)},nil,{ret=true,ico=fun.pack_icon(item,1,"pack"),cat="wooden-pack",en=1})
    woodpack.localised_name = {"recipe-name.wood-pack-generic", flib_locale.of_item(item)}
    woodpack.subgroup="wooden-pack"
    if hider then woodpack.hide_from_player_crafting=true end
    table.insert(protos, woodpack)
    local woodunpack=kl.qrecipe("wood-unpacked-"..name,{"wood-packed-"..name,1},{name,math.ceil(item.stack_size/2)},{rt="name-and-amount",ret=true,ico=fun.pack_icon(item,1,"unpack"),cat="wooden-pack",en=1})
    woodunpack.localised_name = {"recipe-name.wood-unpack-generic", flib_locale.of_item(item)}
    woodunpack.subgroup="wooden-pack"
    if hider then woodunpack.hide_from_player_crafting=true end
    table.insert(protos, woodunpack)
    table.insert(techlock.tier1,"wood-packed-"..name)
    table.insert(techlock.tier1,"wood-unpacked-"..name)
    i=i+1

    if tier==1 then goto next_item end

    table.insert(protos,
    {
        type = "item",
        name = "iron-packed-"..name,
        icons = fun.pack_icon(item,2),
        localised_name = {"item-name.iron-packed-generic", flib_locale.of_item(item)},
        stack_size = 5
    })
    packeditems["iron-packed-"..name]=500
    local ironpack=kl.qrecipe("iron-packed-"..name,{"wood-packed-"..name,5},nil,{ret=true,ico=fun.pack_icon(item,2,"pack"),cat="iron-pack",en=1})
    ironpack.localised_name = {"recipe-name.iron-pack-generic", flib_locale.of_item(item)}
    ironpack.subgroup="iron-pack"
    if hider then ironpack.hide_from_player_crafting=true end
    table.insert(protos, ironpack)
    local ironunpack=kl.qrecipe("iron-unpacked-"..name,{"iron-packed-"..name,1},{"wood-packed-"..name,5},{rt="name-and-amount",ret=true,ico=fun.pack_icon(item,2,"unpack"),cat="iron-pack",en=1})
    ironunpack.localised_name = {"recipe-name.iron-unpack-generic", flib_locale.of_item(item)}
    ironunpack.subgroup="iron-pack"
    if hider then ironunpack.hide_from_player_crafting=true end
    table.insert(protos, ironunpack)
    table.insert(techlock.tier2,"iron-packed-"..name)
    table.insert(techlock.tier2,"iron-unpacked-"..name)

    if tier==2 then goto next_item end

    table.insert(protos,
    {
        type = "item",
        name = "steel-packed-"..name,
        icons = fun.pack_icon(item,3),
        localised_name = {"item-name.steel-packed-generic", flib_locale.of_item(item)},
        stack_size = 5
    })
    packeditems["steel-packed-"..name]=500
    local steelpack=kl.qrecipe("steel-packed-"..name,{"iron-packed-"..name,4},nil,{ret=true,ico=fun.pack_icon(item,3,"pack"),cat="steel-pack",en=1})
    steelpack.localised_name = {"recipe-name.steel-pack-generic", flib_locale.of_item(item)}
    steelpack.subgroup="steel-pack"
    if hider then steelpack.hide_from_player_crafting=true end
    table.insert(protos, steelpack)
    local steelunpack=kl.qrecipe("steel-unpacked-"..name,{"steel-packed-"..name,1},{"iron-packed-"..name,4},{rt="name-and-amount",ret=true,ico=fun.pack_icon(item,3,"unpack"),cat="steel-pack",en=1})
    steelunpack.localised_name = {"recipe-name.steel-unpack-generic", flib_locale.of_item(item)}
    steelunpack.subgroup="steel-pack"
    if hider then steelunpack.hide_from_player_crafting=true end
    table.insert(protos, steelunpack)
    table.insert(techlock.tier3,"steel-packed-"..name)
    table.insert(techlock.tier3,"steel-unpacked-"..name)

    ::next_item::
  end
end



for name, item in pairs(data.raw["fluid"]) do
  if nblacklist[name] then goto next_fluid end
  if item.parameter then goto next_fluid end

  table.insert(protos,
  {
      type = "fluid",
      name = "wood-packed-"..name,
      icons = fun.pack_icon(item,1),
      localised_name = {"item-name.wood-packed-generic", {"fluid-name."..name}},
      base_color=item.base_color,
      default_temperature=item.default_temperature,
      flow_color=item.flow_color

  })
  local woodpack=kl.qrecipe("wood-packed-"..name,{"f",name,math.ceil(fluidsize/2)},{"f","wood-packed-"..name,1},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,1,"pack"),cat="wooden-pack",en=0.1})
  woodpack.localised_name = {"recipe-name.wood-pack-generic", {"fluid-name."..name}}
  woodpack.subgroup="wooden-pack"
  woodpack.hide_from_player_crafting=true
  table.insert(protos, woodpack)
  local woodunpack=kl.qrecipe("wood-unpacked-"..name,{"f","wood-packed-"..name,1},{"f",name,math.ceil(fluidsize/2)},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,1,"unpack"),cat="wooden-pack",en=0.1})
  woodunpack.localised_name = {"recipe-name.wood-unpack-generic", {"fluid-name."..name}}
  woodunpack.subgroup="wooden-pack"
  woodunpack.hide_from_player_crafting=true
  table.insert(protos, woodunpack)
  table.insert(techlock.tier1,"wood-packed-"..name)
  table.insert(techlock.tier1,"wood-unpacked-"..name)
  i=i+1

  if tier==1 then goto next_fluid end

  table.insert(protos,
  {
      type = "fluid",
      name = "iron-packed-"..name,
      icons = fun.pack_icon(item,2),
      localised_name = {"item-name.iron-packed-generic", {"fluid-name."..name}},
      base_color=item.base_color,
      default_temperature=item.default_temperature,
      flow_color=item.flow_color
  })
  local ironpack=kl.qrecipe("iron-packed-"..name,{"f","wood-packed-"..name,5},{"f","iron-packed-"..name,1},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,2,"pack"),cat="iron-pack",en=0.1})
  ironpack.localised_name = {"recipe-name.iron-pack-generic", {"fluid-name."..name}}
  ironpack.subgroup="iron-pack"
  ironpack.hide_from_player_crafting=true
  table.insert(protos, ironpack)
  local ironunpack=kl.qrecipe("iron-unpacked-"..name,{"f","iron-packed-"..name,1},{"f","wood-packed-"..name,5},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,2,"unpack"),cat="iron-pack",en=0.1})
  ironunpack.localised_name = {"recipe-name.iron-unpack-generic", {"fluid-name."..name}}
  ironunpack.subgroup="iron-pack"
  ironunpack.hide_from_player_crafting=true
  table.insert(protos, ironunpack)
  table.insert(techlock.tier2,"iron-packed-"..name)
  table.insert(techlock.tier2,"iron-unpacked-"..name)

  if tier==2 then goto next_fluid end

  table.insert(protos,
  {
      type = "fluid",
      name = "steel-packed-"..name,
      icons = fun.pack_icon(item,3),
      localised_name = {"item-name.steel-packed-generic", {"fluid-name."..name}},
      base_color=item.base_color,
      default_temperature=item.default_temperature,
      flow_color=item.flow_color
  })
  local steelpack=kl.qrecipe("steel-packed-"..name,{"f","iron-packed-"..name,4},{"f","steel-packed-"..name,1},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,3,"pack"),cat="steel-pack",en=0.1})
  steelpack.localised_name = {"recipe-name.steel-pack-generic", {"fluid-name."..name}}
  steelpack.subgroup="steel-pack"
  steelpack.hide_from_player_crafting=true
  table.insert(protos, steelpack)
  local steelunpack=kl.qrecipe("steel-unpacked-"..name,{"f","steel-packed-"..name,1},{"f","iron-packed-"..name,4},{it="type-name-amounts",rt="type-name-amounts",ret=true,ico=fun.pack_icon(item,3,"unpack"),cat="steel-pack",en=0.1})
  steelunpack.localised_name = {"recipe-name.steel-unpack-generic", {"fluid-name."..name}}
  steelunpack.subgroup="steel-pack"
  steelunpack.hide_from_player_crafting=true
  table.insert(protos, steelunpack)
  table.insert(techlock.tier3,"steel-packed-"..name)
  table.insert(techlock.tier3,"steel-unpacked-"..name)

  ::next_fluid::
end



kl.qtech("packing-items-1",150,1,{pi={"__packing_items__/graphics/technology/packing.png",256},pre={"logistics"},eff=techlock.tier1})
kl.qmeld("furnace","electric-furnace",{name="packer-1",crafting_speed=1,module_slots=0,minable={result="packer-1"},crafting_categories=meldy.overwrite({"wooden-pack"})})
data.raw["furnace"]["packer-1"].graphics_set=egfx.t1_graphics_set
data.raw["furnace"]["packer-1"].fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 100,
    pipe_connections = {{ flow_direction="input", direction = defines.direction.west, position = {-1, 1} }}
  },
  {
    production_type = "output",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    volume = 100,
    pipe_connections = {{ flow_direction="output", direction = defines.direction.north, position = {1, -1} }}
  }
}

kl.qtech("packer-can",150,1,{pi={"__packing_items__/graphics/entity/packer-can.png",96},pre={"packing-items-1"},eff={"packer-can"}})
kl.qmeld("container","steel-chest",{name="packer-can",minable={result="packer-can"},inventory_size=10,inventory_type="with_custom_stack_size",inventory_properties={stack_size_override=packeditems,with_bar=true},picture=meldy.overwrite({layers={{filename="__packing_items__/graphics/entity/packer-can.png",height=96,width=96,priority="extra-high",scale=0.55,shift={0,0}}}})})

if tier==1 then goto final end

kl.qtech("packing-items-2",300,2,{pi={"__packing_items__/graphics/technology/packing.png",256},pre={"packing-items-1","logistics-2"},eff=techlock.tier2})

if mods["pypostprocessing"] then kl.qtech("packing-items-2",300,kl.pyamounts[4],{pi={"__packing_items__/graphics/technology/packing.png",256},pre={"packing-items-1","logistics-2"},eff=techlock.tier2,order=kl.pyorder}) end

kl.qmeld("furnace","electric-furnace",{name="packer-2",crafting_speed=1,module_slots=0,minable={result="packer-2"},crafting_categories=meldy.overwrite({"iron-pack"})})
data.raw["furnace"]["packer-2"].graphics_set=egfx.t2_graphics_set
data.raw["furnace"]["packer-2"].fluid_boxes = table.deepcopy(data.raw["furnace"]["packer-1"].fluid_boxes)

if tier==2 then goto final end

kl.qtech("packing-items-3",450,3,{pi={"__packing_items__/graphics/technology/packing.png",256},pre={"packing-items-2","logistics-3"},eff=techlock.tier3})

if mods["pypostprocessing"] then kl.qtech("packing-items-3",450,kl.pyamounts[7],{pi={"__packing_items__/graphics/technology/packing.png",256},pre={"packing-items-2","logistics-3"},eff=techlock.tier3,order=kl.pyorder}) end

kl.qmeld("furnace","electric-furnace",{name="packer-3",crafting_speed=1,module_slots=0,minable={result="packer-3"},crafting_categories=meldy.overwrite({"steel-pack"})})
data.raw["furnace"]["packer-3"].graphics_set=egfx.t3_graphics_set
data.raw["furnace"]["packer-3"].fluid_boxes = table.deepcopy(data.raw["furnace"]["packer-1"].fluid_boxes)


::final::

log("The # of processed protos was: " .. serpent.line(i))
data:extend(protos)