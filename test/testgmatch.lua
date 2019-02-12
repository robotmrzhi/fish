
t = {}

s = "res1=aaa, re2=bbb"

for k,v in string.gmatch(s,"(%w+)=(%w+)") do
  t[k]=v
end


for k,v in pairs(t) do
  print(k..v)
end
