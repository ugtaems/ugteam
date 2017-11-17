local function MrRoO(msg)
if (matches[1]:lower() == "photo" and not Clang) or (matches[1] == "عکس" and Clang) then 
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.jpg') 
    tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "", dl_cb, nil)
end
--------------------------------
if (matches[1]:lower() == "sticker" and not Clang) or (matches[1] == "استیکر" and Clang) then 
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.webp') 
     tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil) 
end
--------------------------------
if (matches[1]:lower() == "gif" and not Clang) or (matches[1] == "گیف" and Clang) then
        local modes = {'memories-anim-logo','alien-glow-anim-logo','flash-anim-logo','flaming-logo','whirl-anim-logo','highlight-anim-logo','burn-in-anim-logo','shake-anim-logo','inner-fire-anim-logo','jump-anim-logo'}
        local text = URL.escape(matches[2]) 
        local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
        local title , res = http.request(url2)
        local jdat = json:decode(title)
        local gif = jdat.src
        local file = download_to_file(gif,'byroo.gif')
        tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil)
end
end

return {
patterns ={
"^[#!/]([Gg][Ii][Ff]) (.*)$",
"^([Gg][Ii][Ff]) (.*)$",
"^(گیف) (.*)$",
"^[!/#]([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$",
"^([Ss][Tt][Ii][Cc][Kk][Ee][Rr]) (.*)$",
"^(استیکر) (.*)$",
"^[!/#]([Pp][Hh][Oo][Tt][Oo]) (.*)$",
"^([Pp][Hh][Oo][Tt][Oo]) (.*)$",
"^(عکس) (.*)$"
},
run= MrRoO
}
