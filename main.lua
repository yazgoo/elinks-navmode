nav_mode = false
nav_mode_urls = {}
navigated_urls = {}

function tablecontains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

add_pre_format_hook("nav_mode", function (url, html)
  if not tablecontains(navigated_urls, url) then
    table.insert(navigated_urls, url)
  end
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

bind_key ("main", "x", function ()   
  if nav_mode then
    xdialog("", function(num) 
      return "goto_url", nav_mode_urls[tonumber(num)]
    end)
  end
end)
bind_key ("main", "f", function ()
  nav_mode = not nav_mode
end)

suggestions = {}
bind_key ("main", "o", function ()
  if tablelength(suggestions)==0  then
    for _, v in pairs(navigated_urls) do
        table.insert(suggestions, v)
    end
  end
  xdialog("", function(suggestion) 
    local new_suggestions = {}
    os.execute("clear")
    for k, v in pairs(suggestions) do
      if string.find(v, suggestion) then
        io.write(v .. "\n")
        table.insert(new_suggestions, v)
      end
    end
    suggestions = new_suggestions
    if tablelength(suggestions) == 1 then
      os.execute("clear")
      local url = suggestions[1]
      io.write("going to " .. url)
      suggestions = {}
      return "goto_url", url
    else
      return "goto_url", current_url()
    end
  end)
end)
