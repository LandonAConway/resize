resize_mod = {}

minetest.register_privilege("set_size", {
        description = "Allows player to set their own size.",
})

minetest.register_chatcommand("restore_size", {
        params = "",
        description = "Restores players size",
        privs = {set_size=true},
        func = function(name)
          local player = minetest.get_player_by_name(name)
          resize_mod.restore(player)
          return true, "Size set to normal."
        end
})

minetest.register_chatcommand("set_size", {
        params = "<size>",
        description = "Set players size",
        privs = {set_size=true},
        func = function(name, text)
          if tonumber(text) then
            local player = minetest.get_player_by_name(name)
            resize_mod.set_size(player, tonumber(text))
            return true, "Size set to '"..text.."'."
          end
          return false, "'"..text.."' is not a valid number."
        end
})

function resize_mod.restore(player)
  local properties = player:get_properties()
--  minetest.log("collisionbox = {"..table.concat(properties["collisionbox"], ", ").."},"..
--  "selectionbox = {"..table.concat(properties["selectionbox"], ", ").."},"..
--  "visual_size = {x="..properties["visual_size"].x..",y="..properties["visual_size"].y..",z="..properties["visual_size"].z.."},"..
--  "eye_height = "..properties["eye_height"]
--  )
  local prop = {
    visual_size = {x=1,y=1,z=1},
    eye_height = 1.4700000286102,
    collisionbox = {-0.30000001192093, 0, -0.30000001192093, 0.30000001192093, 1.7000000476837, 0.30000001192093},
    selectionbox = {-0.30000001192093, 0, -0.30000001192093, 0.30000001192093, 1.7000000476837, 0.30000001192093},
  }
  player:set_properties(prop)
  player:set_physics_override({jump=1})
end

function resize_mod.set_size(player, size)
  local eye_height = 1.4700000286102*size
  local prop = {
    visual_size = {x = size, y = size, z = size},
    eye_height = eye_height,
    collisionbox = {-0.30000001192093*size, 0*size, -0.30000001192093*size, 0.30000001192093*size, 1.7000000476837*size, 0.30000001192093*size},
    selectionbox = {-0.30000001192093*size, 0*size, -0.30000001192093*size, 0.30000001192093*size, 1.7000000476837*size, 0.30000001192093*size},
  }
  player:set_properties(prop)
  player:set_physics_override({jump=size})
end