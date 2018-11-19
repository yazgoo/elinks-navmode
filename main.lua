nav_mode = false
nav_mode_urls = {}

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

add_pre_format_hook("nav_mode", function (url, html)
  local n
  if not nav_mode then return nil,nil end
  local i = 0
  nav_mode_urls = {}
  html, n = string.gsub (html, '<a[^>]* href="[^"]*"', function(s) 
    i = i + 1
    local res = '<b>'.. i ..'</b>'.. s
    local href = string.gsub(s, '<a[^>]* href="([^"]*)"', "%1")
    if string.find(href, "^/") then
      href = current_url() .. href
    end
    table.insert(nav_mode_urls, href)
    return res
  end)
  return ((n > 0) and html), nil
end)

bind_key ("main", "g", function ()   
  if nav_mode then
    xdialog("", function(num) 
      return "goto_url", nav_mode_urls[tonumber(num)]
    end)
  end
end)
bind_key ("main", "f", function ()
  nav_mode = not nav_mode
end)
