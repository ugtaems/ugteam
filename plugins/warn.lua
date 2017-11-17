--Begin Warn.lua By @SoLiD #BeyondTeam
local function action_by_reply(TM, BD)
local cmd = TM.cmd
if not tonumber(BD.sender_user_id_) then return false end
if BD.sender_user_id_ then
  if cmd == "warn" then
local function warn_cb(TM, BD)
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*من نمیتوانم به خودم اخطار دهم*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:hdel(hashwarn, BD.id_, '0')
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\nNumber of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = BD.sender_user_id_
  }, warn_cb, {chat_id=BD.chat_id_,user_id=BD.sender_user_id_,msg=TM.msg})
  end
   if cmd == "unwarn" then
local function unwarn_cb(TM, BD)
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = TM.chat_id..':warn'
local warnhash = redis:hget(hashwarn, BD.id_) or 1
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
if not redis:hget(hashwarn, BD.id_) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id_, '0')
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_تمامی اخطار های_ "..user_name.." *"..BD.id_.."* *پاک شدند*", 0, "md")
      end
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = BD.sender_user_id_
  }, unwarn_cb, {chat_id=BD.chat_id_,user_id=BD.sender_user_id_})
    end
else
    if lang then
  return tdcli.sendMessage(BD.chat_id_, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(BD.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end
local function action_by_username(TM, BD)
if BD.id_ then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.type_.user_.username_ then
user_name = '@'..check_markdown(BD.type_.user_.username_)
else
user_name = check_markdown(BD.title_)
end
   if cmd == "warn" then
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*من نمیتوانم به خودم اخطار دهم*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:hdel(hashwarn, BD.id_, '0')
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\nNumber of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:hget(hashwarn, BD.id_) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id_, '0')
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_تمامی اخطار های_ "..user_name.." *"..BD.id_.."* *پاک شدند*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end
	local function action_by_id(TM, BD)
    if BD.id_ then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id_) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username_ then
user_name = '@'..check_markdown(BD.username_)
else
user_name = check_markdown(BD.first_name_)
end
   if cmd == "warn" then
     if BD.id_ == our_id then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_I can't warn_ *my self*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*من نمیتوانم به خودم اخطار دهم*", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id_) and not is_admin1(msg.from.id)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
   if is_admin1(BD.id_)then
  if not lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_You can't warn_ *bot admins*", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*شما نمیتوانید به ادمین های ربات اخطار دهید*", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id_, TM.chat_id)
redis:hdel(hashwarn, BD.id_, '0')
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _has been_ *kicked* _because max warning_\n_Number of warn :_ "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* به دلیل دریافت اخطار بیش از حد اخراج شد\nتعداد اخطار ها : "..hashwarn.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id_, tonumber(warnhash) + 1)
    if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."*\n_You've_ "..warnhash.." _of_ "..max_warn.." _Warns!_", 0, "md")
    else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *شما یک اخطار دریافت کردید*\n*تعداد اخطار های شما : "..warnhash.."/"..max_warn.."*", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:hget(hashwarn, BD.id_) then
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_User_ "..user_name.." *"..BD.id_.."* _don't have_ *warning*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر_ "..user_name.." *"..BD.id_.."* *هیچ اخطاری دریافت نکرده*", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id_, '0')
   if not lang then
    return tdcli.sendMessage(TM.chat_id, "", 0, "_All warn of_ "..user_name.." *"..BD.id_.."* _has been_ *cleaned*", 0, "md")
   else
    return tdcli.sendMessage(TM.chat_id, "", 0, "_تمامی اخطار های_ "..user_name.." *"..BD.id_.."* *پاک شدند*", 0, "md")
    end
  end
end
else
    if lang then
  return tdcli.sendMessage(TM.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(TM.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function BeyondTeam(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
		if ((matches[1]:lower() == 'پاک کردن' and matches[2] == 'اخطار ها' and not Clang) or (matches[1] == "" and matches[2] == '' and Clang)) then
			if not is_owner(msg) then
				return
			end
    local hash = msg.to.id..':warn'
    redis:del(hash)
    if not lang then
     return "_All_ *warn* _of_ *users* _in this_ *group* _has been_ *cleaned*"
   else
     return "_تمام اخطار های کاربران این گروه پاک شد_"
		end
  end
		if ((matches[1]:lower() == 'حداکثر اخطار' and not Clang) or (matches[1] == "" and Clang)) then
			if not is_mod(msg) then
				return
			end
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 20 then
     if not lang then
				return "_Wrong number, range is_ *[1-20]*"
    else
				return "_لطفا عددی بین [1-20] را انتخاب کنید_"
      end
    end
			local warn_max = matches[2]
   redis:set('max_warn:'..msg.to.id, warn_max)
    if not lang then
     return "*Warn maximum* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_حداکثر اخطار تنظیم شد به :_ *[ "..matches[2].." ]*"
		end
  end
if ((matches[1] == "اخطار" and not Clang) or (matches[1] == "" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="warn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="warn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="warn"})
      end
   end
if ((matches[1] == "حذف اخطار" and not Clang) or (matches[1] == "" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="unwarn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="unwarn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="unwarn"})
     end
	end
	if ((matches[1] == "لیست اخطار" and not Clang) or (matches[1] == "" and Clang)) and is_mod(msg) then
	local list = 'Warn Users List:\n'
local empty = list
		for k,v in pairs (redis:hkeys(msg.to.id..':warn')) do
  		local user_info = redis:hgetall('user:'..v)
					local cont = redis:hget(msg.to.id..':warn', v)
		if user_info and user_info.user_name then
		list = list..k..'- '..check_markdown(user_info.user_name)..' [`'..v..'`] *Warn : '..(cont - 1)..'*\n'
       else
		list = list..k..'- `'..v..'` *Warn : '..(cont - 1)..'*\n'
      end
    end
		if list == empty then
		return '_لیست اخطار خالی داداچ عزیزم _'
		else
		return list
		end
	end
end
local function pre_process(msg)
    local hash = 'user:'..msg.from.id
    if msg.from.username then
     user_name = '@'..msg.from.username
  else
     user_name = msg.from.print_name
    end
      redis:hset(hash, 'user_name', user_name)
end

return {
  patterns = {
  "^(اخطار)$",
  "^(اخطار) (.*)$",
  "^(حذف اخطار)$",
  "^(حذف اخطار) (.*)$",
  "^(حداکثر اخطار) (%d+)$",
  "^(پاک کردن) (اخطار ها)$",
  "^(لیست اخطار)$",


  },
  run = BeyondTeam,
	pre_process = pre_process
}
