-- Copyright (C) James Marlowe (jamesmarlowe), Lumate LLC.


local cjson = require "cjson"
local url_parameters = "?format=json&auth_token="
local hipchat_proxy_url = "/hipchat/v1/"
local room_message_url = "/v1/rooms/message"..url_parameters


local ok, new_tab = pcall(require, "table.new")
if not ok then
    new_tab = function (narr, nrec) return {} end
end


local _M = new_tab(0, 155)
_M._VERSION = '0.01'


local valid_message_format_values = {
    html = "html", text = "text"
}


local valid_notify_values = {
    [0] = 0, [1] = 1
}


local valid_color_values = {
    yellow = "yellow", red = "red", green = "green", purple = "purple", gray = "gray"
}


local mt = { __index = _M }


function _M.new(self, auth_token )
    local auth_token  = auth_token 
    if not auth_token  then
        return nil, "must provide auth_token "
    end
    return setmetatable({ auth_token  = auth_token  }, mt)
end


function _M.set_room(self, room_id)
    local auth_token = self.auth_token
    if not auth_token then
        return nil, "not initialized"
    end
    
    self.room_id = room_id
    
    return self.room_id
end


function _M.room_message(self, room_id, from, message, message_format, notify, color)
    local auth_token = self.auth_token
    if not auth_token then
        return nil, "not initialized"
    end
    
    local room_id = room_id or self.room_id
    
    if not room_id then
        return nil, "no room specified"
    end
    
    local from = from
                 or "lua-resty-hipchat"
    
    local message = message
                    or ""
    
    local message_format = message_format and 
                           valid_message_format_values[message_format]
                           or "text"
    
    local notify = notify and 
                   valid_notify_values[notify]
                   or "0"
    
    local color = color and 
                  valid_color_values[color]
                  or "yellow"
    
    local message_specification = "room_id="..room_id.."&"..
                                  "from="..from.."&"..
                                  "message="..message.."&"..
                                  "message_format="..message_format.."&"..
                                  "notify="..notify.."&"..
                                  "color="..color
    
    resp = ngx.location.capture(
              hipchat_proxy_url,
            { method = ngx.HTTP_POST,
              body = message_specification,
              args = {api_method=room_message_url..auth_token}}
    )
    
    if resp.status ~= 200 then
        return nil, "message failed"
    end
    
    return true
end


return _M
