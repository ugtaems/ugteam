
local function pre_process(msg)
	if not is_mod(msg) then
		local username = ''
		local cpmadd = 'addpm'..msg.to.id
		local pmadd = redis:get(cpmadd)
		local add_lock = redis:hget('addmeminvite', msg.to.id)
		if add_lock == 'on' then
			local setadd = redis:hget('addmemset', msg.to.id) or 5
			if msg.adduser then
				if msg.content_.members_[0].type_.ID == 'UserTypeBot' then
					if not pmadd then
							return '`🤖 شما یک ربات اضافه کردید`\n*لطفا ربات  اد  نکنید*'
					end
					return
				end
				if msg.from.username then
					username = '@'..check_markdown(msg.from.username)
				else
					username = check_markdown(msg.from.print_name)
				end
				if #msg.content_.members_ > 0 then
					if not pmadd then
							tdcli.sendMessage(msg.to.id, 0, 1, '`🆔 :`\n '..username..'\n\n*شما اضافه کردید* '..(#msg.content_.members_ + 1)..'\n`لطفا یک کاربر را اضافه کنید.`', 1, 'md')
					end
				end
				local chash = msg.content_.members_[0].id_..'chkinvusr'..msg.from.id..'chat'..msg.to.id
				local chk = redis:get(chash)
				if not chk then
					redis:set(chash, true)
					local achash = 'addusercount'..msg.from.id
					local count = redis:hget(achash, msg.to.id) or 0
					redis:hset(achash, msg.to.id, (tonumber(count) + 1))
					local permit = redis:hget(achash, msg.to.id)
					if tonumber(permit) < tonumber(setadd) then
						local less = tonumber(setadd) - tonumber(permit)
						if not pmadd then
								tdcli.sendMessage(msg.to.id, 0, 1, '`🆔 :`\n'..username..'\n*تو دعوت کردی* `'..permit..'` *کاربری را به  این  گروه .*\n*شما باید دعوت کنید* `'..less..'` *اعضای دیگر.*', 1, 'md')
						end
					elseif tonumber(permit) == tonumber(setadd) then
						if not pmadd then
								tdcli.sendMessage(msg.to.id, 0, 1, '`🆔 :`\n'..username..'\n*شما می توانید پیام ها را  ارسال  کنید *', 1, 'md')
						end
					end
				else
					if not pmadd then
							tdcli.sendMessage(msg.to.id, 0, 1, '`🆔 :`\n'..username..'\n*اخطار شما قبلا این کاربر را به گروه اضافه کرده اید *', 1, 'md')
					end
				end
			end
			local permit = redis:hget('addusercount'..msg.from.id, msg.to.id) or 0
			if tonumber(permit) < tonumber(setadd) then
				tdcli.deleteMessages(msg.to.id, {[0] = msg.id_}, dl_cb, nil)
			end
		end
	end
end

local function run(msg, text)
	if is_mod(msg) then
		if text[1]:lower() == 'بستن' then
			if text[2]:lower() == 'اد' then
				local add = redis:hget('addmeminvite' ,msg.to.id)
				if not add then
					redis:hset('addmeminvite', msg.to.id, 'off')
				end
				if add == 'on' then 
					redis:hset('addmeminvite', msg.to.id, 'off')
						return '🚷 *محدود کردن  افزودن عضو جدید* `قفل شده `!'
				elseif add == 'off' then
						return '🚷 * محدود کردن افزودن عضو ازقبل  * `قفل شده بود `!'
				end
			end
		end
		if text[1]:lower() == 'بازکردن' then
			if text[2]:lower() == 'اد' then
				local add = redis:hget('addmeminvite' ,msg.to.id)
				if not add then
					redis:hset('addmeminvite', msg.to.id, 'on')
				end
				if add == 'off' then 
					redis:hset('addmeminvite', msg.to.id, 'on')
						return '👤 *محدود کردن افزودن عضو جدید * `باز شده  `!'
				elseif add == 'on' then
						return '👤 *محدود کردن افزودن عضو از قبل * `بازشده  بود`!'
				end
			end
		end
		if text[1]:lower() == 'تنظیم اد' and text[2] then
			if tonumber(text[2]) >= 1 and tonumber(text[2]) <= 10 then
				redis:hset('addmemset', msg.to.id, text[2])
					return '🔰 *تنظیم  حداکثر کاربر به گروه :* `'.. text[2]..'`'
			else
					return '🔰 حداکثر اد  کردن کاربر *1 تا 10* میباشد '
			end
		end
		if text[1]:lower() == 'اطلاعات اد' then
			local getadd = redis:hget('addmemset', msg.to.id)
				return '*:* `'..getadd..'`'
		end
		if text[1]:lower() == 'اد پیام' then
			local pmadd = 'addpm'..msg.to.id
			if text[2] == 'فعال' then
				redis:del(pmadd)
					return '🔰 *ارسال پیام برای کاربر * `فعال شده`'
			elseif text[2] == 'غیرفعال' then
				redis:set(pmadd, true)
					return '🔰 *ارسال پیام برای کاربر * `غیرفعال شده`'
			end
		end
	end
end
 
return {
  patterns = {
	'^(بازکردن) (.*)$',
	'^(بستن) (.*)$',
	'^(اد پیام) (.*)$',
	'^(تنظیم اد) (%d+)$',
	'^(اطلاعات اد)$',
  },
  run = run,
  pre_process = pre_process
}
