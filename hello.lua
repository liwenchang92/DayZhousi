--[[
local mt={}
mt.__add=function (t1,t2)
    print("两个label相加时调用")
end
-- function mt.__add(t1,t2)
-- 	print("两个label相加时调用")
-- end
local t1={}
local t2 ={}
setmetatable(t1,mt)
setmetatable(t2,mt)
local result=t1+t2

local mt = {}
mt.__add=function (s1,s2)
	local result = ""
	if s1.sex=="boy" and s2.sex=="girl" then
		result="完美的家庭"
		elseif s1.sex=="girl" and s2.sex=="girl" then
			result="不好"
		else
			result="不好"
		end
		return result
end

local s1 = {
	name="hello",
	sex="boy"}
local s2 = {
	name="good",
	sex="girl"}

setmetatable(s1,mt)
setmetatable(s2,mt)

local result = s1+s2
print(result)


local t = {
	name="hehe"
}
local mt = {
	-- __index=function (table,key)
	-- 	print("调用了不存在的字段"..key)
	-- end
	__index={
	money=9000
}
}
setmetatable(t,mt)
print(t.money)


local smartMan = {
	name="none",
	money=9000,
	sayHello=function ( )
		print("大家好")
	end
}
local t1 = {}
local mt = {
  __index=smartMan,
__newindex=function(table,key,value)
	print(key.."字段不存在的不要试图给它赋值")
end
}
setmetatable(t1,mt)
t1.sayHello=function ()
	print("en")
end
t1.sayHello()


local smartMan={name="none"}
local other={name="大家好，我是无辜的table"}
local t1 = {}
local mt = {
	__index=smartMan,
	__newindex=other
}
setmetatable(t1,mt)
print("other的名字，赋值前" .. other.name)
t1.name="小偷"
print("other的名字，赋值后" .. other.name)
print("t1的名字" ..t1.name)


local smartMan={
	name="none"
}
local t1={
	hehe=123
}
local mt={
	__index=smartMan,
	__newindex=function (t,k,v)
		print("别赋值！")
	end
}
setmetatable(t1,mt)
print(rawget(t1,"name"))
print(rawget(t1,"hehe"))
rawset(t1,"name","小偷")
print(t1.name)
]]



-- require("game")
-- game.paly()

-- game.setLevel(10)
-- print(game.getLevel())


-- TSprite={
-- 	x=0,
-- 	y=0
-- }
-- function TSprite.setPosition(self,x,y)
-- 	self.x = x;
-- 	self.y = y;
-- end
-- local who =TSprite;
-- TSprite=nil;
-- who.setPosition(who,1,2);

-- for k,v in pairs(who) do 
-- 	print(k,v) 
-- end


-- Hero ={attack=0}
-- function Hero:new(o)
-- 	o=o or {}
-- 	setmetatable(o,self)
-- 	self.__index=self
-- 	return o
-- end
-- function Hero:skill(addAttack)
-- 	self.attack=self.attack+addAttack
-- end
-- oneHero=Hero:new()
-- function oneHero:skill(addAttack)
-- 	print("chongxie")
-- end
-- oneHero:skill(10)
-- print(oneHero.attack)


--[[
function createClass(...)
    local parents = {...};
    local child = {}; -- 设置类的元表
    setmetatable(child, {
        __index = function(table, key)
            return search(parents, key);
        end
    })
-- 给类新增⼀一个new函数,用于创建对象 
    function child:new()
        o = {};
        setmetatable(o, child);
        child.__index = child;
        return o;
    end
     -- 返回这个继承了多个类的⼦子类 
    return child
end

-- 一个精灵类 
TSprite = {}
function TSprite:hello()
    print("hello");
end
function TSprite:new()
    o = {}
    setmetatable(o, self);
    self.__index = self;
    return o; 
end
-- 一个⼦子弹类 
TBullet = {}
function TBullet:fire() 
	print("开⽕");
end
function TBullet:new()
    o = {}
    setmetatable(o, self);
    self.__index = self;
    return o;
end
-- 继承了两个类的⼦子类
local BulletSprite = createClass(TSprite, TBullet);
-- 子类的对象
local bSprite = BulletSprite:new();
bSprite:hello();
bSprite:fire();
]]


--table深拷贝如何实现
--如何正确计算table的长度
-- t={x=3,y=5}
-- local m = t
-- m.x=8
-- print(t.x)

--错误的
-- t={x=3,y=5}
-- function copy(t)
-- 	local a={}
-- 	for k,v in pairs(t) do
-- 		a[k]=v
-- 	end
-- 	return a
-- end
-- m=copy(t)
-- m.x=8
-- print(t.x)

t={}
--使用一个table作为t的key值
key1={name="key1"}
setmetatable(t, {_mode="k"})
t[key1]=1
key1=nil
--又使用一个table作为t的key值
key2={name="key2"}
t[key2]=1
key2=nil
--强制进行一次垃圾收集
collectgarbage()
for key,value in pairs(t) do
	print(key.name..":"..value)
end
