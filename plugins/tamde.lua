 local function run(msg, matches) 
if matches [1] =='ثبت کارت' then 
if not is_admin(msg) then 
return 'شما سودو نیستید' 
end 
local tmded = matches[2] 
redis:set('bot:tmded',tmded) 
return 'متن شما با موفقیت تنظیم شد\n➖➖➖➖➖➖➖➖➖\nپشتیبانی  ربات یوگی  با ما امنیت  رو تجربه  کنید' 
end 
if matches[1] == 'tmded' or 'کارت' then 
if not is_mod(msg) then 
return 
end 
    local hash = ('bot:tmded') 
    local tmded = redis:get(hash) 
    if not tmded then 
    return 'قیمت برای  ربات  ثبت نشده\n➖➖➖➖➖➖➖➖➖\nپشتیبانی  ربات یوگی  با ما امنیت  رو تجربه  کنید ' 
    else 
     tdcli.sendMessage(msg.chat_id_, 0, 1, tmded, 1, 'html') 
    end 
    end 
if matches[1]=="دیلت کارت" then 
if not is_admin(msg) then 
return 'شما ادمین نیستید\n➖➖➖➖➖➖➖➖➖\nپشتیبانی  ربات یوگی  با ما امنیت  رو تجربه  کنید' 
end 
    local hash = ('bot:tmded') 
    redis:del(hash) 
return 'متن ثبت شده پاک  شد \n➖➖➖➖➖➖➖➖➖\nپشتیبانی  ربات یوگی  با ما امنیت  رو تجربه  کنید' 
end 
end 
return { 
patterns ={ 
"^(ثبت کارت) (.*)$", 
"^(کارت)$",
"^💳$",
"^شماره کارت$",
"^برای تمدید$",
"^کارت$",
"^تمدید$", 
"^ربات$",
"^ربات تمدید$",
"^(دیلت کارت)$", 
}, 
run = run 
}
-- 
-- channel:@musa