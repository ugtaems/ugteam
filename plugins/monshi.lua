--Start By 
--help
local function run(msg, matches) 
local monshi = 257104993,289000262
if matches[1] == "اضافه" then 
if not is_sudo(msg) then 
return 'شما سودو نیستید' 
end 
local pm = matches[2] 
redis:set('bot:pm',pm) 
return 'متن پاسخ گویی ثبت شد' 
end 

if matches[1] == "pm" and is_sudo(msg) then
local hash = ('bot:pm') 
    local pm = redis:get(hash) 
    if not pm then 
    return ' ثبت نشده' 
    else 
	   return tdcli.sendMessage(msg.chat_id_ , 0, 1, 'پیغام  تیم پشتیبانی ربات های ug:\n\n'..pm, 0, 'html')
    end
end

if matches[1]=="monshi" then 
if not is_sudo(msg) then 
return 'شما سودو نیستید' 
end 
if matches[2]=="on"then 
redis:set("bot:pm", "منشی فعال نیست از سودو بخواید که منشی  ربات  را  فعال  کنه باتشکر تیم پشتیبانی")
return "منشی فعال شد لطفا دوباره پیغام را تنظیم کنید" 
end 
if matches[2]=="off"then 
redis:del("bot:pm")
return "منشی غیرفعال شد" 
end
 end
  if gp_type(msg.chat_id_) == "پیام" and   msg.content_.text_ then
    local hash = ('bot:pm') 
    local pm = redis:get(hash)
if gp_type(msg.chat_id_) == "channel" or gp_type(msg.chat_id_) == "chat" then
return
else
tdcli.sendMessage(msg.chat_id_ , 0, 1, pm, 0, 'html')
  tdcli.sendMessage(monshi , 0, 1,"پیام:".. msg.content_.text_.."\nآیدی فرستنده  :"..msg.sender_user_id_, 0, 'html')  end 
    end
end
return { 
patterns ={ 
"^(اضافه) (.*)$", 
"^(monshi) (on)$", 
"^(monshi) (off)$", 
"^(monshi) (.*)$",
"^(pm)     (.*)$",
"^(پیام)   (.*)$",
"^(.*)$",
}, 
run = run 
}


