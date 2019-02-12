
account_tbl = {}


for accout = 1,10000000 do
  account_tbl[accout] = accout + 1
end


print(account_tbl[2000])

os.execute("sleep " .. 100000)
