local module = {}

local rf_path = "__packing_items__/graphics/entity"
local base_path = "__base__/graphics/entity/electric-furnace"

module.t1_graphics_set = {
    animation = {
    layers =
    {
        {
            filename = rf_path.."/packer-1.png",
            priority = "high",
            width = 239,
            height = 219,
            --frame_count = 1,
            shift = util.by_pixel(0.75, 5.75),
            scale = 0.5
        },
        {
            filename = base_path.."/electric-furnace-shadow.png",
            priority = "high",
            width = 227,
            height = 171,
            frame_count = 1,
            draw_as_shadow = true,
            shift = util.by_pixel(11.25, 7.75),
            scale = 0.5
        }
    }
    },
    working_visualisations = {
    {
        fadeout = true,
        animation = {
        layers = {
            {
                filename = rf_path.."/packer-heater.png",
                priority = "high",
                width = 60,
                height = 56,
                frame_count = 12,
                animation_speed = 1,
                draw_as_glow = true,
                shift = util.by_pixel(1.75, 32.75),
                scale = 0.5
            },
            {
                filename = base_path.."/electric-furnace-light.png",
                blend_mode = "additive",
                width = 202,
                height = 202,
                repeat_count = 12,
                draw_as_glow = true,
                shift = util.by_pixel(1, 0),
                scale = 0.5,
            },
        }
        },
    },
    {
        fadeout = true,
        animation = {
            filename = base_path.."/electric-furnace-ground-light.png",
            blend_mode = "additive",
            width = 166,
            height = 124,
            draw_as_light = true,
            shift = util.by_pixel(3, 69),
            scale = 0.5,
        },
    },
    {
        animation = {
            filename = rf_path.."/packer-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
        }
    },
    {
        animation = {
            filename = rf_path.."/packer-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
        }
    }
    },
    water_reflection = {
        pictures = {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 24,
        shift = util.by_pixel(5, 40),
        variation_count = 1,
        scale = 5
        },
        rotate = false,
        orientation_to_variation = false
    }
}


module.t2_graphics_set  = {
    animation = {
        layers =
        {
        {
            filename = rf_path.."/packer-2.png",
            priority = "high",
            width = 239,
            height = 219,
            frame_count = 1,
            repeat_count = 32,
            shift = util.by_pixel(0.75, 5.75),
            scale = 0.5
        },
        {
            filename = base_path.."/electric-furnace-shadow.png",
            priority = "high",
            width = 227,
            height = 171,
            frame_count = 1,
            repeat_count = 32,
            draw_as_shadow = true,
            shift = util.by_pixel(11.25, 7.75),
            scale = 0.5
        },
        {
            filename = rf_path.."/packer-turbine.png",
            priority = "high",
            width = 116,
            height = 78,
            frame_count = 32,
            repeat_count = 1,
            line_length = 8,
            animation_speed = 0.5,
            shift = util.by_pixel(15.25, -13.5),
            scale = 0.33
        }
        }
    },
    working_visualisations = {
        {
        fadeout = true,
        animation = {
            layers = {
            {
                filename = rf_path.."/packer-heater.png",
                priority = "high",
                width = 60,
                height = 56,
                frame_count = 12,
                animation_speed = 1,
                draw_as_glow = true,
                shift = util.by_pixel(1.75, 32.75),
                scale = 0.5
            },
            {
                filename = base_path.."/electric-furnace-light.png",
                blend_mode = "additive",
                width = 202,
                height = 202,
                repeat_count = 12,
                draw_as_glow = true,
                shift = util.by_pixel(1, 0),
                scale = 0.5,
            },
            }
        },
        },
        {
        fadeout = true,
        animation = {
            filename = base_path.."/electric-furnace-ground-light.png",
            blend_mode = "additive",
            width = 166,
            height = 124,
            draw_as_light = true,
            shift = util.by_pixel(3, 69),
            scale = 0.5,
        },
        },
        {
        animation = {
            filename = rf_path.."/packer-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
        }
        },
        {
        animation = {
            filename = rf_path.."/packer-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
        }
        },
        {
        animation = {
            filename = rf_path.."/packer-turbine.png",
            priority = "high",
            width = 116,
            height = 78,
            frame_count = 32,
            repeat_count = 1,
            line_length = 8,
            animation_speed = 0.45,
            shift = util.by_pixel(15.25, -13.5),
            scale = 0.33
        }
        },
    },
    water_reflection = {
        pictures = {
            filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            shift = util.by_pixel(5, 40),
            variation_count = 1,
            scale = 5
        },
        rotate = false,
        orientation_to_variation = false
    }
}


module.t3_graphics_set  = {
    animation = {
        layers =
        {
        {
            filename = rf_path.."/packer-3.png",
            priority = "high",
            width = 239,
            height = 219,
            frame_count = 1,
            repeat_count = 32,
            shift = util.by_pixel(0.75, 5.75),
            scale = 0.5
        },
        {
            filename = base_path.."/electric-furnace-shadow.png",
            priority = "high",
            width = 227,
            height = 171,
            frame_count = 1,
            repeat_count = 32,
            draw_as_shadow = true,
            shift = util.by_pixel(11.25, 7.75),
            scale = 0.5
        },
        {
            filename = rf_path.."/packer-turbine.png",
            priority = "high",
            width = 116,
            height = 78,
            frame_count = 32,
            repeat_count = 1,
            line_length = 8,
            animation_speed = 0.5,
            shift = util.by_pixel(15.25, -13.5),
            scale = 0.33
        }
        }
    },
    working_visualisations = {
        {
        fadeout = true,
        animation = {
            layers = {
            {
                filename = rf_path.."/packer-heater.png",
                priority = "high",
                width = 60,
                height = 56,
                frame_count = 12,
                animation_speed = 1,
                draw_as_glow = true,
                shift = util.by_pixel(1.75, 32.75),
                scale = 0.5
            },
            {
                filename = base_path.."/electric-furnace-light.png",
                blend_mode = "additive",
                width = 202,
                height = 202,
                repeat_count = 12,
                draw_as_glow = true,
                shift = util.by_pixel(1, 0),
                scale = 0.5,
            },
            }
        },
        },
        {
        fadeout = true,
        animation = {
            filename = base_path.."/electric-furnace-ground-light.png",
            blend_mode = "additive",
            width = 166,
            height = 124,
            draw_as_light = true,
            shift = util.by_pixel(3, 69),
            scale = 0.5,
        },
        },
        {
        animation = {
            filename = rf_path.."/packer-propeller-1.png",
            priority = "high",
            width = 37,
            height = 25,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(-20.5, -18.5),
            scale = 0.5
        }
        },
        {
        animation = {
            filename = rf_path.."/packer-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 1,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
        }
        },
        {
        animation = {
            filename = rf_path.."/packer-turbine.png",
            priority = "high",
            width = 116,
            height = 78,
            frame_count = 32,
            repeat_count = 1,
            line_length = 8,
            animation_speed = 0.45,
            shift = util.by_pixel(15.25, -13.5),
            scale = 0.33
        }
        },
    },
    water_reflection = {
        pictures = {
            filename = "__base__/graphics/entity/electric-furnace/electric-furnace-reflection.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            shift = util.by_pixel(5, 40),
            variation_count = 1,
            scale = 5
        },
        rotate = false,
        orientation_to_variation = false
    }
}

return module