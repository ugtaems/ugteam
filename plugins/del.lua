local function getChatId(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  return chat
end
-----------------------------------------
local function delmsg (MaTaDoR,MahDiRoO)
    msgs = MaTaDoR.msgs 
    for k,v in pairs(MahDiRoO.messages_) do
        msgs = msgs - 1
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
        if msgs == 1 then
            tdcli.deleteMessages(MahDiRoO.messages_[0].chat_id_,{[0] = MahDiRoO.messages_[0].id_}, dl_cb, cmd)
            return false
        end
    end
    tdcli.getChatHistory(MahDiRoO.messages_[0].chat_id_, MahDiRoO.messages_[0].id_,0 , 100, delmsg, {msgs=msgs})
end
-----------------------------------------
local function MrRoO(msg)
if (matches[1] == 'rmsg all' or matches[1] == "پاکسازی همه") and is_mod(msg) then
  local function pro(extra,result,success)
             local roo = result.members_        
               for i=0 , #roo do
                  tdcli.deleteMessagesFromUser(msg.chat_id_, roo[i].user_id_)
               end
end
local function cb(arg,data)
for k,v in pairs(data.messages_) do
          tdcli.deletemessages(msg.chat_id_,{[0] = v.id_})
end
end
  tdcli.getChatHistory(msg.chat_id_, msg.id_,0 , 100,cb)
      tdcli.sendMessage(msg.chat_id_, msg.id_, 1,  '*🚮درحال پاک کردن کل پیام های گروه*', 1,'md')      
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,offset_ = 0,limit_ = 5000}, pro, nil)
end
------------------------------------------
    if (matches[1]:lower() == "rmsg" or matches[1] == "پاکسازی") and is_mod(msg) then
        if tostring(msg.to.id):match("^-100") then 
            if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
                return  '🚫 *1000*> _تعداد پیام های قابل پاک سازی در هر دفعه_ >*1* 🚫'
            else
			if not lang then  
				tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
				return "`"..matches[2].." `تعداد پیام های تعیین شده پاک سازی شد"
				else
				tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
				return "`"..matches[2].." `*پیام اخیر پاکسازی شد*"
				end
            end
        else
            return '⚠️ _این قابلیت فقط در سوپرگروه ممکن است_ ⚠️'
			
        end
    end
------------------------------------------
if (matches[1]:lower() == "del" or matches[1] == "حذف") and msg.reply_to_message_id_ ~= 0 and is_mod(msg) then
        tdcli.deleteMessages(msg.to.id,{[0] = tonumber(msg.reply_id),msg.id})
end
------------------------------------------
if matches[1]:lower() == "mydel" or matches[1] == "پاکسازی پیام من"  then  
tdcli.deleteMessagesFromUser(msg.to.id, msg.sender_user_id_, dl_cb, cmd)
     if not lang then   
           tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '*پیام های  شما  کامل پاکسازی شد *', 1, 'md')
		   else
		   tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_انجام شد :)_', 1, 'md')
	 end
end
------------------------------------------
end

return {  
patterns ={  
"^[!/#](rmsg) (%d*)$",
"^[!/#](rmsg all)$",
"^[!/#](mydel)$",
"^[!/#](del)$",
"^(پاکسازی) (%d*)$",
"^(پاکسازی همه)$",
"^(پاکسازی پیام من)$",
"^(حذف)$"
 }, 
  run = MrRoO
}