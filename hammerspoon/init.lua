hs.hotkey.bind({"command"}, "return", function()
  local alacritty = hs.application.find('alacritty')
  if alacritty:isFrontmost() then
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
  end
end)


local lastMousePositions = {}

-- local function focus_other_screen() -- focuses the other screen 
--   local screen = hs.mouse.getCurrentScreen()
--   local nextScreen = screen:next()
--   local rect = nextScreen:fullFrame()
--   local center = hs.geometry.rectMidPoint(rect)
--   hs.mouse.absolutePosition(center)
-- end 

local function focus_primary_screen()
  local newScreen = hs.screen.primaryScreen()
  local rect = newScreen:fullFrame()
  local newMousePos = lastMousePositions[newScreen:id()] or hs.geometry.rectMidPoint(rect)
  hs.mouse.absolutePosition(newMousePos)
end 

local function focus_second_screen()
  local primaryScreen = hs.screen.primaryScreen()
  local newScreen = primaryScreen:next()
  local rect = newScreen:fullFrame()
  local newMousePos = lastMousePositions[newScreen:id()] or hs.geometry.rectMidPoint(rect)
  hs.mouse.absolutePosition(newMousePos)
end 

local function focus_third_screen()
  local primaryScreen = hs.screen.primaryScreen()
  local newScreen = primaryScreen:next():next()
  local rect = newScreen:fullFrame()
  local newMousePos = lastMousePositions[newScreen:id()] or hs.geometry.rectMidPoint(rect)
  hs.mouse.absolutePosition(newMousePos)
end 

function get_window_under_mouse() -- from https://gist.github.com/kizzx2/e542fa74b80b7563045a 
  local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
  local my_screen = hs.mouse.getCurrentScreen()
  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return my_screen == w:screen() and my_pos:inside(w:frame())
  end)
end

function store_display_mouse_position()
  local currentScreen = hs.mouse.getCurrentScreen()
  lastMousePositions[currentScreen:id()] = hs.geometry.new(hs.mouse.getAbsolutePosition())
end

function activate_primary_screen()
   store_display_mouse_position()
   focus_primary_screen() 
   local win = get_window_under_mouse() 
   -- now activate that window 
   win:focus() 
end 

function activate_second_screen()
   store_display_mouse_position()
   focus_second_screen() 
   local win = get_window_under_mouse() 
   -- now activate that window 
   win:focus() 
end 

function activate_third_screen()
   store_display_mouse_position()
   focus_third_screen() 
   local win = get_window_under_mouse() 
   -- now activate that window 
   win:focus() 
end 

hs.hotkey.bind({"cmd", "shift", "alt"}, "1", function() -- does the keybinding
      activate_primary_screen()
end)

hs.hotkey.bind({"cmd", "shift", "alt"}, "2", function() -- does the keybinding
      activate_second_screen()
end)

hs.hotkey.bind({"cmd", "shift", "alt"}, "3", function() -- does the keybinding
      activate_third_screen()
end)
