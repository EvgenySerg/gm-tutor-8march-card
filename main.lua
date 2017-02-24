-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,20)


local nFlowerTypes=6
local nFlowers=nFlowerTypes*50

local flower={
	image="",
	size=0,
	posX=0, 
	posY=0,
	imgObject=nil
}
flowers={}

function  flower:new(imagePath)
	self={}
	self.image=imagePath
	self.size=3000/((math.random()+0.5)*250)
	self.posX=math.random()*display.contentWidth
	self.posY=math.random()*display.contentHeight
	self.imgObject=display.newImageRect(imagePath,self.size, self.size)
	self.imgObject.x=self.posX
	self.imgObject.y=self.posY
	transition.scaleTo( self.imgObject, {xScale=self.size, yScale=self.size, time=1000 } )

function self:fall()
	tm=timer.performWithDelay(2000+math.random()*500, fall,1)
	tm.params={obj=self.imgObject}
end

	return self
end

function fall(event)
	local params=event.source.params 
	physics.addBody(params.obj,"dynamic")
end

math.randomseed(os.time())



local function onObjectTouch( event )
    if ( event.phase == "began" ) then
        event.target:fall()
    elseif ( event.phase == "ended" ) then
       
    end
    return true
end



local fType=1
for i=1,nFlowers,1 do 
	f=flower:new("/assets/flower"..fType..".png")
	
	f.imgObject:addEventListener( "touch", onObjectTouch )
	
	table.insert(flowers, i, f )
	if fType==nFlowerTypes then
		fType=1
	end
	fType=fType+1


end

--[[for i=1,nFlowers,1 do
	print( flowers[i].posX)
	flowers[i]:fall()
end]]



