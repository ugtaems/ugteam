--- coded by @ musa
local function LiOnKiNgTeAm(msg,matches)
if matches[1]:lower() == 'انلاینی' or matches[1]:lower() == 'هستی ربات' then
if is_sudo(msg) then
 return "*یوزرنیم مدیر ارشد :* @"..(check_markdown(msg.from.username) or 'No یوزر نام ').." \n*نام مدیر ارشد :* `"..msg.from.first_name.."` \n*ایدی مدیر ارشد:* `"..msg.from.id.."` \n*مقام :*`مدیر ارشد گروه`\n\n*تعداد کل پیام :* `"..user_info_msgs.."️`\n *👑من انلاین هستم مدیر ارشد  ✅*"
  elseif is_admin(msg) then
 return "*یوزرنیم معاون ارشد:* @"..(check_markdown(msg.from.username) or 'No یوزر نام ').." \n*نام معاون ارشد :* `"..msg.from.first_name.."` \n*ایدی معاون ارشد:*`"..msg.from.id.."` \n*مقام :*`معاون ارشد`\n\n*تعداد کل پیام :* `"..user_info_msgs.."️`\n *من انلاین هستم معاون ارشد✅*"
  elseif is_owner(msg) then
 return "*یوزرنیم معاون گروه:* @"..(check_markdown(msg.from.username) or 'No یوزر نام ').." \n*نام معاون گروه:* `"..msg.from.first_name.."` \n*ایدی معاون گروه:*`"..msg.from.id.."` \n*مقام :*`معاون گروه`\n\n*تعداد کل پیام :* `"..user_info_msgs.."️`\n *من انلاین هستم  معاون گروه ✅*"
   elseif is_mod(msg) then
 return "*یوزرنیم ناظر ارشد:* @"..(check_markdown(msg.from.username) or 'No یوزر نام ').." \n*نام ناظر ارشد:* `"..msg.from.first_name.."` \n*ایدی ناظر ارشد:*`"..msg.from.id.."` \n*مقام :*`ناظرارشد`\n\n*تعداد کل پیام :* `"..user_info_msgs.."️`\n *من انلاین هستم ناظر ارشد ✅*"
  else
 return "*یوزرنیم سربازگروه :* @"..(check_markdown(msg.from.username) or 'No یوزر نام ').." \n*نام سرباز گروه:* `"..msg.from.first_name.."` \n*ایدی سرباز گروه:*`"..msg.from.id.."` \n*مقام :*`سرباز گروه`\n\n*تعداد کل پیام :* `"..user_info_msgs.."️`\n *من انلاین هستم  سرباز گروه ✅*"
 end 
end
end

return {
patterns = {

     "^(هستی ربات)",
     "^(انلاینی)$"
         
},
run = LiOnKiNgTeAm,
}
-- coded by @musa
