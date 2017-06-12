--start by edit by 
local datebase = {
  "  من انلاینم و تمام پیام های گروه رو برسی میکنم😐❤️ ",

  }
local function run(msg, matches) 
return datebase[math.random(#datebase)]
end
return {
  patterns = {
    "^(انلاینی)",
  },
  run = run
}

--end by edit by 
--Channel 
