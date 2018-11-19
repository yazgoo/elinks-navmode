nav_mode = true

add_pre_format_hook("nav_mode", function (url, html)
  local n
  if not nav_mode then return nil,nil end
  html, n = gisub (html, '<a', '<b>2</b><a')
  return ((n > 0) and html), nil
end)

bind_key ("main", "f", function ()   nav_mode = not nav_mode end)

