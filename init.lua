local switcher = hs.menubar.new()

function setLocation()
  local workScreen = "DELL U2713HM"
  local homeScreen = "VX279"
  local laptopScreen = "Color LCD"
  local homeLayout = {
    {"Google Chrome", nil, homeScreen,   hs.layout.right70,   nil, nil},
    {"iTerm",         nil, homeScreen,   hs.layout.left50,    nil, nil},
    {"Atom",          nil, laptopScreen, hs.layout.maximized, nil, nil},
  }
  local workLayout = {
    {"Google Chrome", nil, workScreen,   hs.layout.right70,   nil, nil},
    {"iTerm",         nil, workScreen,   hs.layout.left50,    nil, nil},
    {"Atom",          nil, laptopScreen, hs.layout.maximized, nil, nil},
  }
  local laptopLayout = {
    {"Google Chrome", nil, laptopScreen, hs.layout.maximized, nil, nil},
    {"iTerm",         nil, laptopScreen, hs.layout.maximized, nil, nil},
    {"Atom",          nil, laptopScreen, hs.layout.maximized, nil, nil},
  }

  if switcher:title() == "Laptop" then
    hs.layout.apply(laptopLayout)
    switcher:setTitle("Home")
  elseif switcher:title() == "Home" then
    hs.layout.apply(homeLayout)
    switcher:setTitle("Work")
  else
    hs.layout.apply(workLayout)
    switcher:setTitle("Laptop")
  end
end

hs.hotkey.bind({"shift", "ctrl"}, "`", function()
  setLocation()
end)

hs.hotkey.bind({"shift", "ctrl"}, "1", function()
  hs.alert.show(tostring(hs.window.focusedWindow()))
end)

hs.hotkey.bind({"shift", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

if switcher then
  switcher:setClickCallback(setLocation)
  setLocation()
end

function takeScreenshot(window)
  window:snapshot():saveToFile(os.getenv("HOME") .. "/Desktop/chrome-images/" .. os.time() .. ".png")
end

local wf=hs.window.filter
wf_chrome = wf.new{'Google Chrome'}
wf_chrome:subscribe(wf.windowFocused,takeScreenshot)

function inkscapeFixer(appName, eventType, appObject)
  if ((eventType == hs.application.watcher.launched) and (appName == 'Inkscape')) then
    hs.alert.show(appName)
    hs.layout.apply({{appObject, nil, hs.screen.mainScreen(), hs.layout.maximized, nil, nil}})
  end
end

local appWatcher = hs.application.watcher.new(inkscapeFixer)
appWatcher:start()
