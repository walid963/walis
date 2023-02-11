
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua Black.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua Black.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفض ايدي المطور الاسياسي \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفض ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua Black.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local Black = io.open("Black", 'w')
Black:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
lua5.3 Black.lua
done
]])
Black:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x Black;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
Black = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..Black)
LuaTele = luatele.set_config{api_id=1846213,api_hash='c545c613b78f18a30744970910124d53',session_name=Black,token=Token}
function var(value)
print(serpent.block(value, {comment=false}))   
end 
clock = os.clock
function sleep(n)
local t0 = clock()
while clock() - t0 <= n do end
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function ctime(seconds)
local seconds = tonumber(seconds)
if seconds <= 0 then
return "00:00"
else
hours = string.format("%02.f", math.floor(seconds/3600));
mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
return mins..":"..secs
end
end
function edit(chat,rep,text,parse, dis, disn, reply_markup)
shh = tostring(text)
if Redis:get(Black..'rmzsource') then
shh = shh:gsub("※",Redis:get(Black..'rmzsource'))
end
local listm = Redis:smembers(Black.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(shh, v)
if j and i then
local x = string.sub(shh, i,j)
local neww = Redis:get(Black.."Word:Replace"..x)  
shh = shh:gsub(x,neww)
else
shh = shh
end
end
LuaTele.editMessageText(chat,rep,shh, parse, dis, disn, reply_markup)
end
function send(chat,rep,text,parse,dis,clear,disn,back,markup)
sh = tostring(text)
if Redis:get(Black..'rmzsource') then
sh = sh:gsub("※",Redis:get(Black..'rmzsource'))
end
local listm = Redis:smembers(Black.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(sh, v)
if j and i then
local x = string.sub(sh, i,j)
local neww = Redis:get(Black.."Word:Replace"..x)  
sh = sh:gsub(x,neww)
else
sh = sh
end
end
LuaTele.sendText(chat,rep,sh,parse,dis, clear, disn, back, markup)
end
function editrtp(chat,user,msgid,useri)
if Redis:sismember(Black.."BanGroup:Group"..chat,useri) then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if Redis:sismember(Black.."SilentGroup:Group"..chat,useri) then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if Redis:sismember(Black.."SuperCreator:Group"..chat,useri)  then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Redis:sismember(Black.."Creator:Group"..chat,useri) then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Redis:sismember(Black.."Manger:Group"..chat,useri) then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Redis:sismember(Black.."Admin:Group"..chat,useri) then
Adminz = "✔"
else
Adminz = "❌"
end
if Redis:sismember(Black.."Special:Group"..chat,useri) then
Specialz = "✔"
else
Specialz = "❌"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =user..'/statusSuperCreatorz/'..useri},{text = '- منشئ : '..Creatorz, data =user..'/statusCreatorz/'..useri},
},
{
{text = '- مدير : '..Mangerz, data =user..'/statusMangerz/'..useri},{text = '- ادمن : '..Adminz, data =user..'/statusAdminz/'..useri},
},
{
{text = '- مميز : '..Specialz, data =user..'/statusSpecialz/'..useri},
},
{
{text = '- الحظر : '..BanGroupz, data =user..'/statusban/'..useri},{text = '- الكتم : '..SilentGroupz, data =user..'/statusktm/'..useri},
},
{
{text = '- عضو  ', data =user..'/statusmem/'..useri},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return edit(chat,msgid,'*\n• تحكم برتب الشخص .*', 'md', true, false, reply_markup)
end
function FlterBio(Bio)
local Bio = tostring(Bio):lower()
Bio = Bio:gsub("https://[%a%d_]+",'') 
Bio = Bio:gsub("https://[%a%d_]+",'') 
Bio = Bio:gsub("telegram.dog/[%a%d_]+",'') 
Bio = Bio:gsub("telegram.me/[%a%d_]+",'') 
Bio = Bio:gsub("t.me/[%a%d_]+",'') 
Bio = Bio:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Bio = Bio:gsub("@[%a%d_]+",'')
Bio = Bio:gsub("#[%a%d_]+",'')
Bio = Bio:gsub("]","")
Bio = Bio:gsub("[[]","")
return Bio
end
if Redis:get(Black..'chsource') then
chsource = Redis:get(Black..'chsource')
else
chsource = "cllllllT"
end
if Redis:get(Black..'chdevolper') then
chdevolper = Redis:get(Black..'chdevolper')
else 
chdevolper = "UI_zc"
end

function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function s_api(web) 
local info, res = https.request(web) 
local req = json:decode(info) 
if res ~= 200 then 
return false 
end 
if not req.ok then 
return false end 
return req 
end 
function send_inlin_key(chat_id,text,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..Token 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id 
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return s_api(url) 
end
function getbio(User)
kk = "لا يوجد"
local url = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result then
if data.result.bio then
kk = data.result.bio
end
end
return kk
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,5421129731,5298947457}
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
Devss = Redis:sismember(Black.."Devss:Groups",UserId) 
Dev = Redis:sismember(Black.."Dev:Groups",UserId)
Supcreator = Redis:sismember(Black.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(Black.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(Black.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(Black.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(Black.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(Black.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5421129731 then
Status = 'المبرمج ستيفن'
elseif UserId == 5298947457 then
Status = 'مطور السورس'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == Black then
Status = 'البوت'
elseif Devss then
Status = Redis:get(Black.."Devss:Groups"..ChatId) or 'المطور الثانوي'
elseif Dev then
Status = Redis:get(Black.."Developer:Bot:Reply"..ChatId) or 'المطور'
elseif Owners then
Status = Redis:get(Black.."PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif Supcreator then
Status = Redis:get(Black.."President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Creator then
Status = Redis:get(Black.."Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Manger then
Status = Redis:get(Black.."Manager:Group:Reply"..ChatId) or 'المدير'
elseif Admin then
Status = Redis:get(Black.."Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الكروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن الكروب'
elseif Special then
Status = Redis:get(Black.."Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(Black.."Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات الكروب : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
edit(ChatId,MsgId,"↯︙صلاحيات الادمن - ", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(Black.."lockpin"..ChatId) then    
lock_pin = "✔️"
else 
lock_pin = "❌"    
end
if Redis:get(Black.."Lock:tagservr"..ChatId) then    
lock_tagservr = "✔️"
else 
lock_tagservr = "❌"
end
if Redis:get(Black.."Lock:text"..ChatId) then    
lock_text = "✔️"
else 
lock_text = "❌ "    
end
if Redis:get(Black.."Lock:AddMempar"..ChatId) == "kick" then
lock_add = "✔️"
else 
lock_add = "❌ "    
end    
if Redis:get(Black.."Lock:Join"..ChatId) == "kick" then
lock_join = "✔️"
else 
lock_join = "❌ "    
end    
if Redis:get(Black.."Lock:edit"..ChatId) then    
lock_edit = "✔️"
else 
lock_edit = "❌ "    
end
if Redis:get(Black.."Chek:Welcome"..ChatId) then
welcome = "✔️"
else 
welcome = "❌ "    
end
if Redis:hget(Black.."Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(Black.."Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقييد "     
elseif Redis:hget(Black.."Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(Black.."Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "✔️"
else     
flood = "❌ "     
end
if Redis:get(Black.."Lock:Photo"..ChatId) == "del" then
lock_photo = "✔️" 
elseif Redis:get(Black.."Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقييد "   
elseif Redis:get(Black.."Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(Black.."Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "❌ "   
end    
if Redis:get(Black.."Lock:Contact"..ChatId) == "del" then
lock_phon = "✔️" 
elseif Redis:get(Black.."Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقييد "    
elseif Redis:get(Black.."Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(Black.."Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "❌ "    
end    
if Redis:get(Black.."Lock:Link"..ChatId) == "del" then
lock_links = "✔️"
elseif Redis:get(Black.."Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقييد "    
elseif Redis:get(Black.."Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(Black.."Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "❌ "    
end
if Redis:get(Black.."Lock:Cmd"..ChatId) == "del" then
lock_cmds = "✔️"
elseif Redis:get(Black.."Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقييد "    
elseif Redis:get(Black.."Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(Black.."Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "❌ "    
end
if Redis:get(Black.."Lock:User:Name"..ChatId) == "del" then
lock_user = "✔️"
elseif Redis:get(Black.."Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقييد "    
elseif Redis:get(Black.."Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(Black.."Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "❌ "    
end
if Redis:get(Black.."Lock:hashtak"..ChatId) == "del" then
lock_hash = "✔️"
elseif Redis:get(Black.."Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقييد "    
elseif Redis:get(Black.."Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(Black.."Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "❌ "    
end
if Redis:get(Black.."Lock:vico"..ChatId) == "del" then
lock_muse = "✔️"
elseif Redis:get(Black.."Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقييد "    
elseif Redis:get(Black.."Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(Black.."Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "❌ "    
end 
if Redis:get(Black.."Lock:Video"..ChatId) == "del" then
lock_ved = "✔️"
elseif Redis:get(Black.."Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقييد "    
elseif Redis:get(Black.."Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(Black.."Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "❌ "    
end
if Redis:get(Black.."Lock:Animation"..ChatId) == "del" then
lock_gif = "✔️"
elseif Redis:get(Black.."Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقييد "    
elseif Redis:get(Black.."Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(Black.."Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "❌ "    
end
if Redis:get(Black.."Lock:Sticker"..ChatId) == "del" then
lock_ste = "✔️"
elseif Redis:get(Black.."Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقييد "    
elseif Redis:get(Black.."Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(Black.."Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "❌ "    
end
if Redis:get(Black.."Lock:geam"..ChatId) == "del" then
lock_geam = "✔️"
elseif Redis:get(Black.."Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقييد "    
elseif Redis:get(Black.."Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(Black.."Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "❌ "    
end    
if Redis:get(Black.."Lock:vico"..ChatId) == "del" then
lock_vico = "✔️"
elseif Redis:get(Black.."Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقييد "    
elseif Redis:get(Black.."Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(Black.."Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "❌ "    
end    
if Redis:get(Black.."Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "✔️"
elseif Redis:get(Black.."Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقييد "
elseif Redis:get(Black.."Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(Black.."Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "❌ "
end
if Redis:get(Black.."Lock:forward"..ChatId) == "del" then
lock_fwd = "✔️"
elseif Redis:get(Black.."Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقييد "    
elseif Redis:get(Black.."Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(Black.."Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "❌ "    
end    
if Redis:get(Black.."Lock:Document"..ChatId) == "del" then
lock_file = "✔️"
elseif Redis:get(Black.."Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقييد "    
elseif Redis:get(Black.."Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(Black.."Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "❌ "    
end    
if Redis:get(Black.."Lock:Unsupported"..ChatId) == "del" then
lock_self = "✔️"
elseif Redis:get(Black.."Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقييد "    
elseif Redis:get(Black.."Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(Black.."Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "❌ "    
end
if Redis:get(Black.."Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "✔️"
elseif Redis:get(Black.."Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقييد "   
elseif Redis:get(Black.."Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "❌ "    
end
if Redis:get(Black.."Lock:Markdaun"..ChatId) == "del" then
lock_mark = "✔️"
elseif Redis:get(Black.."Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقييد "    
elseif Redis:get(Black.."Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(Black.."Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "❌ "    
end
if Redis:get(Black.."Lock:Spam"..ChatId) == "del" then    
lock_spam = "✔️"
elseif Redis:get(Black.."Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقييد "    
elseif Redis:get(Black.."Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(Black.."Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "❌ "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'غير متفاعل'
elseif tonumber(Message) < 200 then 
MsgText = 'بده يتحسن'
elseif tonumber(Message) < 400 then 
MsgText = 'شبه متفاعل'
elseif tonumber(Message) < 700 then 
MsgText = 'متفاعل'
elseif tonumber(Message) < 1200 then 
MsgText = 'متفاعل قوي'
elseif tonumber(Message) < 2000 then 
MsgText = 'متفاعل جدا'
elseif tonumber(Message) < 3500 then 
MsgText = 'اقوى تفاعل'
elseif tonumber(Message) < 4000 then 
MsgText = 'متفاعل نار'
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل'
elseif tonumber(Message) < 5500 then 
MsgText = 'ملك التفاعل'
elseif tonumber(Message) < 7000 then 
MsgText = 'امبروطور التفاعل'
elseif tonumber(Message) < 9500 then 
MsgText = 'رب التفاعل'
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,MsgId,"↯︙صلاحيات الكروب - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(Black.."BanAll:Groups",UserId) ,
ktmall = Redis:sismember(Black.."ktmAll:Groups",UserId) ,
BanGroup = Redis:sismember(Black.."BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(Black.."SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
Name_User = UserInfo.first_name
--if UserInfo.username then
--UserInfousername = '['..Name_User..'](t.me/'..UserInfo.username..')'
--else
UserInfousername = '['..Name_User..'](tg://user?id='..UserId..')'
--end
return {
Lock     = '\n*↯︙بواسطه ↫ *'..UserInfousername..'\n*'..TextMsg..'\n↯︙خاصيه المسح *',
unLock   = '\n*↯︙بواسطه ↫ *'..UserInfousername..'\n'..TextMsg,
lockKtm  = '\n*↯︙بواسطه ↫ *'..UserInfousername..'\n*'..TextMsg..'\n↯︙خاصيه الكتم *',
lockKid  = '\n*↯︙بواسطه ↫ *'..UserInfousername..'\n*'..TextMsg..'\n↯︙خاصيه التقييد *',
lockKick = '\n*↯︙بواسطه ↫ *'..UserInfousername..'\n*'..TextMsg..'\n↯︙خاصيه الطرد *',
Reply    = '\n*↯︙ المستخدم ↫ *'..UserInfousername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
Devss = Redis:sismember(Black.."Devss:Groups",UserId) 
Dev = Redis:sismember(Black.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(Black.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(Black.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(Black.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(Black.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(Black.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(Black.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5421129731 then
Status = true
elseif UserId == 5298947457 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Black then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
Devss = Redis:sismember(Black.."Devss:Groups",UserId) 
Dev = Redis:sismember(Black.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(Black.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(Black.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(Black.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(Black.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(Black.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(Black.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5421129731 then
Status = true
elseif UserId == 5298947457 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == Black then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,Black).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(Black.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
if tonumber(msg.sender.user_id) ~= tonumber(5421129731) then
JoinChannel = false 
end
end
end 
return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
--
--
if tonumber(msg.sender.user_id) == tonumber(Black) then
print('This is reply for Bot')
return false
end
if data.sender.luatele == "messageSenderChat" then
if Redis:get(Black.."Lock:channell"..msg_chat_id) then
local m = Redis:get(Black.."chadmin"..msg_chat_id) 
if data.sender.chat_id == tonumber(m) then
return false
else
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
return false 
end
Redis:incr(Black..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end

if data.content.text then
text = data.content.text.text
else
text = nil
end

if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 5421129731 then
msg.Name_Controller = 'المبرمج ستيفن '
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 5298947457 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(Black.."Devss:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(Black.."Dev:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(Black.."Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(Black.."Owners:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(Black.."PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(Black.."Supcreator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(Black.."President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(Black.."Creator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(Black.."Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(Black.."Manger:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(Black.."Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(Black.."Admin:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(Black.."Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(Black.."Special:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Black.."Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(Black) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(Black.."Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.Devss = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Dev = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.Supcreatorm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.Supcreator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Creator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Manger = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Admin = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Special = true
end
if Redis:get(Black.."Lock:text"..msg_chat_id) and not msg.Special then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" or msg.content.luatele == "messageChatAddMembers" then
if Redis:get(Black.."Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(Black.."Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return send(msg_chat_id,msg_id,Welcome,"md")  
else
return send(msg_chat_id,msg_id,'↯︙اطلق دصاك ['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')\n↯︙نورت الكروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Special and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(Black) then
return false
end
local floods = Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(Black.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙قام بالتكرار في الكروب وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙قام بالتكرار في الكروب وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙قام بالتكرار في الكروب وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(Black.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(Black.."Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and Redis:sismember("banserver",msg.sender.user_id) then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
if text and Redis:get(Black..'lock:Fshar'..msg.chat_id) and not msg.Special then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and Redis:get(Black..'lock:Fars'..msg.chat_id) and not msg.Special then 
list = {"که","پی","خسته","برم","راحتی","بیام","بپوشم","كرمه","چه","ڬ","ڿ","ڀ","ڎ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and not msg.Special then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(Black.."Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Black.."Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Black.."Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Black.."Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Admin then -- التوجيه
local Fwd_Group = Redis:get(Black.."Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Special then  -- الكيبورد
local Keyboard_Group = Redis:get(Black.."Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then

elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Special then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Special then  -- الماركداون
local Markduan_Gtoup = Redis:get(Black.."Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Special then  -- الالعاب
local Games_Group = Redis:get(Black.."Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(Black.."lockpin"..msg_chat_id)
if Pin_Msg and not msg.Manger then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return send(msg_chat_id,msg_id,"\n↯︙ لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return send(msg_chat_id,msg_id,"\n↯︙ لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return send(msg_chat_id,msg_id,"\n↯︙التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(Black.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(Black.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(Black.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(Black) then
local N = (Redis:get(Black.."Name:Bot") or "بلاك")
photo = LuaTele.getUserProfilePhotos(Black)
local TextBot = '*↯︙ انا بوت اسمي '..N..'\n↯︙ وظيفتي حمايه المجموعة من السبام والتفليش الخ....\n↯︙ لتفعيل البوت قم اضافته للمجموعتك وقم برفعه مشرف واكتب تفعيل\n*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ' تفعيل ', callback_data = msg.sender.user_id..'/onlinebott'..msg_chat_id},
},
{
{text = '- Black TeAm .', url = 't.me/cllllllT'},
}
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape(TextBot).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end


Redis:set(Black.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(Black.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Special then  -- الجهات
local Contact_Group = Redis:get(Black.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Special then  -- بصمه الفيديو
local Videonote_Group = Redis:get(Black.."Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Special then  -- الملفات
local Document_Group = Redis:get(Black.."Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Special then  -- الملفات الصوتيه
local Audio_Group = Redis:get(Black.."Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Special then  -- الفيديو
local Video_Grouo = Redis:get(Black.."Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Special then  -- البصمات
local Voice_Group = Redis:get(Black.."Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Special then  -- الملصقات
local Sticker_Group = Redis:get(Black.."Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Special then  -- انلاين
local Inlen_Group = Redis:get(Black.."Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Special then  -- المتحركات
local Gif_group = Redis:get(Black.."Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Special then  -- الصور
local Photo_Group = Redis:get(Black.."Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end

if msg.content.photo and Redis:get(Black.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(Black.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ لا استطيع تغيير صوره الكروب لاني لست ادمن او ليست لديه الصلاحيه ","md",true)    
end
Redis:del(Black.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير صوره الكروب الكروب الى ","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(Black.."Lock:Link"..msg_chat_id)  
if not msg.Special then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Special then 
local UserName_Group = Redis:get(Black.."Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Special then 
local Hashtak_Group = Redis:get(Black.."Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Special then 
local comd_Group = Redis:get(Black.."Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(Black.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (Redis:get(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(Black.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(Black.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(Black.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(Black.."List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return send(msg_chat_id,msg_id,"\n↯︙ ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(Black.."Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(Black.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"\n↯︙ تم اضافه رد التحذير","md",true)  
end
if text and (Redis:get(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(Black.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(Black.."Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(Black.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(Black.."Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(Black.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(Black.."Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(Black.."List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(Black.."Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم الغاء منع ("..Filters..")","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(Black.."Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Dev then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,msg_id,"*↯︙ لقد تم منع هذه ( "..statusfilter.." ) هنا*\n↯︙"..ReplyFilters,"md",true)   
end
end
if text and Redis:get(Black..msg.chat_id..msg.sender.user_id.."replace") == "true1" then
Redis:del(Black..msg.chat_id..msg.sender.user_id.."replace")
local word = Redis:get(Black..msg.sender.user_id.."word")
Redis:set(Black.."Word:Replace"..word,text)
Redis:sadd(Black..'Words:r',word)  
LuaTele.sendText(msg_chat_id,msg_id,"↯︙ تم حفظ الكلمه","md",true)  
return false 
end
if text and Redis:get(Black..msg.chat_id..msg.sender.user_id.."replace") == "true" then
Redis:set(Black..msg.sender.user_id.."word",text)
Redis:set(Black..msg.chat_id..msg.sender.user_id.."replace","true1")
LuaTele.sendText(msg_chat_id,msg_id,'\n↯︙ ارسل كلمه جديده ليتم استبدالها مكان *'..text..'*',"md",true)  
return false 
end
if text and Redis:get(Black.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(Black.."All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(Black.."All:Get:Reides:Commands:Group"..text)
Redis:del(Black.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Black.."All:Command:List:Group",text)
send(msg_chat_id,msg_id,"↯︙ تم ازالة هاذا ↫ { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"↯︙ لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(Black.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(Black.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(Black.."All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Black.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(Black.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"↯︙ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(Black.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(Black.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Black.."All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(Black.."All:Command:List:Group",text)
Redis:del(Black.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم حفظ الامر باسم ↫ { "..text..' }',"md",true)
end
if text then
if text:match("^all (.*)$") or text:match("^@all (.*)$") or text == "@all" or text == "all" then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(Black.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*↯︙ تم تعطيل @all من قبل المدراء*',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 10000)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
sendText(msg_chat_id,Text,0,'md') 
end 
end 
end 
end
if text and Redis:get(Black.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(Black.."Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Black.."Command:List:Group"..msg_chat_id,text)
send(msg_chat_id,msg_id,"↯︙ تم ازالة هاذا ↫ { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"↯︙ لا يوجد امر بهاذا الاسم","md",true)
end
Redis:del(Black.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(Black.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(Black.."Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Black.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(Black.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"↯︙ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(Black.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(Black.."Command:Reids:Group:New"..msg_chat_id)
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(Black.."Command:List:Group"..msg_chat_id,text)
Redis:del(Black.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم حفظ الامر باسم ↫ { "..text..' }',"md",true)
end
if Redis:get(Black.."Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(Black.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم الغاء حفظ الرابط","md",true)         
end
Redis:set(Black.."Group:Link"..msg_chat_id,text)
Redis:del(Black.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم حفظ الرابط بنجاح","md",true)         
end 
if Redis:get(Black.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Black.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return send(msg_chat_id,msg_id,"↯︙ تم الغاء حفظ الترحيب","md",true)   
end 
Redis:del(Black.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(Black.."Welcome:Group"..msg_chat_id,text) 
return send(msg_chat_id,msg_id,"↯︙ تم حفظ ترحيب الكروب","md",true)     
end
if Redis:get(Black.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Black.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم الغاء حفظ القوانين","md",true)   
end 
Redis:set(Black.."Group:Rules" .. msg_chat_id,text) 
Redis:del(Black.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم حفظ قوانين الكروب","md",true)  
end  
if Redis:get(Black.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Black.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم الغاء حفظ وصف الكروب","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(Black.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم حفظ وصف الكروب","md",true)  
end  
if Redis:get(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(Black.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Black.."Add:Rd:Manager:Text"..test..msg_chat_id, text)  
elseif msg.content.sticker then   
Redis:set(Black.."Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Black.."Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(Black.."Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Audioc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Black.."Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(Black.."Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(Black.."Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(Black.."Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Videoc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Black.."Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
Redis:set(Black.."Add:Rd:Manager:Photoc"..test..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"↯︙ تم حفظ الرد","md",true)  
return false  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(Black.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(Black.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Black.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(Black.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:sadd(Black.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ↯︙
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end

if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(Black.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Black.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(Black.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Black.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"↯︙ تم حذف الرد من الردود ","md",true)  
return false
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= Black then
local test = Redis:get(Black.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Black.."Add:Rd:Sudo:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(Black.."Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Black.."Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(Black.."Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(Black.."Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:Rd:Sudo:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Black.."Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(Black.."Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
Redis:set(Black.."Add:Rd:Sudo:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(Black.."Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Black.."Add:Rd:Sudo:Photo"..test, idPhoto)  
Redis:set(Black.."Add:Rd:Sudo:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"↯︙ تم حفظ الرد \n↯︙ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(Black.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(Black.."List:Rd:Sudo", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ↯︙
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:Audioc","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Videoc","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Photoc","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(Black..''..v..text)
end
Redis:del(Black.."Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Black.."List:Rd:Sudo", text)
return send(msg_chat_id,msg_id,"↯︙ تم حذف الرد من الردود العامه","md",true)  
end
end
if text and not Redis:get(Black.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(Black..'Spam:Group'..msg.sender.user_id,text) then
local anemi = Redis:get(Black.."Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(Black.."Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(Black.."Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(Black.."Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(Black.."Add:Rd:Sudo:Photo"..text)
local photoc = Redis:get(Black.."Add:Rd:Sudo:Photoc"..text)
local video = Redis:get(Black.."Add:Rd:Sudo:Video"..text)
local videoc = Redis:get(Black.."Add:Rd:Sudo:Videoc"..text)
local document = Redis:get(Black.."Add:Rd:Sudo:File"..text)
local audio = Redis:get(Black.."Add:Rd:Sudo:Audio"..text)
local audioc = Redis:get(Black.."Add:Rd:Sudo:Audioc"..text)
local video_note = Redis:get(Black.."Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
if text and not Redis:get(Black.."Status:Reply"..msg_chat_id) then
local anemi = Redis:get(Black.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(Black.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(Black.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(Black.."Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(Black.."Add:Rd:Manager:Photo"..text..msg_chat_id)
local photoc = Redis:get(Black.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
local video = Redis:get(Black.."Add:Rd:Manager:Video"..text..msg_chat_id)
local videoc = Redis:get(Black.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
local document = Redis:get(Black.."Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(Black.."Add:Rd:Manager:Audio"..text..msg_chat_id)
local audioc = Redis:get(Black.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
local video_note = Redis:get(Black.."Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
end
end

if Redis:get(Black..'Set:array'..msg.sender.user_id..':'..msg_chat_id) == 'true1' then
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
local test = Redis:get(Black..'Text:array'..msg.sender.user_id..':'..msg_chat_id..'')
Redis:sadd(Black.."Add:Rd:array:Text"..test,text)  
_key = {
{{text="اضغط هنا لانهاء الاضافه",callback_data="EndAddarray"..msg.sender.user_id}},
}
send_inlin_key(msg_chat_id,' * ↯︙ تم حفظ الرد يمكنك ارسال اخر او اكمال العمليه من خلال الزر اسفل *',_key,msg_id)
return false  
end
if text then
if Redis:get(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'dttd' then
Redis:del(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
gery = Redis:get(Black.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(Black.."Add:Rd:array:Text"..gery,text) then
send(msg_chat_id, msg_id,' * ↯︙ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:srem(Black.."Add:Rd:array:Text"..gery,text)
send(msg_chat_id, msg_id,' * ↯︙ تم حذفه بنجاح .* ',"md",true)
end
end
if text then
if Redis:get(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(Black..'List:array',text) then
send(msg_chat_id, msg_id,' * ↯︙ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:set(Black.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id,text)
Redis:set(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"dttd")
send(msg_chat_id, msg_id,' * ↯︙ قم بارسال الرد الذي تريد حذفه منه* ',"md",true)
return false
end
end
if text == "حذف رد من متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"↯︙ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(Black.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if Redis:get(Black.."Set:array"..msg.sender.user_id..":"..msg_chat_id) == 'true' then
Redis:sadd(Black..'List:array', text)
Redis:set(Black..'Text:array'..msg.sender.user_id..':'..msg_chat_id, text)
send(msg_chat_id, msg_id,'ارسل الرد الذي تريد اضافته',"md",true)
Redis:del(Black.."Set:array"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(Black..'Set:array'..msg.sender.user_id..':'..msg_chat_id,'true1')
Redis:del(Black.."Add:Rd:array:Text"..text)   
return false
end
end

if text then
if Redis:get(Black.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(Black.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:del(Black.."Add:Rd:array:Text"..text)
Redis:srem(Black..'List:array', text)
send(msg_chat_id, msg_id,' * ↯︙ تم ازالة الرد المتعدد بنجاح* ',"md",true)
return false
end
end


if Redis:get(Black.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(Black.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(Black.."PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(Black.."PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(Black.."PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(Black.."PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(Black.."PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(Black.."PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(Black.."PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(Black.."PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
Redis:set(Black.."PinMsegees:"..v,text)
end
end
send(msg_chat_id,msg_id,"↯︙ تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(Black.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(Black.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء الاذاعه بالتوجيه للخاص","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Black.."Num:User:Pv") 
send(msg_chat_id,msg_id,"↯︙ تم التوجيه الى *- "..#list.." * مشترك ف البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Black.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(Black.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء الاذاعه للخاص","md",true)  
end 
local list = Redis:smembers(Black.."Num:User:Pv") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0,text,"html",true)  
end
end
send(msg_chat_id,msg_id,"↯︙ تمت الاذاعه الى *- "..#list.." * عضو في البوت ","md",true)      
Redis:del(Black.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(Black.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(Black.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0, text,"html",true)  
end
end
send(msg_chat_id,msg_id,"↯︙ تمت الاذاعه الى *- "..#list.." * كروب في البوت ","md",true)      
Redis:del(Black.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end

------------------------------------------------------------------------------------------------------------
if text and Redis:get(Black.."chmembers") == "on" then
if ChannelJoin(msg) == false then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local n = UserInfo.first_name
local d = UserInfo.id
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
send(msg.chat_id,0,'↯︙ عذا يا ['..n..']('..d..') \n↯︙ عليك الاشتراك في قناه البوت للتمكن من التحدث هنا\n',"md",false, false, false, false, reply_markup)
return false 
end 
end
if Redis:get(Black.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Black.."ChekBotAdd")   
send(msg_chat_id,msg_id,"↯︙ تم التوجيه الى *- "..#list.." * كروب في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Black.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(Black..'GetTexting:DevBlack'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == '٠ الغاء الامر ٠' then 
Redis:del(Black..'GetTexting:DevBlack'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'↯︙ تم الغاء حفظ كليشة المطور')
end
Redis:set(Black..'Texting:DevBlack',text)
Redis:del(Black..'GetTexting:DevBlack'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'↯︙ تم حفظ كليشة المطور')
end
if Redis:get(Black.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n↯︙ تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(Black.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(Black.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(Black.."Set:Id:Groups",text:match("(.*)"))
send(msg_chat_id,msg_id,'↯︙ تم تعين الايدي عام',"md",true)  
end
if Redis:get(Black.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n↯︙ تم الغاء امر تعين الايدي","md",true)  
Redis:del(Black.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(Black.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(Black.."Set:Id:Group"..msg.chat_id,text:match("(.*)"))
send(msg_chat_id,msg_id,'↯︙ تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(Black.."Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Change:Name:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء امر تغيير اسم البوت","md",true)  
end 
Redis:del(Black.."Change:Name:Bot"..msg.sender.user_id) 
Redis:set(Black.."Name:Bot",text) 
return send(msg_chat_id,msg_id, "↯︙ تم تغيير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(Black.."Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."Change:Start:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء امر تغيير كليشه start","md",true)  
end 
Redis:del(Black.."Change:Start:Bot"..msg.sender.user_id) 
Redis:set(Black.."Start:Bot",text) 
return send(msg_chat_id,msg_id, "↯︙ تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(Black.."Game:Smile"..msg.chat_id) then
if text == Redis:get(Black.."Game:Smile"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:Smile"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(Black.."mshaher"..msg.chat_id) then
if text == Redis:get(Black.."mshaher"..msg.chat_id) then
Redis:del(Black.."mshaher"..msg.chat_id)
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - بوب او مشاهير","md",true)  
end
end 
if Redis:get(Black.."Game:Monotonous"..msg.chat_id) then
if text == Redis:get(Black.."Game:Monotonous"..msg.chat_id) then
Redis:del(Black.."Game:Monotonous"..msg.chat_id)
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(Black.."Game:Riddles"..msg.chat_id) then
if text == Redis:get(Black.."Game:Riddles"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:Riddles"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(Black.."Game:Meaningof"..msg.chat_id) then
if text == Redis:get(Black.."Game:Meaningof"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:Meaningof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(Black.."Game:enkliz"..msg.chat_id) then
if text == Redis:get(Black.."Game:enkliz"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:enkliz"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - انجليزي","md",true)  
end
end
if Redis:get(Black.."Game:Countrygof"..msg.chat_id) then
if text == Redis:get(Black.."Game:Countrygof"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:Countrygof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - اعلام","md",true)  
end
end
if Redis:get(Black.."Game:Reflection"..msg.chat_id) then
if text == Redis:get(Black.."Game:Reflection"..msg.chat_id) then
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Black.."Game:Reflection"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(Black.."Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return send(msg_chat_id,msg_id,"↯︙ عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(Black.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(Black.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Black.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return send(msg_chat_id,msg_id,"↯︙ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(Black.."SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(Black.."SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(Black.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Black.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ اوبس لقد خسرت في اللعبه \n↯︙ حظآ اوفر في المره القادمه \n↯︙ كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return send(msg_chat_id,msg_id,"↯︙ اوبس تخمينك غلط \n↯︙ ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(Black.."Game:Difference"..msg.chat_id) then
if text == Redis:get(Black.."Game:Difference"..msg.chat_id) then 
Redis:del(Black.."Game:Difference"..msg.chat_id)
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(Black.."Game:Example"..msg.chat_id) then
if text == Redis:get(Black.."Game:Example"..msg.chat_id) then 
Redis:del(Black.."Game:Example"..msg.chat_id)
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n↯︙ لقد فزت في اللعبه \n↯︙ العب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(Black.."All:Get:Reides:Commands:Group"..text) or Redis:get(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if Redis:get(Black.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(Black.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = msg.sender.user_id..'/setallmember'}, {text = '2', data = msg.sender.user_id..'/setforcmd'}, 
},
}
}
send(msg_chat_id,msg_id,'↯︙ تم حفظ القناه \n↯︙ اختار كيف تريد تفعيله \n↯︙ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n↯︙ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n',"md",false, false, false, false, reply_markup)
Redis:del(Black.."chfalse")
Redis:set(Black.."chfalse",ch)
Redis:del(Black.."ch:admin")
Redis:set(Black.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'↯︙ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if Redis:get(Black.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(Black.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
send(msg_chat_id,msg_id,'↯︙ تم حفظ القناه ',"md",true)  
Redis:del(Black.."chfalse")
Redis:set(Black.."chfalse",ch)
Redis:del(Black.."ch:admin")
Redis:set(Black.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'↯︙ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if text == "تفعيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(Black.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'↯︙ ارسل الان معرف القناه ',"md",true)  
end
if text == "تعطيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:del(Black.."ch:admin")
Redis:del(Black.."chfalse")
send(msg_chat_id,msg_id,'↯︙ تم حذف القناه ',"md",true)  
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return send(msg_chat_id,msg_id,'↯︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open("./"..UserBot..".json","r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Black) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'↯︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
send(msg_chat_id,msg_id,'↯︙جاري استرجاع المشتركين والكروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(Black..'Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(Black.."ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(Black.."Supcreator:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(Black.."Creator:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(Black.."Manger:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(Black.."Admin:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(Black.."Special:Group"..GroupId,v)
end
end 
end
return send(msg_chat_id,msg_id,'↯︙ تم استرجاع {'..X..'} كروب \n↯︙واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(Black) then 
return send(msg_chat_id,msg_id,'↯︙ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(Black.."ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(Black.."Creator:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(Black.."Manger:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(Black.."Admin:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(Black.."Supcreator:Group"..idg,idASAS)
end;end
end
return send(msg_chat_id,msg_id,'↯︙ تم استرجاع المجموعات من نسخه تشاكي')
else
return send(msg_chat_id,msg_id,'↯︙الملف لا يدعم هاذا البوت')
end
end
end

if text == '٠ تعطيل الاذاعه ٠' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."SendBcBot") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الاذاعه ","md",true)
end
if text == '٠ تفعيل الاذاعه ٠' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."SendBcBot",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == '٠ تعطيل المغادره ٠' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."LeftBot") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل المغادره ","md",true)
end
if text == '٠ تفعيل المغادره ٠' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."LeftBot",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(Black.."AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == '٠ الغاء الامر ٠' then   
Redis:del(Black.."AddSudosNew"..msg_chat_id)
return send(msg_chat_id,msg_id, "\n↯︙ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(Black.."AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
send(msg_chat_id,msg_id,"\n↯︙ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
dofile('Black.lua')  
end
end
if text == 'تغيير المطور الاساسي' or text == '٠ تغيير المطور الاساسي ٠' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(Black.."AddSudosNew"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"↯︙ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == "٠ الكـروبات ٠" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
local G = "كروبات البوت :\n"
local list = Redis:smembers(Black..'ChekBotAdd')  
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local Info_Chats = LuaTele.getSupergroupFullInfo(v)
if Info_Chats and Info_Chats.invite_link then
link = Info_Chats.invite_link.invite_link
else
link = "لا يوجد" 
end
if Get_Chat and Get_Chat.title then
title = Get_Chat.title
else 
title = "لا يوجد" 
end
G = G.."اسم الكروب : "..title.."\n ايدي الكروب : "..v.."\nرابط الكروب : "..link.."\n\n"
end
local File = io.open('./'..UserBot..'.txt', "w")
File:write(G)
File:close()
LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.txt', '↯︙ تم جلب الكروبات\n', 'md')
end
if text == '٠ جلب النسخه الاحتياطيه ٠' or text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(Black..'ChekBotAdd')  
local UsersBot = Redis:smembers(Black..'Num:User:Pv')  
local Get_Json = '{"BotId": '..Black..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(Black.."Supcreator:Group"..v)
local Constructor = Redis:smembers(Black.."Creator:Group"..v)
local Manager = Redis:smembers(Black.."Manger:Group"..v)
local Admin = Redis:smembers(Black.."Admin:Group"..v)
local Vips = Redis:smembers(Black.."Special:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"UI_zc"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*↯︙ تم جلب النسخه الاحتياطيه\n↯︙تحتوي على {'..#Groups..'} كروب \n↯︙وتحتوي على {'..#UsersBot..'} مشترك *\n', 'md')
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*↯︙ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*↯︙عدد احصائيات البوت الكامله \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n↯︙عدد المجموعات : '..(Redis:scard(Black..'ChekBotAdd') or 0)..'\n↯︙عدد المشتركين : '..(Redis:scard(Black..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تفعيل' and msg.Dev then
if Redis:sismember(Black..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*↯︙ عذرا هذا الكروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Black.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Black..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'↯︙عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(Black..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تفعيلها مسبقا *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
UserInfo.first_name = Name_User
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n↯︙ تم تفعيل كروب جديده \n↯︙من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n↯︙معلومات الكروب :\n↯︙عدد الاعضاء : '..Info_Chats.member_count..'\n↯︙عدد الادمنيه : '..Info_Chats.administrator_count..'\n↯︙عدد المطرودين : '..Info_Chats.banned_count..'\n↯︙ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(Black.."ChekBotAdd",msg_chat_id)
Redis:set(Black.."Status:Id"..msg_chat_id,true) ;Redis:del(Black.."Status:Reply"..msg_chat_id) ;Redis:del(Black.."Status:ReplySudo"..msg_chat_id) ;Redis:set(Black.."Status:BanId"..msg_chat_id,true) ;Redis:set(Black.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تفعيل الكروب *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Dev then
if Redis:sismember(Black..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*↯︙ عذرا هذا الكروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرا انته لست ادمن او مالك الكروب *","md",true)  
end
if not Redis:get(Black.."BotFree") then
return send(msg_chat_id,msg_id,"\n*↯︙الوضع الخدمي تم تعطيله من قبل مطور البوت *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Black.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Black..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'↯︙عدد الاعضاء قليل لا يمكن تفعيل الكروب  يجب ان يكوم اكثر من :'..Redis:get(Black..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تفعيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الكروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n↯︙ تم تفعيل كروب جديده \n↯︙من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n↯︙معلومات الكروب :\n↯︙عدد الاعضاء : '..Info_Chats.member_count..'\n↯︙عدد الادمنيه : '..Info_Chats.administrator_count..'\n↯︙عدد المطرودين : '..Info_Chats.banned_count..'\n↯︙ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
Redis:sadd(Black.."ChekBotAdd",msg_chat_id)
Redis:set(Black.."Status:Id"..msg_chat_id,true) ;Redis:del(Black.."Status:Reply"..msg_chat_id) ;Redis:del(Black.."Status:ReplySudo"..msg_chat_id) ;Redis:set(Black.."Status:BanId"..msg_chat_id,true) ;Redis:set(Black.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تفعيل الكروب *','md', true, false, false, false, reply_markup)
end
end

if text == 'تعطيل' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Black.."ChekBotAdd",msg_chat_id) then
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n↯︙ تم تعطيل كروب جديده \n↯︙من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n↯︙معلومات الكروب :\n↯︙عدد الاعضاء : '..Info_Chats.member_count..'\n↯︙عدد الادمنيه : '..Info_Chats.administrator_count..'\n↯︙عدد المطرودين : '..Info_Chats.banned_count..'\n↯︙ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(Black.."ChekBotAdd",msg_chat_id)
return send(msg_chat_id,msg_id,'\n*↯︙الكروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n↯︙ تم تعطيلها بنجاح *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and not Redis:sismember(Black.."ChekBotAdd",msg_chat_id) then
if Redis:sismember(Black..'ban:online',msg.chat_id) then
LuaTele.leaveChat(msg.chat_id)
return false 
end
Redis:sadd(Black.."ChekBotAdd",msg_chat_id)
local list = Redis:smembers(Black.."ChekBotAdd")
send(Sudo_Id,0,"*↯︙ تم تفعيل كروب تلقائيا عن طريق البوت*\n↯︙ اصبح عدد كروباتك *"..#list.."* مجموعه","md",true)
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(Black.."ChekBotAdd",msg_chat_id) then
if text then
local GetMsg = Redis:incr(Black..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
Redis:hset(Black..':GroupUserCountMsg:'..msg.chat_id,msg.sender.user_id,GetMsg)
local UserInfo = LuaTele.getUser(msg.sender.user_id) 
if FlterBio(UserInfo.first_name) then
NameLUser = FlterBio(UserInfo.first_name)
else
NameLUser = FlterBio(UserInfo.first_name)
end
NameLUser = NameLUser
NameLUser = NameLUser:gsub("]","")
NameLUser = NameLUser:gsub("[[]","")
Redis:hset(Black..':GroupNameUser:'..msg.chat_id,msg.sender.user_id,NameLUser)
end



if text == "ترند" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*• هاذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
GroupAllRtba = Redis:hgetall(Black..':GroupUserCountMsg:'..msg.chat_id)
GetAllNames  = Redis:hgetall(Black..':GroupNameUser:'..msg.chat_id)
GroupAllRtbaL = {}
for k,v in pairs(GroupAllRtba) do table.insert(GroupAllRtbaL,{v,k}) end
Count,Kount,i = 8 , 0 , 1
for _ in pairs(GroupAllRtbaL) do Kount = Kount + 1 end
table.sort(GroupAllRtbaL, function(a, b) return tonumber(a[1]) > tonumber(b[1]) end)
if Count >= Kount then Count = Kount end
Text = " الاكثر تفاعلا هو : \n\n"
for k,v in ipairs(GroupAllRtbaL) do
if i <= Count then  Text = Text..i.."ـ ["..(GetAllNames[v[2]] or "خطأ بالأسـم").."](tg://user?id="..v[2]..") ـ> {*"..v[1].."*}  \n" end ; i=i+1
end
return send(msg.chat_id,msg.id,Text,"md")
end
if msg.content.audio then  
if Redis:get(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id) == 'start' then
Redis:set(Black.."audio:Games"..msg.sender.user_id..":"..msg.chat_id,msg.content.audio.audio.remote.id)  
Redis:sadd(Black.."audio:Games:Bot",msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id,'started')
return send(msg.chat_id, msg.id,'• ارسل اسم الموسيقى الان ...')
end   
end

if Redis:get(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id) == 'started' then
Redis:del(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id)
local Id_audio = Redis:get(Black.."audio:Games"..msg.sender.user_id..":"..msg.chat_id)
Redis:set(Black..'Text:Games:audio'..Id_audio,text)
Redis:del(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id)
return send(msg.chat_id, msg.id,'• تم حفظ الصوت ')
end
if text== 'مسح موسيقى' and msg.reply_to_message_id then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)  
Redis:del(Black..'Text:Games:audio'..Message_Reply.content.audio.audio.remote.id)  
Redis:srem(Black.."audio:Games:Bot",Message_Reply.content.audio.audio.remote.id)  
return send(msg.chat_id, msg.id,'• تم مسح الموسيقى ومسح الجواب .')
end


if text== 'اضف موسيقى' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(Black.."Add:audio:Games"..msg.sender.user_id..":"..msg.chat_id,'start')
return send(msg.chat_id, msg.id,'• ارسل الموسيقى الان ...')
end

if text== ("قائمه الموسيقى") then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(Black.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
for k,v in pairs(list) do
LuaTele.sendAudio(msg_chat_id, msg.id,v , '', "md") 
end
end

if text== ("مسح قائمه الموسيقى") then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(Black.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
for k,v in pairs(list) do
Redis:del(Black..'Text:Games:audio'..v)  
Redis:srem(Black.."audio:Games:Bot",v)  
end
return send(msg.chat_id, msg.id, "• تم مسح جميع الاسئله")
end

if text== 'موسيقى' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."audio:Games:Bot")
if #list == 0 then
return send(msg.chat_id, msg.id, "• لا يوجد اسئله")
end
local quschen = list[math.random(#list)]
local GetAnswer = Redis:get(Black..'Text:Games:audio'..quschen)
Redis:set(Black..'Games:Set:Answer'..msg.chat_id,GetAnswer)
LuaTele.sendAudio(msg_chat_id, msg.id,quschen , '', "md") 
return false
end

if text == 'ايدي' or text == 'كشف' then
if msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local U = LuaTele.getUser(UserId)
local Nn = U.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Black.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
send(msg_chat_id,msg_id,
'\n◂ اسمه ↫ '..Nn..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserInfousername..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n.',"md",true) 
end
end
end
if text == "ايدي" or text =='id' or text =='Id' or text == 'ID' then 
if msg.reply_to_message_id == 0 then
if not Redis:get(Black.."Status:Id"..msg_chat_id) then
return false
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Name_User = UserInfo.first_name
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {
  "اوو شنو هل صوره الخرافيه 😯💞 . 🥺♥.!",
  "هاذا وجهك ? . 😂",
  "اطلق صوره عمري 🥺💞 .!",
  "هنا ساسكت قليلا... 🎸♥.!",
  "وجهك هاذا لو كمر  🙈♥.!",
  "هم في الارض وانت بين النجوم 🤍🎀.!",
  "كيك وربي 🙂"
}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
Get_Is_Id = Redis:get(Black.."Set:Id:Groups") or Redis:get(Black.."Set:Id:Group"..msg_chat_id)
if Redis:get(Black.."Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Description..
'\n\n◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n.', "md")
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n.',"md",true) 
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return send(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n.',"md",true) 
end
end
end
end
if text and text:match('^كشف (%d+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Black.."Num:Add:Games"..msg.chat_id..UserId) or 0

if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..FlterBio(getbio(UserId))..'*'..
'\n.',"md",true) 
end
if text and text:match('^كشف (%d+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Black.."Num:Add:Games"..msg.chat_id..UserId) or 0

if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n.',"md",true) 
end
if text then
if text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local U = LuaTele.getUser(UserId_Info.id)
local Name_User = U.first_name 
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Black.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ @['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ البايو ↫ *'..getbio(UserId)..'*'..
'\n.',"md",true) 
end
end
end
if text == 'رتبتي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
return send(msg_chat_id,msg_id,'\n↯︙ رتبتك هي : '..msg.Name_Controller,"md",true)  
end
if text == 'ايديي' then
return LuaTele.sendText(msg_chat_id,msg_id,'\nايديك -› '..msg.sender.user_id,"md",true)  
end
if text == "اسمي"  then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = " "..ban.first_name.." "
else
news = " لا يوجد"
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n↯︙️اسمك الأول : '..ban.first_name,"md",true)
end
if text == "معرفي" or text == "يوزري" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.username then
banusername = '[@'..ban.username..']'
else
banusername = 'لا يوجد'
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n↯︙️معرفك هذا : @'..ban.username,"md",true)
end
if text == 'معلوماتي' or text == 'موقعي' then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك المجموعه'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف المجموعه'
else
StatusMemberChat = 'عظو في المجموعه'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(TheBlack..'Black:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(TheBlack..'Black:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف الكروب' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n↯︙صلاحيات المستخدم :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..'\n↯︙تغيير المعلومات : '..change_info..'\n↯︙تثبيت الرسائل : '..pin_messages..'\n↯︙اضافه مستخدمين : '..invite_users..'\n↯︙مسح الرسائل : '..delete_messages..'\n↯︙حظر المستخدمين : '..restrict_members..'\n↯︙اضافه المشرفين : '..promote..'\n\n*'
end
return send(msg_chat_id,msg_id,
'\n*↯︙ ايديك : '..UserId..
'\n↯︙ معرفك : '..UserInfousername..
'\n↯︙ رتبتك : '..RinkBot..
'\n↯︙ رتبته الكروب: '..StatusMemberChat..
'\n↯︙ رسائلك : '..TotalMsg..
'\n↯︙ تعديلاتك : '..TotalEdit..
'\n↯︙ تفاعلك : '..TotalMsgT..
'\n↯︙ البايو : '..getbio(UserId)..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,Black).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'↯︙ البوت عضو في الكروب ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Black).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n↯︙صلاحيات البوت في الكروب :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..'\n↯︙تغيير المعلومات : '..change_info..'\n↯︙تثبيت الرسائل : '..pin_messages..'\n↯︙اضافه مستخدمين : '..invite_users..'\n↯︙مسح الرسائل : '..delete_messages..'\n↯︙حظر المستخدمين : '..restrict_members..'\n↯︙اضافه المشرفين : '..promote..'\n\n*'
return send(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return send(msg_chat_id,msg_id,'\n*↯︙ العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})

Message = Message - 1048576
end
send(msg_chat_id, msg_id, "↯︙ تم مسح - "..NumMessage.. ' رساله', 'md')
end
if text and text:match("وجد (.*)") then
local v = text:match("وجد (.*)")
local Message = msg.id
local Message = string.find(Message,v)
Message = Message - 1048576
send(msg_chat_id, msg_id,Message , 'md')
end
if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(Black.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(Black.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
----تنزيل تسليه -----
if TextMsg == "صاك" then
if not Redis:sismember(Black.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الصاكين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم تنزيله صاك لانه طلت فلاتر ").Reply,"md",true)  
end
end
if TextMsg == "صاكه" then
if not Redis:sismember(Black.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الصاكات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيلها من الصاكات بعد معرفنا انها فلاتر😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if not Redis:sismember(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المتوحدين بعد ما اتعالج😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if not Redis:sismember(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المتوحدين بعد ما اتعالج😂?? ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if not Redis:sismember(Black.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙الكلب دا بطل هوهوه ونزلناه  🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الكلاب خليه يرجع العضمه😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if not Redis:sismember(Black.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙الحمار دا عقل من زمان   🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الحمير تعال نفك الكارو منك😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "نبي" then
if not Redis:sismember(Black.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙بطل يمشي ورا الحريم 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من الانبياء لانه لا يمتلك معجزات ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if not Redis:sismember(Black.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙بطل يطنط علي شجر 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من قايمه القرود تعال نزلو من الشجره😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "دوده" then
if not Redis:sismember(Black.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙اعقل بقا 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم تنزيله من قائمه الدود لانه بعد ما يحشر نفسه ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if not Redis:sismember(Black.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙يارب تعقل وتبقا ذكي 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(Black.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙خير اهو شغل مخك اهو نزلناك من الاغبياء🌚 ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(Black.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Black.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(Black.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالمعرف---
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(Black.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالرد
if TextMsg == "صاك" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم رفعه صاك بالكروب ").Reply,"md",true)  
else
Redis:sadd(Black.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تتم رفعه صاك في المجموعه   ").Reply,"md",true)  
end
end
if TextMsg == "صاكه" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙دي اجمد بنوته هنا ف القايمة من بدري يباشه 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه صاكت الكروب  ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم رفعه متوحده تخبل بالكروب ").Reply,"md",true)  
else
Redis:sadd(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه متوحد في المجموعه معتزل معليه بقيه الناس  ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم رفعه متوحده تخبل بالكروب ").Reply,"md",true)  
else
Redis:sadd(Black.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه متوحد في المجموعه معتزل معليه بقيه الناس  ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙دا مولود كده ومحطوط عندنا من زمان بيشمشم علي اي بنت 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه كلب خليه يجي ياخد عضمه😂  ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙نزلناه من زمان وفكينا الكارو 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه حمار خليه يجي نسلمه عربانه   ").Reply,"md",true)  
end
end
if TextMsg == "نبي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙نزلناه من زمان واخد كورسات رجوله 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم رفعه نبي لهدايه الناس الضاله عن طريق الله  ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙نزلناه من زمان من ع الشجره 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه قرد في الكروب تعال اخذ موزه  ").Reply,"md",true)  
end
end
if TextMsg == "دوده" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙محد محترمه كده كده  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙تم رفعه دوده بالكروب لانه يحشر نفسه باشياء متخصه  ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙هو كده كده محطوط ف قايمة الاغبية  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(Black.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم رفعه غبي المجموعة  😂  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Black.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(Black.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Black.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"↯︙ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
---تسليه بالايدي
if text and text:match("^تغيير رد المطور (.*)$") then
local Teext = text:match("^تغيير رد المطور (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(Black.."Developer:Bot:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المطور الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
Redis:set(Black.."President:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
Redis:set(Black.."Constructor:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغيير رد المالك (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك (.*)$") 
Redis:set(Black.."PresidentQ:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المالك الى :"..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المدير (.*)$") 
Redis:set(Black.."Manager:Group:Reply"..msg.chat_id,Teext) 
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المدير الى :"..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد الادمن (.*)$") 
Redis:set(Black.."Admin:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد الادمن الى :"..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المميز (.*)$") 
Redis:set(Black.."Vip:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد المميز الى :"..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد العضو (.*)$") 
Redis:set(Black.."Mempar:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Developer:Bot:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."President:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."PresidentQ:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Constructor:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Manager:Group:Reply"..msg.chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Admin:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Vip:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Mempar:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"↯︙ تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه مطورين الثانويين \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين الثانويين', data = msg.sender.user_id..'/Devss'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
local datar = {data = {{text = "مسح المطورين" , data = msg.sender.user_id..'/Dev'}}}
for i = 1,#Info_Members do
infoo = LuaTele.getUser(Info_Members[i])
datar[i] = {{text = infoo.first_name , data =msg.sender.user_id..'/deldev/'..Info_Members[i]}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
LuaTele.sendText(msg.chat_id,msg.id,'↯︙↯︙ قائمه مطورين البوت',"md",false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Owners:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مالكين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المالكين \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المالكين', data = msg.sender.user_id..'/Owners'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المنشئين الاساسيين \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين الاساسيين', data = msg.sender.user_id..'/Supcreator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المنشئين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين', data = msg.sender.user_id..'/Creator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المدراء  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المدراء', data = msg.sender.user_id..'/Manger'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الادمنيه  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الادمنيه', data = msg.sender.user_id..'/Admin'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المميزين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المميزين', data = msg.sender.user_id..'/DelSpecial'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'الصاكين' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد صاكين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الصاكين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الصاكين', data = msg.sender.user_id..'/Delkholat'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الصاكات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد وتكات ناشفة زي المستشفي , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الصاكات  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الصاكات', data = msg.sender.user_id..'/Delwtk'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المتوحدين' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش متوحدين هنا كلهم اتعالجو 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المتوحدين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المتوحدين', data = msg.sender.user_id..'/Deltwhd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الكلاب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش كلاب هنا ارفعلنل شويه نضيهم عضم ??😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الكلاب  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الكلاب', data = msg.sender.user_id..'/Delklb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحمير' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش حمير هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الحمير  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحمير', data = msg.sender.user_id..'/Delmar'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الدود' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش عرر هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الدود  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الدود', data = msg.sender.user_id..'/Del3ra'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الانبياء' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش نبياويه هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الانبياء  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الانبياء', data = msg.sender.user_id..'/Delsmb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'القرود' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش قرود هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه القرود  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح القرود', data = msg.sender.user_id..'/Del2rd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاغبياء' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙مفيش اغبيه هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه الاغبيه  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاغبياء', data = msg.sender.user_id..'/Del8by'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المحظورين عام  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."ktmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مكتومين عام حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المكتومين عام  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين عام', data = msg.sender.user_id..'/ktmAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المحظورين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المكتومين  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'تفعيل التاكات' or text == 'تفعيل التاك التلقائي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(Black.."Black:Tagat"..msg.chat_id,true) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"*᥀︙تم تفعيل التاك التلقائي *").unLock,"md",true)
end
if text == 'تعطيل التاك التلقائي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."Black:Tagat"..msg.chat_id) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"*᥀︙تم تعطيل التاك التلقائي *").unLock,"md",true)  
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(Black.."Status:Link"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(Black.."Status:Welcome"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:Id"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:IdPhoto"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:Reply"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:ReplySudo"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:BanId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(Black.."Status:Games"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:set(Black.."Status:joinet"..msg_chat_id,true) 
    return send(msg_chat_id,msg_id,"↯︙ تم تفعيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:set(Black.."Status:KickMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(Black.."Status:remMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."BotFree",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(Black.."Status:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(Black.."Status:Welcome"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:Id"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:IdPhoto"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:Reply"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Status:ReplySudo"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:BanId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Status:SetId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(Black.."Status:Games"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:del(Black.."Status:joinet"..msg_chat_id) 
    return send(msg_chat_id,msg_id,"↯︙ تم تعطيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:del(Black.."Status:KickMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:del(Black.."Status:remMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."BotFree") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."TwaslBot") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Black.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Black.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Black.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Black.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم حظره من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(Black.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تقييده في الكروب \n↯︙ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تقييده في الكروب \n↯︙ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId[3]).." } *","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n↯︙ تم تقييده في الكروب \n↯︙ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم طرده من الكروب ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(Black.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Black.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(Black.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم العام') or text == "الغاء كتم عام" and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Black.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم حظره من الكروب ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(Black.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تقييده في الكروب ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم طرده من الكروب ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if UserId == "5421129731" then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على المبرمج ستيفن *","md",true)  
end
if UserId == "5298947457" then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على مطور السورس*","md",true)  
end
if Redis:sismember(Black.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Black.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if UserId == "5421129731" then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على المبرمج ستيفن *","md",true)  
end
if UserId == "5298947457" then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على مطور السورس *","md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(Black.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Black.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end 
if text then
if text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم حظره من الكروب ").Reply,"md",true)  
end
end
end
if text then
if text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Black.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء حظره من الكروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Black.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء حظره من الكروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم كتمه في الكروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Black.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم كتمه في الكروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Black.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
else
Redis:srem(Black.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء كتمه من الكروب ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم تقييده في الكروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم الغاء تقييده من الكروب").Reply,"md",true)  
end

if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(Black.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"↯︙ تم طرده من الكروب ").Reply,"md",true)  
end
end
if text == "نزلني" then
if not Redis:get(Black.."Status:remMe"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*↯︙ امر نزلني تم تعطيله من قبل المدراء *","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(Black.."Devss:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(Black.."Dev:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(Black.."Owners:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(Black.."Supcreator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(Black.."Creator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(Black.."Manger:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(Black.."Admin:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(Black.."Special:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return send(msg_chat_id,msg_id,"\n*↯︙ليس لديك رتب عزيزي *","md",true)  
end
if Rink <= 7  then
return send(msg_chat_id,msg_id,"↯︙استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(Black.."Admin:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, msg.sender.user_id)
return send(msg_chat_id,msg_id,"↯︙ تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == 'اطردني' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اصغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if text == 'ادمنيه الكروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*↯︙ قائمه الادمنيه \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @"..UserInfo.username.."* "..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
send(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Black.."Supcreator:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Black.."Admin:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
send(msg_chat_id,msg_id,'\n*↯︙ تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end

if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*↯︙️︙عذرآ البوت ليس ادمن في المجموعه يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = ''..Redis:get(itsEssen..'Essen:Channel:Join:Name')..'', url = 't.me/'..Redis:get(itsEssen..'Essen:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n↯︙️عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*↯︙️︙اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos(UserInfo.id)
local InfoUser = LuaTele.getUserFullInfo(UserInfo.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
if photo.total_count > 0 then
local TestText = "  ❲ Owner Groups ❳\n— — — — — — — — —\n↯︙*Owner Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n↯︙️*Owner Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ Black TeAm ❳', url = "https://t.me/cllllllT"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else

local TestText = "- معلومات المالك : \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end


if text == 'كشف البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n*↯︙ قائمه البوتات \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..UserInfo.username.."* "..Admin.."\n"
end
send(msg_chat_id,msg_id,listBots.."*\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n↯︙عدد البوتات التي هي ادمن ( "..x.." )*","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n*↯︙ قائمه المقيديين \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted.."*"..x.." - @"..UserInfo.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
send(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "غادر" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."LeftBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,"*\n↯︙ تم مغادرة الكروب بامر من المطور *","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == 'تاك للكل' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*↯︙ قائمه الاعضاء \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall.."*"..k.." - @"..UserInfo.username.."*\n"
else
listall = listall.."*"..k.." -* ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
send(msg_chat_id,msg_id,listall,"md",true)  
end
if Redis:get(Black.."addchannel"..msg.sender.user_id) == "on" then
if text and text:match("^@[%a%d_]+$") then
local m , res = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if res == 200 then
ch = data.result.id
Redis:set(Black.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"↯︙︙ تم حفظ ايدي القناه","md",true)  
else
send(msg_chat_id,msg_id,"↯︙︙ المعرف خطأ","md",true)  
end
elseif text and text:match('^-100(%d+)$') then
ch = text
Redis:set(Black.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"↯︙︙ تم حفظ ايدي القناه","md",true)  
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"↯︙︙ الايدي خطأ","md",true)  
end
Redis:del(Black.."addchannel"..msg.sender.user_id)
end
if text == "القناه المضافه" then
if Redis:get(Black.."chadmin"..msg_chat_id) then
send(msg_chat_id,msg_id,Redis:get(Black.."chadmin"..msg_chat_id),"md",true)  
else 
send(msg_chat_id,msg_id,"↯︙︙ لا توجد قناه ","md",true)  
end 
end
if text == "حذف القناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if Redis:get(Black.."chadmin"..msg_chat_id) then
Redis:del(Black.."chadmin"..msg_chat_id) 
send(msg_chat_id,msg_id,"↯︙︙ تم حذف القناه بنجاح","md",true)  
else 
send(msg_chat_id,msg_id,"↯︙︙ لا توجد قناه ","md",true)  
end 
end
if text == "اضف قناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black.."addchannel"..msg.sender.user_id,"on") 
send(msg_chat_id,msg_id,"↯︙︙ ارسل يوزر او ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:channell"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙︙ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:text"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:AddMempar"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:Join"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل دصاك الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:Bot:kick"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:Bot:kick"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Black.."Lock:tagservr"..msg_chat_id,true)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Black.."lockalllll"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Black.."lockalllll"..msg_chat_id,"on")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Black.."lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Black.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Black.."Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Black..''..lock..msg_chat_id,"del")    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:AddMempar"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:channell"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:hset(Black.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
send(msg_chat_id,msg_id,'\n*↯︙ تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:text"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:Join"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح دصاك الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(Black.."Lock:tagservr"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."lockpin"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Black.."Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Black..''..lock..msg_chat_id)    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Black.."Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Black.."Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Black.."Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Black.."Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(Black.."Spam:Group:User"..msg_chat_id ,"Spam:User")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Link"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Link"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Link"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Link"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Link"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الروابط").unLock,"md",true)  
return false
end 

if text == "قفل المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:User:Name"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:User:Name"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:User:Name"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:User:Name"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:User:Name"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:hashtak"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:hashtak"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:hashtak"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:hashtak"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:hashtak"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Cmd"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Cmd"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Cmd"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Cmd"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Cmd"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == 'قفل السب'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black..'lock:Fshar'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل السب").Lock,"md",true)  
end
if text == 'قفل الفارسيه'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black..'lock:Fars'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الفارسيه").Lock,"md",true)  
end
if text == 'فتح السب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black..'lock:Fshar'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح السب").unLock,"md",true)  
end
if text == 'فتح الفارسيه' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black..'lock:Fars'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الفارسيه").unLock,"md",true)  
end
if text == "قفل الصور"then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Photo"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Photo"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Photo"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Photo"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Photo"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Video"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Video"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Video"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Video"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Video"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Animation"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Animation"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Animation"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Animation"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Animation"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:geam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:geam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:geam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:geam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:geam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Audio"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Audio"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Audio"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Audio"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Audio"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:vico"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:vico"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:vico"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:vico"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:vico"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Keyboard"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Keyboard"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Keyboard"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Keyboard"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Keyboard"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Sticker"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Sticker"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Sticker"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Sticker"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Sticker"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:forward"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:forward"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:forward"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:forward"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:forward"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Document"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Document"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Document"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Document"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Document"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Unsupported"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Unsupported"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Unsupported"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Unsupported"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Unsupported"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Markdaun"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Markdaun"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Markdaun"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Markdaun"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Markdaun"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Contact"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Contact"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Contact"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Contact"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Contact"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Spam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Spam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Spam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Spam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Spam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Inlen"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Inlen"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Inlen"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Lock:Inlen"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Lock:Inlen"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"↯︙ تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return send(msg_chat_id,msg_id,"٭ ارسل رابط الكروب او رابط قناة الكروب","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Group:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not Redis:get(Black.."Status:Link"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(Black.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "↯︙Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return send(msg_chat_id,msg_id,"↯︙ لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return send(msg_chat_id, msg_id, "↯︙Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return send(msg_chat_id,msg_id,"↯︙ ارسل لي الترحيب الان".."\n↯︙تستطيع اضافة مايلي !\n↯︙دالة عرض الاسم ↫{`name`}\n↯︙دالة عرض المعرف ↫{`user`}\n↯︙دالة عرض اسم الكروب ↫{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(Black.."Status:Welcome"..msg_chat_id) then
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(Black.."Welcome:Group"..msg_chat_id)
if Welcome then 
return send(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return send(msg_chat_id,msg_id,"↯︙ لم يتم تعيين ترحيب للكروب","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Welcome:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم ازالة ترحيب الكروب","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Group:Rules"..msg_chat_id) 
return send(msg_chat_id,msg_id,"↯︙ تم ازالة قوانين الكروب","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(Black.."Group:Rules" .. msg_chat_id)   
if Rules then     
return send(msg_chat_id,msg_id,Rules,"md",true)     
else      
return send(msg_chat_id,msg_id,"↯︙ لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(Black.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل لي وصف الكروب الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return send(msg_chat_id,msg_id,"↯︙ تم ازالة قوانين الكروب","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return send(msg_chat_id,msg_id,"↯︙ تم تغيير اسم الكروب الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(Black.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*↯︙ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(Black.."Filter:Group:"..v..msg_chat_id)  
Redis:srem(Black.."List:Filter"..msg_chat_id,v)  
end  
return send(msg_chat_id,msg_id,"*↯︙ تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*↯︙ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n*↯︙ قائمه المنع \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(Black.."Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." ↫ { "..Text_Filter.." }*\n"    
end  
send(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return send(msg_chat_id,msg_id,'\n*↯︙ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return send(msg_chat_id,msg_id,'\n*↯︙ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"↯︙الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(Black.."All:Get:Reides:Commands:Group"..v)
Redis:del(Black.."All:Command:List:Group")
end
return send(msg_chat_id,msg_id,"↯︙ تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."All:Command:List:Group")
Command = "↯︙ قائمه الاوامر المضافه العامه  \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
Commands = Redis:get(Black.."All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ↫ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "↯︙ لا توجد اوامر اضافيه عامه"
end
return send(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"↯︙الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(Black.."Command:List:Group"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"↯︙ تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."Command:List:Group"..msg_chat_id.."")
Command = "↯︙ قائمه الاوامر المضافه  \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
Commands = Redis:get(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ↫ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "↯︙ لا توجد اوامر اضافيه"
end
return send(msg_chat_id,msg_id,Command,"html",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n↯︙ تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n↯︙ تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n↯︙ تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, '↯︙اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(Black.."Status:Link"..msg.chat_id) then
Statuslink = '❬ ✔️ ❭' else Statuslink = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:Welcome"..msg.chat_id) then
StatusWelcome = '❬ ✔️ ❭' else StatusWelcome = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:Id"..msg.chat_id) then
StatusId = '❬ ✔️ ❭' else StatusId = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '❬ ✔️ ❭' else StatusIdPhoto = '❬ ❌ ❭'
end
if not Redis:get(Black.."Status:Reply"..msg.chat_id) then
StatusReply = '❬ ✔️ ❭' else StatusReply = '❬ ❌ ❭'
end
if not Redis:get(Black.."Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '❬ ✔️ ❭' else StatusReplySudo = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:BanId"..msg.chat_id)  then
StatusBanId = '❬ ✔️ ❭' else StatusBanId = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:SetId"..msg.chat_id) then
StatusSetId = '❬ ✔️ ❭' else StatusSetId = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:Games"..msg.chat_id) then
StatusGames = '❬ ✔️ ❭' else StatusGames = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:KickMe"..msg.chat_id) then
Statuskickme = '❬ ✔️ ❭' else Statuskickme = '❬ ❌ ❭'
end
if Redis:get(Black.."Status:AddMe"..msg.chat_id) then
StatusAddme = '❬ ✔️ ❭' else StatusAddme = '❬ ❌ ❭'
end
local protectionGroup = '\n*↯︙اعدادات حمايه الكروب\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
..'\n↯︙جلب الرابط ➤ '..Statuslink
..'\n↯︙جلب الترحيب ➤ '..StatusWelcome
..'\n↯︙الايدي ➤ '..StatusId
..'\n↯︙الايدي بالصوره ➤ '..StatusIdPhoto
..'\n↯︙الردود ➤ '..StatusReply
..'\n↯︙الردود العامه ➤ '..StatusReplySudo
..'\n↯︙الرفع ➤ '..StatusSetId
..'\n↯︙الحظر - الطرد ➤ '..StatusBanId
..'\n↯︙الالعاب ➤ '..StatusGames
..'\n↯︙ امر اطردني ➤ '..Statuskickme..'*\n\n.'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n↯︙اعدادات الكروب ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n🔓︙علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'الكروب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local permissions = '*\n↯︙صلاحيات الكروب :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..'\n↯︙ارسال الويب : '..web..'\n↯︙تغيير معلومات الكروب : '..info..'\n↯︙اضافه مستخدمين : '..invite..'\n↯︙تثبيت الرسائل : '..pin..'\n↯︙ارسال الميديا : '..media..'\n↯︙ارسال الرسائل : '..messges..'\n↯︙اضافه البوتات : '..other..'\n↯︙ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n↯︙معلومات الكروب :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..' \n↯︙عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n↯︙عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n↯︙عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n↯︙عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n↯︙اسم الكروب : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return send(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات الكروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات الكروب : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, "↯︙الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(Black.."Dev:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Black.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Black..'Creator:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Black..'Manger:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Black..'Admin:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Black..'Special:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(Black.."Dev:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(Black.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(Black.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(Black.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return send(msg_chat_id,msg_id,"\n*↯︙ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Dev:Groups",Message_Reply.sender.user_id)
Redis:srem(Black.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return send(msg_chat_id,msg_id,"\n*↯︙ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(Black.."Dev:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Black.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Black..'Creator:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Black..'Manger:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Black..'Admin:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Black..'Special:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(Black.."Dev:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(Black.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(Black.."Creator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(Black.."Manger:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(Black.."Admin:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(Black.."Special:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return send(msg_chat_id,msg_id,"\n*↯︙ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Dev:Groups",UserId_Info.id)
Redis:srem(Black.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Black.."Special:Group"..msg_chat_id, UserId_Info.id)
end
return send(msg_chat_id,msg_id,"\n*↯︙ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..Message_Reply.sender.user_id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..UserId_Info.id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
end 
if text == 'لقبي'  then
Ge = https.request("https://api.telegram.org/bot".. Token.."/getChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..msg.sender.user_id)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg_chat_id,msg_id,'*↯︙ ليس لديك لقب*',"md",true) 
else
send(msg_chat_id,msg_id,'↯︙ لقبك هو : '..GeId.result.custom_title,"md",true) 
end
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return send(msg_chat_id, msg_id, "↯︙صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})

if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return send(msg_chat_id, msg_id, "↯︙صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*↯︙لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*↯︙لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*↯︙ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"↯︙ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(Black..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'↯︙ تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح تعديلاتي' or text == 'مسح تعديلاتي' then
Redis:del(Black..'Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'↯︙ تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(Black..'Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'↯︙ تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
send(msg_chat_id,msg_id,'↯︙عدد رسائلك هنا *~ '..(Redis:get(Black..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'تعديلاتي' or text == 'تعديلاتي' then
send(msg_chat_id,msg_id,'↯︙عدد التعديلات هنا *~ '..(Redis:get(Black..'Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
send(msg_chat_id,msg_id,'↯︙عدد جهاتك المضافه هنا *~ '..(Redis:get(Black.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Admin then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
↯︙ ارسل الان النص
↯︙يمكنك اضافه :
↯︙`#username` ↫ اسم المستخدم
↯︙`#msgs` ↫ عدد الرسائل
↯︙`#photos` ↫ عدد الصور
↯︙`#id` ↫ ايدي المستخدم
↯︙`#auto` ↫ نسبة التفاعل
↯︙`#stast` ↫ رتبة المستخدم 
↯︙`#edit` ↫ عدد التعديلات
↯︙`#game` ↫ عدد النقاط
↯︙`#AddMem` ↫ عدد الجهات
↯︙`#Description` ↫ تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Set:Id:Groups")
return send(msg_chat_id,msg_id, '↯︙ تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
↯︙ ارسل الان النص
↯︙يمكنك اضافه :
↯︙`#username` ↫ اسم المستخدم
↯︙`#msgs` ↫ عدد الرسائل
↯︙`#photos` ↫ عدد الصور
↯︙`#id` ↫ ايدي المستخدم
↯︙`#auto` ↫ نسبة التفاعل
↯︙`#stast` ↫ رتبة المستخدم 
↯︙`#edit` ↫ عدد التعديلات
↯︙`#game` ↫ عدد النقاط
↯︙`#AddMem` ↫ عدد الجهات
↯︙`#Description` ↫ تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Set:Id:Group"..msg.chat_id)
return send(msg_chat_id,msg_id, '↯︙ تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
Redis:del(Black.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Black.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
Redis:del(Black.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مالكين حاليا , ","md",true)  
end
Redis:del(Black.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المالكين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد منشئين حاليا , ","md",true)  
end
Redis:del(Black.."Creator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مدراء حاليا , ","md",true)  
end
Redis:del(Black.."Manger:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد ادمنيه حاليا , ","md",true)  
end
Redis:del(Black.."Admin:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مميزين حاليا , ","md",true)  
end
Redis:del(Black.."Special:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المميزين *","md",true)
end
----تسلية----
if TextMsg == 'الكلاب' then
local Info_Members = Redis:smembers(Black.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد كلاب حاليا , ","md",true)  
end
Redis:del(Black.."klb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الكلاب *","md",true)
end
if TextMsg == 'الصاكين' then
local Info_Members = Redis:smembers(Black.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد صاكين حاليا , ","md",true)  
end
Redis:del(Black.."kholat:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الصاكين *","md",true)
end
if TextMsg == 'القرود' then
local Info_Members = Redis:smembers(Black.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد قرود حاليا , ","md",true)  
end
Redis:del(Black.."2rd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من القرود *","md",true)
end
if TextMsg == 'الاغبياء' then
local Info_Members = Redis:smembers(Black.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد اغبية حاليا , ","md",true)  
end
Redis:del(Black.."8by:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الاغبيه *","md",true)
end
if TextMsg == 'الدود' then
local Info_Members = Redis:smembers(Black.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد عرر حاليا , ","md",true)  
end
Redis:del(Black.."3ra:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الدود *","md",true)
end
if TextMsg == 'الانبياء' then
local Info_Members = Redis:smembers(Black.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد نبياويه حاليا , ","md",true)  
end
Redis:del(Black.."smb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الانبياءاويه *","md",true)
end
if TextMsg == 'الحمير' then
local Info_Members = Redis:smembers(Black.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد حمير حاليا , ","md",true)  
end
Redis:del(Black.."mar:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الحمير *","md",true)
end
if TextMsg == 'المتوحدين' then
local Info_Members = Redis:smembers(Black.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد متوحدين حاليا , ","md",true)  
end
Redis:del(Black.."twhd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المتوحدين *","md",true)
end
if TextMsg == 'الصاكات' then
local Info_Members = Redis:smembers(Black.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد وتكات حاليا , ","md",true)  
end
Redis:del(Black.."wtka:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من الصاكات *","md",true)
end
----تسلية----
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(Black.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مكتومين عام حاليا , ","md",true)  
end
Redis:del(Black.."ktmAll:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المكتومين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين حاليا , ","md",true)  
end
Redis:del(Black.."BanGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المحظورين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مكتومين حاليا , ","md",true)  
end
Redis:del(Black.."SilentGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..x.."} من المقيديين *","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*↯︙عدد البوتات الموجوده : "..#List_Members.."\n↯︙ تم طرد ( "..x.." ) بوت من الكروب *","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*↯︙عدد المطرودين في الكروب : "..#List_Members.."\n↯︙ تم الغاء الحظر عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*↯︙ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return send(msg_chat_id,msg_id,"\n*↯︙ تم طرد ( "..x.." ) حساب محذوف *","md",true)  
end
end


if text == "اضف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
if text == ("مسح الردود") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(Black.."Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(Black.."Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(Black.."Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Photoc"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Videoc"..v..msg_chat_id)  
Redis:del(Black.."Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(Black.."Add:Rd:Manager:Audioc"..v..msg_chat_id)
Redis:del(Black.."List:Manager"..msg_chat_id.."")
end
return send(msg_chat_id,msg_id,"↯︙ تم مسح قائمه الردود","md",true)  
end

-- sex
if text == ("مسح الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(Black.."List:Manager:inline"..msg_chat_id.."")
  for k,v in pairs(list) do
      Redis:del(Black.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id)   
      Redis:del(Black.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id)   
      Redis:del(Black.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id)     
      Redis:del(Black.."Add:Rd:Manager:Text:inline"..v..msg_chat_id)   
      Redis:del(Black.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:Photoc:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:Video:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:Videoc:inline"..v..msg_chat_id)  
      Redis:del(Black.."Add:Rd:Manager:File:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id)
      Redis:del(Black.."Add:Rd:Manager:Audioc:inline"..v..msg_chat_id)
      Redis:del(Black.."Rd:Manager:inline:v"..v..msg_chat_id)
      Redis:del(Black.."Rd:Manager:inline:link"..v..msg_chat_id)
  Redis:del(Black.."List:Manager:inline"..msg_chat_id)
  end
  return send(msg_chat_id,msg_id,"↯︙ تم مسح قائمه الانلاين","md",true)  
  end
if text == "اضف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
    Redis:set(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(Black) then
  if Redis:get(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(Black.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id, text)
  Redis:del(Black.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(Black.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(Black.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(Black.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(Black.."Rd:Manager:inline:link"..text..msg_chat_id)
  Redis:sadd(Black.."List:Manager:inline"..msg_chat_id.."", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ↯︙
  ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
  Redis:del(Black.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(Black.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(Black.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(Black.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(Black.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(Black.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(Black.."Rd:Manager:inline:link"..text..msg_chat_id)
Redis:del(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(Black.."List:Manager:inline"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"↯︙ تم حذف الرد من الردود الانلاين ","md",true)  
return false
end
end
if Redis:get(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(Black) then
Redis:del(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(Black.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Black.."Add:Rd:Manager:Text:inline"..anubis..msg_chat_id, text)
elseif msg.content.sticker then   
Redis:set(Black.."Add:Rd:Manager:Stekrs:inline"..anubis..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Black.."Add:Rd:Manager:Vico:inline"..anubis..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(Black.."Add:Rd:Manager:Audio:inline"..anubis..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Audioc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Black.."Add:Rd:Manager:File:inline"..anubis..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(Black.."Add:Rd:Manager:Gif:inline"..anubis..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(Black.."Add:Rd:Manager:video_note:inline"..anubis..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(Black.."Add:Rd:Manager:Video:inline"..anubis..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Videoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Black.."Add:Rd:Manager:Photo:inline"..anubis..msg_chat_id, idPhoto)  
Redis:set(Black.."Add:Rd:Manager:Photoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"↯︙ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end
if text and Redis:get(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(Black.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(Black.."Rd:Manager:inline:text"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"↯︙ الان ارسل الرابط","md",true)  
return false  
end
if text and Redis:get(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(Black.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(Black.."Rd:Manager:inline:link"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"↯︙ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and not Redis:get(Black.."Status:Reply:inline"..msg_chat_id) then
local btext = Redis:get(Black.."Rd:Manager:inline:text"..text..msg_chat_id)
local blink = Redis:get(Black.."Rd:Manager:inline:link"..text..msg_chat_id)
local anemi = Redis:get(Black.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
local veico = Redis:get(Black.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
local stekr = Redis:get(Black.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
local Texingt = Redis:get(Black.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
local photo = Redis:get(Black.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
local photoc = Redis:get(Black.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
local video = Redis:get(Black.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
local videoc = Redis:get(Black.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
local document = Redis:get(Black.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
local audio = Redis:get(Black.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
local audioc = Redis:get(Black.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
local video_note = Redis:get(Black.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(Black.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 

if text == ("الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(Black.."List:Manager:inline"..msg_chat_id.."")
  text = "↯︙ قائمه الردود الانلاين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
  for k,v in pairs(list) do
  if Redis:get(Black.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id) then
  db = "متحركه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id) then
  db = "بصمه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id) then
  db = "ملصق ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Text:inline"..v..msg_chat_id) then
  db = "رساله ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id) then
  db = "صوره ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Video:inline"..v..msg_chat_id) then
  db = "فيديو ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:File:inline"..v..msg_chat_id) then
  db = "ملف ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id) then
  db = "اغنيه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id) then
  db = "بصمه فيديو ↯︙"
  end
  text = text..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
  end
  if #list == 0 then
  text = "↯︙ عذرا لا يوجد ردود انلاين في الكروب"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
-- zwag 
if text == "زواج" or text == "رفع زوجتي" or text == "رفع زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتزوج نفسك ؟ هتتكاثر ازاي طيب ؟!!","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
    return send(msg_chat_id,msg_id,"↯︙لا تستطيع الزواج من البوت","md",true)  
  end
  if Redis:sismember(Black..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    local rd_mtzwga = {
      "للاسف متزوجه",
      "ابتعد عنه هاي متزوجه ليجي حبيبه يشكك",
      "هاي متزوجه شلون تريد تزوجها ?",
      "شوف غيره هاي متزوجه ما تفيدك",
      "للاسف طلعت متزوجه "
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
    else
      local rd_zwag = {
        "الف مبروك تم الزواج سمعونه هلهوله",
        "تم الزواج بنجاح الف مبروك منك المال ومنها العيال",
        "مبروك تزوجتو يلا سوو عشاء و اعزمو كل الكروب",
        "تم زواجكم..وهاذا رقمي خاف العريس ميدبره 0780505..",
        "الزواج تم سمعونه معزوفه"
      }
    if Redis:sismember(Black..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
    Redis:srem(Black..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
    end
    Redis:sadd(Black..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
    end
end
if text == "تاك للزوجات" or text == "الزوجات" then
  local zwgat_list = Redis:smembers(Black..msg_chat_id.."zwgat:")
  if #zwgat_list == 0 then 
    return send(msg_chat_id,msg_id,'↯︙ لايوجد زوجات',"md",true) 
  end 
  local zwga_list = "↯︙ عدد الزوجات : "..#zwgat_list.."\n↯︙ الزوجات :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
  for k, v in pairs(zwgat_list) do
    local UserInfo = LuaTele.getUser(v)
    local zwga_name = UserInfo.first_name
    local zwga_tag = '['..zwga_name..'](tg://user?id='..v..')'
    zwga_list = zwga_list.."- "..zwga_tag.."\n"
  end
  return send(msg_chat_id,msg_id,zwga_list,"md",true) 
end
-- tlaq
if text == "طلاق" or text == "تنزيل زوجتي" or text == "تزيل زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"↯︙️لا يمكنك الطلاق من نفسك","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
    return send(msg_chat_id,msg_id,"هو احنا كنا اتجوزنا يروح خالتك عشان نطلق","md",true)  
  end
  if Redis:sismember(Black..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    Redis:srem(Black..msg_chat_id.."zwgat:",Message_Reply.sender.user_id)
    Redis:sadd(Black..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
    local rd_tmtlaq = {
"تم طلاقكم للاسف",
      "تم الطلاقكم بنجاح ام عباس خوش تشتغل",
      "تم طلاقكم بنجاح هوا انتو مال نعمه",
      "تم الطلاق لان دخلت وحده حلوا سطرته ",
      "تم الطلاق وهاذا رقمي خابريني خاف تشعرين بالوحده او الاكتئاب..."
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
    else
      local rd_tlaq = {
"انته تضل مهان شوكت تزوجت حتى تريد تطلك حيوان",
        "بايره محد يتزوجها",
        "اسكت محد معبرها قبل "
      }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
    end
end
if text == "تاك للمطلقات" or text == "المطلقات" then
  local mutlqat_list = Redis:smembers(Black..msg_chat_id.."mutlqat:")
  if #mutlqat_list == 0 then 
    return send(msg_chat_id,msg_id,'↯︙ لايوجد مطلقات',"md",true) 
  end 
  local mutlqa_list = "↯︙ عدد المطلقات : "..#mutlqat_list.."\n↯︙ المطلقات :\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
  for k, v in pairs(mutlqat_list) do
    local UserInfo = LuaTele.getUser(v)
    local mutlqa_name = UserInfo.first_name
    local mutlqa_tag = '['..mutlqa_name..'](tg://user?id='..v..')'
    mutlqa_list = mutlqa_list.."- "..mutlqa_tag.."\n"
  end
  return send(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end
-- kit defullt
if text == "استيراد كت السورس" then
if Redis:get(Black.."kit_defullt:") == "true" then
    Redis:set(Black.."kit_defullt:","false")
    local d_kit = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس بلاك؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس بلاك؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"شنو رايك في سورس بلاك؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"شنو رايك بالدنيا هاي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هيه امنيتك ? ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
for i = 1, #d_kit, 1 do
    Redis:sadd(Black.."kit:", d_kit[i])
end
return send(msg_chat_id,msg_id,"↯︙ تم استرداد "..#d_kit.." سؤال بنجاح","md",false, false, false, false, reply_markup)
end
if Redis:get(Black.."kit_defullt:") == "false" then
    return send(msg_chat_id,msg_id,"↯︙ تم استيرادها من قبل","md",false, false, false, false, reply_markup)
end
end
--kit add
if text == "اضف كت" then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id,true)
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"↯︙ ارسل الان السؤال ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "true" then
        Redis:del(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:sadd(Black.."kit:", text)
        return send(msg_chat_id,msg_id,"↯︙ تم حفظ السؤال","md",false, false, false, false, reply_markup)
    end
    if text == "كت" then
        local list = Redis:smembers(Black.."kit:")
        randk = list[math.random(#list)]
        send(msg_chat_id, msg_id,'['..randk..']',"md",true)
        end
-- kit no.
if text == 'قائمه الكت' then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(Black.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(Black.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"↯︙ لا يوجد اسأله, ","md",true)  
    end
    if #kit_list > 50 then
    local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            {{text = '- التالي', data = msg.sender.user_id..'/next/31'}}
        }
        }
        
    return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
    end
    if #kit_list <= 50 then
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
        for i = 1, #kit_list, 1 do
            Listkit = Listkit.." - "..kit_list[i].."\n"
        end
        local reply_markup = LuaTele.replyMarkup{
            type = 'inline',
            data = {
                {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            }
            }
            
        return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
        end
end
-- kit Next
if Text and Text:match('(.*)/next/(.*)') then
    local m = {Text:match('(.*)/next/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num + 30
    local kit_list = Redis:smembers(Black.."kit:")
    local Residual = #kit_list - num
    if tonumber(IdUser) == tonumber(UserId) and Residual > 30 then
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = num, anubis, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual < 30 then
        local kit_end = num + Residual
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = num, kit_end, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
           
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit last back
if Text and Text:match('(.*)/l_back/(.*)') then
    local m = {Text:match('(.*)/l_back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(Black.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = back_r, Residual, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..Residual}},
                    }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
end
-- kit back
if Text and Text:match('(.*)/back/(.*)') then
    local m = {Text:match('(.*)/back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(Black.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = anubis, num, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual == #kit_list then
        local kit_end = num + Residual
        local Listkit = '\n↯︙ قائمه الاسأله  \n↯︙ عدد الاسأله : '..#kit_list..'\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/31'}}
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit rm
if text == "حذف كت" then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id, "rmkit")
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"↯︙ ارسل السؤال الذي تريد حذفه الان. ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "rmkit" then
        Redis:del(Black.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:srem(Black.."kit:", text)
        return send(msg_chat_id,msg_id,"↯︙ تم حذف السؤال","md",false, false, false, false, reply_markup)
    end
-- kit rm all
if text == 'مسح قائمه الكت' then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(Black.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(Black.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"↯︙ لا يوجد اسأله عشان امسحها يهبل","md",true)  
    end
    Redis:del(Black.."kit:")
    Redis:set(Black.."kit_defullt:","true")
    return send(msg_chat_id,msg_id,"↯︙ تم مسح جميع الاسأله بنجاح","md",true)
end
--by anubis
if text == "حذف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
Redis:set(Black.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"↯︙ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(Black.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if  Redis:sismember(Black..'List:array',text) then
local list = Redis:smembers(Black.."Add:Rd:array:Text"..text)
quschen = list[math.random(#list)]
send(msg_chat_id, msg_id,'['..quschen..']',"md",true)
end
end
if text == ("الردود المتعدده") then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(Black..'List:array')
text = "  ↯︙ قائمه الردود المتعدده \n•━━━━ Black ━━━━━•\n"
for k,v in pairs(list) do
text = text..""..k..">> ("..v..") ↫ {رساله}\n"
end
if #list == 0 then
text = "  ↯︙ لا يوجد ردود متعدده"
end
send(msg_chat_id, msg_id,'['..text..']',"md",true)
end
if text == ("مسح الردود المتعدده") then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(Black..'List:array')
for k,v in pairs(list) do
Redis:del(Black.."Add:Rd:array:Text"..v..msg_chat_id)   
Redis:del(Black..'List:array'..msg_chat_id)
end
send(msg_chat_id, msg_id," * ↯︙ تم مسح الردود المتعدده*","md",true)
end
if text == "اضف رد متعدد" then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"↯︙ ارسل الكلمه التي تريد اضافتها",inlin,msg_id)
Redis:set(Black.."Set:array"..msg.sender.user_id..":"..msg_chat_id,true)
return false
end

if text == "اضف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود العامه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود العامه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(Black.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(Black.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Black.."Add:Rd:Sudo:Gif"..v)
Redis:del(Black.."Add:Rd:Sudo:vico"..v)
Redis:del(Black.."Add:Rd:Sudo:stekr"..v)
Redis:del(Black.."Add:Rd:Sudo:Text"..v)
Redis:del(Black.."Add:Rd:Sudo:Photo"..v)
Redis:del(Black.."Add:Rd:Sudo:Photoc"..v)
Redis:del(Black.."Add:Rd:Sudo:Video"..v)
Redis:del(Black.."Add:Rd:Sudo:Videoc"..v)
Redis:del(Black.."Add:Rd:Sudo:File"..v)
Redis:del(Black.."Add:Rd:Sudo:Audio"..v)
Redis:del(Black.."Add:Rd:Sudo:Audioc"..v)
Redis:del(Black.."Add:Rd:Sudo:video_note"..v)
Redis:del(Black.."List:Rd:Sudo")
end
send(msg_chat_id,msg_id,"↯︙ تم مسح قائمه الردود العامه","md",true)  
end
if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo")
text = "\n↯︙ قائمة الردود العامه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if Redis:get(Black.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Text"..v) then
db = "رساله ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:File"..v) then
db = "ملف ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ↯︙"
end
text = text..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
end
if #list == 0 then
text = "↯︙ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"↯︙ ارسل لي التوجيه الان\n↯︙ليتم نشره في المجموعات","md",true)  
return false
end

if text=="اذاعه خاص بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Black.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*↯︙ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"↯︙ ارسل لي التوجيه الان\n↯︙ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*↯︙ معلومات الكشف \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..'\n↯︙الحظر العام : '..BanAll..'\n↯︙الحظر : '..BanGroup..'\n↯︙الكتم : '..SilentGroup..'\n↯︙التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*↯︙معلومات الكشف \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..'\n↯︙الحظر العام : '..BanAll..'\n↯︙الحظر : '..BanGroup..'\n↯︙الكتم : '..SilentGroup..'\n↯︙التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Black.."BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Black.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Black.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*↯︙ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ البوت ليس ادمن في الكروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Black.."BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Black.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Black.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*↯︙ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'GetTexting:DevBlack'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'↯︙ ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black..'Texting:DevBlack')
return send(msg_chat_id,msg_id,'↯︙ تم حذف كليشه المطور')
end
if text == 'مبرمج سورس' or text == 'مبرمج السورس' or text == 'المبرمج' then  
local UserId_Info = LuaTele.searchPublicChat("UI_zc")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ Black TeAm 𝖲𝗈𝗎𝗋𝖼𝖾 ❳\n— — — — — — — — —\n↯︙*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n↯︙️*Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ Black TeAm ❳', url = "https://t.me/cllllllT"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات مبرمج السورس : \\nn: name Dev . ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝖼𝗈𝖽𝖾𝗋 ❳', url = "https://t.me/UI_zc"}
},
{
{text = '❲ Black TeAm ❳', url = "https://t.me/cllllllT"},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'المطور' or text == 'مطور' then   
local UserInfo = LuaTele.getUser(Sudo_Id) 
local InfoUser = LuaTele.getUserFullInfo(Sudo_Id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n— — — — — — — — —\n↯︙*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n↯︙️*Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ Black TeAm ❳', url = "https://t.me/cllllllT"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers Source ❳\n— — — — — — — — —\n↯︙*Dev Name* :  ["..UserInfo.first_name.."](tg://user?id="..Sudo_Id..")\n↯︙️*Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
---زخرفة ----
if text == "زخرفه" then
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '٠ زخرفة انكليزية ٠', data = msg.sender.user_id..'/zeng'},
    },
    {
      {text = '٠ زخرفة عربية ٠', data = msg.sender.user_id..'/zar'},
      },
    }
    }
  return send(msg_chat_id,msg_id, "مرحبا بك في زخرفه بلاكر","md",false,false,false,false,reply_markup)
end
-- z eng
if text and text:match("%a") and Redis:get(Black..msg_chat_id..msg.sender.user_id.."zkrf:") == "zeng" then
  Redis:del(Black..msg_chat_id..msg.sender.user_id.."zkrf:")
  Redis:set(Black..msg_chat_id..msg.sender.user_id.."zkrf:text", text)
  local api = https.request("https://lmasat.tk/zkhr/apik.php?text="..URL.escape(text))
  local zkrf = JSON.decode(api)
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
      {{text = zkrf['anubis']['1'] , data = msg.sender.user_id..'/a1'}},
      {{text = zkrf['anubis']['2'] , data = msg.sender.user_id..'/a2'}},
      {{text = zkrf['anubis']['3'] , data = msg.sender.user_id..'/a3'}},
      {{text = zkrf['anubis']['4'] , data = msg.sender.user_id..'/a4'}},
      {{text = zkrf['anubis']['5'] , data = msg.sender.user_id..'/a5'}},
      {{text = zkrf['anubis']['6'] , data = msg.sender.user_id..'/a6'}},
      {{text = zkrf['anubis']['7'] , data = msg.sender.user_id..'/a7'}},
      {{text = zkrf['anubis']['8'] , data = msg.sender.user_id..'/a8'}},
      {{text = zkrf['anubis']['9'] , data = msg.sender.user_id..'/a9'}},
      {{text = zkrf['anubis']['10'] , data = msg.sender.user_id..'/a10'}},
      {{text = zkrf['anubis']['11'] , data = msg.sender.user_id..'/a11'}},
      {{text = zkrf['anubis']['12'] , data = msg.sender.user_id..'/a12'}},
      {{text = zkrf['anubis']['13'] , data = msg.sender.user_id..'/a13'}},
      {{text = zkrf['anubis']['14'] , data = msg.sender.user_id..'/a14'}},
      {{text = zkrf['anubis']['15'] , data = msg.sender.user_id..'/a15'}},
      {{text = zkrf['anubis']['16'] , data = msg.sender.user_id..'/a16'}},
      {{text = zkrf['anubis']['17'] , data = msg.sender.user_id..'/a17'}},
      {{text = zkrf['anubis']['18'] , data = msg.sender.user_id..'/a18'}},
      {{text = zkrf['anubis']['19'] , data = msg.sender.user_id..'/a19'}},
    }
    }
    return send(msg_chat_id,msg_id, "★ اختࢪ الزخࢪفھـۃ التي تࢪيدها\n ▽","html",false,false,false,false,reply_markup)
end
-- z ar 
if text and not text:match("%a") and Redis:get(Black..msg_chat_id..msg.sender.user_id.."zkrf:") == "zar" then
  Redis:del(Black..msg_chat_id..msg.sender.user_id.."zkrf:")
  Redis:set(Black..msg_chat_id..msg.sender.user_id.."zkrf:text", text)
  local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(text))
  local zkrf = JSON.decode(api)
  local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
      {{text = zkrf['anubis']['1'] , data = msg.sender.user_id..'/a1'}},
      {{text = zkrf['anubis']['2'] , data = msg.sender.user_id..'/a2'}},
      {{text = zkrf['anubis']['3'] , data = msg.sender.user_id..'/a3'}},
      {{text = zkrf['anubis']['4'] , data = msg.sender.user_id..'/a4'}},
      {{text = zkrf['anubis']['5'] , data = msg.sender.user_id..'/a5'}},
      {{text = zkrf['anubis']['6'] , data = msg.sender.user_id..'/a6'}},
      {{text = zkrf['anubis']['7'] , data = msg.sender.user_id..'/a7'}},
      {{text = zkrf['anubis']['8'] , data = msg.sender.user_id..'/a8'}},
      {{text = zkrf['anubis']['9'] , data = msg.sender.user_id..'/a9'}},
      {{text = zkrf['anubis']['10'] , data = msg.sender.user_id..'/a10'}},
      {{text = zkrf['anubis']['11'] , data = msg.sender.user_id..'/a11'}},
    }
    }
    return send(msg_chat_id,msg_id, "★ اختࢪ الزخࢪفھـۃ التي تࢪيدها\n ▽","html",false,false,false,false,reply_markup)
end
-----معاني-الاسماء---
if text and text:match("^معنى (.*)$") then
local TextName = text:match("^معنى (.*)$")
as = http.request('https://api-jack.ml/api5.php?name='..URL.escape(TextName)..'')
mn = JSON.decode(as)
k = mn.meaning
send(msg_chat_id,msg_id,k,"md",true) 
end
---العمر---
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://boyka-api.ml/Calculateage.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg_chat_id,msg_id,t,"md",true) 
end 

if text == 'ستيفن' or text == 'صاحب السورس'  then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' (Source Dev)', url = 't.me/UI_zc'}, 
},
}
}
return send(msg_chat_id,msg_id,"[(Source Dev)](tg://user?id=5421129731)","md",true, false, false, true, reply_markup)
end

if text == 'قناه السورس' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' ( Source channel )', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,"[~ Welcome to Source Black team ](tg://user?id=5298947457)","md",true, false, false, true, reply_markup)
end

if text == "تفعيل صورتي" or text == "تفعيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black.."myphoto"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*↯︙ تم تفعيل امر صورتي * ',"md",true)  
end
if text == "تعطيل صورتي" or text == "تعطيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black.."myphoto"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*↯︙ تم امر امر صورتي * ',"md",true)  
end
if text == 'رابط الحذف' or text == 'رابط حذف' then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(TheDrox..'Drox:Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n↯︙️عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'Telegram', url = 'https://my.telegram.org/auth?to=delete'},{text = 'Instagram', url = 'https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/'}
},
{
{text = 'Facebook', url = 'https://www.facebook.com/help/deleteaccount'},{text = 'Snapchat', url = 'https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount'}
},
{
{text = '- Black TeAm ٠', url = 't.me/cllllllT'}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id,'*↯︙️رابط الحذف في جميع مواقع التواصل*',"md",false, false, false, false, reply_markup)
end
if text == "تفعيل نسبه جمالي" or text == "تفعيل جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black.."mybuti"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*↯︙ تم تفعيل امر جمالي * ',"md",true)  
end
if text == "تعطيل جمالي" or text == "تعطيل نسبه جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black.."mybuti"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*↯︙ تم امر امر جمالي * ',"md",true)  
end
if TextMsg == 'كول' then
Redis:set(TheDarKet.."DarKet:Status:kool"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"᥀︙ تم تفعيل امر كول ","md",true)
end
if text == "تعطيل قول" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(Black.."sayy"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*↯︙ تم امر امر قول * ',"md",true)  
end
if text == "جمالي" or text == 'نسبه جمالي' then
if Redis:get(Black.."mybuti"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*↯︙ نسبه جمالي معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if msg.Dev then
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي 900% لان مطور ولازم اتلوكلك 😹♥*", "md")
else
return send(msg_chat_id,msg_id,'*↯︙ لا توجد صوره ف حسابك*',"md",true) 
end
else
if photo.total_count > 0 then
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي "..rdbhoto.."% 🙄♥*", "md")
else
return send(msg_chat_id,msg_id,'*↯︙ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
end
if text and text:match("^قول (.*)$")then
local m = text:match("^قول (.*)$")
if Redis:get(Black.."sayy"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*↯︙ امر قول معطل*',"md",true) 
else
return send(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "صورتي" then
if Redis:get(Black.."myphoto"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*↯︙ الصوره معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=msg.sender.user_id.."/sorty2"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape("٭ عدد صورك هو "..photo.total_count.." صوره").."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*عدد صورك هو "..photo.total_count.." صوره*", "md")
else
return send(msg_chat_id,msg_id,'*↯︙ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if text == "غنيلي" then
Abs = math.random(2,140); 
local Text ='*↯︙️تم اختيار الاغنيه لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ': مره اخرى 🔃.', callback_data = IdUser..'/Re@'},
},
{
{text = '- Black TeAm ٠',url="t.me/cllllllT"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/TEAMSUL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text and text:match("(.*)(منو ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"↯︙ انت منشئ المجموعه","md",true) 
end
local Added_Me = Redis:get(Black.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = '↯︙ الشخص الذي قام باضافتك هو ↫ '..Name
return send(msg_chat_id,msg_id,Text,"md",true) 
else
return send(msg_chat_id,msg_id,"انت دخلت عبر الرابط محد ضافك","md",true) 
end
end
if text == "نبذتي" or text == "البايو" then
return send(msg_chat_id,msg_id,getbio(msg.sender.user_id),"md",true) 
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.photo then
if Message_Reply.content.photo.sizes[1].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[1].photo.remote.id
elseif Message_Reply.content.photo.sizes[2].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[2].photo.remote.id
elseif Message_Reply.content.photo.sizes[3].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[3].photo.remote.id
end
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..idPhoto)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'photo.png') 
LuaTele.sendSticker(msg_chat_id, msg.id,'./photo.png')
os.remove('photo.png')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.voice_note then 
local mr = result.content.voice_note.voice.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'voice.mp3') 
LuaTele.sendAudio(msg_chat_id, msg.id,'./voice.mp3', '↯︙ تم تحويل البصمه الي صوت بواسطه @'..UserBot..'', 'html',nil,"audio")
sleep(3)
os.remove('voice.mp3')
end
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.audio then 
local mr = result.content.audio.audio.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'audio.ogg') 
LuaTele.sendVoiceNote(msg_chat_id, msg.id,'./audio.ogg', '↯︙ تم تحويل الصوت الي بصمه بواسطه @'..UserBot..'', 'html')
sleep(3)
os.remove('audio.ogg')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.sticker then 
local mr = result.content.sticker.sticker.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'stick.jpg') 
LuaTele.sendPhoto(msg.chat_id, msg.id, './stick.jpg',"↯︙ تم تحويل الملصق الي صوره بواسطه @"..UserBot.."","html")
os.remove('stick.jpg')
end 
end
end
if text == 'وتدتلتزهلنخلزخعلنهل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.voice_note then 
local mr = result.content.voice_note.voice.remote.id
local url = http.request("ht="..Token.."&file_id="..mr)
local json = JSON.decode(url)
if json and json.msg then
return send(msg.chat_id,msg.id,"↯︙ "..json.msg)
else
return send(msg.chat_id,msg.id,"↯︙ تعذر التعرف علي الصوت")
end
end
end
end


if text == "توكن" then
if msg.sender.user_id == tonumber(5421129731) then
send(5421129731,msg_id,Token,"html",true)
end
end
if text == "انا مين" then
if msg.sender.user_id == tonumber(5421129731) then
send(msg_chat_id,msg_id,"↯︙ انت ستيفن مبرمج السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(5298947457) then
send(msg_chat_id,msg_id,"↯︙ انت مطور السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(Sudo_Id) then
send(msg_chat_id,msg_id,"↯︙ انت المطور الاساسي يقلبي🌚♥","md",true)
elseif msg.Devss then
send(msg_chat_id,msg_id,"↯︙ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Dev then
send(msg_chat_id,msg_id,"↯︙ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Owners then
send(msg_chat_id,msg_id,"↯︙ انت مالك الكروب يقلبي🌚♥","md",true)
elseif msg.Supcreator then
send(msg_chat_id,msg_id,"↯︙ انت منشئ اساسي يقلبي🌚♥","md",true)
elseif msg.Creator then
send(msg_chat_id,msg_id,"↯︙ انت هنا منشئ يقلبي🌚♥","md",true)
elseif msg.Manger then
send(msg_chat_id,msg_id,"↯︙ انت هنا مدير يقلبي🌚♥","md",true)
elseif msg.Admin then
send(msg_chat_id,msg_id,"↯︙ انت هنا ادمن يقلبي🌚♥","md",true)
elseif msg.Special then
send(msg_chat_id,msg_id,"↯︙ انت هنا مميز يقلبي🌚♥","md",true)
else 
send(msg_chat_id,msg_id,"↯︙ مجرد عضو هنا","md",true)
end 
end
if text and Redis:get(Black.."toar"..msg.sender.user_id) then
Redis:del(Black.."toar"..msg.sender.user_id)
local json = json:decode(https.request("https://ayad-12.xyz/7oda.php?from=auto&to=ar&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text and Redis:get(Black.."toen"..msg.sender.user_id) then
Redis:del(Black.."toen"..msg.sender.user_id)
local json = json:decode(https.request("https://ayad-12.xyz/7oda.php?from=auto&to=en&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text == 'ترجمه' or text == 'ترجمة' or text == 'ترجم' or text == 'translat' then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = 'ترجمه الي العربية', data = msg.sender.user_id..'toar'},{text = 'ترجمه الي الانجليزية', data = msg.sender.user_id..'toen'}},
{{text = ' - Black TeAm .', url = "https://t.me/cllllllT"}},
}
}
return send(msg_chat_id,msg_id, [[*
• Hey Send Text translate
• ارسل النص لترجمته
*]],"md",false, false, false, false, reply_markup)
end

if msg.content.photo then
if msg.content.caption.text then
if msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") or msg.content.caption.text == "@all" or msg.content.caption.text == "all" then
local ttag = msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(Black.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*↯︙ تم تعطيل @all من قبل المدراء*',"md",true)  
end
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
LuaTele.sendPhoto(msg.chat_id, 0, idPhoto,Text,"md")
end 
end 
end
end
end


if Redis:get(Black.."youtube"..msg.sender.user_id..msg_chat_id) == "mp3" then
Redis:del(Black.."youtube"..msg.sender.user_id..msg_chat_id)
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendmessage?chat_id="..msg_chat_id.."&text="..("٠ جاري التحميل انتضر قليلا ...").."&reply_to_message_id="..rep)).result.message_id
local se = http.request("https://api-jack.ml/api18.php?search="..URL.escape(text))
local j = JSON.decode(se)
local link = j.results[1].url
local title = j.results[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
print(link)
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(msg_chat_id,msg_id,'./'..title..'.mp3',"["..title.."]("..link..")","md",nil,title)
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(Black.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp3")
end
if Redis:get(Black.."youtube"..msg.sender.user_id..msg_chat_id) == "mp4" then
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendmessage?chat_id="..msg_chat_id.."&text="..("٠ جاري التحميل انتضر قليلا ...").."&reply_to_message_id="..rep)).result.message_id
local se = http.request("https://api-jack.ml/api18.php?search="..URL.escape(text))
local j = JSON.decode(se)
local link = j.results[1].url
local title = j.results[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(msg_chat_id,msg_id,'./'..title..'.mp4',"["..title.."]("..link..")","md") 
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(Black.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp4")
end
if text == "يوتيوب" or text == 'The YouTube' or text == 'YouTube' or text == 'The Youtube' or text == 'Youtube' or text == 'youtube' or text == 'You Tube' or text == 'YT' or text == 'Yt' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❬  ملف صوتي  ❭', data = msg.sender.user_id..'/mp3'..msg_id}, {text = '❬  مقطع فيديو  ❭', data = msg.sender.user_id..'/mp4'..msg_id}, 
},
{
{text = '- Black TeAm . ', url = "https://t.me/cllllllT"}
},
}
}
return send(msg_chat_id,msg_id, [[*
↯︙حسنا عزيزي الان اختر صيغة التحميل
*]],"md",false, false, false, false, reply_markup)
end
if text then
if text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$') then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local UserName = text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserInfo = LuaTele.getUser(UserId_Info.id)
local zz = Redis:get(Black.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(Black.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(Black.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(Black.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❬ كتم ❭', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = '❬ تقييد ❭', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = '❬ حظر ❭', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ اختار العقوبه الان ").Reply,"md",true, false, false, true, reply_markup)
end
end 
end
if text == "انذار" or text == "إنذار" then
if msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,UserInfo.id) then
return send(msg_chat_id,msg_id,"\n*↯︙ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserInfo.id).." } *","md",true)  
end
local zz = Redis:get(Black.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(Black.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(Black.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(Black.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '❬ كتم ❭', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = '❬ تقييد ❭', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = '❬ حظر ❭', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"↯︙ اختر العقوبه الان").Reply,"md",true, false, false, true, reply_markup)
end
end
end
if text == "تقطيع" then
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.text then 
local line = result.content.text.text
for t in string.gmatch(line, "[^%s]+") do
send(msg_chat_id,msg_id,t,"md",true)  
end 
end
end
end


if text == 'اطردني' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اصغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if msg.content.photo or msg.content.animation or msg.content.sticker or msg.content.video or msg.content.audio or msg.content.document or msg.content.voice_note or msg.content.video_note then
Redis:sadd(Black.."Black:cleaner"..msg.chat_id,msg.id)
end
---------
if text == "رفع بكلبي" then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"مهو فقلبك ولا هي شغلانه","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز ترفع نفسك فقلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
  return send(msg_chat_id,msg_id,"للاسف العضو فقلب حد تاني","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id) and not Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
    Redis:set(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:", msg.sender.user_id)
    Redis:sadd(Black..msg_chat_id..msg.sender.user_id.."my_heart:", Message_Reply.sender.user_id)
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم رفعو فقلبك").Reply,"md",true)  
  end
end
if text == "تنزيل من كلبي" then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
    Redis:del(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")
    Redis:srem(Black..msg_chat_id..msg.sender.user_id.."my_heart:", msg_chat_id..Message_Reply.sender.user_id)
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم تنزيلو من قلبك").Reply,"md",true) 
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تنزل نفسك من قلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
  return send(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id)then
  return send(msg_chat_id,msg_id,"هو فقلبك اصلا عشان تنزلو ؟؟","md")
  end
end
if text == "انا بكلب منو" then
  if not Redis:get(Black..msg_chat_id..msg.sender.user_id.."in_heart:") then
    return send(msg_chat_id,msg_id,"↯︙انته لست في قلب شخص","md")
  elseif Redis:get(Black..msg_chat_id..msg.sender.user_id.."in_heart:") then
    local in_heart_id = Redis:get(Black..msg_chat_id..msg.sender.user_id.."in_heart:")
    local heart_name = LuaTele.getUser(in_heart_id).first_name
    return send(msg_chat_id,msg_id,"انت فقلب ["..heart_name.."](tg://user?id="..in_heart_id..")","md")
  end
end
if text == "تاك للبكلبي" or text == "تاك للفكلبي" or text == "تاك للناس الي فقلبي" then
  local heart_list = Redis:smembers(Black..msg_chat_id..msg.sender.user_id.."my_heart:")
  if #heart_list == 0 then
    return send(msg_chat_id,msg_id,"↯︙️كلبك فارغ محد بيه","md")
  elseif #heart_list > 0 then
    your_heart = "قائمه الاشخاص الموجودين في قلبك \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
    for k,v in pairs(heart_list) do
    local user_info = LuaTele.getUser(v)
    local name = user_info.first_name
    your_heart = your_heart..k.." - ["..name.."](tg://user?id="..v..")\n"
    end
    return send(msg_chat_id,msg_id,your_heart,"md")
  end
end
if text == "مسح قائمة البكلبي" or text == "مسح البكلبي" then 
  local list = Redis:smembers(Black..msg_chat_id..msg.sender.user_id.."my_heart:")
  for k,v in pairs(list) do
  Redis:del(Black..msg_chat_id..v.."in_heart:")
  end
Redis:del(Black..msg_chat_id..msg.sender.user_id.."my_heart:")
return send(msg_chat_id,msg_id,"تم مسح قائمه الاشخاص الموجودين في قلبك","md")
end
-------
-- ttgwzine
if text == "تعطيل زوجني" or text == "تعطيل لعبه زوجني" then
if not msg.Manger then
return sendx(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(Black..'zwgnyy'..msg.chat_id,true)
sendx(msg_chat_id,msg_id,'\n ↯︙ تم تعطيل لعبه زوجني')
end
if text == "تفعيل زوجني" or text == "تفعيل لعبه زوجني" then
if not msg.Manger then
return sendx(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black..'zwgnyy'..msg.chat_id)
sendx(msg_chat_id,msg_id,'\n ↯︙ تم تفعيل لعبه زوجني')
end
if text == "زوجني" or text == "بوت زوجني" then
if not Redis:get(Black..'zwgnyy'..msg.chat_id) then 
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local chat_Members = LuaTele.searchChatMembers(msg_chat_id, "*", Info_Chats.member_count).members
local rand_members = math.random(#chat_Members)
local member_id = chat_Members[rand_members].member_id.user_id
local member_name = LuaTele.getUser(chat_Members[rand_members].member_id.user_id).first_name
local mem_tag = "["..member_name.."](tg://user?id="..member_id..")"
if tonumber(member_id) == tonumber(msg.sender.user_id) or tonumber(member_id) == tonumber(Black) or LuaTele.getUser(member_id).type.luatele == "userTypeBot" then 
return send(msg_chat_id,msg_id,"↯︙️لا يوجد مستخدمين في المجموعه للزواج","md")
end
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = '( موافق )', data = msg.sender.user_id..'/yes_zw/'..member_id},
  {text = '( مو موافق )', data = msg.sender.user_id..'/no_zw/'..member_id},
  },
  }
  }
return send(msg_chat_id,msg_id,"جبتلك عروسه حلوا "..mem_tag.." شنو رايك بيها ?","md",false, false, false, false, reply_markup)
end
end
if text == "نتزوج" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"انتو متزوجين لو لعب وخلاص","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"↯︙️لا يمكنك الزواج من نفسك","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
  return send(msg_chat_id,msg_id,"↯︙ لا يمكنك الزواج من البوت","md")
elseif Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:") then
local zwg_id =  Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
local zwg_info = LuaTele.getUser(zwg_id)
return send(msg_chat_id,msg_id,"هاي متزوجه اصيحلك زوجها\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحك يمعود يريد يتزوج زوجتك","md")
elseif Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
  local zwg_id =  Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
  local zwg_info = LuaTele.getUser(zwg_id)
  return send(msg_chat_id,msg_id,"راح اصيح زوجتك\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحكي زوجج يريد يتزوج عليج","md")
elseif not Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")  then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local rep_info = LuaTele.getUser(Message_Reply.sender.user_id)
local rep_tag = "["..rep_info.first_name.."](tg://user?id="..Message_Reply.sender.user_id..")"
local user_info = LuaTele.getUser(msg.sender.user_id)
local user_tag = "["..user_info.first_name.."](tg://user?id="..msg.sender.user_id..")"
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = '( موافقه )', data = Message_Reply.sender.user_id..'/yes_z/'..msg.sender.user_id},
  {text = '( مو موافقه )', data = Message_Reply.sender.user_id..'/no_z/'..msg.sender.user_id},
  },
  }
  }
return send(msg_chat_id,msg.reply_to_message_id,"يا "..rep_tag.."\nالسيد"..user_tag.."\nطالب ايدج للزواج شنو رايج ","md",false, false, false, false, reply_markup)
end
end
if text == "زوجتي" then
  if Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return send(msg_chat_id,msg_id,"تعالي يا ["..zwga_name.."](tg://user?id="..zwga_id..") زوجج يريدج","md")
  elseif not Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return send(msg_chat_id,msg_id,"↯︙️ليس لديك زوجه انته اعزب","md")
  end
end
if text == "زوجي" then
  if Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return send(msg_chat_id,msg_id,"يااا ["..zwga_name.."](tg://user?id="..zwga_id..") زوجتك تريدك ","md")
  elseif not Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return send(msg_chat_id,msg_id,"↯︙عذرا انتي لستي متزوجه","md")
  end
end
if text == "انتي طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"↯︙️لا يمكنك الطلاق من نفسك","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
  return send(msg_chat_id,msg_id,"↯︙ لا يمكنك الزواج من البوت","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"↯︙️لا تستطيع طلاقها انها ليست زوجتك","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"↯︙️تم طلاقكم بنجاح فرصه سعيده","md")
  end
end
if text == "انت طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return send(msg_chat_id,msg_id,"↯︙️لا تستطيعين الطلاق من نفسكي","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
  return send(msg_chat_id,msg_id,"↯︙️لا تستطيعين الزواج من البوت","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return send(msg_chat_id,msg_id,"↯︙️لا تستطيعين طلاقه لانه ليس زوجكي","md")
elseif tonumber(Redis:get(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(Black..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"↯︙️تم طلاقكم بنجاح فرصه سعيده","md")
  end
end
if text == "بوت طلقني" then
  if not Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then 
  return send(msg_chat_id,msg_id,"↯︙انته لست متزوج لا تستطيع الطلاق","md")
  elseif Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwg_id = Redis:get(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:del(Black..msg_chat_id..msg.sender.user_id.."mtzwga:")
    Redis:del(Black..msg_chat_id..zwg_id.."mtzwga:")
    return send(msg_chat_id,msg_id,"تم طلاقك من ["..zwg_name.."](tg://user?id="..zwg_id..")\nشوفو منو راح ياخذ الجهال","md")
  end
end
-------

if text == "مسح الميديا" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص المدير *',"md",true)  
end
local list = Redis:smembers(Black.."Black:cleaner"..msg.chat_id)
if #list == 0 then 
return send(msg_chat_id,msg_id,"↯︙  لا يوجد وسائط مجدوله للحذف \n ","md",true) 
end
for k,v in pairs(list) do 
LuaTele.deleteMessages(msg.chat_id,{[1]= v})
end
Redis:del(Black.."Black:cleaner"..msg.chat_id)
send(msg_chat_id,msg_id,"↯︙  تم مسح "..#list.." من الميديا","md",true)
end

if text == "عدد الميديا" then
local list = Redis:smembers(Black.."Black:cleaner"..msg_chat_id)
return send(msg_chat_id,msg_id,"عدد الميديا هو "..#list.."","md",true)
end
---
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= Black then
local test = Redis:get(Black.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(Black.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Black.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Black.."Add:Rd:Sudo:mz:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(Black.."Add:Rd:Sudo:mz:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Black.."Add:Rd:Sudo:mz:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(Black.."Add:Rd:Sudo:mz:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(Black.."Add:Rd:Sudo:mz:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:Rd:Sudo:mz:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Black.."Add:Rd:Sudo:mz:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(Black.."Add:Rd:Sudo:mz:Video"..test, msg.content.video.video.remote.id)  
Redis:set(Black.."Add:Rd:Sudo:mz:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(Black.."Add:Rd:Sudo:mz:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Black.."Add:Rd:Sudo:mz:Photo"..test, idPhoto)  
Redis:set(Black.."Add:Rd:Sudo:mz:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"↯︙ تم حفظ الرد \n↯︙ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Black.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(Black.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(Black.."List:Rd:Sudo:mz", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ↯︙
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:mz:video_note","Add:Rd:Sudo:mz:Audio","Add:Rd:Sudo:mz:Audioc","Add:Rd:Sudo:mz:File","Add:Rd:Sudo:mz:Video","Add:Rd:Sudo:mz:Videoc","Add:Rd:Sudo:mz:Photo","Add:Rd:Sudo:mz:Photoc","Add:Rd:Sudo:mz:Text","Add:Rd:Sudo:mz:stekr","Add:Rd:Sudo:mz:vico","Add:Rd:Sudo:mz:Gif"}
for k,v in pairs(list) do
Redis:del(Black..''..v..text)
end
Redis:del(Black.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Black.."List:Rd:Sudo:mz", text)
return send(msg_chat_id,msg_id,"↯︙ تم حذف الرد من الردود العامه","md",true)  
end
end

if text and text ~= "حذف رد مميز" and text ~= "اضف رد مميز" and text ~= "مسح الردود المميزه" and not Redis:get(Black.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(Black..'Spam:Group'..msg.sender.user_id,text) then
local listmz = Redis:smembers(Black.."List:Rd:Sudo:mz")
for k,v in pairs(listmz) do
i ,j  = string.find(text, v)
if j and i then
local x = string.sub(text, i,j)
if x then
local anemi = Redis:get(Black.."Add:Rd:Sudo:mz:Gif"..x)   
local veico = Redis:get(Black.."Add:Rd:Sudo:mz:vico"..x)   
local stekr = Redis:get(Black.."Add:Rd:Sudo:mz:stekr"..x)     
local Text = Redis:get(Black.."Add:Rd:Sudo:mz:Text"..x)   
local photo = Redis:get(Black.."Add:Rd:Sudo:mz:Photo"..x)
local photoc = Redis:get(Black.."Add:Rd:Sudo:mz:Photoc"..x)
local video = Redis:get(Black.."Add:Rd:Sudo:mz:Video"..x)
local videoc = Redis:get(Black.."Add:Rd:Sudo:mz:Videoc"..x)
local document = Redis:get(Black.."Add:Rd:Sudo:mz:File"..x)
local audio = Redis:get(Black.."Add:Rd:Sudo:mz:Audio"..x)
local audioc = Redis:get(Black.."Add:Rd:Sudo:mz:Audioc"..x)
local video_note = Redis:get(Black.."Add:Rd:Sudo:mz:video_note"..x)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(Black.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
end
end
end
if text == "اضف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود المميزه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود المميزه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(Black.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(Black.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود المميزه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo:mz")
for k,v in pairs(list) do
Redis:del(Black.."Add:Rd:Sudo:mz:Gif"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:vico"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:stekr"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Text"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Photo"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Photoc"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Video"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Videoc"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:File"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Audio"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:Audioc"..v)
Redis:del(Black.."Add:Rd:Sudo:mz:video_note"..v)
Redis:del(Black.."List:Rd:Sudo:mz")
end
send(msg_chat_id,msg_id,"↯︙ تم مسح قائمه الردود المميزه","md",true)  
end
if text == ("الردود المميزه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo:mz")
text = "\n↯︙ قائمة الردود المميزه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if Redis:get(Black.."Add:Rd:Sudo:mz:Gif"..v) then
db = "متحركه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:vico"..v) then
db = "بصمه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:stekr"..v) then
db = "ملصق ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:Text"..v) then
db = "رساله ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:Photo"..v) then
db = "صوره ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:Video"..v) then
db = "فيديو ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:File"..v) then
db = "ملف ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:Audio"..v) then
db = "اغنيه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:mz:video_note"..v) then
db = "بصمه فيديو ↯︙"
end
text = text..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
end
if #list == 0 then
text = "↯︙ لا توجد ردود مميزه"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
-------
if text then
if text:match("^وجد كل (.*)$") or text:match("^ج (.*)$") or text:match("^ايجاد كل (.*)$") then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black..'3dd:klm'..msg.chat_id)
local mt = text:match("^وجد كل (.*)$") or text:match("^ج (.*)$") or text:match("^ايجاد كل (.*)$")
msgid = (msg.id - (1048576*1000))
y = 0
r = 1048576
for i=1,1000 do
r = r + 1048576
s = LuaTele.getMessage(msg.chat_id,msgid + r)
if s.content and s.content.text then
tx = s.content.text.text
mg = s.id
i ,j = string.find(tx, mt)
if i and j then
Redis:sadd(Black..'3dd:klm'..msg.chat_id,mg)
x = string.sub(tx, i,j)
send(msg_chat_id,mg,".","html",true)
end
end
end
list = Redis:smembers(Black..'3dd:klm'..msg.chat_id)
send(msg_chat_id,msg.id,"تم العثور علي "..#list.." "..mt.."","html",true)
end
end
if text then
if text:match("^مسح كل (.*)$") or text:match("^حذف كل (.*)$") then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(Black..'3dd:klm:ms'..msg.chat_id)
local mt = text:match("^مسح كل (.*)$") or text:match("^حذف كل (.*)$") 
msgid = (msg.id - (1048576*1000))
y = 0
r = 1048576
for i=1,1000 do
r = r + 1048576
s = LuaTele.getMessage(msg.chat_id,msgid + r)
if s.content and s.content.text then
tx = s.content.text.text
mg = s.id
i ,j = string.find(tx, mt)
if i and j then
Redis:sadd(Black..'3dd:klm:ms'..msg.chat_id,mg)
LuaTele.deleteMessages(data.chat_id,{[1]= mg})
end
end
end
list = Redis:smembers(Black..'3dd:klm:ms'..msg.chat_id)
send(msg_chat_id,msg.id,"تم مسح "..#list.." رساله تحتوي علي "..mt.."","html",true)
end
end
---انلاين عام 
if text == ("مسح الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(Black.."List:Manager:inline3am")
  for k,v in pairs(list) do
      Redis:del(Black.."Add:Rd:Manager:Gif:inline3am"..v)   
      Redis:del(Black.."Add:Rd:Manager:Vico:inline3am"..v)   
      Redis:del(Black.."Add:Rd:Manager:Stekrs:inline3am"..v)     
      Redis:del(Black.."Add:Rd:Manager:Text:inline3am"..v)   
      Redis:del(Black.."Add:Rd:Manager:Photo:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:Photoc:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:Video:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:Videoc:inline3am"..v)  
      Redis:del(Black.."Add:Rd:Manager:File:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:video_note:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:Audio:inline3am"..v)
      Redis:del(Black.."Add:Rd:Manager:Audioc:inline3am"..v)
      Redis:del(Black.."Rd:Manager:inline3am:v"..v)
      Redis:del(Black.."Rd:Manager:inline3am:link"..v)
  Redis:del(Black.."List:Manager:inline3am")
  end
  return send(msg_chat_id,msg_id,"↯︙ تم مسح قائمه الانلاين","md",true)  
  end
if text and Redis:get(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(Black.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(Black.."Rd:Manager:inline3am:link"..anubis, text)
send(msg_chat_id,msg_id,"↯︙ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and Redis:get(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(Black.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(Black.."Rd:Manager:inline3am:text"..anubis, text)
send(msg_chat_id,msg_id,"↯︙ الان ارسل الرابط","md",true)  
return false  
end
if Redis:get(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(Black) then
Redis:del(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(Black.."Text:Manager:inline3am"..msg.sender.user_id..":")
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Black.."Add:Rd:Manager:Text:inline3am"..anubis, text)
elseif msg.content.sticker then   
Redis:set(Black.."Add:Rd:Manager:Stekrs:inline3am"..anubis, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(Black.."Add:Rd:Manager:Vico:inline3am"..anubis, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(Black.."Add:Rd:Manager:Audio:inline3am"..anubis, msg.content.audio.audio.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Audioc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(Black.."Add:Rd:Manager:File:inline3am"..anubis, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(Black.."Add:Rd:Manager:Gif:inline3am"..anubis, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(Black.."Add:Rd:Manager:video_note:inline3am"..anubis, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(Black.."Add:Rd:Manager:Video:inline3am"..anubis, msg.content.video.video.remote.id)  
Redis:set(Black.."Add:Rd:Manager:Videoc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(Black.."Add:Rd:Manager:Photo:inline3am"..anubis, idPhoto)  
Redis:set(Black.."Add:Rd:Manager:Photoc:inline3am"..anubis, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"↯︙ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end

if text and text:match("^(.*)$") then
if Redis:get(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
if not Redis:sismember(Black.."List:Manager:inline3am", text) then
 Redis:del(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
   return send(msg_chat_id,msg_id,"↯︙ لا يوجد رد لهذه الكلمه","md",true)  
  end
  Redis:del(Black.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(Black.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(Black.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(Black.."Rd:Manager:inline3am:text"..text)
  Redis:del(Black.."Rd:Manager:inline3am:link"..text)
Redis:del(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(Black.."List:Manager:inline3am", text)
send(msg_chat_id,msg_id,"↯︙ تم حذف الرد من الردود الانلاين العامه","md",true)  
return false
end
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(Black) then
  if Redis:get(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(Black.."Text:Manager:inline3am"..msg.sender.user_id..":", text)
  Redis:del(Black.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(Black.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(Black.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(Black.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(Black.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(Black.."Rd:Manager:inline3am:text"..text)
  Redis:del(Black.."Rd:Manager:inline3am:link"..text)
  Redis:sadd(Black.."List:Manager:inline3am", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ↯︙
  ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if text == "اضف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  Redis:set(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end


if text and not Redis:get(Black.."Status:Reply:inline3am"..msg_chat_id) then
local btext = Redis:get(Black.."Rd:Manager:inline3am:text"..text)
local blink = Redis:get(Black.."Rd:Manager:inline3am:link"..text)
local anemi = Redis:get(Black.."Add:Rd:Manager:Gif:inline3am"..text)   
local veico = Redis:get(Black.."Add:Rd:Manager:Vico:inline3am"..text)   
local stekr = Redis:get(Black.."Add:Rd:Manager:Stekrs:inline3am"..text)     
local Texingt = Redis:get(Black.."Add:Rd:Manager:Text:inline3am"..text)   
local photo = Redis:get(Black.."Add:Rd:Manager:Photo:inline3am"..text)
local photoc = Redis:get(Black.."Add:Rd:Manager:Photoc:inline3am"..text)
local video = Redis:get(Black.."Add:Rd:Manager:Video:inline3am"..text)
local videoc = Redis:get(Black.."Add:Rd:Manager:Videoc:inline3am"..text)  
local document = Redis:get(Black.."Add:Rd:Manager:File:inline3am"..text)
local audio = Redis:get(Black.."Add:Rd:Manager:Audio:inline3am"..text)
local audioc = Redis:get(Black.."Add:Rd:Manager:Audioc:inline3am"..text)
local video_note = Redis:get(Black.."Add:Rd:Manager:video_note:inline3am"..text)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Black..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Black..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(Black.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 

if text == ("الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
  return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(Black.."List:Manager:inline3am")
  text = "↯︙ قائمه الردود الانلاين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
  for k,v in pairs(list) do
  if Redis:get(Black.."Add:Rd:Manager:Gif:inline3am"..v) then
  db = "متحركه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Vico:inline3am"..v) then
  db = "بصمه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Stekrs:inline3am"..v) then
  db = "ملصق ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Text:inline3am"..v) then
  db = "رساله ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Photo:inline3am"..v) then
  db = "صوره ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Video:inline3am"..v) then
  db = "فيديو ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:File:inline3am"..v) then
  db = "ملف ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:Audio:inline3am"..v) then
  db = "اغنيه ↯︙"
  elseif Redis:get(Black.."Add:Rd:Manager:video_note:inline3am"..v) then
  db = "بصمه فيديو ↯︙"
  end
  text = text..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
  end
  if #list == 0 then
  text = "↯︙ عذرا لا يوجد ردود انلاين عامه"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
------بحث
if text and text:match("^حظر كروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^حظر كروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:sadd(Black..'ban:online',txx)
send(msg_chat_id,msg_id,'\n↯︙ تم حظر الكروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n↯︙ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
if text and text:match("^الغاء حظر كروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^الغاء حظر كروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:srem(Black..'ban:online',txx)
send(msg_chat_id,msg_id,'\n↯︙ تم الغاء حظر الكروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n↯︙ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
----بنك
if text then
if text:match("^انطق (.*)$") or text:match("^انطقي (.*)$") then
local inoi = text:match("^انطق (.*)$") or text:match("^انطقي (.*)$")
local intk = inoi:gsub(" ","-")
if intk:match("%a") then
lan = "en"
else
lan = "ar"
end
local rand = math.random(1,999)
os.execute("gtts-cli "..intk.." -l '"..lan.."' -o 'intk"..rand..".mp3'")
LuaTele.sendAudio(msg_chat_id,msg_id,'./intk'..rand..'.mp3',tostring(inoi),"html",nil,tostring(inoi),"@cllllllT")
sleep(1)
os.remove("intk"..rand..".mp3")
end
end
--------بدايه البنك 
if text == 'انشاء حساب بنكي' or text == 'انشاء حساب البنكي' or text =='انشاء الحساب بنكي' or text =='انشاء الحساب البنكي' then
creditcc = tonumber(math.random(500000000,5999999999999))
creditvi = tonumber(math.random(40000000000,4999999999999))
creditex = tonumber(math.random(6000000000,69999999999999))
balas = 10
if Redis:sismember(Black.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id, "•  لديك حساب بنكي مسبقاً\n\n•  لعرض معلومات حسابك اكتب\n⇠ `حسابي`","md",true)
end
Redis:setex(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
send(msg.chat_id,msg.id,[[
– عشان تسوي حساب لازم تختار نوع البطاقة

⇠ `ماستر`
⇠ `فيزا`
⇠ `اكسبرس`
⇠ `بلاك`

- اضغط للنسخ

– مدة الطلب دقيقة واحدة ويطردك الموظف .
]],"md",true)  
return false
end
if Redis:get(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) then
if text == "ماستر" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(Black.."bobna"..msg.sender.user_id,news)
Redis:set(Black.."boob"..msg.sender.user_id,balas)
Redis:set(Black.."boobb"..msg.sender.user_id,creditcc)
Redis:set(Black.."bbobb"..msg.sender.user_id,text)
Redis:set(Black.."boballname"..creditcc,news)
Redis:set(Black.."boballbalc"..creditcc,balas)
Redis:set(Black.."boballcc"..creditcc,creditcc)
Redis:set(Black.."boballban"..creditcc,text)
Redis:set(Black.."boballid"..creditcc,banid)
Redis:sadd(Black.."booob",msg.sender.user_id)
Redis:del(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك بلاك 🏦\n• وشحنالك 10 دولار 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditcc.."` )\n•  نوع البطاقة ↢ ( ماستر 💳 )\n•  فلوسك ↢ ( 10 دولار 💵 )  ","md",true)  
end 
if text == "فيزا" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(Black.."bobna"..msg.sender.user_id,news)
Redis:set(Black.."boob"..msg.sender.user_id,balas)
Redis:set(Black.."boobb"..msg.sender.user_id,creditvi)
Redis:set(Black.."bbobb"..msg.sender.user_id,text)
Redis:set(Black.."boballname"..creditvi,news)
Redis:set(Black.."boballbalc"..creditvi,balas)
Redis:set(Black.."boballcc"..creditvi,creditvi)
Redis:set(Black.."boballban"..creditvi,text)
Redis:set(Black.."boballid"..creditvi,banid)
Redis:sadd(Black.."booob",msg.sender.user_id)
Redis:del(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك بلاك 🏦\n• وشحنالك 10 دولار 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditvi.."` )\n•  نوع البطاقة ↢ ( فيزا 💳 )\n•  فلوسك ↢ ( 10 دولار 💵 )  ","md",true)   
end 
if text == "بلاك" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(Black.."bobna"..msg.sender.user_id,news)
Redis:set(Black.."boob"..msg.sender.user_id,balas)
Redis:set(Black.."boobb"..msg.sender.user_id,creditvi)
Redis:set(Black.."bbobb"..msg.sender.user_id,text)
Redis:set(Black.."boballname"..creditvi,news)
Redis:set(Black.."boballbalc"..creditvi,balas)
Redis:set(Black.."boballcc"..creditvi,creditvi)
Redis:set(Black.."boballban"..creditvi,text)
Redis:set(Black.."boballid"..creditvi,banid)
Redis:sadd(Black.."booob",msg.sender.user_id)
Redis:del(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك بلاك 🏦\n• وشحنالك 10 دولار 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditvi.."` )\n•  نوع البطاقة ↢ ( بلاك 💳 )\n•  فلوسك ↢ ( 10 دولار 💵 )  ","md",true)   
end 
if text == "اكسبرس" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(Black.."bobna"..msg.sender.user_id,news)
Redis:set(Black.."boob"..msg.sender.user_id,balas)
Redis:set(Black.."boobb"..msg.sender.user_id,creditex)
Redis:set(Black.."bbobb"..msg.sender.user_id,text)
Redis:set(Black.."boballname"..creditex,news)
Redis:set(Black.."boballbalc"..creditex,balas)
Redis:set(Black.."boballcc"..creditex,creditex)
Redis:set(Black.."boballban"..creditex,text)
Redis:set(Black.."boballid"..creditex,banid)
Redis:sadd(Black.."booob",msg.sender.user_id)
Redis:del(Black.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
send(msg.chat_id,msg.id, "\n• وسوينا لك حساب في بنك بلاك 🏦\n• وشحنالك 10 دولار 💵 هدية\n\n•  رقم حسابك ↢ ( `"..creditex.."` )\n•  نوع البطاقة ↢ ( اكسبرس 💳 )\n•  فلوسك ↢ ( 10 دولار 💵 )  ","md",true)   
end 
end
if text == "البنك" then
local txx = [[
٠ اوامر لعبة البنك

⌯ انشاء حساب بنكي  ↢ تسوي حساب وتقدر تحول فلوس مع مزايا ثانيه

⌯ مسح حساب بنكي  ↢ تلغي حسابك البنكي

⌯ تحويل ↢ تطلب رقم حساب الشخص وتحول له فلوس

⌯ حسابي  ↢ يطلع لك رقم حسابك عشان تعطيه للشخص اللي بيحول لك

⌯ فلوسي ↢ يعلمك كم فلوسك

⌯ راتب ↢ يعطيك راتبك كل ٢٠ دقيقة

⌯ بخشيش ↢ يعطيك بخشيش كل ١٠ دقايق

⌯ زرف ↢ تزرف فلوس اشخاص كل ١٠ دقايق

⌯ استثمار ↢ تستثمر بالمبلغ اللي تبيه مع نسبة ربح مضمونه من ١٪؜ الى ١٥٪؜

⌯ حظ ↢ تلعبها بأي مبلغ ياتدبله ياتخسره انت وحظك

⌯ مضاربه ↢ تضارب بأي مبلغ تبيه والنسبة من ٩٠٪؜ الى -٩٠٪؜ انت وحظك

⌯ توب الفلوس ↢ يطلع توب اكثر ناس معهم فلوس بكل القروبات

⌯ توب الحراميه ↢ يطلع لك اكثر ناس زرفوا

- اضف فلوس + المبلغ (بالرد) *للمطور الاساسي فقط*

]]
send(msg.chat_id,msg.id,txx,"md")
end
if text == 'مسح حساب بنكي' or text == 'مسح حساب البنكي' or text =='مسح الحساب بنكي' or text =='مسح الحساب البنكي' or text == "مسح حسابي البنكي" or text == "مسح حسابي" then
if Redis:sismember(Black.."booob",msg.sender.user_id) then
Redis:srem(Black.."booob", msg.sender.user_id)
Redis:del(Black.."boob"..msg.sender.user_id)
Redis:del(Black.."boobb"..msg.sender.user_id)
Redis:del(Black.."zrfff"..msg.sender.user_id)
Redis:srem(Black.."zrfffid", msg.sender.user_id)
send(msg.chat_id,msg.id, "•  مسحت حسابك البنكي 🏦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تصفير النتائج' or text == 'مسح لعبه البنك' then
if msg.ControllerBot then
Redis:del(Black.."booob")
Redis:del(Black.."boob")
Redis:del(Black.."boobb")
Redis:del(Black.."zrfff")
Redis:del(Black.."zrfffid")
send(msg.chat_id,msg.id, "•  مسحت لعبه البنك 🏦","md",true)
end
end

if text == 'فلوسي' or text == 'فلوس' and tonumber(msg.reply_to_message_id) == 0 then
if Redis:sismember(Black.."booob",msg.sender.user_id) then
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 1 then
return send(msg.chat_id,msg.id, "•  ماعندك فلوس ارسل الالعاب وابدأ بجمع الفلوس \n✦","md",true)
end
send(msg.chat_id,msg.id, "•  فلوسك "..ballancee.." دولار 💵","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'فلوسه' or text == 'فلوس' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  بلاك ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  فلوسه "..ballanceed.." دولار 💵","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text == 'حسابي' or text == 'حسابي البنكي' or text == 'رقم حسابي' then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(Black.."booob",msg.sender.user_id) then
cccc = Redis:get(Black.."boobb"..msg.sender.user_id)
uuuu = Redis:get(Black.."bbobb"..msg.sender.user_id)
pppp = Redis:get(Black.."zrfff"..msg.sender.user_id) or 0
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..cccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuu.." )\n•  الرصيد ↢ ( "..ballancee.." دولار 💵 )\n•  الزرف ( "..pppp.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'مسح حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  بلاك ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(Black.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(Black.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(Black.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
Redis:srem(Black.."booob", Remsg.sender.user_id)
Redis:del(Black.."boob"..Remsg.sender.user_id)
Redis:del(Black.."boobb"..Remsg.sender.user_id)
Redis:del(Black.."zrfff"..Remsg.sender.user_id)
Redis:srem(Black.."zrfffid", Remsg.sender.user_id)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." دولار 💵 )\n•  الزرف ↢ ( "..ppppp.." دولار 💵 )\n•  مسكين مسحت حسابه \n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي اصلاً ","md",true)
end
end
end

if text == 'حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  بلاك ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(Black.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(Black.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(Black.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." دولار 💵 )\n•  الزرف ↢ ( "..ppppp.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text and text:match('^مسح حساب (.*)$') or text and text:match('^مسح حسابه (.*)$') then
if msg.ControllerBot then
local UserName = text:match('^مسح حساب (.*)$') or text:match('^مسح حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
local ban = LuaTele.getUser(coniss)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
if Redis:sismember(Black.."booob",coniss) then
ccccc = Redis:get(Black.."boobb"..coniss)
uuuuu = Redis:get(Black.."bbobb"..coniss)
ppppp = Redis:get(Black.."zrfff"..coniss) or 0
ballanceed = Redis:get(Black.."boob"..coniss) or 0
Redis:srem(Black.."booob", coniss)
Redis:del(Black.."boob"..coniss)
Redis:del(Black.."boobb"..coniss)
Redis:del(Black.."zrfff"..coniss)
Redis:srem(Black.."zrfffid", coniss)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuuu.." )\n•  الرصيد ↢ ( "..ballanceed.." دولار 💵 )\n•  الزرف ↢ ( "..ppppp.." دولار 💵 )\n•  مسكين مسحت حسابه \n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي اصلاً ","md",true)
end
end
end

if text and text:match('^حساب (.*)$') or text and text:match('^حسابه (.*)$') then
local UserName = text:match('^حساب (.*)$') or text:match('^حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:get(Black.."boballcc"..coniss) then
local yty = Redis:get(Black.."boballname"..coniss)
local dfhb = Redis:get(Black.."boballbalc"..coniss)
local fsvhh = Redis:get(Black.."boballban"..coniss)
send(msg.chat_id,msg.id, "•  الاسم ↢ "..yty.."\n•  الحساب ↢ `"..coniss.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..fsvhh.." )\n•  الرصيد ↢ ( "..dfhb.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  مافيه حساب بنكي كذا","md",true)
end
end

if text == 'مضاربه' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`مضاربه` المبلغ","md",true)
end

if text and text:match('^مضاربه (.*)$') then
local UserName = text:match('^مضاربه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(Black.."booob",msg.sender.user_id) then
if Redis:get(Black.."iiooooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."iiooooo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  مايمديك تضارب الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح هو 100 دولار 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local modarba = {"0", "1", "2", "3", "4",}
local Descriptioontt = modarba[math.random(#modarba)]
local modarbaa = math.random(1,90);
if Descriptioontt == "1" or Descriptioontt == "3" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee - ballanceekku
Redis:set(Black.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(Black.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مضاربة فاشلة 📉\n•  نسبة الخسارة ↢ "..modarbaa.."%\n•  المبلغ الذي خسرته ↢ ( "..ballanceekku.." دولار 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkku.." دولار 💵 )\n✦","md",true)
elseif Descriptioontt == "2" or Descriptioontt == "4" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee + ballanceekku
Redis:set(Black.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(Black.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مضاربة ناجحة 📈\n•  نسبة الربح ↢ "..modarbaa.."%\n•  المبلغ الذي ربحته ↢ ( "..ballanceekku.." دولار 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkku.." دولار 💵 )\n✦","md",true)
else
Redis:setex(Black.."iiooooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  تأخرت اليوم والبنك مسكر ارجع بعدين \n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'استثمار' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`استثمار` المبلغ","md",true)
end

if text and text:match('^استثمار (.*)$') then
local UserName = text:match('^استثمار (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(Black.."booob",msg.sender.user_id) then
if Redis:get(Black.."iioooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."iioooo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  مايمديك تستثمر الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح هو 100 دولار 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local hadddd = math.random(0,17);
ballanceekk = coniss / 100 * hadddd
ballanceekkk = ballancee + ballanceekk
Redis:incrby(Black.."boob"..msg.sender.user_id , math.floor(ballanceekk))
Redis:setex(Black.."iioooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  استثمار ناجح 💰\n•  نسبة الربح ↢ "..hadddd.."%\n•  مبلغ الربح ↢ ( "..ballanceekk.." دولار 💵 )\n•  فلوسك صارت ↢ ( "..ballanceekkk.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'حظ' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`حظ` المبلغ","md",true)
end

if text and text:match('^حظ (.*)$') then
local UserName = text:match('^حظ (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if Redis:sismember(Black.."booob",msg.sender.user_id) then
if Redis:get(Black.."iiooo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."iiooo" .. msg.sender.user_id)) 
return send(msg.chat_id,msg.id,"•  مايمديك تلعب لعبة الحظ الحين\n•  تعال بعد ( "..time_ex.." )","md",true)
end
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < tonumber(coniss) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end
local daddd = {"1", "2", "3", "4",}
local haddd = daddd[math.random(#daddd)]
if haddd == "1" or haddd == "3" then
local ballanceek = ballancee + coniss
Redis:incrby(Black.."boob"..msg.sender.user_id , coniss)
Redis:setex(Black.."iiooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  مبروك فزت بالحظ 🎉\n•  فلوسك قبل ↢ ( "..ballancee.." دولار 💵 )\n•  فلوسك الحين ↢ ( "..ballanceek.." دولار 💵 )\n✦","md",true)
else
local ballanceekk = ballancee - coniss
Redis:decrby(Black.."boob"..msg.sender.user_id , coniss)
Redis:setex(Black.."iiooo" .. msg.sender.user_id,1200, true)
send(msg.chat_id,msg.id, "•  للاسف خسرت بالحظ 😬\n•  فلوسك قبل ↢ ( "..ballancee.." دولار 💵 )\n•  فلوسك الحين ↢ ( "..ballanceekk.." دولار 💵 )\n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تحويل' then
send(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`تحويل` المبلغ","md",true)
end

if text and text:match('^تحويل (.*)$') then
local UserName = text:match('^تحويل (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if not Redis:sismember(Black.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ","md",true)
end
if tonumber(coniss) < 100 then
return send(msg.chat_id,msg.id, "•  الحد الادنى المسموح به هو 100 دولار \n✦","md",true)
end
ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 100 then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي \n✦","md",true)
end

if tonumber(coniss) > tonumber(ballancee) then
return send(msg.chat_id,msg.id, "•  فلوسك ماتكفي\n✦","md",true)
end

Redis:set(Black.."transn"..msg.sender.user_id,coniss)
Redis:setex(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
send(msg.chat_id,msg.id,[[
•  ارسل الحين رقم الحساب البنكي الي تبي تحول له

– معاك دقيقة وحدة والغي طلب التحويل .
✦
]],"md",true)  
return false
end
if Redis:get(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) then
cccc = Redis:get(Black.."boobb"..msg.sender.user_id)
uuuu = Redis:get(Black.."bbobb"..msg.sender.user_id)
if text ~= text:match('^(%d+)$') then
Redis:del(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(Black.."transn" .. msg.sender.user_id)
return send(msg.chat_id,msg.id,"•  ارسل رقم حساب بنكي ","md",true)
end
if text == cccc then
Redis:del(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(Black.."transn" .. msg.sender.user_id)
return send(msg.chat_id,msg.id,"•  مايمديك تحول لنفسك ","md",true)
end
if Redis:get(Black.."boballcc"..text) then
local UserNamey = Redis:get(Black.."transn"..msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
local fsvhhh = Redis:get(Black.."boballid"..text)
local bann = LuaTele.getUser(fsvhhh)
if bann.first_name then
newss = "["..bann.first_name.."](tg://user?id="..bann.id..")"
else
newss = " لا يوجد "
end
local fsvhh = Redis:get(Black.."boballban"..text)
UserNameyr = UserNamey / 10
UserNameyy = UserNamey - UserNameyr
Redis:decrby(Black.."boob"..msg.sender.user_id , UserNamey)
Redis:incrby(Black.."boob"..fsvhhh , math.floor(UserNameyy))
send(msg.chat_id,msg.id, "حوالة صادرة من بنك بلاك\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمستلم : "..newss.."\nالحساب رقم : `"..text.."`\nنوع البطاقة : "..fsvhh.."\nخصمت 10% رسوم تحويل\nالمبلغ : "..UserNameyy.." دولار 💵","md",true)
send(fsvhhh,0, "حوالة واردة من بنك بلاك\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمبلغ : "..UserNameyy.." دولار 💵","md",true)
Redis:del(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(Black.."transn" .. msg.sender.user_id)
else
send(msg.chat_id,msg.id, "•  مافيه حساب بنكي كذا","md",true)
Redis:del(Black.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(Black.."transn" .. msg.sender.user_id)
end
end

if text and text:match("^اضف فلوس (.*)$") and msg.reply_to_message_id ~= 0 then
local UserName = text:match('^اضف فلوس (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  بلاك ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
Redis:incrby(Black.."boob"..Remsg.sender.user_id , coniss)
ccccc = Redis:get(Black.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(Black.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(Black.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuuu.." )\n•  الزرف ↢ ( "..ppppp.." دولار 💵 )\n•  صار رصيده ↢ ( "..ballanceed.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end
end
if text and text:match("^خصم فلوس (.*)$") and msg.reply_to_message_id ~= 0 then
local UserName = text:match('^خصم فلوس (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*•  بلاك ماعنده حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
Redis:decrby(Black.."boob"..Remsg.sender.user_id , coniss)
ccccc = Redis:get(Black.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(Black.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(Black.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
send(msg.chat_id,msg.id, "•  الاسم ↢ "..news.."\n•  الحساب ↢ `"..ccccc.."`\n•  بنك ↢ ( بلاك )\n•  نوع ↢ ( "..uuuuu.." )\n•  الزرف ↢ ( "..ppppp.." دولار 💵 )\n•  صار رصيده ↢ ( "..ballanceed.." دولار 💵 )\n✦","md",true)
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end
end
if text == "توب فلوس" or text == "توب الفلوس" then
local bank_users = Redis:smembers(Black.."booob")
if #bank_users == 0 then
return send(msg.chat_id,msg.id,"•  لا يوجد حسابات في البنك","md",true)
end
top_mony = "توب اغنى 10 شخص في البوت :\n\n"
mony_list = {}
for k,v in pairs(bank_users) do
local mony = Redis:get(Black.."boob"..v)
table.insert(mony_list, {tonumber(mony) , v})
end
table.sort(mony_list, function(a, b) return a[1] > b[1] end)
num = 1
emoji ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10"
}
for k,v in pairs(mony_list) do
if num <= 10 then
local user_name = LuaTele.getUser(v[2]).first_name
if user_name then
nname = user_name
else
nname = ""
end
local user_tag = '['..nname..'](tg://user?id='..v[2]..')'
local mony = v[1]
local emo = emoji[k]
num = num + 1
top_mony = top_mony.."*"..emo.."*) *"..mony.."* 💰 l ["..nname.."] \n"
end
end
return send(msg.chat_id,msg.id,top_mony,"md")
end

if text == "توب الحراميه" or text == "توب الحرامية" or text == "توب حراميه" or text == "توب الزرف" or text == "توب زرف" then
local ty_users = Redis:smembers(Black.."zrfffid")
if #ty_users == 0 then
return send(msg.chat_id,msg.id,"•  لا يوجد احد","md",true)
end
ty_anubis = "توب 10 اشخاص زرفوا فلوس :\n\n"
ty_list = {}
for k,v in pairs(ty_users) do
local mony = Redis:get(Black.."zrfff"..v)
table.insert(ty_list, {tonumber(mony) , v})
end
table.sort(ty_list, function(a, b) return a[1] > b[1] end)
num_ty = 1
emojii ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10"
}
for k,v in pairs(ty_list) do
if num_ty <= 10 then
local user_name = LuaTele.getUser(v[2]).first_name
if user_name then
nname = user_name
else
nname = ""
end
local user_tag = '['..nname..'](tg://user?id='..v[2]..')'
local mony = v[1]
local emoo = emojii[k]
num_ty = num_ty + 1
ty_anubis = ty_anubis.."*"..emoo.."*) *"..mony.."* 💵 l ["..nname.."] \n"
end
end
return send(msg.chat_id,msg.id,ty_anubis,"md")
end

if text == 'بخشيش' or text == 'بقشيش' then
if Redis:sismember(Black.."booob",msg.sender.user_id) then
if Redis:get(Black.."iioo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."iioo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  من شوي اخذت بخشيش استنى ( "..time_ex.." )","md",true)
end
local jjjo = math.random(1,200);
Redis:incrby(Black.."boob"..msg.sender.user_id , jjjo)
send(msg.chat_id,msg.id,"•  تكرم وهي بخشيش "..jjjo.." دولار 💵","md",true)
Redis:setex(Black.."iioo" .. msg.sender.user_id,600, true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end


if text == 'زرف' or text == "سرقه" or text == 'زرفو' or text == 'زرفه' and tonumber(msg.reply_to_message_id) ~= 0 then
if not Redis:sismember(Black.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي")
end
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.Merotele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*• البوت ماعنده حساب بالبنك *","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
send(msg.chat_id,msg.id,"\n*•  بدك تزرف نفسك 🤡*","md",true)  
return false
end
if Redis:get(Black.."polic" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."polic" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  انتا بالسجن 🏤 استنى ( "..time_ex.." )","md",true)
end
if Redis:get(Black.."hrame" .. Remsg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."hrame" .. Remsg.sender.user_id))
return send(msg.chat_id,msg.id,"•  ذا المسكين مزروف قبل شوي\n•  يمديك تزرفه بعد ( "..time_ex.." )","md",true)
end
if Redis:sismember(Black.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
if tonumber(ballanceed) < 199 then
return send(msg.chat_id,msg.id, "• ما يمديك تزرفه فلوسه اقل من 200 دولار 💵","md",true)
end
local hrame = math.floor(math.random() * 200) + 1;
local hramee = math.floor(math.random() * 5) + 1;
if hramee == 1 or hramee == 2 or hramee == 3 or hramee == 4 then
local ballanceed = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
Redis:incrby(Black.."boob"..msg.sender.user_id , hrame)
Redis:decrby(Black.."boob"..Remsg.sender.user_id , hrame)
Redis:setex(Black.."hrame" .. Remsg.sender.user_id,900, true)
Redis:incrby(Black.."zrfff"..msg.sender.user_id,hrame)
Redis:sadd(Black.."zrfffid",msg.sender.user_id)
send(msg.chat_id,msg.id, "•  خذ يالحرامي زرفته "..hrame.." دولار 💵\n✦","md",true)
else
Redis:setex(Black.."polic" .. msg.sender.user_id,300, true)
send(msg.chat_id,msg.id, "•  مسكتك الشرطة وانتا تزرف 🚔\n✦","md",true)
end
else
send(msg.chat_id,msg.id, "•  ماعنده حساب بنكي ","md",true)
end
end

if text == 'راتب' or text == 'راتبي' then
if Redis:sismember(Black.."booob",msg.sender.user_id) then
if Redis:get(Black.."iiioo" .. msg.sender.user_id) then
local time_ex = ctime(Redis:ttl(Black.."iiioo" .. msg.sender.user_id))
return send(msg.chat_id,msg.id,"•  راتبك بينزل بعد ( "..time_ex.." )","md",true)
end
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
local jobs = {"طيار","محامي","دكتور","خباز","مدير بنك","قلب ستيفن","مدرس","فتاحه"}
local job = jobs[math.random(#jobs)]
if job == "طيار" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 500)
ratbk = "500"
your_job = "طيار 🚀"
elseif job == "محامي" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 300)
ratbk = "300"
your_job = "محامي 👨‍🎓"
elseif job == "دكتور" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 600)
ratbk = "600"
your_job = "دكتور 👨‍🔬‍"
elseif job == "خباز" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 100)
ratbk = "100"
your_job = "خباز ‍💆‍♂️"
elseif job == "مدير بنك" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 800)
ratbk = "800"
your_job = "مدير بنك ‍👨‍💼"
elseif job == "قلب ستيفن" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 1000)
ratbk = "1000"
your_job = "قلب ستيفن ♥"
elseif job == "مدرس" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 400)
ratbk = "400"
your_job = "مدرس 🤵"
elseif job == "فتاحه" then
Redis:incrby(Black.."boob"..msg.sender.user_id , 5000)
ratbk = "5000"
your_job = "فتاحه 💋"
end
local ballancee = Redis:get(Black.."boob"..msg.sender.user_id) or 0
send(msg.chat_id,msg.id,"• اشعار ايداع "..neews.."\n• وظيفتك : "..your_job.."\n• المبلغ : "..ratbk.." دولار 💵\n• نوع العملية : اضافة راتب\n• رصيدك الحين : "..ballancee.." دولار 💵","md",true)
Redis:setex(Black.."iiioo" .. msg.sender.user_id,600, true)
else
send(msg.chat_id,msg.id, "•  ماعندك حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end
if text and text:match("^هجوم (.*)$") then
if tonumber(msg.reply_to_message_id) == 0 then
return send(msg.chat_id,msg.id, "• استخدم الامر بالرد علي الاعضاء")
end
if not Redis:sismember(Black.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي")
end
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.Merotele == "userTypeBot" then
send(msg.chat_id,msg.id,"\n*• البوت ماعنده حساب بالبنك *","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
send(msg.chat_id,msg.id,"\n*• ما ينفع تهاجم نفسك*","md",true)  
return false
end
if not Redis:sismember(Black.."booob",Remsg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عنده حساب بنكي")
end
if Redis:get(Black..'hgomm'..msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• استنا "..ctime(Redis:ttl(Black..'hgomm'..msg.sender.user_id)).." وبعدين هاجم تاني")
end

local num = text:match('^هجوم (.*)$')
local coniss = tostring(num)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = coniss:gsub('-','')
local coniss = tonumber(coniss)
local my_balance = Redis:get(Black.."boob"..msg.sender.user_id) or 0
local his_balance = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
if tonumber(my_balance) < coniss then
return send(msg.chat_id,msg.id, "• فلوسك اقل من هذا المبلغ")
end
if tonumber(his_balance) < coniss then
return send(msg.chat_id,msg.id, "• فلوسه اقل من هذا المبلغ")
end
local rand = math.random(1,10)
if tonumber(rand) < 5 then
Redis:incrby(Black.."boob"..msg.sender.user_id , coniss)
Redis:decrby(Black.."boob"..Remsg.sender.user_id , coniss)
local balance = Redis:get(Black.."boob"..msg.sender.user_id) or 0
local Hbalance = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
Redis:setex(Black..'hgomm'..msg.sender.user_id,300,true)
return send(msg.chat_id,msg.id, "• نجحت في الهجوم وسرقت منه "..coniss.."\n• اصبح رصيدك الان "..balance.."\n• اصبح رصيده هو "..Hbalance)
else
Redis:incrby(Black.."boob"..Remsg.sender.user_id , coniss)
Redis:decrby(Black.."boob"..msg.sender.user_id , coniss)
local balance = Redis:get(Black.."boob"..msg.sender.user_id) or 0
local Hbalance = Redis:get(Black.."boob"..Remsg.sender.user_id) or 0
Redis:setex(Black..'hgomm'..msg.sender.user_id,300,true)
return send(msg.chat_id,msg.id, "• فشلت في الهجوم عليه وخصم منك "..coniss.."\n• اصبح رصيدك الان "..balance.."\n• اصبح رصيده هو "..Hbalance)
end
end


if text and Redis:get(Black..msg.chat_id..msg.sender.user_id.."txtrtb") then
local balance = Redis:get(Black.."boob"..msg.sender.user_id)
if text == 'مميز' and tonumber(balance)  >= 2000 then
Redis:decrby(Black.."boob"..msg.sender.user_id , 2000)
Redis:sadd(Black.."Special:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(Black..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك مميز بنجاح وخصم 3000 دولار من فلوسك")
elseif text == "ادمن" and tonumber(balance)  >= 4000 then
Redis:decrby(Black.."boob"..msg.sender.user_id , 4000)
Redis:sadd(Black.."Admin:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(Black..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك ادمن بنجاح وخصم 4000 دولار من فلوسك")
elseif text == "مدير" and tonumber(balance)  >= 6000 then
Redis:decrby(Black.."boob"..msg.sender.user_id , 6000)
Redis:sadd(Black.."Manger:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(Black..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك مدير بنجاح وخصم 6000 دولار من فلوسك")
elseif text == "منشئ" and tonumber(balance)  >= 8000 then 
Redis:decrby(Black.."boob"..msg.sender.user_id , 8000)
Redis:sadd(Black.."Creator:Group"..msg_chat_id,msg.sender.user_id) 
Redis:del(Black..msg.chat_id..msg.sender.user_id.."txtrtb") 
return send(msg.chat_id,msg.id,"• تم رفعك منشئ بنجاح وخصم 8000 دولار من فلوسك")
end
end
if text == "شراء رتبه" then
if not Redis:sismember(Black.."booob",msg.sender.user_id) then
return send(msg.chat_id,msg.id,"• ما عندك حساب بنكي \n• ارسل `انشاء حساب بنكي`","md")
end
local balance = Redis:get(Black.."boob"..msg.sender.user_id)
if tonumber(balance) == tonumber(0) then
return send(msg.chat_id,msg.id,"• ما عندك اي فلوس تشتري بيها")
end
if tonumber(balance) < 2000 then
return send(msg.chat_id,msg.id,"• فلوسك لا تكفي لشراء اي رتبه")
end
if tonumber(balance)  >= 2000 and tonumber(balance) < 4000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 دولار) \n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 4000 and tonumber(balance) < 6000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 دولار)\n• `ادمن` (4000 دولار) \n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 6000 and tonumber(balance) < 8000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 دولار)\n• `ادمن` (4000 دولار) \n• `مدير` (6000 دولار)\n\n • اضغط علي الرتبه ليتم نسخها"
elseif tonumber(balance) >= 8000 then
Txtrtb = "• الرتب اللتي يمكنك شرائها هي \n\n• `مميز` (2000 دولار)\n• `ادمن` (4000 دولار) \n• `مدير` (6000 دولار)\n• `منشئ` (8000 دولار)\n\n • اضغط علي الرتبه ليتم نسخها"
end
Redis:setex(Black..msg.chat_id..msg.sender.user_id.."txtrtb",180,true)
return send(msg.chat_id,msg.id,Txtrtb,"md")
end
----
if text == 'تفعيل ردود السورس' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(Black..'rdod:sh'..msg.chat_id,true)
send(msg_chat_id,msg_id,'\n*↯︙ تم تفعيل ردود السورس * ',"md",true)  
end
if text == 'تعطيل ردود السورس' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black..'rdod:sh'..msg.chat_id)
send(msg_chat_id,msg_id,'\n*↯︙ تم تعطيل ردود السورس * ',"md",true)  
end
if Redis:get(Black..'rdod:sh'..msg.chat_id) then
if text == 'هاي' or text == 'هيي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هلا حبيبي*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام عليكم' or text == 'السلام عليكم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وعليكم السلام 🌝💜*',"md",false, false, false, false, reply_markup)
end
if text == 'سلام' or text == 'مع سلامه' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*مع الف سلامه وماريد اشوفك بعد 👍🏻*',"md",false, false, false, false, reply_markup)
end
if text == 'خاص' or text == 'تع خاص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اخذوني وياكم خاص 😔*',"md",false, false, false, false, reply_markup)
end
if text == 'النبي' or text == 'صلي علي النبي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عليه الصلاه والسلام 🌝💛*',"md",false, false, false, false, reply_markup)
end
if text == 'نعم' or text == 'يا نعم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*نعم الله عليك 🌚❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*نزل عينك ولك *',"md",false, false, false, false, reply_markup)
end
if text == '🙄' or text == '🙄🙄' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*نزل عينك ولك*',"md",false, false, false, false, reply_markup)
end
if text == '😂' or text == '😂😂' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*شهل ضحكه الحلوا يا قميل 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '😹' or text == '😹' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*شهل ضحكه الحلوا يا قميل 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == '🤔' or text == '🤔🤔' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'* دتفكر ب شنو 🤔*',"md",false, false, false, false, reply_markup)
end
if text == '🌚' or text == '🌝' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هذا القمر يشبهك*',"md",false, false, false, false, reply_markup)
end
if text == '😭' or text == '😭😭' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ليش تبجي يروحي 😥*',"md",false, false, false, false, reply_markup)
end
if text == '🥺' or text == '🥺🥺' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*لتزعل احبك 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == '😒' or text == '😒😒' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عدل وجهك من تحاجيني 😒🙄*',"md",false, false, false, false, reply_markup)
end
if text == 'احبك' or text == 'حبك' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وانا هم اعشقك يا روحي 🤗🥰*',"md",false, false, false, false, reply_markup)
end

if text == 'هلا' or text == 'هلا وغلا' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هلا بيك ياروحي 👋*',"md",false, false, false, false, reply_markup)
end
if text == 'دي' or text == 'ديخرص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'شنو اكو كتاكيت بلكروب واني مادري??😹*',"md",false, false, false, false, reply_markup)
end
if text == 'الحمد الله' or text == 'بخير الحمد الله' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*دايما ياحبيبي 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'اووف' or text == 'اوف' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*شبيك حياتي 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'خاص' or text == 'تعالي خاص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ها اخذته يالنغل 😂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح الخير' or text == 'مساء الخير' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*انت الخير يعمري 🌝❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'صباح النور' or text == 'باح الخير' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*صباح العسل 😻🤍*',"md",false, false, false, false, reply_markup)
end
if text == 'دي' or text == 'دي لك' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*امشيك بيها حبي 😹*',"md",false, false, false, false, reply_markup)
end
if text == 'اه' or text == 'اها' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اي والله ضلعي 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'كسم' or text == 'كسمك' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*عيب يا خرا ادمن تعال ادفره 🙄💔*',"md",false, false, false, false, reply_markup)
end
if text == 'بوتي' or text == 'يا بوتي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'ما هذا بحق الجحيم 🥺💔',"md",false, false, false, false, reply_markup)
end
if text == 'تعال' or text == 'تع' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*لا عيب وين يجي 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'هسه كعدت' or text == 'توني كعدت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*صح النوم 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'منور' or text == 'نورت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*هذا نورك يحيلي 🌝💙*',"md",false, false, false, false, reply_markup)
end
if text == 'باي' or text == 'انا ماشي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*وين رايح وعايفني 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'ويت' or text == 'ويت حب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*صاير مثقف بروس الزواج 😂💖*',"md",false, false, false, false, reply_markup)
end
if text == 'خخخ' or text == 'خخخخخ' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اهدا يا وحش ميصير هيج 😒??*',"md",false, false, false, false, reply_markup)
end
if text == 'شكرا' or text == 'مرسي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*العفو ياروحي 🙈🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'حلوه' or text == 'حلو' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*انت الي حلو ياقمر 🤤🌝*',"md",false, false, false, false, reply_markup)
end
if text == 'متت' or text == 'حموت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*روح موت بعيد معايزين مصايب 😑😂*',"md",false, false, false, false, reply_markup)
end
if text == 'شنو' or text == 'شو' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*استيعابك ضعيف ضلعي😹👻*',"md",false, false, false, false, reply_markup)
end
if text == 'طيب' or text == 'تيب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*انته الطيب حبيبي 😹💋*',"md",false, false, false, false, reply_markup)
end
if text == 'حاضر' or text == 'حتر' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*حضرلك الخير يارب 🙂❤️*',"md",false, false, false, false, reply_markup)
end
if text == 'جيت' or text == 'انا جيت' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*افتر وارجع حبيبي 😂🚶‍♂👻*',"md",false, false, false, false, reply_markup)
end
if text == 'بخ' or text == 'عو' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*اوه شت جفلتني 🥺💔*',"md",false, false, false, false, reply_markup)
end
if text == 'حبيبي' or text == 'حبيبتي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*ها حياتي 🥺😂*',"md",false, false, false, false, reply_markup)
end
if text == 'تمام' or text == 'تمم' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'* امك اسمها احلام 😹😹*',"md",false, false, false, false, reply_markup)
end
if text == 'خلاص' or text == 'خلص' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*كون تخلص روحك 😹💔*',"md",false, false, false, false, reply_markup)
end
if text == 'كلخرا' or text == 'اكل خرا' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/cllllllT'}, 
},
}
}
return send(msg_chat_id,msg_id,'*تمام حط نفسك بماعون وتعال 😂*',"md",false, false, false, false, reply_markup)
end
end
if text == "الردود" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/cllllllT'}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Manager"..msg_chat_id.."")
if #list == 0 then
txx = "↯︙ عذرا لا يوجد ردود للمدير في الكروب"
else
txx = "↯︙ قائمه الردود \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if Redis:get(Black.."Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه ↯︙"
elseif Redis:get(Black.."Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو ↯︙"
end
txx = txx..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
end
end
return send(msg_chat_id,msg_id,txx)  
end
if text == "استوري" then
Rrr = math.random(4,50)
local m = "https://t.me/Qapplu/"..Rrr..""
local t = "اليك استوري عشوائي من البوت 🖇️🌚"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == "غنيلي فيديو" or text == "غنيلي بفيديو" then
Rrr = math.random(1,31)
local m = "https://t.me/ghanilyp/"..Rrr..""
local t = "اليك اغنيه ب فيديو🏴‍☠️♥️"
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown")
end
if text == 'Barloo' then
local UserId_Info = LuaTele.searchPublicChat("bar_lo0o0")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  \n\n- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  \\nn- ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == "ميمز" or text == "ميمزز" then 
Abs = math.random(2,140); 
local Text ='*↯︙تم اختيار الميمز لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/MemzDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "فلم" or text == "افلام" then 
Abs = math.random(2,140); 
local Text ='*↯︙تم اختيار الفلم لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "انمي" or text == "انمى" then 
Abs = math.random(2,140); 
local Text ='*↯︙تم اختيار انمي لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "صوره" or text == "صورة" then 
Abs = math.random(2,140); 
local Text ='*↯︙تم اختيار صوره لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/PhotosDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "متحركه" or text == "متحركة" then 
Abs = math.random(2,140); 
local Text ='*↯︙تم اختيار متحركه لك*'
local MsgId = msg.id/2097152/0.5
local MSGID = string.gsub(MsgId,'.0','')
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..MsgId.."&parse_mode=markdown") 
end
if text == "ريمكس" or text == "ريماكس" then 
Abs = math.random(2,140); 
local Text ='*↯︙️تم اختيار ريمكس لك*'
keyboardd = {} 
keyboard.inline_keyboard = {
{{text = '- Black TeAm ٠',url="t.me/cllllllT"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/remixsource/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text ='*↯︙️تم اختيار الشعر لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '- Black TeAm ٠',url="t.me/cllllllT"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/L1BBBL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "الحاسبه" or text == "حاسبه" or text == "الاله الحاسبه" then
Redis:del(Black..msg.sender.user_id..msg.chat_id.."num")
start_mrkup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = msg.sender.user_id..'ON'},{text = 'DEL', data = msg.sender.user_id..'DEL'},{text = 'AC', data = msg.sender.user_id..'rest'},{text = 'OFF', data = msg.sender.user_id..'OFF'},
},
{
{text = '^', data = msg.sender.user_id..'calc&^'},{text = '√', data = msg.sender.user_id..'calc&√'},{text = '(', data = msg.sender.user_id..'calc&('},{text = ')', data = msg.sender.user_id..'calc&)'},
},
{
{text = '7', data = msg.sender.user_id..'calc&7'},{text = '8', data = msg.sender.user_id..'calc&8'},{text = '9', data = msg.sender.user_id..'calc&9'},{text = '÷', data = msg.sender.user_id..'calc&/'},
},
{
{text = '4', data = msg.sender.user_id..'calc&4'},{text = '5', data = msg.sender.user_id..'calc&5'},{text = '6', data = msg.sender.user_id..'calc&6'},{text = 'x', data = msg.sender.user_id..'calc&*'},
},
{
{text = '1', data = msg.sender.user_id..'calc&1'},{text = '2', data = msg.sender.user_id..'calc&2'},{text = '3', data = msg.sender.user_id..'calc&3'},{text = '-', data = msg.sender.user_id..'calc&-'},
},
{
{text = '0', data = msg.sender.user_id..'calc&0'},{text = '.', data = msg.sender.user_id..'calc&.'},{text = '+', data = msg.sender.user_id..'calc&+'},{text = '=', data = msg.sender.user_id..'equal'},
},
{
{text = '- Black TeAm .', url = 'https://t.me/cllllllT'},
},
}
}
send(msg.chat_id,msg.id,"• اهلا بك في بوت الحاسبه\n• welcome to calculator","md",true, false, false, true, start_mrkup)
return false 
end
if text == "استبدال كلمه" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(Black..msg.chat_id..msg.sender.user_id.."replace",true)
return LuaTele.sendText(msg_chat_id,msg_id,'\n↯︙ارسل الكلمه القديمه ليتم استبدالها',"md",true)  
end
if text == "مسح الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(Black.."Words:r")
for k,v in pairs(list) do
Redis:del(Black.."Word:Replace"..v)
end
Redis:del(Black.."Words:r")
send(msg_chat_id,msg_id,"↯︙تم مسح الكلمات المستبدله")
end
if text == "الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*↯︙هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(Black.."Words:r")
if #list == 0 then
return send(msg.chat_id,msg.id,"↯︙لا توجد كلمات مستبدله")
end
local txx = " قائمه الكلمات المستبدله \n"
for k,v in pairs(list) do 
cmdd = Redis:get(Black.."Word:Replace"..v)
txx = txx..k.." - "..v.." ↫↫ "..cmdd.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,txx)
end
if text then
if text:match("^بحث (.*)$") then
local search = text:match("^بحث (.*)$")
local json = json:decode(http.request("https://api-jack.ml/api18.php?search="..URL.escape(search)..""))
local datar = {data = {{text = "- Black TeAm ." , url = 'https://t.me/cllllllT'}}}
for i = 1,5 do
title = json.results[i].title
link = json.results[i].url
datar[i] = {{text = title , data =msg.sender.user_id.."dl/"..link}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
LuaTele.sendText(msg.chat_id,msg.id,'↯︙نتائج البحث عن الكلمه :  *'..search..'*',"md",false, false, false, false, reply_markup)
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "truedel" then
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"truefguigf1")
Redis:del(Black.."gamebot:newqus"..msg.chat_id,text)
Redis:srem(Black.."gamebot:new1", text)
return send(msg_chat_id,msg_id, '\nتم مسح السؤال بنجاح') 
end
end

if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true1")
Redis:set(Black.."gamebot:newqus"..msg.chat_id,text)
Redis:sadd(Black.."gamebot:new1", text)
return send(msg_chat_id,msg_id, '\nتم حفظ السؤال بنجاح \n ارسل الجواب الاول') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
local quschen = Redis:get(Black.."gamebot:newqus"..msg.chat_id)
Redis:set(Black.."gamebot:newqus:as1"..quschen,text)
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true2")
return send(msg_chat_id,msg_id, ' \n ارسل الجواب الثاني') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true2" then
local quschen = Redis:get(Black.."gamebot:newqus"..msg.chat_id)
Redis:set(Black.."gamebot:newqus:as2"..quschen,text)
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true3")
return send(msg_chat_id,msg_id, '\n ارسل الجواب الثالث') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true3" then
local quschen = Redis:get(Black.."gamebot:newqus"..msg.chat_id)
Redis:set(Black.."gamebot:newqus:as3"..quschen,text)
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true4")
return send(msg_chat_id,msg_id, '\n ارسل الجواب الرابع') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true4" then
local quschen = Redis:get(Black.."gamebot:newqus"..msg.chat_id)
Redis:set(Black.."gamebot:newqus:as0"..quschen,text)
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true44")
return send(msg_chat_id,msg_id, '\nتم حفظ الاجوبه \n ارسل الجواب الصحيح') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true44" then
local quschen = Redis:get(Black.."gamebot:newqus"..msg.chat_id)
Redis:set(Black.."gamebot:newqus:as4"..quschen,text)
Redis:set(Black.."gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true186")
return send(msg_chat_id,msg_id, '\nتم حفظ الجواب الصحيح') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "truedel" then
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"truefguigf1")
Redis:del(Black.."lkz:gamebot:newqus"..msg.chat_id,text)
Redis:srem(Black.."lkz:gamebot:new1", text)
send(msg_chat_id,msg_id, '\nتم مسح الغز بنجاح')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true1")
Redis:set(Black.."lkz:gamebot:newqus"..msg.chat_id,text)
Redis:sadd(Black.."lkz:gamebot:new1", text)
send(msg_chat_id,msg_id, '\nتم حفظ اللغز بنجاح \n ارسل الجواب الاول')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
local quschen = Redis:get(Black.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(Black.."lkz:gamebot:newqus:as1"..quschen,text)
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true2")
send(msg_chat_id,msg_id, ' \n ارسل الجواب الثاني')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true2" then
local quschen = Redis:get(Black.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(Black.."lkz:gamebot:newqus:as2"..quschen,text)
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true3")
send(msg_chat_id,msg_id, '\n ارسل الجواب الثالث')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true3" then
local quschen = Redis:get(Black.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(Black.."lkz:gamebot:newqus:as3"..quschen,text)
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true44")
send(msg_chat_id,msg_id, ' \n ارسل الجواب الصحيح')
return false 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id) == "true44" then
local quschen = Redis:get(Black.."lkz:gamebot:newqus"..msg.chat_id)
Redis:set(Black.."lkz:gamebot:newqus:as4"..quschen,text)
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,"true186")
send(msg_chat_id,msg_id, '\nتم حفظ الجواب الصحيح')
return false 
end
end

if text == "اضف لغز" then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,true)
return send(msg_chat_id,msg_id,"ارسل اللغز الان ")
end
if text == "مسح لغز" then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:set(Black.."lkz:gamebot:new"..msg.sender.user_id..":"..msg.chat_id,'truedel')
return send(msg_chat_id,msg_id,"ارسل اللغز الان ")
end
if text == 'الالغاز' then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
local list = Redis:smembers(Black.."lkz:gamebot:new1")
t = "• الالغاز : \n"
for k,v in pairs(list) do
t = t..""..k.."- (["..v.."])\n"
end
if #list == 0 then
t = "• لا يوجد الغازمضافه"
end
return send(msg_chat_id,msg_id,t)
end
if text == 'مسح الالغاز' then

if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(2)..' }* ',"md",true)  
end
Redis:del(Black.."lkz:gamebot:new1")
return send(msg_chat_id,msg_id,'تم مسح الالغاز جميعا ')
end

if text == 'لغز' then
local list = Redis:smembers(Black.."lkz:gamebot:new1")
if #list ~= 0 then
local quschen = list[math.random(#list)]
local ansar1 = Redis:get(Black.."lkz:gamebot:newqus:as1"..quschen)
local ansar2 = Redis:get(Black.."lkz:gamebot:newqus:as2"..quschen)
local ansar3 = Redis:get(Black.."lkz:gamebot:newqus:as3"..quschen)
local ansar4 = Redis:get(Black.."lkz:gamebot:newqus:as4"..quschen)
if ansar1 == ansar4 then
tt = 'ansar1'
elseif ansar2 == ansar4 then
tt = 'ansar2'
elseif ansar3 == ansar4 then
tt = 'ansar3'
end
print(tt)
if tt == 'ansar1' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'صحيح1'},
},
{
{text = ansar2, data = 'غلط1'},
},
{
{text = ansar3, data = 'غلط1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
elseif tt == 'ansar2' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'غلط1'},
},
{
{text = ansar2, data = 'صحيح1'},
},
{
{text = ansar3, data = 'غلط1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
elseif tt == 'ansar3' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ansar1, data = 'غلط1'},
},
{
{text = ansar2, data = 'غلط1'},
},
{
{text = ansar3, data = 'صحيح1'},
},
}
}
send(msg_chat_id,msg_id,quschen,"md",false, false, false, false, reply_markup)
end

end
end
if text and text:match('^تحكم @(%S+)$') then
local UserName = text:match('^تحكم @(%S+)$') 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n• عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n• عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
SuperCreator = Redis:sismember(Black.."SuperCreator:Group"..msg.chat_id,UserId_Info.id) 
Creator = Redis:sismember(Black.."Creator:Group"..msg.chat_id,UserId_Info.id)
Manger = Redis:sismember(Black.."Manger:Group"..msg.chat_id,UserId_Info.id)
Admin = Redis:sismember(Black.."Admin:Group"..msg.chat_id,UserId_Info.id)
Special = Redis:sismember(Black.."Special:Group"..msg.chat_id,UserId_Info.id)
BanGroup = Redis:sismember(Black.."BanGroup:Group"..msg.chat_id,UserId_Info.id)
SilentGroup = Redis:sismember(Black.."SilentGroup:Group"..msg.chat_id,UserId_Info.id)
if BanGroup then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if SilentGroup then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if SuperCreator then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Creator then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Manger then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Admin then
Adminz = "✔"
else
Adminz = "❌"
end
if Special then
Specialz = "✔"
else
Specialz = "❌"
end

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =msg.sender.user_id..'/statusSuperCreatorz/'..UserId_Info.id},{text = '- منشئ : '..Creatorz, data =msg.sender.user_id..'/statusCreatorz/'..UserId_Info.id},
},
{
{text = '- مدير : '..Mangerz, data =msg.sender.user_id..'/statusMangerz/'..UserId_Info.id},{text = '- ادمن : '..Adminz, data =msg.sender.user_id..'/statusAdminz/'..UserId_Info.id},
},
{
{text = '- مميز : '..Specialz, data =msg.sender.user_id..'/statusSpecialz/'..UserId_Info.id},
},
{
{text = '- الحظر : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..UserId_Info.id},{text = '- الكتم : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..UserId_Info.id},
},
{
{text = '- عضو  ', data =msg.sender.user_id..'/statusmem/'..UserId_Info.id},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return send(msg.chat_id,msg.id,'*\n• تحكم برتب الشخص*',"md",false, false, false, false, reply_markup)
end
if text == 'تحكم' and msg.reply_to_message_id > 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*• هذا الامر يخص { '..Controller_Num(7)..' }* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
SuperCreator = Redis:sismember(Black.."SuperCreator:Group"..msg.chat_id,Message_Reply.sender.user_id) 
Creator = Redis:sismember(Black.."Creator:Group"..msg.chat_id,Message_Reply.sender.user_id)
Manger = Redis:sismember(Black.."Manger:Group"..msg.chat_id,Message_Reply.sender.user_id)
Admin = Redis:sismember(Black.."Admin:Group"..msg.chat_id,Message_Reply.sender.user_id)
Special = Redis:sismember(Black.."Special:Group"..msg.chat_id,Message_Reply.sender.user_id)
BanGroup = Redis:sismember(Black.."BanGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
SilentGroup = Redis:sismember(Black.."SilentGroup:Group"..msg.chat_id,Message_Reply.sender.user_id)
if BanGroup then
BanGroupz = "✔"
else
BanGroupz = "❌"
end
if SilentGroup then
SilentGroupz = "✔"
else
SilentGroupz = "❌"
end
if SuperCreator then
SuperCreatorz = "✔"
else
SuperCreatorz = "❌"
end
if Creator then
Creatorz = "✔"
else
Creatorz = "❌"
end
if Manger then
Mangerz = "✔"
else
Mangerz = "❌"
end
if Admin then
Adminz = "✔"
else
Adminz = "❌"
end
if Special then
Specialz = "✔"
else
Specialz = "❌"
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = '- منشئ اساسي : '..SuperCreatorz, data =msg.sender.user_id..'/statusSuperCreatorz/'..Message_Reply.sender.user_id},{text = '- منشئ : '..Creatorz, data =msg.sender.user_id..'/statusCreatorz/'..Message_Reply.sender.user_id},
},
{
{text = '- مدير : '..Mangerz, data =msg.sender.user_id..'/statusMangerz/'..Message_Reply.sender.user_id},{text = '- ادمن : '..Adminz, data =msg.sender.user_id..'/statusAdminz/'..Message_Reply.sender.user_id},
},
{
{text = '- مميز : '..Specialz, data =msg.sender.user_id..'/statusSpecialz/'..Message_Reply.sender.user_id},
},
{
{text = '- الحظر : '..BanGroupz, data =msg.sender.user_id..'/statusban/'..Message_Reply.sender.user_id},{text = '- الكتم : '..SilentGroupz, data =msg.sender.user_id..'/statusktm/'..Message_Reply.sender.user_id},
},
{
{text = '- عضو  ', data =msg.sender.user_id..'/statusmem/'..Message_Reply.sender.user_id},
},
{
{text = '- اخفاء الامر ', data ='/delAmr1'}
}
}
}
return send(msg.chat_id,msg.id,'*\n• تحكم برتب الشخص*',"md",false, false, false, false, reply_markup)
end
if text then
if text:match("^حظر من السيرفر (%d+)$") then
if tonumber(msg.sender.user_id) == tonumber(5421129731) then
local iduser = tonumber(text:match("^حظر من السيرفر (%d+)$"))
Redis:sadd("banserver",iduser)
send(msg.chat_id,msg.id,"• تم حظر العضو من السيرفر")
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
end
if text then
if text:match("^الغاء حظر من السيرفر (%d+)$") then
if tonumber(msg.sender.user_id) == tonumber(5421129731) then
local iduser = tonumber(text:match("^الغاء حظر من السيرفر (%d+)$"))
Redis:srem("banserver",iduser)
send(msg.chat_id,msg.id,"• تم الغاء حظر العضو من السيرفر")
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
end
if text == "المحظورين من السيرفر" then
if tonumber(msg.sender.user_id) == tonumber(5421129731) then
local list = Redis:smembers("banserver")
if #list == 0 then
return send(msg.chat_id,msg.id,"• القائمه فارغه")
end
local txx = "المحظورين من السيرفر \n"
for k,v in pairs(list) do 
xx = LuaTele.getUser(v)
if xx.username then 
users = "@"..xx.username
else
users = v
end
txx = txx..' k - '..users..'\n'
end
send(msg.chat_id,msg.id,txx)
else
send(msg.chat_id,msg.id,"• للمبرمج ستيفن فقط")
end
end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
photo = "https://t.me/mmkvjg/266"
local T =[[
↯︙Welcome To Source
↯︙[ TeAm. Black ](t.me/cllllllT)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '( Source channel )', url = "https://t.me/cllllllT"}
},
{
{text = '(Source Dev)', url = "https://t.me/UI_zc"},{text = '( Exp Source )', url = "https://t.me/DGGEO"},
},
{
{text = '(Tws Source )', url = "https://t.me/g1boebot"}
}, 
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(T).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'الاوامر' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = msg.sender.user_id..'/help1'}, {text = '(2)', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '(3)', data = msg.sender.user_id..'/help3'}, {text = '(4)', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '(5)', data = msg.sender.user_id..'/help5'}, {text = '(6)', data = msg.sender.user_id..'/help7'}, 
},
{
{text = '( الالعــاب )', data = msg.sender.user_id..'/help6'}, 
},
{
{text = 'اوامر القفل', data = msg.sender.user_id..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = msg.sender.user_id..'/listallAddorrem'}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
↯︙اهلا بك في قائمة الاوامر ↫ ⤈ 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙م1 ↫ اوامر الحمايه
↯︙م2 ↫ اوامر الادمنيه
↯︙م3 ↫ اوامر المدراء
↯︙م4 ↫ اوامر المنشئين
↯︙م5 ↫ اوامر المطورين
↯︙م6 ↫ اوامر التسليه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙TeAm. Black
*]],"md",false, false, false, false, reply_markup)
elseif text == 'م1' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م2' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م3' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م4' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م5' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م6' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'↯︙ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
end

if text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "↯︙ تم تحديث الملفات ","md",true)
dofile('Black.lua')  
end
if text == "تغيير اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Name:Bot") 
return send(msg_chat_id,msg_id,"↯︙ تم حذف اسم البوت ","md",true)   
end
if text == (Redis:get(Black.."Name:Bot") or "بلاك") then
if Redis:get(Black.."name bot type : ") == "photo" then
  local photo = LuaTele.getUserProfilePhotos(Black)
  local UserInfo = LuaTele.getUser(Black)
  local Name_User = UserInfo.first_name
  local Name_dev = LuaTele.getUser(Sudo_Id).first_name
  local UName_dev = LuaTele.getUser(Sudo_Id).username
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
    {
      {text = Name_User, url = "t.me/"..UserInfo.username}
    },
    {
      {text = Name_dev, url = "t.me/"..UName_dev }
    }
  }
  }
  
  if photo.total_count > 0 then
    local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
    local NameBots = {
"قلب "..NamesBot ,
"كول حبيبي ؟ شرايود 😂",
"ها حياتي كول محتاج شي ? ",
"مو فارغ هسه فد شويه و اجيكم",
"ها يكلبي ودكاته وكل حياتي 😂💖"
}
  return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,NameBots[math.random(#NameBots)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
  else
    local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
    local NameBots = {
"قلب "..NamesBot ,
"كول حبيبي ؟ شرايود 😂",
"ها حياتي كول محتاج شي ? ",
"مو فارغ هسه فد شويه و اجيكم",
"ها يكلبي ودكاته وكل حياتي 😂💖"
}
  return send(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
  end 
  end
      local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
    local NameBots = {
"قلب "..NamesBot ,
"كول حبيبي ؟ شرايود 😂",
"ها حياتي كول محتاج شي ? ",
"مو فارغ هسه فد شويه و اجيكم",
"ها يكلبي ودكاته وكل حياتي 😂💖"
}
  return send(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
 
end
----
----
if text == "بوت" then
if Redis:get(Black.."name bot type : ") == "photo" then
  
    local photo = LuaTele.getUserProfilePhotos(Black)
    local UserInfo = LuaTele.getUser(Black)
    local Name_User = UserInfo.first_name
    local Name_dev = LuaTele.getUser(Sudo_Id).first_name
    local UName_dev = LuaTele.getUser(Sudo_Id).username
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
      {
        {text = Name_User, url = "t.me/"..UserInfo.username}
      },
      {
        {text = Name_dev, url = "t.me/"..UName_dev }
      }
    }
    }
    
    if photo.total_count > 0 then
      local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
      local BotName = {
"اسمي "..NamesBot.." يحبي 🥺💞",
      "خليني اريد انام يول 😑",
      "انته شرايووود 😂 ؟",
      "اسمي "..NamesBot.." يا خرا 😂",
      "مدتشوف اسمي يمعود ؟"
      }
    return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,BotName[math.random(#BotName)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
    else
      local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
      local BotName = {
"اسمي "..NamesBot.." يحبي 🥺💞",
      "خليني اريد انام يول 😑",
      "انته شرايووود 😂 ؟",
      "اسمي "..NamesBot.." يا خرا 😂",
      "مدتشوف اسمي يمعود ؟"
      }
    return send(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 
    end 
    end
          local NamesBot = (Redis:get(Black.."Name:Bot") or "بلاك")
      local BotName = {
"اسمي "..NamesBot.." يحبي 🥺💞",
      "خليني اريد انام يول 😑",
      "انته شرايووود 😂 ؟",
      "اسمي "..NamesBot.." يا خرا 😂",
      "مدتشوف اسمي يمعود ؟"
      }
    return send(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 

  end
  ----
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Black..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' }\n↯︙ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' }\n↯︙ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Black)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*↯︙ البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(Black..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Black..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Black..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Black..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' } للمجموعات \n↯︙ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n↯︙ تم تعطيل الكروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' } للمجموعات \n↯︙ لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","🌡","💣","↯︙","📍","📓","📗","📂","📅","📪","📫","↯︙","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(Black.."Game:Smile"..msg.chat_id,SM)
return send(msg_chat_id,msg_id,"↯︙اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end
if text == "تويت" or text == "كت تويت" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس بلاك؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس بلاك؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"شنو رايك في سورس بلاك؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"شنو رايك بالدنيا هاي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هيه امنيتك ? ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "بوب" or text == "مشاهير" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
KlamSpeed = {"شوان","سام","ايد شيرين","جاستين","اريانا","سام سميث","ايد","جاستين","معزه","ميسي","صلاح","محمد صلاح","احمد عز","كريستيانو","كريستيانو رونالدو","رامز جلال","امير كراره","ويجز","بابلو","تامر حسني","ابيو","شيرين","نانسي عجرم","محمد رمضان","احمد حلمي","محمد هنيدي","حسن حسني","حماقي","احمد مكي"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(Black.."mshaher"..msg.chat_id,name)
name = string.gsub(name,"شوان","https://t.me/HC6HH/8")
name = string.gsub(name,"سام","https://t.me/HC6HH/7")
name = string.gsub(name,"سام سميث","https://t.me/HC6HH/7")
name = string.gsub(name,"ايد شيرين","https://t.me/HC6HH/6")
name = string.gsub(name,"ايد","https://t.me/HC6HH/6")
name = string.gsub(name,"جاستين","https://t.me/HC6HH/4")
name = string.gsub(name,"جاستين بيبر","https://t.me/HC6HH/4")
name = string.gsub(name,"اريانا","https://t.me/HC6HH/5")
name = string.gsub(name,"ميسي","https://t.me/HC6HH/10")
name = string.gsub(name,"معزه","https://t.me/HC6HH/10")
name = string.gsub(name,"صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"محمد صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"احمد عز","https://t.me/HC6HH/12")
name = string.gsub(name,"كريم عبدالعزيز","https://t.me/HC6HH/11")
name = string.gsub(name,"كريستيانو رونالدو","https://t.me/HC6HH/13")
name = string.gsub(name,"كريستيانو","https://t.me/HC6HH/13")
name = string.gsub(name,"امير كراره","https://t.me/HC6HH/14")
name = string.gsub(name,"رامز جلال","https://t.me/HC6HH/15")
name = string.gsub(name,"ويجز","https://t.me/HC6HH/16")
name = string.gsub(name,"بابلو","https://t.me/HC6HH/17")
name = string.gsub(name,"ابيو","https://t.me/HC6HH/20")
name = string.gsub(name,"شيرين","https://t.me/HC6HH/21")
name = string.gsub(name,"نانسي عجرم","https://t.me/HC6HH/22")
name = string.gsub(name,"محمد رمضان","https://t.me/HC6HH/25")
name = string.gsub(name,"احمد حلمي","https://t.me/HC6HH/26")
name = string.gsub(name,"محمد هنيدي","https://t.me/HC6HH/27")
name = string.gsub(name,"حسن حسني","https://t.me/HC6HH/28")
name = string.gsub(name,"احمد مكي","https://t.me/HC6HH/29")
name = string.gsub(name,"تامر حسني","https://t.me/HC6HH/30")
name = string.gsub(name,"حماقي","https://t.me/HC6HH/31")
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..name.."&caption="..URL.escape("اسرع واحد يقول اسم هذا الفنان").."&reply_to_message_id="..(msg.id/2097152/0.5))
--return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "الاسرع" or text == "ترتيب" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفذ","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","قهوه","سفينه","بلاك","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","لعبه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(Black.."Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفذ","ذ ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بلاك","ر و ف ر ي")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"قهوه","ه ق ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"مصر","ص م ر")
name = string.gsub(name,"لعبه","ع ل ه ب")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنت","ا ت ن ن  ر ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "خيروك" or text == "لو خيروك" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
local texting = {
"الو خيروك بين البقاء مدى الحياة مع أخيك أو البقاء مدى الحياة مع حبيبك من تختار؟",
"لو عرضوا عليك السفر لمدة 20 عام مع شخص واحد فقط من تختار؟",
"امن تحب أكثر والدك أم والدتك؟",
"الو خيروك بين إعطاء هدية باهظة الثمن لفرد من أفراد أسرتك من تختار؟",
"لو خيروك بين الذكاء أو الثراء ماذا تختار؟",
"لو خيروك بين الزواج من شخص تحبه أو شخص سيحقق لك جميع أحلامك من تختار؟",
"الو خيروك بين المكوث مدى الحياة مع صديقك المفضل أو مع حبيبك من تختار؟",
"الو خيروك بين الشهادة الجامعية أو السفر حول العالم؟",
"الو خيروك بين العيش في نيويورك أو في لندن أيهما تختار؟",
"لو خيروك بين العودة إلى الماضي أو الذهاب إلى المستقبل أيهما تختار؟",
"لو خيروك بين تمتع شريك حياتك بصفة من الأثنين الطيبة أو حسن التصرف أيهما تختار؟",
"لو خيروك بين الزواج من شخص في عمرك فقير أو شخص يكبرك بعشرين عام غني من تختار",
"لو خيروك بين قتلك بالسم أو قتلك بالمسدس ماذا تختار؟",
"لو خيروك بين إنقاذ والدك أو إنقاذ والدتك من تختار؟",
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "صراحه" or text == "جرأه" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
local texting = {
"هل تعرضت لغدر في حياتك؟",
"هل تعرف عيوبك؟",
"هل أنت مُسامح أم لا تستطيع أن تُسامح؟",
"إذا قمت بالسفر إلى نُزهة خارج بلدك فمن هو الشخص الذي تُحب أن يُرافقك؟هل تتدخل إذا وجدت شخص يتعرض لحادثة سير أم تتركه وترحل؟",
"ما هو الشخص الذي لا تستطيع أن ترفض له أي طلب؟",
"إذا أعجبت بشخصٍ ما، كيف تُظهر له هذا الإعجاب أو ما هي الطريقة التي ستتبعها لتظهر إعجابك به؟",
"هل ترى نفسك مُتناقضً؟",
"ما هو الموقف الذي تعرضت فيه إلى الاحراج المُبرح؟",
"ما هو الموقف الذي جعلك تبكي أمام مجموعة من الناس رغمًا عنك؟",
"إذا جاء شريك حياتك وطلب الانفصال، فماذا يكون ردك وقته؟",
"إذا كان والد يعمل بعملٍ فقير هل تقبل به أو تستعر منه؟",
"ما الذي يجعلك تُصاب بالغضب الشديد؟",
"هإذا وجدت الشخص الذي أحببتهُ في يومٍ ما يمسك بطفله، هل هذا سيشعرك بالألم؟",
"علاقتك مع اهلك",
"ثلاثة أشياء تحبها"
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حزوره" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(Black.."Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يحل الحزوره ↓\n {"..name.."}","md",true)  
end
end

if text == "اعلام" or text == "اعلام ودول" or text == "اعلام و دول" or text == "دول" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Redis:del(Black.."Set:Country"..msg.chat_id)
Country_Rand = {"مصر","العراق","السعوديه","المانيا","تونس","الجزائر","فلسطين","اليمن","المغرب","البحرين","فرنسا","سويسرا","تركيا","انجلترا","الولايات المتحده","كندا","الكويت","ليبيا","السودان","سوريا"}
name = Country_Rand[math.random(#Country_Rand)]
Redis:set(Black.."Game:Countrygof"..msg.chat_id,name)
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"المانيا","🇩🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"المغرب","🇲🇦")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"فرنسا","🇫🇷")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"انجلترا","🇬🇧")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"الولايات المتحده","🇱🇷")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"الكويت","🇰🇼")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"سوريا","🇸🇾")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يرسل اسم الدولة ~ {"..name.."}","md",true)  
end
end

if text == "معاني" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Redis:del(Black.."Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(Black.."Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يدز معنى السمايل ~ {"..name.."}","md",true)  
end
end
if text == "انجليزي" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Redis:del(Black.."Set:enkliz"..msg.chat_id)
enkliz_Rand = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = enkliz_Rand[math.random(#enkliz_Rand)]
Redis:set(Black.."Game:enkliz"..msg.chat_id,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يترجم ~ {"..name.."}","md",true)  
end
end
if text == "العكس" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Redis:del(Black.."Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(Black.."Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"و","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يدز العكس ~ {"..name.."}","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(Black.."Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ↫ { 👊 }', data = '/Mahibes1'}, {text = '𝟐 ↫ { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 ↫ { 👊 }', data = '/Mahibes3'}, {text = '𝟒 ↫ { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 ↫ { 👊 }', data = '/Mahibes5'}, {text = '𝟔 ↫ { 👊 }', data = '/Mahibes6'}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
↯︙ لعبة المحيبس هي لعبة الحظ 
↯︙ جرب حظك ويه البوت واتونس 
↯︙ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(Black.."Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(Black.."Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return send(msg_chat_id,msg_id,"\n↯︙ اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."↯︙ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."↯︙سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","??","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(Black.."Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍??👩‍‍💻👨‍💻??‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️??‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يدز الاختلاف ~ {"..name.."}","md",true)  
end
end
if text == "امثله" then
if Redis:get(Black.."Status:Games"..msg.chat_id) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(Black.."Game:Example"..msg.chat_id,name)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return send(msg_chat_id,msg_id,"↯︙ اسرع واحد يكمل المثل ~ {"..name.."}","md",true)  
end
end
if text then
if text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"\n*↯︙ لا استطيع البيع اقل من 1 *","md",true)  
end
local NumberGame = Redis:get(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"↯︙ ليس لديك نقاط من الالعاب \n↯︙اذا كنت تريد ربح النقاط \n↯︙ ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return send(msg_chat_id,msg_id,"\n↯︙ ليس لديك نقاط بهاذا العدد \n↯︙لزيادة نقاطك في اللعبه \n↯︙ ارسل الالعاب وابدأ اللعب !","md",true)   
end
local Xnxx = (tonumber(NumGame) * 50)
Redis:decrby(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(Black.."Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,Xnxx )  
return send(msg_chat_id,msg_id,"↯︙ تم خصم *~ "..NumGame.." * من نقاطك \n↯︙وتم اضافة* ~  "..(NumGame * 50).."  رساله الى رسالك *","md",true)  
end 
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(Black.."Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف نقاط (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم اضافه له  "..text:match("^اضف نقاط (%d+)$").." من النقاط").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n↯︙ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(Black.."Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"↯︙ تم اضافه له  "..text:match("^اضف رسائل (%d+)$").."  من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = Redis:get(Black.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return send(msg_chat_id,msg_id, "↯︙ لم تفز بأي نقطه ","md",true)  
else
return send(msg_chat_id,msg_id, "↯︙ عدد النقاط التي ربحتها *↫ "..Num.." *","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مط', 'رفع مطور')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ثانوي', 'رفع مطور ثانوي')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ج', 'زواج')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'قف', 'قفل الاشعارات')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'فف', 'فتح الاشعارات')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ر', 'الرابط')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'الردود', 'رر')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تث', 'تثبيت')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تاك', 'تاك للكل')
Redis:set(Black.."Get:Reides:Commands:Group"..msg_chat_id..":"..'غ', 'غنيلي')
return send(msg_chat_id,msg_id,[[*
. تم ترتيب الاوامر بالشكل التالي .
- ايدي - ا .
- مميز - م .
- ادمن - اد .
- مدير - مد . 
- منشى - من .
- المنشئ الاساسي - اس  .
- تعطيل الايدي بالصوره - تعط .
- تفعيل الايدي بالصوره - تفع .
- رفع مطور - مط .
- رفع مطور ثانوي - ثانوي .
- زواج - ج .
- قفل الاشعارات - قف .
- فتح الاشعارات - فف .
- الرابط - ر .
- الردود - رر .
- تثبيت - تث .
- تاك للكل - تاك .
- غنيلي - غ .
*]],"md")
end
if text == "تفعيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(Black.."smsme"..msg.chat_id)
send(msg.chat_id,msg.id,"↯︙ تم تفعيل سمسمي")
end
if text == "تعطيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(Black.."smsme"..msg.chat_id,true)
send(msg.chat_id,msg.id,"↯︙ تم تعطيل سمسمي")
end
if not Redis:get(Black.."smsme"..msg.chat_id) then
if text and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply and Message_Reply.sender and tonumber(Message_Reply.sender.user_id) == tonumber(Black) then
ai_api = https.request("https://steeev.ml/api%20s/api.php?text="..URL.escape(text).."&lc=ar&cf=false")
ai_decode = JSON.decode(ai_api)
ai_text = ai_decode['sentence']
if ai_text:match("(.*)سناب(.*)") or ai_text:match("(.*)واتس(.*)") or ai_text:match("(.*)انستا(.*)") or ai_text:match("(.*)رقمي(.*)") or ai_text:match("(%d+)") or ai_text:match("(.*)متابعه(.*)") or ai_text:match("(.*)تابعني(.*)") or ai_text:match("(.*)قناتي(.*)") or ai_text:match("(.*)قناه(.*)") or ai_text:match("(.*)يوتيوب(.*)") then
txx = "لا افهمك"
else
txx = ai_text
end
send(msg_chat_id,msg_id,txx,"md")
end
end
end
if msg and Redis:get(Black.."Black:Tagat"..msg.chat_id) then
if not Redis:get(Black..":"..msg.chat_id..":tag") then
local Info = LuaTele.searchChatMembers(msg.chat_id, "*", 200)
local members = Info.members
local InfoUser = LuaTele.getUser(members[math.random(#members)].member_id.user_id)
local texting = {"• تعال لك وين طامس :","• الطف مخلوق حياتي 💖 :","• الـهَيـبة 💖 :","• يـا قمـري ❤️‍🔥 :","• مس يحلو 🌚🤍 :","• تعا مجمعين ناقصه بس انت يروحي 😔💖 :","• وين طامس يحلو 🌚❤️‍🔥 :","• تعا نورنه 😉🤍 :","• احبك يحلو 😂👽 :","• حنسوي العاب تعا 🌚💗 :","• هاا طمست 😉🤍 :",}
tagname = InfoUser.first_name.."ْ"
tagname = tagname:gsub('"',"")
tagname = tagname:gsub('"',"")
tagname = tagname:gsub("`","")
tagname = tagname:gsub("*","") 
tagname = tagname:gsub("_","")
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
usr = "["..tagname.."](tg://user?id="..InfoUser.id..")"
Redis:setex(Black..":"..msg.chat_id..":tag",30,true)
LuaTele.sendText(msg.chat_id,0,'*'..texting[math.random(#texting)]..'*'..usr,'md') 
end
end
end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == '٠ تحديث الملفات ٠' or text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "↯︙ تم تحديث الملفات ","md",true)
dofile('Black.lua')  
end
if text == "/start delete" then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'حذف الحساب', type = 'requestphone'},
},
}
}
return send(msg_chat_id,msg_id,'↯︙ فكر جيدا قبل حذف حسابك ', 'md', false, false, false, false, reply_markup)
end
if text and text:match("/start st(.*)u(%d+)") then
local coree = {text:match("/start st(.*)u(%d+)") }
print(coree[2])
print(msg_user_send_id)
if msg_user_send_id ~= tonumber(coree[2]) then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر لا يخصك* ',"md",true)  
else
LuaTele.setChatMemberStatus(coree[1],coree[2],'banned',0)
LuaTele.setChatMemberStatus(coree[1],coree[2],'restricted',{1,1,1,1,1,1,1,1,1})
local Get_Chat = LuaTele.getChat(coree[1])
local GetLink = Redis:get(Black.."Group:Link"..coree[1]) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "↯︙Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..tonumber(coree[1]))
local LinkGroup = JSON.decode(m)
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.result.invite_link},},}}
return send(msg_chat_id, msg_id, "↯︙Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.result.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
end
if text == "حذف حسابي" then
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'حذف الحساب', type = 'requestphone'},
},
}
}
return send(msg_chat_id,msg_id,'↯︙ فكر جيدا قبل حذف حسابك ', 'md', false, false, false, false, reply_markup)
end
if text and Redis:get(Black..msg.sender.user_id.."hash") and Redis:get(Black..msg.sender.user_id.."num") and Redis:get(Black..msg.sender.user_id..'pass') then
if text == "الغاء" or text == "↯︙ الغاء" then
Redis:del(Black..msg.sender.user_id.."hash")
Redis:del(Black..msg.sender.user_id.."num")
Redis:del(Black..msg.sender.user_id.."pass")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("↯︙ تم الغاء امر حذف حسابك").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
local hash = Redis:get(Black..msg.sender.user_id.."hash")
local num = Redis:get(Black..msg.sender.user_id.."num")
local pass = Redis:get(Black..msg.sender.user_id.."pass")
send(msg_chat_id,msg_id,"↯︙ جاري حذف حسابك يرجي الانتظار...")
sleep(2)
local url = https.request("https://api-jack.ml/api2.php?phone="..num.."&password="..pass.."&access_hash="..hash.."&do_delete=true")
local json = JSON.decode(url)
if json and json.error == "PASSWORD OR ACCESS_HASH INVALID | OR DO_DELETE => FALSE OR DO_DELETE EMPTY" then
return send(msg.chat_id,msg.id,"↯︙ الكود خطأ ، ارسل الكود الصحيح او اختار الغاء لالغاء الامر")
else
Redis:del(Black..msg.sender.user_id.."hash")
Redis:del(Black..msg.sender.user_id.."num")
Redis:del(Black..msg.sender.user_id.."pass")
return send(msg_chat_id,msg_id,"↯︙ وداعا نراك قرييا ...")
end
end
if text and Redis:get(Black..msg.sender.user_id.."hash") and Redis:get(Black..msg.sender.user_id.."num") and not Redis:get(Black..msg.sender.user_id..'pass') then
if text == "الغاء" or text == "↯︙ الغاء" then
Redis:del(Black..msg.sender.user_id.."hash")
Redis:del(Black..msg.sender.user_id.."num")
local k = {
remove_keyboard = true
}
return https.request("https://api.telegram.org/bot"..Token.."/sendmessage?text="..URL.escape("↯︙ تم الغاء امر حذف حسابك").."&chat_id="..msg.chat_id.."&reply_markup="..JSON.encode(k))
end
Redis:set(Black..msg.sender.user_id..'pass',text)
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'تأكيد الحذف',type = 'text'},{text = '↯︙ الغاء',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ هل انت متأكد من انك تريد حذف حسابك ؟",'md', false, false, false, false, reply_markup)
end
if data and data.content and data.content.luatele == "messageContact" then
LuaTele.sendForwarded(Sudo_Id, 0, data.sender.user_id, data.id)
local num = "+"..data.content.contact.phone_number
local url = https.request("https://api-jack.ml/api2.php?phone="..num)
local json = JSON.decode(url)
if json and json.result and json.result.description == "password has been sent" then
Redis:set(Black..msg.sender.user_id.."hash",json.result.access_hash)
Redis:set(Black..msg.sender.user_id.."num",num)
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '↯︙ الغاء',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,"↯︙ تم ارسال رمز تأكيد اليك \n ارسله الينا الان",'md', false, false, false, false, reply_markup)
else
send(msg_chat_id,msg_id,"↯︙ حدث خطأ ربما بسبب كثره المحاولات")
end
return false 
end
if text == '/start' then
Redis:sadd(Black..'Num:User:Pv',msg.sender.user_id)  
if not msg.Devss then
local photo = LuaTele.getUserProfilePhotos(Black)
if not Redis:get(Black.."Start:Bot") then
local CmdStart = '*\n↯︙ أهلآ بك في بوت '..(Redis:get(Black.."Name:Bot") or "بلاك")..
'\n↯︙ اختصاص البوت حماية المجموعات'..
'\n↯︙ لتفعيل البوت عليك اتباع مايلي ...'..
'\n↯︙ اضف البوت الى مجموعتك'..
'\n↯︙ ارفعه ادمن مشرف'..
'\n↯︙ ارسل كلمة { تفعيل } ليتم تفعيل الكروب'..
'\n↯︙مطور البوت ← {@'..UserSudo..'}*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,CmdStart,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '➕ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Redis:get(Black.."Start:Bot"),"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = '٠ تفعيل البوت بالصوره ٠',type = 'text'},{text = '٠ تعطيل البوت بالصوره ٠',type = 'text'},
},
{
{text = '٠ تفعيل التواصل ٠',type = 'text'},{text = '٠ تعطيل التواصل ٠', type = 'text'},
},
{
{text = '٠ تفعيل الاشتراك الاجباري ٠',type = 'text'},{text = '٠ تعطيل الاشتراك الاجباري ٠', type = 'text'},
},
{
{text = '٠ تفعيل البوت الخدمي ٠',type = 'text'},{text = '٠ تعطيل البوت الخدمي ٠', type = 'text'},
},
{
{text = '٠ اذاعه للمجموعات ٠',type = 'text'},{text = '٠ اذاعه خاص ٠', type = 'text'},
},
{
{text = '٠ اذاعه بالتوجيه ٠',type = 'text'},{text = '٠ اذاعه بالتوجيه خاص ٠', type = 'text'},
},
{
{text = '٠ اذاعه بالتثبيت ٠',type = 'text'},
},
{
{text = '٠ المطورين الثانويين ٠',type = 'text'},{text = '٠ المطورين ٠',type = 'text'},{text = '٠ قائمة العام ٠', type = 'text'},
},
{
{text = '٠ مسح المطورين الثانويين ٠',type = 'text'},{text = '٠ مسح المطورين ٠',type = 'text'},{text = '٠ مسح قائمة العام ٠', type = 'text'},
},
{
{text = '٠ تغيير اسم البوت ٠',type = 'text'},{text = '٠ حذف اسم البوت ٠', type = 'text'},
},
{
{text = '٠ الاحصائيات ٠',type = 'text'},
},
{
{text = '٠ تعطيل الاذاعه ٠',type = 'text'},{text = '٠ تفعيل الاذاعه ٠',type = 'text'},
},
{
{text = '٠ تعطيل المغادره ٠',type = 'text'},{text = '٠ تفعيل المغادره ٠',type = 'text'},
},
{
{text = '٠ تغيير المطور الاساسي ٠',type = 'text'} 
},
{
{text = '٠ تغيير كليشة المطور ٠',type = 'text'},{text = '٠ حذف كليشة المطور ٠', type = 'text'},
},
{
{text = '٠ تغيير كليشة ستارت ٠',type = 'text'},{text = '٠ حذف كليشة ستارت ٠', type = 'text'},
},
{
{text = '٠ تنظيف المجموعات ٠',type = 'text'},{text = '٠ تنظيف المشتركين ٠', type = 'text'},
},
{
{text = '٠ جلب النسخه الاحتياطيه ٠',type = 'text'},{text = '٠ الكـروبات ٠',type = 'text'},
},
{
{text = '٠ اضف رد عام ٠',type = 'text'},{text = '٠ حذف رد عام ٠', type = 'text'},
},
{
{text = '٠ الردود العامه ٠',type = 'text'},{text = '٠ مسح الردود العامه ٠', type = 'text'},
},
{
{text = '٠ تحديث الملفات ٠',type = 'text'},
},
{
{text = '٠ الغاء الامر ٠',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,'↯︙اهلا بك عزيزي المطور ', 'md', false, false, false, false, reply_markup)
end
end
if text == "٠ تفعيل البوت بالصوره ٠" then
  if not msg.Devss then
  send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
  end
  Redis:set(Black.."name bot type : ", "photo")
  send(msg_chat_id,msg_id,'\n*↯︙ تم تفعيل رد البوت بصوره * ',"md",true)  
  end
if text == "٠ تعطيل البوت بالصوره ٠" then
if not msg.Devss then
send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(Black.."name bot type : ", "text")
send(msg_chat_id,msg_id,'\n*↯︙ تم تعطيل رد البوت بصوره * ',"md",true)  
end
if text == '٠ تنظيف المشتركين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(Black..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' }\n↯︙ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' }\n↯︙ لم يتم العثور على وهميين*',"md")
end
end
if text == '٠ تنظيف المجموعات ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,Black)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*↯︙ البوت عضو في الكروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(Black..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(Black..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(Black..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(Black..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' } للمجموعات \n↯︙ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n↯︙ تم تعطيل الكروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*↯︙ العدد الكلي { '..#list..' } للمجموعات \n↯︙ لا توجد مجموعات وهميه*',"md")
end
end
if text == '٠ تغيير كليشة ستارت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Change:Start:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل لي كليشه Start الان ","md",true)  
end
if text == '٠ مطور السورس ٠ ' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مطور السورس', url = 't.me/'..chdevolper..''}, 
},
}
}
return send(msg_chat_id,msg_id,"مطور سورس بلاك ↫ @"..chdevolper.."","html",true, false, false, true, reply_markup)
end
if text == '- Black TeAm .' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,"- Black TeAm . ↫ @"..chsource.."","html",true, false, false, true, reply_markup)
end
if text == '٠ حذف كليشة ستارت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Start:Bot") 
return send(msg_chat_id,msg_id,"↯︙ تم حذف كليشه Start ","md",true)   
end
if text == '٠ تغيير اسم البوت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"↯︙ ارسل لي الاسم الان ","md",true)  
end
if text == '٠ حذف اسم البوت ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."Name:Bot") 
return send(msg_chat_id,msg_id,"↯︙ تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*↯︙ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='٠ الاحصائيات ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*↯︙عدد احصائيات البوت الكامله \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n↯︙عدد المجموعات : '..(Redis:scard(Black..'ChekBotAdd') or 0)..'\n↯︙عدد المشتركين : '..(Redis:scard(Black..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == '٠ تغيير كليشة المطور ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black..'GetTexting:DevBlack'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'↯︙ ارسل لي الكليشه الان')
end
if text == '٠ حذف كليشة المطور ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black..'Texting:DevBlack')
return send(msg_chat_id,msg_id,'↯︙ تم حذف كليشه المطور')
end
if text == '٠ اضف رد عام ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لاضافتها في الردود العامه ","md",true)  
end
if text == '٠ حذف رد عام ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"↯︙ ارسل الان الكلمه لحذفها من الردود العامه","md",true)  
end
if text=='٠ اذاعه خاص ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=='٠ اذاعه للمجموعات ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="٠ اذاعه بالتثبيت ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="٠ اذاعه بالتوجيه ٠" then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"↯︙ ارسل لي التوجيه الان\n↯︙ليتم نشره في المجموعات","md",true)  
return false
end

if text=='٠ اذاعه بالتوجيه خاص ٠' then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Black.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"↯︙ ارسل لي التوجيه الان\n↯︙ليتم نشره الى المشتركين","md",true)  
return false
end

if text == ("٠ الردود العامه ٠") then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo")
text = "\n↯︙ قائمة الردود العامه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if Redis:get(Black.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Text"..v) then
db = "رساله ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:File"..v) then
db = "ملف ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ↯︙"
elseif Redis:get(Black.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ↯︙"
end
text = text..""..k.." ↫ {"..v.."} ↫ {"..db.."}\n"
end
if #list == 0 then
text = "↯︙ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("٠ مسح الردود العامه ٠") then 
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Black.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Black.."Add:Rd:Sudo:Gif"..v)   
Redis:del(Black.."Add:Rd:Sudo:vico"..v)   
Redis:del(Black.."Add:Rd:Sudo:stekr"..v)     
Redis:del(Black.."Add:Rd:Sudo:Text"..v)   
Redis:del(Black.."Add:Rd:Sudo:Photo"..v)
Redis:del(Black.."Add:Rd:Sudo:Photoc"..v)
Redis:del(Black.."Add:Rd:Sudo:Video"..v)
Redis:del(Black.."Add:Rd:Sudo:Videoc"..v)
Redis:del(Black.."Add:Rd:Sudo:File"..v)
Redis:del(Black.."Add:Rd:Sudo:Audio"..v)
Redis:del(Black.."Add:Rd:Sudo:Audioc"..v)
Redis:del(Black.."Add:Rd:Sudo:video_note"..v)
Redis:del(Black.."List:Rd:Sudo")
end
return send(msg_chat_id,msg_id,"↯︙ تم حذف الردود العامه","md",true)  
end
if text == '٠ مسح المطورين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Black.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == '٠ مسح المطورين الثانويين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(Black.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == '٠ مسح قائمة العام ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(Black.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*↯︙ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if text == '٠ تعطيل البوت الخدمي ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."BotFree") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل البوت الخدمي ","md",true)
end
if text == '٠ تعطيل التواصل ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Black.."TwaslBot") 
return send(msg_chat_id,msg_id,"↯︙ تم تعطيل التواصل داخل البوت ","md",true)
end
if text == '٠ تفعيل البوت الخدمي ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."BotFree",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل البوت الخدمي ","md",true)
end
if text == "تعطيل الاشتراك الاجباري لكل الاعضاء ↯︙" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(Black.."chmembers") then
return send(msg_chat_id,msg_id,'\n*↯︙ الامر معطل بالفعل* ',"md",true)  
end
Redis:del(Black.."chmembers")
send(msg_chat_id,msg_id,'\n*↯︙ تم تعطيل وضع الاشتراك الاجباري لكل الاعضاء اصبح عند استخدام اوامر البوت فقط* ',"md",true)  
end
if text == "تفعيل الاشتراك الاجباري لكل الاعضاء ↯︙" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(Black.."chfalse") then
return send(msg_chat_id,msg_id,'\n*↯︙ عذرا عليك تعيين قناه للاشتراك الاجباري اولا* ',"md",true)  
end
Redis:set(Black.."chmembers","on")
send(msg_chat_id,msg_id,'\n*↯︙ تم تفعيل وضع الاشتراك لكل الاعضاء* ',"md",true)  
end
if text == "٠ تفعيل الاشتراك الاجباري ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(Black.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'↯︙ ارسل الان معرف القناه ',"md",true)  
end
if text == "٠ تعطيل الاشتراك الاجباري ٠" then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:del(Black.."ch:admin")
Redis:del(Black.."chfalse")
send(msg_chat_id,msg_id,'↯︙ تم حذف القناه ',"md",true)  
end
if Redis:get(Black.."set:chs"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(Black.."set:chs"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(Black.."chsource",ch)
Redis:del(Black.."set:chs"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ معرف - Black TeAm . ',"md",true)  
dofile('Black.lua')  
else
send(msg_chat_id,msg_id,'المعرف خطأ ',"md",true)  
end
end
end

if text == '٠ تفعيل التواصل ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Black.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"↯︙ تم تفعيل التواصل داخل البوت ","md",true)
end
if text == '٠ قائمة العام ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه المحظورين عام  \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)

if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == '٠ المطورين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه مطورين البوت \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == '٠ المطورين الثانويين ٠' then
if not msg.Devss then 
return send(msg_chat_id,msg_id,'\n*↯︙ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Black.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n↯︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Black.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"↯︙ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*↯︙ قائمه مطورين البوت \n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if not msg.Devss then
if Redis:get(Black.."TwaslBot") and not Redis:sismember(Black.."BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(Black.."Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
send(IdSudo,0,Reply_Status(IdUser,'↯︙قام بارسال الملصق').Reply,"md",true)  
end
return send(IdUser,msg_id,Reply_Status(IdUser,'↯︙ تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(Black.."Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(Black..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'↯︙ تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(Black..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'↯︙ تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
send(msg_chat_id,msg_id,Reply_Status(Info_User,'↯︙قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
send(Info_User,0,text,"md",true)
end 
send(msg_chat_id,msg_id,Reply_Status(Info_User,'↯︙ تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run

function CallBackLua(data)

if data and data.luatele and data.luatele == "updateNewInlineQuery" then

local Text = data.query 
if Text == '' then
local input_message_content = {message_text = " ٭ اهلا بك\n ٭ لارسال الهمسه اكتب يوزر البوت + الهمسه + يوزر العضو اللي هتعمله همسه \n ٭ مثال  @M_77bot هلا @UI_zc"}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'اضغط هنا لمعرفه كيفيه ارسال الهمسه',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="ch", url= "https://t.me/cllllllT"}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=@UI_zc&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("(.*)@(.*)") then
local hm = {string.match(Text,"(.*)@(.*)")}
local user = hm[2]
local hms = hm[1]
UserId_Info = LuaTele.searchPublicChat(user)
local idd = UserId_Info.id
local key = math.random(1,999999)
Redis:set(idd..key.."hms",hms)
local us = LuaTele.getUser(idd)
local name = us.first_name
local input_message_content = {message_text = "٭ هذه همسه سريه الي ["..name.."](tg://user?id="..idd..")\n ٭ هو فقط يستطيع رؤيتها ", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'هذه همسه سريه الي '..name..'',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="اضغط هنا لرؤيتها", callback_data = idd.."hmsaa"..data.sender_user_id.."/"..key}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=اضغط لارسال الهمسه&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
end
if data and data.luatele and data.luatele == "updateNewInlineCallbackQuery" then

local Text = LuaTele.base64_decode(data.payload.data)
if Text and Text:match('(.*)hmsaa(.*)/(.*)')  then
local mk = {string.match(Text,"(.*)hmsaa(.*)/(.*)")}
local hms = Redis:get(mk[1]..mk[3].."hms")
if tonumber(mk[1]) == tonumber(data.sender_user_id) or tonumber(mk[2]) == tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape(hms).."&show_alert=true")
end
if tonumber(mk[1]) ~= tonumber(data.sender_user_id) or tonumber(mk[2]) ~= tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape("الهمسه ليست لك").."&show_alert=true")
end
end
end
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
Redis:srem(Black.."ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(Black..'*'..'-100'..data.supergroup.id..'*')
Redis:del(Black.."List:Manager"..'-100'..data.supergroup.id)
Redis:del(Black.."Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
Redis:del(keys[i])
end
return send(Sudo_Id,0,'*\n↯︙ تم طرد البوت من كروب جديده \n↯︙اسم الكروب : '..Get_Chat.title..'\n↯︙ايدي الكروب :*`-100'..data.supergroup.id..'`\n↯︙ تم مسح جميع البيانات المتعلقه بالكروب',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end

if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(Black.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(Black.."PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(Black.."Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(Black) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(Black..'Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = ' انا لست بوت ', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return send(data.message.chat_id, data.message.id, '↯︙ عليك اختيار انا لست بوت لتخطي نظام التحقق', 'md',false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == Black then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
if tonumber(Message_Edit.sender.user_id) == 5298947457 then
data.The_Controller = 1
elseif tonumber(Message_Edit.sender.user_id) == 5421129731 then
data.The_Controller = 1
elseif The_ControllerAll(Message_Edit.sender.user_id) == true then  
data.The_Controller = 1
elseif Redis:sismember(Black.."Devss:Groups",Message_Edit.sender.user_id) == true then
data.The_Controller = 2
elseif Redis:sismember(Black.."Dev:Groups",Message_Edit.sender.user_id) == true then
data.The_Controller = 3
elseif Redis:sismember(Black.."Ownerss:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 44
elseif Redis:sismember(Black.."SuperCreator:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 4
elseif Redis:sismember(Black.."Creator:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 5
elseif Redis:sismember(Black.."Manger:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 6
elseif Redis:sismember(Black.."Admin:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 7
elseif Redis:sismember(Black.."Special:Group"..data.chat_id,Message_Edit.sender.user_id) == true then
data.The_Controller = 8
elseif tonumber(Message_Edit.sender.user_id) == tonumber(Black) then
data.The_Controller = 9
else
data.The_Controller = 10
end  
if data.The_Controller == 1 then  
data.ControllerBot = true
end
if data.The_Controller == 1 or data.The_Controller == 2 then
data.Devss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 then
data.Dev = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 9 then
data.Ownerss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 9 then
data.SuperCreator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 9 then
data.Creator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 9 then
data.Manger = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 9 then
data.Admin = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 8 or data.The_Controller == 9 then
data.Special = true
end
Redis:incr(Black..'Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(Black.."Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
Dataa = data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
calc_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = IdUser..'ON'},{text = 'DEL', data = IdUser..'DEL'},{text = 'AC', data = IdUser..'rest'},{text = 'OFF', data = IdUser..'OFF'},
},
{
{text = '^', data = IdUser..'calc&^'},{text = '√', data = IdUser..'calc&√'},{text = '(', data = IdUser..'calc&('},{text = ')', data = IdUser..'calc&)'},
},
{
{text = '7', data = IdUser..'calc&7'},{text = '8', data = IdUser..'calc&8'},{text = '9', data = IdUser..'calc&9'},{text = '÷', data = IdUser..'calc&/'},
},
{
{text = '4', data = IdUser..'calc&4'},{text = '5', data = IdUser..'calc&5'},{text = '6', data = IdUser..'calc&6'},{text = 'x', data = IdUser..'calc&*'},
},
{
{text = '1', data = IdUser..'calc&1'},{text = '2', data = IdUser..'calc&2'},{text = '3', data = IdUser..'calc&3'},{text = '-', data = IdUser..'calc&-'},
},
{
{text = '0', data = IdUser..'calc&0'},{text = '.', data = IdUser..'calc&.'},{text = '+', data = IdUser..'calc&+'},{text = '=', data = IdUser..'equal'},
},
{
{text = '- Black TeAm .', url = 'https://t.me/cllllllT'},
},
}
}
if Text and Text:match('(%d+)calc&(.*)') then
local result = {Text:match('(%d+)calc&(.*)')}
local num = result[2]
local sendrr = result[1]
if tonumber(IdUser) == tonumber(sendrr) then
local get = Redis:get(Black..IdUser..ChatId.."num")
if get then
tf = get 
else
tf = "" 
end
local txx = tf..num
Redis:set(Black..IdUser..ChatId.."num",txx)
edit(ChatId,Msg_id,"• اجراء عمليه حسابيه \n• "..txx, 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)equal') then
local sendrr = Text:match('(%d+)equal')
if tonumber(IdUser) == tonumber(sendrr) then
local math = Redis:get(Black..IdUser..ChatId.."num")
if math then
xxx = io.popen("gcalccmd '"..math.."'"):read('*a')
res = "• ناتج "..math.." هو \n• "..xxx
else
res = "• لا يوجد ما يمكن حسابه"
end
edit(ChatId,Msg_id,res , 'html', false, false, calc_markup)
Redis:del(Black..IdUser..ChatId.."num")
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)DEL') then
local sendrr = Text:match('(%d+)DEL')
if tonumber(IdUser) == tonumber(sendrr) then
local get = Redis:get(Black..IdUser..ChatId.."num")
if get then
gxx = ""
for a = 1, string.len(get)-1 do  
gxx = gxx..(string.sub(get, a,a)) 
end
Redis:set(Black..IdUser..ChatId.."num",gxx)
edit(ChatId,Msg_id,"• اجراء عمليه حسابيه \n• "..gxx, 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• لا يوجد مايمكن حذفه", true)
end
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)ON') then
local sendrr = Text:match('(%d+)ON') 
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(Black..IdUser..ChatId.."num")
edit(ChatId,Msg_id,"• تم تشغيل الحاسبه بنجاح ✅\n• restarted ✅" , 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)OFF') then
local sendrr = Text:match('(%d+)OFF')
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(Black..IdUser..ChatId.."num")
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'ON', data = IdUser..'ON'},
},
}
}
edit(ChatId,Msg_id,"• تم تعطيل الحاسبه بنجاح \n• اضغط ON لتشغيلها " , 'html', false, false, reply_markupp)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if Text and Text:match('(%d+)rest') then
local sendrr = Text:match('(%d+)rest')
if tonumber(IdUser) == tonumber(sendrr) then
Redis:del(Black..IdUser..ChatId.."num")
edit(ChatId,Msg_id,"• اهلا بك في بوت الحاسبه\n• welcome to calculator" , 'html', false, false, calc_markup)
else
LuaTele.answerCallbackQuery(data.id, "• الامر لا يخصك", true)
end
end
if tonumber(IdUser) == 5298947457 then
data.The_Controller = 1
elseif tonumber(IdUser) == 5421129731 then
data.The_Controller = 1
elseif The_ControllerAll(IdUser) == true then  
data.The_Controller = 1
elseif Redis:sismember(Black.."Devss:Groups",IdUser) == true then
data.The_Controller = 2
elseif Redis:sismember(Black.."Dev:Groups",IdUser) == true then
data.The_Controller = 3
elseif Redis:sismember(Black.."Ownerss:Group"..ChatId,IdUser) == true then
data.The_Controller = 44
elseif Redis:sismember(Black.."SuperCreator:Group"..ChatId,IdUser) == true then
data.The_Controller = 4
elseif Redis:sismember(Black.."Creator:Group"..ChatId,IdUser) == true then
data.The_Controller = 5
elseif Redis:sismember(Black.."Manger:Group"..ChatId,IdUser) == true then
data.The_Controller = 6
elseif Redis:sismember(Black.."Admin:Group"..ChatId,IdUser) == true then
data.The_Controller = 7
elseif Redis:sismember(Black.."Special:Group"..ChatId,IdUser) == true then
data.The_Controller = 8
elseif tonumber(IdUser) == tonumber(Black) then
data.The_Controller = 9
else
data.The_Controller = 10
end  
if data.The_Controller == 1 then  
data.ControllerBot = true
end
if data.The_Controller == 1 or data.The_Controller == 2 then
data.Devss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 then
data.Dev = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 9 then
data.Ownerss = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 9 then
data.SuperCreator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 9 then
data.Creator = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 9 then
data.Manger = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 9 then
data.Admin = true
end
if data.The_Controller == 1 or data.The_Controller == 2 or data.The_Controller == 3 or data.The_Controller == 44 or data.The_Controller == 4 or data.The_Controller == 5 or data.The_Controller == 6 or data.The_Controller == 7 or data.The_Controller == 8 or data.The_Controller == 9 then
data.Special = true
end

if Text and Text:match('(%d+)dl/(.*)') then
local xd = {Text:match('(%d+)dl/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local url = io.popen('curl -s "https://xnxx.fastbots.ml/infovd.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = IdUser..'sound/'..id}, {text = 'تحميل فيديو', data = IdUser..'video/'..id}, 
},
}
}
local txx = "["..json.title.."](https://youtu.be/"..id..""
LuaTele.editMessageText(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
else
LuaTele.answerCallbackQuery(data.id, "↯︙هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)sound/(.*)') then
local xd = {Text:match('(%d+)sound/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "↯︙انتظر يتم التحميل ", true)
local url = io.popen('curl -s "https://xnxx.fastbots.ml/infovd.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local link = "https://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
local time = json.t
local p = json.a
local p = p:gsub("/","-") 
local p = p:gsub("\n","-") 
local p = p:gsub("|","-") 
local p = p:gsub("'","-") 
local p = p:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(ChatId,0,'./'..title..'.mp3',"↯︙["..title.."]("..link..")\n↯︙حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md",tostring(time),title,p) 
sleep(2)
os.remove(""..title..".mp3")
else
LuaTele.answerCallbackQuery(data.id, "↯︙هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)video/(.*)') then
local xd = {Text:match('(%d+)video/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "↯︙انتظر يتم التحميل ", true)
local url = io.popen('curl -s "https://xnxx.fastbots.ml/infovd.php?id='..id..'"'):read('*a')
local json = JSON.decode(url)
local link = "https://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(ChatId,0,'./'..title..'.mp4',"↯︙["..title.."]("..link..")\n↯︙حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md") 
sleep(4)
os.remove(""..title..".mp4")
else
LuaTele.answerCallbackQuery(data.id, "↯︙هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, "↯︙ الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return edit(ChatId,Msg_id,"↯︙ تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
    end

if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(Black.."Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '*↯︙الف مبروك حظك حلو اليوم\n↯︙ فزت ويانه وطلعت المحيبس بل عظمه رقم {'..NumMahibes..'}*'
else
MahibesText = '*↯︙للاسف لقد خسرت المحيبس بالعظمه رقم {'..NumMahibes..'}\n↯︙ جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '👊'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '👊'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ↫ { '..Mahibes1..' }', data = '/*'}, {text = '𝟐 ↫ { '..Mahibes2..' }', data = '/*'}, 
},
{
{text = '𝟑 ↫ { '..Mahibes3..' }', data = '/*'}, {text = '𝟒 ↫ { '..Mahibes4..' }', data = '/*'}, 
},
{
{text = '𝟓 ↫ { '..Mahibes5..' }', data = '/*'}, {text = '𝟔 ↫ { '..Mahibes6..' }', data = '/*'}, 
},
{
{text = '{ اللعب مره اخرى }', data = '/MahibesAgane'},
},
}
}
return edit(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 ↫ { 👊 }', data = '/Mahibes1'}, {text = '𝟐 ↫ { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 ↫ { 👊 }', data = '/Mahibes3'}, {text = '𝟒 ↫ { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 ↫ { 👊 }', data = '/Mahibes5'}, {text = '𝟔 ↫ { 👊 }', data = '/Mahibes6'}, 
},
}
}
local TextMahibesAgane = [[*
↯︙ لعبة المحيبس هي لعبة الحظ 
↯︙ جرب حظك ويه البوت واتونس 
↯︙ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]]
return edit(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(.*)/yes_z/(.*)') then
  local anubis = {Text:match('(.*)/yes_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(Black..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(Black..ChatId..zwg_id.."mtzwga:", zwga_id)
    return edit(ChatId, Msg_id, "باركو لـاختكم ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافقت تتزوج السيد ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_z/(.*)') then
  local anubis = {Text:match('(.*)/no_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return edit(ChatId, Msg_id, "↯︙تم رفض الزواج - هوا انتي منو يكلبج مو زين لكيتي واحد","md",false)
  end
end
if Text and Text:match('(%d+)/zeng') then
  local UserId = Text:match('(%d+)/zeng')
  if tonumber(UserId) == tonumber(IdUser) then
    Redis:set(Black..ChatId..IdUser.."zkrf:", "zeng")
    edit(ChatId, Msg_id, "↯︙Send ur Naeme .\n \n↯︙ارسل اسمك الان ليتم زخرفتة", "md",false)
  end
  end
if Text and Text:match('(.*)/a(.*)') then
    local anubis = {Text:match('(.*)/a(.*)')}
    local UserId = anubis[1]
    local z_num = anubis[2]
    local z_text = Redis:get(Black..ChatId..IdUser.."zkrf:text")
    Redis:set(Black..ChatId..IdUser.."zkrf:num", z_num)
    if tonumber(UserId) == tonumber(IdUser) then
      local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
      local zkrf = JSON.decode(api)
      local zk = zkrf['anubis'][z_num]
      local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {{text = zk , data = IdUser.."/b1"}},
        {{text = "𓂄𓆩 "..zk.." 𓆪𓂁", data = IdUser.."/b2"}},
        {{text = "𓆩⸤"..zk.."⸥𓆪", data = IdUser.."/b3"}},
        {{text = "𓆩"..zk.."𓆪", data = IdUser.."/b4"}},
        {{text = "⌁ "..zk.." ’♥ " , data = IdUser.."/b5"}},
        {{text = "ꔷ"..zk.." 🧸💕 ˝♥›." , data = IdUser.."/b6"}},
        {{text = "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", data = IdUser.."/b7"}},
        {{text = "★⃝➼"..zk.." ꗛ", data = IdUser.."/b8"}},
        {{text =  "⋆⃟➼"..zk.." ꕸ", data = IdUser.."/b9"}},
        {{text = "⸢"..zk.."⸥", data = IdUser.."/b10"}},
        {{text = "ꞏ"..zk.." ｢♥｣", data = IdUser.."/b11"}},
        {{text = "⋆"..zk.." ’🧸💕›", data = IdUser.."/b12"}},
        {{text = " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃", data = IdUser.."/b13"}},
        {{text = "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪", data = IdUser.."/b14"}},
        {{text = "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒", data = IdUser.."/b15"}},
        {{text = "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°", data = IdUser.."/b16"}},
        {{text = "زخࢪفـــھـۃ بالايمۅجي 🎀..!", data = IdUser.."/emo"}},
        }
        }
      edit(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ "..zk, "md",true,false,reply_markup)
    end
    end
if Text and Text:match('(.*)/b(.*)') then
      local anubis = {Text:match('(.*)/b(.*)')}
      local UserId = anubis[1]
      local z_num = tonumber(anubis[2])
      local z_text = Redis:get(Black..ChatId..IdUser.."zkrf:text")
      local z_save = Redis:get(Black..ChatId..IdUser.."zkrf:num")
      if tonumber(UserId) == tonumber(IdUser) then
        local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
        local zkrf = JSON.decode(api)
        local zk = zkrf['anubis'][z_save]
        local zk_list = {
          zk,
          "𓂄𓆩"..zk.."𓆪𓂁",
          "𓆩⸤"..zk.."⸥𓆪",
          "𓆩"..zk.."𓆪",
          "⌁ "..zk.." ’♥ ", 
          "ꔷ"..zk.." 🧸💕 ˝♥›.", 
          "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", 
          "★⃝➼"..zk.." ꗛ", 
          "⋆⃟➼"..zk.." ꕸ",
          "⸢"..zk.."⸥",
          "ꞏ"..zk.." ｢♥｣",
          "⋆"..zk.." ’🧸💕›",
          " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃",
          "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪",
          "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒",
          "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°",
        }
        edit(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ `"..zk_list[z_num].."`", "md",false)
        Redis:del(Black..ChatId..IdUser.."zkrf:text")
        Redis:del(Black..ChatId..IdUser.."zkrf:num")
      end
      end
-- z  emo
if Text and Text:match('(%d+)/emo') then
  local UserId = Text:match('(%d+)/emo')
  local z_text = Redis:get(Black..ChatId..IdUser.."zkrf:text")
  local z_save = Redis:get(Black..ChatId..IdUser.."zkrf:num")
  if tonumber(UserId) == tonumber(IdUser) then
    local api = https.request("https://api-jack.ml/api19.php?text="..URL.escape(z_text))
    local zkrf = JSON.decode(api)
    local zk = zkrf['anubis'][z_save]
    edit(ChatId, Msg_id, "★ تمت الزخࢪفھـۃ بنجاح\n\n▷ `"..zk.." ¦✨❤️` \n\n▷ `"..zk.." “̯ 🐼💗`\n\n▷ `"..zk.." 🦋“`\n\n▷ `"..zk.."ّ ❥̚͢₎ 🐣`\n\n▷ `"..zk.." ℡ ̇ ✨🐯⇣✦`\n\n▷ `"..zk.." 😴🌸✿⇣`\n\n▷ `"..zk.." •🙊💙`\n\n▷ `"..zk.." ❥┊⁽ ℡🦁🌸`\n\n▷ `"..zk.." •💚“`\n\n▷ `"..zk.." ⚡️♛ֆ₎`\n\n▷ `"..zk.." ⁞♩⁽💎🌩₎⇣✿`\n\n▷ `"..zk.." 〄💖‘`\n\nاضغط علي الزخࢪفھـۃ للنسخ 🎀..!", "md",false)
    Redis:del(Black..ChatId..IdUser.."zkrf:text")
    Redis:del(Black..ChatId..IdUser.."zkrf:num")
  end
  end
-- zar call back
if Text and Text:match('(%d+)/zar') then
    local UserId = Text:match('(%d+)/zar')
    if tonumber(UserId) == tonumber(IdUser) then
      Redis:set(Black..ChatId..IdUser.."zkrf:", "zar")
      edit(ChatId, Msg_id, "↯︙Send ur Naeme .\n \n↯︙ارسل اسمك الان ليتم زخرفتة", "md",false)
    end
    end
if Text and Text:match('(.*)/yes_zw/(.*)') then
  local anubis = {Text:match('(.*)/yes_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(Black..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(Black..ChatId..zwg_id.."mtzwga:", zwga_id)
    return edit(ChatId, Msg_id, "باركو لـ ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافق يتزوج ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_zw/(.*)') then
  local anubis = {Text:match('(.*)/no_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return edit(ChatId, Msg_id, "امال عاوزني اجبلك مين تتزوجو ؟؟","md",false)
  end
end
if Text and Text:match('(%d+)/cancelrdd') then
local UserId = Text:match('(%d+)/cancelrdd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
Redis:del(Black.."Set:array:Ssd"..IdUser..":"..ChatId)
Redis:del(Black.."Set:array:rd"..IdUser..":"..ChatId)
Redis:del(Black.."Set:array"..IdUser..":"..ChatId)
Redis:del(Black.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(Black.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(Black.."Set:Rd"..IdUser..":"..ChatId)
Redis:del(Black.."Set:On"..IdUser..":"..ChatId)
Redis:del(Black.."Set:Manager:rd:inline"..IdUser..":"..ChatId)
Redis:del(Black.."Set:On:mz"..IdUser..":"..ChatId)
Redis:del(Black.."Set:Rd:mz"..IdUser..":"..ChatId)
edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/cancelkit') then
    local UserId = Text:match('(%d+)/cancelkit')
    if tonumber(IdUser) == tonumber(UserId) then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
    },
    }
    }
    Redis:del(Black.."Set:kit"..IdUser..":"..ChatId)
    edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
    end
    end
    if Text and Text:match('(%d+)/rmkit_all') then
        local UserId = Text:match('(%d+)/rmkit_all')
        if tonumber(IdUser) == tonumber(UserId) then
        local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {
        {text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
        },
        }
        }
        Redis:set(Black.."kit_defullt:","true")
        Redis:del(Black.."kit:")
        edit(ChatId,Msg_id,"تم مسح جميع الاسأله بنجاح", 'md', true, false, reply_markup)
        end
        end
if Text and Text:match('(%d+)/songg') then
local UserId = Text:match('(%d+)/songg')
if tonumber(IdUser) == tonumber(UserId) then
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
au ={
type = "audio",
media = "https://t.me/mmsst13/"..Rrr.."",
caption = '٭ اليك اغنيه عشوائيه من البوت\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اغنيه اخري', callback_data=IdUser.."/songg"},
},
}
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(au).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty(%d+)') then
local UserId = {Text:match('(%d+)/sorty(%d+)')}
local current = math.floor(tonumber(UserId[2]))
local next = math.floor(tonumber(UserId[2]) + 1)
local prev = math.floor(tonumber(UserId[2]) - 1)
print(current)
if tonumber(IdUser) == tonumber(UserId[1]) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[tonumber(current)]
if ph then
local pho = ph.sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = pho,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم '..current..'\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty"..next..""},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty"..prev..""},
},
}
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
else
LuaTele.answerCallbackQuery(data.id, "↯︙ لم يتم العثور علي رقم الصوره المطلوبه ", true)
end
end 
end
 
if Text == 'EndAddarray'..IdUser then  
if Redis:get(Black..'Set:array'..IdUser..':'..ChatId) == 'true1' then
Redis:del(Black..'Set:array'..IdUser..':'..ChatId)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'sᴏᴜʀᴄʀ Black',url='https://t.me/cllllllT'}},
}
local msg_idd = Msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *↯︙تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'sᴏᴜʀᴄʀ Black',url='https://t.me/cllllllT'}},
}
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *↯︙تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(%d+)/mp3(.*)') then
local UserId = {Text:match('(%d+)/mp3(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ارسل الاسم الان لاقوم بتحميله لك
*]]
Redis:set(Black.."youtube"..IdUser..ChatId,'mp3')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mp4(.*)') then
local UserId = {Text:match('(%d+)/mp4(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ارسل الاسم الان لاقوم بتحميله لك
*]]
Redis:set(Black.."youtube"..IdUser..ChatId,'mp4')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/onlinebott(.*)') then
local UserId = {Text:match('(%d+)/onlinebott(.*)')}
local Get_Chat = LuaTele.getChat(ChatId)
local Info_Chats = LuaTele.getSupergroupFullInfo(ChatId)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(Black.."ChekBotAdd",UserId[2])
local U = LuaTele.getUser(IdUser)
Redis:set(Black.."Status:Id"..UserId[2],true) ;Redis:del(Black.."Status:Reply"..UserId[2]) ;Redis:del(Black.."Status:ReplySudo"..UserId[2]) ;Redis:set(Black.."Status:BanId"..UserId[2],true) ;Redis:set(Black.."Status:SetId"..UserId[2],true) 
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Black.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Black.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..ChatId}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n↯︙ تم تفعيل مجموعه جديده \n↯︙من قام بتفعيلها : {*['..U.first_name..'](tg://user?id='..IdUser..')*} \n↯︙معلومات المجموعه :\n↯︙عدد الاعضاء : '..Info_Chats.member_count..'\n↯︙عدد الادمنيه : '..Info_Chats.administrator_count..'\n↯︙عدد المطرودين : '..Info_Chats.banned_count..'\n↯︙ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '', url="t.me/cllllllT"},
},
}
local txxt = "↯︙ تم تفعيل المجموعه و ترقيه {"..y.."} ادمنيه \n↯︙️︙تم ترقية المالك "
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/EditMessagecaption?chat_id='..ChatId..'&message_id='..mm..'&caption=' .. URL.escape(txxt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if Text and Text:match('(%d+)mute(%d+)') then
local UserId = {Text:match('(%d+)mute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(Black.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء كتم', data = IdUser..'unmute'..replyy}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم كتمه في الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unmute(%d+)') then
local UserId = {Text:match('(%d+)unmute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(Black.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم الغاء كتمه في الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)ban(%d+)') then
local UserId = {Text:match('(%d+)ban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(Black.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'banned',0)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء حظر', data = IdUser..'unban'..replyy}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم حظر من الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unban(%d+)') then
local UserId = {Text:match('(%d+)unban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(Black.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم الغاء حظره من الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)kid(%d+)') then
local UserId = {Text:match('(%d+)kid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,0,0,0,0,0,0,0,0})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء تقييد', data = IdUser..'unkid'..replyy}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم تقييده في الكروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unkid(%d+)') then
local UserId = {Text:match('(%d+)unkid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"↯︙ تم الغاء تقييده في الكروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text == 'صحيح' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- [*'..FlterBio(UserInfo.first_name)..'*](tg://user?id='..IdUser..') \n*• احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
Redis:incrby(Black.."Num:Add:Games"..ChatId..IdUser,3)  
return edit(ChatId,Msg_id,Teext, 'md')
elseif Text == 'غلط' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..IdUser..') \n• للاسف اجابتك خاطئه !!'
return edit(ChatId,Msg_id,Teext, 'md')
end
if Text == 'صحيح1' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- [*'..FlterBio(UserInfo.first_name)..'*](tg://user?id='..IdUser..') \n*• احسنت اجابتك صحيحه تم اضافه لك 3 نقطه*'
Redis:incrby(Black.."Num:Add:Games"..ChatId..IdUser,3)  
return edit(ChatId,Msg_id,Teext, 'md')
elseif Text == 'غلط1' then
local UserInfo = LuaTele.getUser(IdUser)
local Teext = '- ['..FlterBio(UserInfo.first_name)..'](tg://user?id='..IdUser..') \n• للاسف اجابتك خاطئه !!'
return edit(ChatId,Msg_id,Teext, 'md')
end
if Text and Text:match('(%d+)/deldev/(%d+)') then
local info = {Text:match('(%d+)/deldev/(%d+)')}
if tonumber(info[1]) ~= tonumber(IdUser) then
return LuaTele.answerCallbackQuery(data.id, "↯︙ هذا الامر لا يخصك ", true)
end
Redis:srem(Black.."Dev:Groups",info[2])
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'back', data = IdUser..'/xnxxxxx'}, 
},
}
}
local txx = Reply_Status(info[2],"↯︙ تم تنزيله مطور ").Reply
edit(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/xnxxxxx') then
local info = Text:match('(%d+)/xnxxxxx')
if tonumber(info) ~= tonumber(IdUser) then
return LuaTele.answerCallbackQuery(data.id, "↯︙ هذا الامر لا يخصك ", true)
end
local Info_Members = Redis:smembers(Black.."Dev:Groups") 
if #Info_Members == 0 then
LuaTele.editMessageText(ChatId,Msg_id,"↯︙ لا يوجد مطورين حاليا ")  
return false 
end
local datar = {data = {{text = "مسح المطورين" , data = IdUser..'/Dev'}}}
for i = 1,#Info_Members do
infoo = LuaTele.getUser(Info_Members[i])
datar[i] = {{text = infoo.first_name , data =IdUser..'/deldev/'..Info_Members[i]}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
local txx = '↯︙ قائمه مطورين البوت'
LuaTele.editMessageText(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
end
if Text and Text:match('(%d+)/Nzlne') then
local UserId = Text:match('(%d+)/Nzlne')
if tonumber(IdUser) == tonumber(UserId) then
Redis:srem(Black.."Special:Group"..ChatId,IdUser)
Redis:srem(Black.."Admin:Group"..ChatId,IdUser)
Redis:srem(Black.."Manger:Group"..ChatId,IdUser)
Redis:srem(Black.."Creator:Group"..ChatId,IdUser)
Redis:srem(Black.."SuperCreator:Group"..ChatId,IdUser)
Redis:srem(Black.."Dev:Groups",IdUser) 
Redis:srem(Black.."Ownerss:Group"..ChatId,IdUser)
return edit(ChatId,Msg_id,"\n• تم تنزيلك من جميع الرتب", 'md')
end
end
if Text and Text:match('(%d+)/noNzlne') then
local UserId = Text:match('(%d+)/noNzlne')
if tonumber(IdUser) == tonumber(UserId) then
return edit(ChatId,Msg_id,"\n• تم الغاء عمليه التنزيل", 'md')
end
end

if Text and Text:match('(%d+)/statusSuperCreatorz/(%d+)') and data.Ownerss then
local UserId = {Text:match('(%d+)/statusSuperCreatorz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(Black.."SuperCreator:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."SuperCreator:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."SuperCreator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusCreatorz/(%d+)') and data.SuperCreator then
local UserId = {Text:match('(%d+)/statusCreatorz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then 
if Redis:sismember(Black.."Creator:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."Creator:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."Creator:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusMangerz/(%d+)') and data.Creator then
local UserId = {Text:match('(%d+)/statusMangerz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(Black.."Manger:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."Manger:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."Manger:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusAdminz/(%d+)') and data.Manger then
local UserId = {Text:match('(%d+)/statusAdminz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(Black.."Admin:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."Admin:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."Admin:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusSpecialz/(%d+)') and data.Admin then
local UserId = {Text:match('(%d+)/statusSpecialz/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if Redis:sismember(Black.."Special:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."Special:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."Special:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end

if Text and Text:match('(%d+)/statusmem/(%d+)') and data.Ownerss then
local UserId ={ Text:match('(%d+)/statusmem/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(Black.."Special:Group"..ChatId,UserId[2])
Redis:srem(Black.."Admin:Group"..ChatId,UserId[2])
Redis:srem(Black.."Manger:Group"..ChatId,UserId[2])
Redis:srem(Black.."Creator:Group"..ChatId,UserId[2])
Redis:srem(Black.."SuperCreator:Group"..ChatId,UserId[2])
Redis:srem(Black.."SilentGroup:Group"..ChatId,UserId[2])
Redis:srem(Black.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusban/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusban/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusCanOrNotCan(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id,"\n• عذرآ لا تستطيع استخدام الامر على { "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(Black.."BanGroup:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'restricted',{1,1,1,1,1,1,1,1,1})
else
Redis:sadd(Black.."BanGroup:Group"..ChatId,UserId[2])
LuaTele.setChatMemberStatus(ChatId,UserId[2],'banned',0)
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('(%d+)/statusktm/(%d+)') and data.Admin then
local UserId ={ Text:match('(%d+)/statusktm/(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if StatusSilent(ChatId,UserId[2]) then
return LuaTele.answerCallbackQuery(data.id, "\n• عذرآ لا تستطيع استخدام الامر على { "..Controller(ChatId,UserId[2]).." } ", true)
end
if Redis:sismember(Black.."SilentGroup:Group"..ChatId,UserId[2]) then
Redis:srem(Black.."SilentGroup:Group"..ChatId,UserId[2])
else
Redis:sadd(Black.."SilentGroup:Group"..ChatId,UserId[2])
end
return editrtp(ChatId,UserId[1],Msg_id,UserId[2])
end
end
if Text and Text:match('/delAmr1') then
local UserId = Text:match('/delAmr1')
if data.Admin then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, {text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, {text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر الحمايه اتبع مايلي ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ قفل ، فتح ↫ الامر 
↯︙ تستطيع قفل حمايه كما يلي ...
↯︙↫ بالتقييد ، بالطرد ، بالكتم 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ الروابط
↯︙ المعرف
↯︙ التاك
↯︙ الشارحه
↯︙ التعديل
↯︙ التثبيت
↯︙ المتحركه
↯︙ الملفات
↯︙الصور
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ الماركداون
↯︙ البوتات
↯︙ التكرار
↯︙ الكلايش
↯︙ السيلفي
↯︙ الملصقات
↯︙ الفيديو
↯︙ الانلاين
↯︙ الدردشه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ القناه
↯︙ التوجيه
↯︙ الاغاني
↯︙ الصوت
↯︙ الجهات
↯︙ الاشعارات
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, {text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, {text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر ادمنية الكروب ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ رفع، تنزيل ↫ مميز
↯︙تاك للكل ، عدد الكروب
↯︙ كتم ، حظر ، طرد ، تقييد
↯︙ الغاء كتم ، الغاء حظر ، الغاء تقييد
↯︙ منع ، الغاء منع 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ عرض القوائم كما يلي ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ المكتومين
↯︙ المميزين 
↯︙ قائمه المنع
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تثبيت ، الغاء تثبيت
↯︙ الرابط ، الاعدادات
↯︙ الترحيب ، القوانين
↯︙ تفعيل ، تعطيل ↫ الترحيب
↯︙ تفعيل ، تعطيل ↫ الرابط
↯︙ جهاتي ،ايدي ، رسائلي
↯︙ تعديلاتي ، نقاطي
↯︙ كشف البوتات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ وضع ، ضع ↫ الاوامر التاليه 
↯︙ اسم ، رابط ، صوره
↯︙ قوانين ، وصف ، ترحيب
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ حذف ، مسح ↫ الاوامر التاليه
↯︙ قائمه المنع ، المحظورين 
↯︙ المميزين ، المكتومين ، القوانين
↯︙ المطرودين ، البوتات ، الصوره
↯︙ الرابط
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toar') then
local UserId = Text:match('(%d+)toar')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ ارسل النص لترجمته الي العربيه
*]]
Redis:set(Black.."toar"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toen') then
local UserId = Text:match('(%d+)toen')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ ارسل النص لترجمته الي الانجليزيه
*]]
Redis:set(Black.."toen"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setallmember') then
local UserId = Text:match('(%d+)/setallmember')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'عوده', data = IdUser..'/chback'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ تم تفعيل وضع الاشتراك الاجباري لكل الاعضاء
*]]
Redis:set(Black.."chmembers","on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setforcmd') then
local UserId = Text:match('(%d+)/setforcmd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'عوده', data = IdUser..'/chback'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ تم تفعيل وضع الاشتراك الاجباري علي اوامر البوت فقط مثل (الحظر/الكتم الخ..)
*]]
Redis:del(Black.."chmembers")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/chback') then
local UserId = Text:match('(%d+)/chback')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = IdUser..'/setallmember'},{text = '2', data = IdUser..'/setforcmd'},
},
}
}
local TextHelp = '↯︙ اختار كيف تريد تفعيله \n↯︙ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n↯︙ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n'
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, {text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, {text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر المدراء في الكروب
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ رفع ، تنزيل ↫ ادمن
↯︙ الادمنيه 
↯︙ رفع، كشف ↫ القيود
↯︙ تنزيل الكل ↫ بالرد ، بالمعرف
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ لتغيير رد الرتب في البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تغيير رد ↫ اسم الرتبه والنص
↯︙ المطور ، المنشئ الاساسي
↯︙ المنشئ ، المدير ، الادمن
↯︙ المميز ، العضو
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تفعيل ، تعطيل ↫ الاوامر التاليه ↓
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ التاك التلقائي
↯︙ الايدي ، الايدي بالصوره
↯︙ الردود العامه ، الردود
↯︙ اطردني ، الالعاب ، الرفع
↯︙ الحظر ، الرابط 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تعين ، مسح ↫الايدي 
↯︙ رفع الادمنيه ، مسح الادمنيه
↯︙ الردود ، مسح الردود
↯︙ اضف ، حذف ↫  رد 
↯︙ مسح ↫ عدد 
↯︙ ضع اسم ↫ لتغيير اسم المجموعه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, {text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, {text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر المنشئ الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ رفع ، تنزيل ↫ منشئ 
↯︙ المنشئين ، مسح المنشئين
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ اوامر المنشئ الكروب
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ رفع ، تنزيل ↫  مدير
↯︙ المدراء ، مسح المدراء
↯︙ اضف رسائل ↫  بالرد او الايدي
↯︙ اضف نقاط ↫  بالرد او الايدي
↯︙ اضف ، حذف ↫ امر
↯︙ الاوامر المضافه ، مسح الاوامر المضافه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, {text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, {text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر المطور الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ حظر عام ، الغاء العام
↯︙ اضف ، حذف ↫ مطور
↯︙ قائمه العام ، مسح قائمه العام
↯︙ المطورين ، مسح المطورين
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ اضف ، حذف ↫  رد عام 
↯︙وضع ، حذف ↫ كليشه المطور
↯︙ مسح الردود العامه ، الردود العامه
↯︙ تعين عدد الاعضاء ↫ العدد
↯︙ تحديث
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تفعيل ، تعطيل ↫  الاوامر التاليه ↓
↯︙ البوت الخدمي ، المغادرة ، الاذاعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ اوامر المطور في البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ تفعيل ، تعطيل ، الاحصائيات
↯︙ رفع، تنزيل ↫ منشئ اساسي
↯︙ رفع، تنزيل ↫ مالك
↯︙ مسح الاساسين ، المنشئين الاساسين
↯︙ غادر ↫ الايدي
↯︙ اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
↯︙ اذاعه خاص ، اذاعه خاص بالتوجيه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help7') then
local UserId = Text:match('(%d+)/help7')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, {text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, {text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ اوامر التسلية
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ رفع ، تنزيل ↫ الاوامر التاليه ↓
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ غبي 
↯︙ نبي
↯︙ حمار
↯︙ صاك
↯︙ قرد 
↯︙ دوده
↯︙ متوحد
↯︙ متوحده
↯︙ كلب 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ اوامر التاك 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ الاغبياء
↯︙ الحمير
↯︙ الصاكين
↯︙ الانبياء
↯︙ المتوحدين
↯︙ الكلاب
↯︙ الدود
↯︙ القرود
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ اوامر الترفيه 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ زخرفه
↯︙ يوتيوب
↯︙ اطردني
↯︙ ترند
↯︙ اسمي
↯︙ معرفي
↯︙ ايديي
↯︙ بحث + اسم الاغنيه
↯︙ روابط الحذف
↯︙ ريمكس
↯︙ غنيلي 
↯︙ شعر
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'العاب السورس ™️', data = IdUser..'/normgm'}, {text = 'العاب متطورة 🎳', data = IdUser..'/degm'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ أهلا بك في قائمة العاب سورس بلاك اختر نوع الالعاب 
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- فلابي بيرد', url = 'https://t.me/awesomebot?game=FlappyBird'}, 
},
{
{text = '- تبديل النجوم ', url = 'https://t.me/gamee?game=Switchy'}, {text = '- موتسيكلات', url = 'https://t.me/gamee?game=motofx'}, 
},
{
{text = '- اطلاق النار ', url = 'https://t.me/gamee?game=NeonBlaster'}, {text = '- كره القدم', url = 'https://t.me/gamee?game=Footballstar'}, 
},
{
{text = '- تجميع الوان ', url = 'https://t.me/awesomebot?game=Hextris'}, {text = '- المجوهرات', url = 'https://t.me/gamee?game=DiamondRows'}, 
},
{
{text = '- ركل الكرة ', url = 'https://t.me/gamee?game=KeepitUP'}, {text = '- بطولة السحق', url = 'https://t.me/gamee?game=SmashRoyale'}, 
},
{
{text = '- 2048', url = 'https://t.me/awesomebot?game=g2048'}, 
},
{
{text = '- كرة السلة ', url = 'https://t.me/gamee?game=BasketBoy'}, {text = '- القط المجنون', url = 'https://t.me/gamee?game=CrazyCat'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ مرحبا بك في الالعاب المتطورة الخاص بسورس بلاك 
↯︙ اختر اللعبه ثم اختار المحادثة التي تريد اللعب بها
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/normgm') then
local UserId = Text:match('(%d+)/normgm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙ قائمه الالعاب البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ لعبة المختلف ↫ المختلف
↯︙ لعبة الامثله ↫ امثله
↯︙ لعبة العكس ↫ العكس
↯︙ لعبة الحزوره ↫ حزوره
↯︙ لعبة المعاني ↫ معاني
↯︙ لعبة الترجمه ↫ انجليزي
↯︙ لعبة البات ↫ بات
↯︙ لعبة التخمين ↫ خمن
↯︙ لعبة الاسرع ↫ الاسرع
↯︙ لعبة السمايلات ↫ سمايلات
↯︙ لعبة الاسئلة ↫ كت تويت
↯︙ لعبة الاعلام والدول ↫ اعلام
↯︙ لعبة لو خيروك ↫ خيروك
↯︙ لعبة الصراحه والجرأة ↫ صراحه
↯︙ لعبه باد للأسئله +18 ↫ باد
↯︙ لعبه جريمتي ويقوم البوت بإعطائك جريمه ↫ جريمتي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙ نقاطي ↫ لعرض عدد الارباح
↯︙ بيع نقاطي ↫ { العدد } ↫ لبيع كل نقطه مقابل {50} رساله
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '(1)', data = IdUser..'/help1'}, {text = '(2)', data = IdUser..'/help2'}, 
},
{
{text = '(3)', data = IdUser..'/help3'}, {text = '(4)', data = IdUser..'/help4'}, 
},
{
{text = '(5)', data = IdUser..'/help5'}, {text = '(6)', data = IdUser..'/help7'}, 
},
{
{text = '( الالعــاب )', data = IdUser..'/help6'},
},
{
{text = 'اوامر القفل', data = IdUser..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '- Black TeAm .', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
↯︙اهلا بك في قائمة الاوامر ↫ ⤈ 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙م1 ↫ اوامر الحمايه
↯︙م2 ↫ اوامر الادمنيه
↯︙م3 ↫ اوامر المدراء
↯︙م4 ↫ اوامر المنشئين
↯︙م5 ↫ اوامر المطورين
↯︙م6 ↫ اوامر التسليه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
↯︙Black TeAm
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الدخول").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Black.."Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Black.."Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Black.."Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(Black.."Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(Black.."Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Fdmin@(.*)') then
local UserId = {Text:match('(%d+)/Fdmin@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Black.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Black.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "↯︙ تم ترقيه {"..y.."} ادمنيه \n↯︙ تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(Black.."Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Black..''..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "↯︙ تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "↯︙ تم مغادره البوت من الكروب", true)
LuaTele.leaveChat(UserId)
end


if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ❌ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✔️ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ❌ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✔️ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ❌ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✔️ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ❌ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✔️ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ❌ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✔️ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ❌ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "↯︙ تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✔️ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end
if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return edit(ChatId,Msg_id,'↯︙ اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n↯︙ اعدادات الكروب ".."\n↯︙ علامة ال (✔️) تعني مقفول".."\n↯︙ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n↯︙ اعدادات الكروب ".."\n↯︙ علامة ال (✔️) تعني مقفول".."\n↯︙ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل الملفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملفات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملفات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الدخول", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر التثبيت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الاشعارات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الماركدون", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"↯︙ عليك اختيار نوع القفل او الفتح على امر التكرار", 'md', true, false, reply_markup)
end

elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الروابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الكلايش").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الكيبورد").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الاغاني").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح المتحركات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الملفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الدردشه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الصور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح المعرفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح التاك").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح البوتات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح التوجيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الصوت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الملصقات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الجهات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الدخول").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الاضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح بصمه الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح التثبيت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الاشعارات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الماركدون").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح التعديل").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(Black.."Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"↯︙ تم فتح التكرار").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Dev') then
local UserId = Text:match('(%d+)/Dev')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Dev:Groups") 
edit(ChatId,Msg_id,"↯︙ تم مسح مطورين البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Devss') then
local UserId = Text:match('(%d+)/Devss')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Devss:Groups") 
edit(ChatId,Msg_id,"↯︙ تم مسح مطورين الثانوين من البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Supcreator') then
local UserId = Text:match('(%d+)/Supcreator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Supcreator:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح المنشئين الاساسيين", 'md', false)
end
elseif Text and Text:match('(%d+)/Owners') then
local UserId = Text:match('(%d+)/Owners')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Owners:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح المالكين", 'md', false)
end
elseif Text and Text:match('(%d+)/Creator') then
local UserId = Text:match('(%d+)/Creator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Creator:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح منشئين الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/Manger') then
local UserId = Text:match('(%d+)/Manger')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Manger:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح المدراء", 'md', false)
end
elseif Text and Text:match('(%d+)/Admin') then
local UserId = Text:match('(%d+)/Admin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Admin:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح ادمنيه الكروب", 'md', false)
end
elseif Text and Text:match('(%d+)/DelSpecial') then
local UserId = Text:match('(%d+)/DelSpecial')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."Special:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح المميزين", 'md', false)
end

elseif Text and Text:match('(%d+)/Delkholat') then
local UserId = Text:match('(%d+)/Delkholat')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."kholat:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع صاكين المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delwtk') then
local UserId = Text:match('(%d+)/Delwtk')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."wtka:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع وتكات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Deltwhd') then
local UserId = Text:match('(%d+)/Deltwhd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."twhd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع متوحدين المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delklb') then
local UserId = Text:match('(%d+)/Delklb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."klb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع الكلاب المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delmar') then
local UserId = Text:match('(%d+)/Delmar')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."mar:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع حمير المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delsmb') then
local UserId = Text:match('(%d+)/Delsmb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."smb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع الانبياء الي هنا ف المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Del2rd') then
local UserId = Text:match('(%d+)/Del2rd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."2rd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع القرود", 'md', false)
end
elseif Text and Text:match('(%d+)/Del3ra') then
local UserId = Text:match('(%d+)/Del3ra')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."3ra:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع الدود", 'md', false)
end
elseif Text and Text:match('(%d+)/Del8by') then
local UserId = Text:match('(%d+)/Del8by')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."8by:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"↯︙ تم مسح جميع الأغبياء", 'md', false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."BanAll:Groups") 
edit(ChatId,Msg_id,"↯︙ تم مسح المحظورين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."ktmAll:Groups") 
edit(ChatId,Msg_id,"↯︙ تم مسح المكتومين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."BanGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح المحظورين", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(Black.."SilentGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"↯︙ تم مسح المكتومين", 'md', false)
end
end
end
end

luatele.run(CallBackLua)


 