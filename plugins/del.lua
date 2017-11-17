-- Coded by SuNova @ImAWitchBurnMe (Guess what, I don't have a team xD)
-- Tests are done on Beyond-CLI v6.0
-- Version 1.0.5
-- Further versions may be released
-- Contact me for bug report/suggestions
-- Some bugs are because of tdcli getChatHistory() uncertainties
-- Ah, say welcome to me ;)
local msgBody
local modList = {}
local function getKeySet(set)
	local keyset={[0]=0}
	local n = 0
	for k,v in pairs(set) do
		table.insert(keyset,1,tonumber(k))
	end
	return keyset
end
local function getTableSize(set)
	local n = 0
	for k,v in pairs(set) do
		n = n + 1
	end
	return n
end
-----------------------------------------
local function checkSuper(msg)
	chat_id = tostring(msg.chat_id_)
	if chat_id:match('^-100') then --supergroups and channels start with -100
		if not msg.is_post_ then
			return true
		end
	else
		msgBody = [[⛔️ این قابلیت فقط در سوپرگروه‌ها در دسترس است
⛔️ This function is only available in supergroups]]
		tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md')
		return false
  end
end
-----------------------------------------
local function auth(msg, n, matches)
	if matches[n] == '' then return true end
	local id = msg.sender_user_id_
	if (matches[n]:lower() == 'mods' or matches[n] == 'مدیران') and (modList[id] or is_mod(msg)) then modList[id] = true return true end
	if (matches[n]:lower() == 'users' or matches[n] == 'کاربران') and not (modList[id] or is_mod(msg)) then modList[id] = true return true end
	return false
end
-----------------------------------------
local function run(msg, matches)
	--vardump(matches)
	--vardump(msg)
	if matches[1]:lower() == "del me" or matches[1] == "پاکسازی من"  then
		if not checkSuper(msg) then return nil end
		tdcli.deleteMessagesFromUser(msg.to.id, msg.sender_user_id_, dl_cb, cmd)
		msgBody = '✅ کاربر ` ' .. msg.from.id .. '` ' .. msg.from.print_name .. ' پیام‌های شما پاک شد'
		.. '\n' .. '✅ User ' .. msg.from.print_name .. ' ‍‍`' .. msg.from.id .. '` your messages are cleared'
			tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md')
		return nil
	end
-----------------------------------------
	local del_user_set = {}
	local del_messages_set = {}
	local del_offset = msg.id_
	local index = 0
	local temp_messages = {}
	if not (is_mod(msg)) then return nil end
	if (matches[1]:lower() == "del" or matches[1] == "حذف") and is_reply(msg) then
			tdcli.deleteMessages(msg.to.id,{[0] = tonumber(msg.reply_id),msg.id})
			return nil
	end
-----------------------------------------
	if is_reply(msg) then del_offset = msg.reply_to_message_id_ end
	local function delAll()
		if (getTableSize(del_user_set) > 0) then
			for k,v in pairs(del_user_set) do
				tdcli.deleteMessagesFromUser(msg.chat_id_, k)
			end
			msgBody = [[✅ تمامی پیام‌های گروه پاک شد
	✅ All group messages are cleaned]]
			if matches[2] then
				if matches[2]:lower() == 'mods' or matches[2] == 'مدیران' then
					msgBody = msgBody:gsub('گروه', 'مدیران گروه')
				elseif matches[2]:lower() == 'users' or matches[2] == 'کاربران' then
					msgBody = msgBody:gsub('گروه', 'کاربران گروه')
				end
			end
		elseif (getTableSize(del_messages_set) > 0) then
			local size = getTableSize(del_messages_set)
			for k,v in pairs(del_messages_set) do
				tdcli.deleteMessages(msg.chat_id_, {[0] = k}, dl_cb, cmd)
			end
			msgBody = '✅ `' .. size .. '` پیام پاکسازی شد' .. '\n' .. '✅ `' .. size .. '` messages are cleaned'
		else msgBody = [[❗️ پیامی برای پاکسازی یافت نشد
❗️ No messages to delete
		]]
		end
		tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md')
	end
-----------------------------------------
	if (matches[1]:lower() == 'del all' or matches[1] == "پاکسازی همه") then
		local function fetch()
			local function cb(arg,data)
				if not data.messages_ or getTableSize(data.messages_) == 0 then
					if (index == 0 or getTableSize(temp_messages) == 0) then
						delAll()
					else
						while not temp_messages[index] or index > 0 do
							index = index - 1
						end
						if (index > 0) then
							del_offset = temp_messages[index].id_
							index = index - 1
						else delAll()
						end
					end
				else
					temp_messages = {}
					index = 0
					for k,v in pairs(data.messages_) do
						if (v.id_) then 
							del_offset = v.id_
							temp_messages[index] = v
							index = index + 1
						end
						if v.sender_user_id_ then
							local userid = v.sender_user_id_
							if not del_user_set[userid] and auth(v, 2, matches) then 
								del_user_set[userid] = true
							end
						end
					end
					fetch()
				end
			end
			tdcli.getChatHistory(msg.chat_id_, del_offset ,0 , 100,cb)
		end
		if not checkSuper(msg) then return nil end
		msgBody = [[️⚠️ در حال جمع‌آوری اطلاعات برای پاک کردن پیام‌ها، لطفا شکیبا باشید.
	⚠️ Gathering data to delete messages, please be patient.]]
		tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1,'md')
		fetch()
		return nil
	end
-----------------------------------------
	if (matches[1]:lower() == "del" or matches[1] == "پاکسازی") then
		local i = 1
		local function fetchAndCount(limit)
			local function cb(arg,data)
				local size = getTableSize(data.messages_)
				if (size == 0) then
					if (index == 0 or getTableSize(temp_messages) == 0) then
						delAll()
					else
						while not temp_messages[index] or index > 0 do
							index = index - 1
						end
						if (index > 0) then
							del_offset = temp_messages[index].id_
							index = index - 1
						else delAll()
						end
					end
				else
					temp_messages = {}
					index = 0
					for j = 0, size - 1 do  
						v = data.messages_[j]
						if (v.id_) then 
							del_offset = v.id_
							temp_messages[index] = v
							index = index + 1
							if not del_messages_set[del_offset] and auth (v, 3, matches) then
								del_messages_set[del_offset] = true
								i = i + 1
							end
							if i > limit then
								delAll()
								return nil
							end
						end
					end
					fetchAndCount(limit)
				end
			end
			tdcli.getChatHistory(msg.chat_id_, del_offset ,0 , 100, cb)
		end
--		msgBody = [[️⚠️ در حال جمع‌آوری اطلاعات برای پاک کردن پیام‌ها، لطفا شکیبا باشید.
--	⚠️ Gathering data to delete messages, please be patient.]]
--		tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1,'md')
		local amount = tonumber(matches[2])
		if amount < 1 then amount = 1 end
		del_messages_set[msg.id_] = true
		fetchAndCount(amount)
		return nil
	end
-----------------------------------------
	if (matches[1]:lower() == "del user" or matches[1] == "پاکسازی کاربر") and is_reply(msg) then
		local function cb(arg,data)
			tdcli.deleteMessagesFromUser(msg.chat_id_,data.sender_user_id_, dl_cb, nil)
			msgBody = [[✅ پیام‌های کاربر پاک شد
✅ Target user messages are now deleted]]
			tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md')
		end
		if not checkSuper(msg) then return nil end
		tdcli.getMessage(msg.chat_id_, msg.reply_to_message_id_ , cb)
		return nil
	end
-----------------------------------------
	if matches[1]:lower() == 'help del' or matches[1] == 'راهنمای پاکسازی' then
		local lang = matches[2] and (matches[2]:lower() == 'en' or matches[2] == 'انگلیسی')
		if lang then
			msgBody = [[🇬🇧 Del guide:

_پاکسازی همه_ 
*del all*
Deletes all the messages of the group

_پاکسازی همه_ [`مدیران`|`کاربران`]
*del all*  [`mods`|`users`]
Deletes all the messages of users|mods in the group

_پاکسازی_ `تعداد`
*del* `amount`
Deletes specified number of messages

_پاکسازی_  `تعداد` [`مدیران`|`کاربران`]
*del* `amount` [`mods`|`users`]
Deletes specified amount of messages of users|moderators in the group

_پاکسازی من_
*del me*
Deletes all of your messages (may be used by regular users)

_پاکسازی کاربر_
*del user*
Deletes messages of a specific user. Reply this command to one of that user messages.

_حذف_
*del*
Reply this command to a message to delete that message

_راهنمای پاکسازی_
*help del*
Shows this help in Persian

_راهنمای پاکسازی انگلیسی_
*help del en*
Shows this help in English

You may use *!/#* in the beginning of English commands optionally

⚠️ This is probable that if you deleted a chunk of messages in the group commands don't work as desired. In those cases, reply commands to non-deleted message and this will fix the problem in most cases.
This plugin works fine in supergroups. In normal groups some of functions don't operate.

*ug:* ]]
		else
			msgBody = [[‏🇮🇷 راهنمای پاکسازی:

_پاکسازی همه_ 
 *del all*
تمام پیام‌های گروه را پاک می‌کند.

_پاکسازی همه_ [`مدیران`|`کاربران`]
 *del all*  [`mods`|`users`]
تمام پیام‌های مدیران|کاربران گروه را پاک می‌کند.

_پاکسازی_ `تعداد`
*del* `amount`
پاکسازی پیام‌های گروه به تعداد مورد نظر

_پاکسازی_  `تعداد` [`مدیران`|`کاربران`]
 *del* `amount` [`mods`|`users`]
پیام‌های مدیران|کاربران گروه را به تعداد مدنظر شما پاک می‌کند.

_پاکسازی من_
*del me*
پیام‌های شما را پاک می‌کند (قابل استفاده توسط کاربران عادی)

_پاکسازی کاربر_
*del user*
پیام‌های یک کاربر خاص را پاک می‌کند. باید روی پیام کاربر مدنظر این دستور را ریپلای بزنید.

_حذف_
*del*
یک پیام خاص را پاک می‌کند. این دستور را روی پیام موردنظر ریپلای بزنید.

_راهنمای پاکسازی_
*help del*
نمایش این راهنما به زبان پارسی

_راهنمای پاکسازی انگلیسی_
*help del en*
نمایش این راهنما به زبان انگلیسی

شما می‌توانید در ابتدای دستورات انگلیسی از کاراکترهای *!/#* استفاده کنید (اختیاری)

⚠️ امکان دارد اگر مابین پیام‌ها دسته‌ای از آن‌ها را پاک کرده باشید، پاکسازی به درستی انجام نشود. در آن صورت با ریپلای کردن دستورات روی پیام‌های باقی مانده معمولا مشکل حل می‌شود.
این پلاگین در سوپرگروه‌ها قابل استفاده است و در گروه‌های عادی برخی دستورات کار نمی‌کنند.

*ug:* ]]
		end
		tdcli.sendMessage(msg.chat_id_, msg.id_, 1, msgBody, 1, 'md')
	end 
end

return {  
patterns ={  
"^[!/#]*([Dd][Ee][Ll])%s(%d+)%s*(.*)$",
"^[!/#]*([Dd][Ee][Ll]%s[Aa][Ll][Ll])%s*(.*)$",
"^[!/#]*([Dd][Ee][Ll]%s[Mm][Ee])$",
"^[!/#]*([Dd][Ee][Ll]%s[Uu][Ss][Ee][Rr])$",
"^[!/#]*([Dd][Ee][Ll])$",
"^[!/#]*([Hh][Ee][Ll][Pp]%s[Dd][Ee][Ll])%s*(.*)$",
"^(پاکسازی)%s(%d+)%s*(.*)$",
"^(پاکسازی%sهمه)%s*(.*)$",
"^(پاکسازی%sمن)$",
"^(پاکسازی%sکاربر)$",
"^(راهنمای%sپاکسازی)%s*(.*)$",
"^(حذف)$"
 }, 
  run = run
}
