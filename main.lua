-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
physics.setGravity(0,100)

cx=display.contentCenterX
local nFlowerTypes=6
local nFlowers=nFlowerTypes*30


local nTaps=nFlowers*0.3

local flower={
	image="",
	size=0,
	posX=0, 
	posY=0,
	imgObject=nil
}
local flowers={}

local fon=display.newImage("fon.jpg")
fon.x=display.contentCenterX
fon.y=display.contentCenterY

local oldNewImageRect = display.newImageRect
function display.newImageRect( ... )
    local img = oldNewImageRect( ... )
    function img:fall()
    	transition.scaleTo( self, {xScale=5, yScale=5, time=200 } )
    	transition.to( self, { rotation=-180, time=500, transition=easing.inOutCubic } )

       physics.addBody(self,"dynamic")
       self.hasBody=true
       audio.play( self.sound )
    end
    return img
end
local fType=1



local function onObjectTouch( event )
    if ( event.phase == "began" ) then
        event.target:fall()
        nTaps=nTaps-1
        
    elseif ( event.phase == "ended" ) then
       
    end
    return true
end

local allfallSound=audio.loadSound("allfall.wav")

math.randomseed(os.time())

for i=1,nFlowers,1 do 
	size=3000/((math.random()+0.5)*250)
	f=display.newImageRect( "flower"..fType..".png", size, size)
	f.sound=audio.loadSound( "flower"..fType..".wav")
	f.x=math.random()*display.contentWidth
	f.y=math.random()*display.contentHeight
	f:addEventListener( "touch", onObjectTouch )
	transition.scaleTo( f, {xScale=size, yScale=size, time=1000 } )
	table.insert(flowers, i, f )
	if fType==nFlowerTypes then
		fType=1
	end
	fType=fType+1
end


local march8Music=audio.loadSound("march8Music.mp3")
local march8=display.newImage("8march.png")	
march8.alpha=0
channel=0

function March8Sow()
	march8.x=display.contentCenterX
	march8.y=display.contentHeight*0.1+march8.height/2
	march8.alpha=0
	march8.xScale=0.6
	march8.yScale=0.6
	transition.scaleTo( march8, {xScale=1, yScale=1, alpha=1, time=10000 } )
	channel=audio.play(march8Music)
	MakeFlowersBelt()
end
nTaps1=7
music2=audio.loadSound("cute.mp3")
stih=display.newImage("stih.png")


local options={width=500, height=375, numFrames=20}
local imageSheet=graphics.newImageSheet( "spritesheets.png", options )
local sequenceData={{name="dancer", start=1, count=20, time=800}}
local dancer=display.newSprite(imageSheet,sequenceData)
dancer:setSequence( "dancer" )

dancer.x=cx
dancer.y=410
dancer.xScale=0.01
dancer.yScale=0.01
dancer.alpha=0


chvak=di
stih.x=cx
stih.y=2500

function onBeltTouch( event )
	 if ( event.phase == "began" ) then
        event.target:fall()
        nTaps1=nTaps1-1
        if nTaps1<=0 then
        	nTaps1=100
        	audio.stop( channel )
        	audio.play( music2 )
        	transition.to(stih,{y=1200, time=1000, transition=easing.inOutCubic})
        	transition.scaleTo( dancer, {xScale=2.2, yScale=2.2, alpha=1, time=1000 } )
        	dancer:play()

        	march8_2=display.newImage( "march8-2.png")
        	march8_2.alpha=0
        	march8_2.x=cx
        	march8_2.y=1700
        	transition.scaleTo( march8_2, {xScale=0.5, yScale=0.5, alpha=1, time=3000 } )
        end
    elseif ( event.phase == "ended" ) then
       
    end

    return true
end




flowersBelt={}
function  MakeFlowersBelt()
	-- body
	for i=1,7,1 do
		f=display.newImageRect( "flower1.png", 50, 50)
		f.alpha=0.4
		f.y=1000
		f.x=display.contentWidth/8*i
		f:addEventListener( "touch", onBeltTouch )
		scaleFactor=(cx-math.abs(cx-f.x))/120
		transition.scaleTo( f, {xScale=scaleFactor, yScale=scaleFactor, alpha=1, time=1000} )
		table.insert(flowersBelt, i, f )	
	end

end




function enterFrame(event)
	if nTaps<=0 then
        	audio.play(allfallSound)
	        for i=1,nFlowers,1 do
	        	transition.to( flowers[i], { y=2200, rotation=-180, time=math.random()*600+1000, transition=easing.inOutCubic } )
   				if flowers[i].hasBody==true then 	
 					physics.removeBody( flowers[i] )  
				end
	        end
	        March8Sow()
	        nTaps=100
        end



end




Runtime:addEventListener("enterFrame", enterFrame)






