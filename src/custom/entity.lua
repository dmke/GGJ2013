Entity = {}
Entity.__index = Entity

function Entity.create(path)
   local acnt = display.newImage(path)            -- our new object
   setmetatable(acnt,Entity)  -- make Account handle lookup  
   acnt.name = ("entity")
   acnt.id = a
   acnt.x = 100
   acnt.y = 100
   acnt.speed = 0
   return acnt
end

function Entity:doSomething(amount)
   --self.balance = self.balance - amount
end

-- create and use an Account
--acc = Entity.create("ghost.png")
--acc:withdraw(100)