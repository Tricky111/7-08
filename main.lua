
display.setDefault( "background", 100/255, 100/255, 200/255 )



-- Gravity



local physics = require( "physics" )



physics.start()

physics.setGravity( 0, 50 ) -- ( x, y )

--physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only



local playerBullets = {} -- Table that holds the players Bullets



--local rightWall = display.newRect( 400, 0, display.contentHeight / 3 , display.contentHeight + 400 )





--ground

local theGround = display.newImage( "land.png" )

theGround.x = -130

theGround.y = 480

theGround.id = "the ground"

physics.addBody( theGround, "static", { 

    friction = 0.5, 

    bounce = 0.3 

    } )





--charater

local Man = display.newImageRect( "Man.png", 175, 175 )

Man.x = 120

Man.y = 200

Man.id = "the character"

physics.addBody( Man, "dynamic", { 

    density = 5.0, 

    friction = 0.5, 

    bounce = 0.3 

    } )

Man.isFixedRotation = true



local State = display.newImageRect( "State.png", 90, 155 )

State.x = 240

State.y = 200

State.id = "State"

physics.addBody( State, "dynamic", { 

    density = 3.0, 

    friction = 0.5, 

    bounce = 0.3 

    } )

State.isFixedRotation = true



-- Character move

local dPad = display.newImageRect( "d-pad.png", 125, 125 )

dPad.x = 80

dPad.y = 440

dPad.id = "d-pad"





local upArrow = display.newImageRect( "upArrow.png", 30, 22 )

upArrow.x = 80

upArrow.y = 393

upArrow.id = "up arrow"



local downArrow = display.newImageRect( "downArrow.png", 30, 22 )

downArrow.x = 80

downArrow.y = 486

downArrow.id = "down arrow"



local leftArrow = display.newImageRect( "leftArrow.png", 22, 30 )

leftArrow.x = 34

leftArrow.y = 440

leftArrow.id = "left arrow"



local rightArrow = display.newImageRect( "rightArrow.png", 22, 30 )

rightArrow.x = 126

rightArrow.y = 440

rightArrow.id = "right arrow"



local jumpButton = display.newImageRect( "jumpButton.png", 30, 30 )

jumpButton.x = 80

jumpButton.y = 440

jumpButton.id = "right arrow"



local shootButton = display.newImageRect( "jumpButton.png", 60, 60 )

shootButton.x = 275

shootButton.y = 440

shootButton.id = "shootButton"

shootButton.alpha = 1



local leftshootButton = display.newImageRect( "jumpButton.png", 60, 60 )

leftshootButton.x = 190

leftshootButton.y = 440

leftshootButton.id = "leftshootButton"

leftshootButton.alpha = 1



--functions 

function upArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( Man, { 

            x = 0, -- move 0 in the x direction 

            y = -50, -- move up 50 pixels

            time = 100 -- move in a 1/10 of a second

            } )

    end



    return true

end



function downArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( Man, { 

            x = 0, -- move 0 in the x direction 

            y = 50, -- move up 50 pixels

            time = 100 -- move in a 1/10 of a second

            } )

    end



    return true

end



function leftArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( Man, { 

            x = -50, -- move 0 in the x direction 

            y = 0, -- move up 50 pixels

            time = 100 -- move in a 1/10 of a second

            } )

    end



    return true

end



function rightArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( Man, { 

            x = 50, -- move 0 in the x direction 

            y = 0, -- move up 50 pixels

            time = 100 -- move in a 1/10 of a second

            } )

    end



    return true

end



function jumpButton:touch( event )

    if ( event.phase == "ended" ) then

        -- make the character jump

        Man:setLinearVelocity( 0, -750 )

    end



    return true

end



function shootButton:touch( event )

    if ( event.phase == "began" ) then

        -- make a bullet appear

        local aSingleBullet = display.newImageRect( "Bullet.png", 80, 30)

        aSingleBullet.x = Man.x + 30

        aSingleBullet.y = Man.y

        physics.addBody( aSingleBullet, 'dynamic' )

        -- Make the object a "bullet" type object

        aSingleBullet.isBullet = true

        aSingleBullet.gravityScale = 0

        aSingleBullet.id = "bullet"

        aSingleBullet:setLinearVelocity(  2000 , 0 )



        table.insert(playerBullets,aSingleBullet)

        print("# of bullet: " .. tostring(#playerBullets))

    end



    return true

end



function leftshootButton:touch( event )

    if ( event.phase == "began" ) then

        -- make a bullet appear

        local aSingleBullet2 = display.newImageRect( "Bullet.png", 80, 30)

        aSingleBullet2.x = Man.x- 30

        aSingleBullet2.y = Man.y

        physics.addBody( aSingleBullet2, 'dynamic' )

        -- Make the object a "bullet" type object

        aSingleBullet2.isBullet = true

        aSingleBullet2.gravityScale = 0

        aSingleBullet2.id = "bullet"

        aSingleBullet2:setLinearVelocity(  -2000 , 0)



        table.insert(playerBullets,aSingleBullet2)

        print("# of bullet: " .. tostring(#playerBullets))

    end



    return true

end



local function characterCollision( self, event )

 

    if ( event.phase == "began" ) then

        print( self.id .. ": collision began with " .. event.other.id )

        if event.other.id == "State" then

            print("yeet")

        end

 

    elseif ( event.phase == "ended" ) then

        print( self.id .. ": collision ended with " .. event.other.id )

    end

end





function checkPlayerBulletsOutOfBounds()

    -- check if any bullets have gone off the screen

    local bulletCounter



    if #playerBullets > 0 then

        for bulletCounter = #playerBullets, 1 ,-1 do

            if playerBullets[bulletCounter].x > display.contentWidth + 1000 then

                playerBullets[bulletCounter]:removeSelf()

                playerBullets[bulletCounter] = nil

                table.remove(playerBullets, bulletCounter)

                print("remove bullet")

            end

        end

    end

end



local function onCollision( event )

 

    if ( event.phase == "began" ) then

 

        local obj1 = event.object1

        local obj2 = event.object2

        local whereCollisonOccurredX = obj1.x

        local whereCollisonOccurredY = obj1.y



        if ( ( obj1.id == "State" and obj2.id == "bullet" ) or

             ( obj1.id == "bullet" and obj2.id == "State" ) ) then

            -- Remove both the laser and asteroid

            --display.remove( obj1 )

            --display.remove( obj2 )

            

            -- remove the bullet

            local bulletCounter = nil

            

            for bulletCounter = #playerBullets, 1, -1 do

                if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then

                    playerBullets[bulletCounter]:removeSelf()

                    playerBullets[bulletCounter] = nil

                    table.remove( playerBullets, bulletCounter )

                    break

                end

            end



            --remove character

            State:removeSelf()

            State = nil





            -- Increase score

            print ("you could increase a score here.")



            -- make an explosion sound effect

            local expolsionSound = audio.loadStream( "Boom.wav" )

            local explosionChannel = audio.play( expolsionSound )



            -- make an explosion happen

            -- Table of emitter parameters

            local emitterParams = {

                startColorAlpha = 1,

                startParticleSizeVariance = 25,

                startColorGreen = 0.3031555,

                yCoordFlipped = -1,

                blendFuncSource = 770,

                rotatePerSecondVariance = 153.95,

                particleLifespan = 0.7237,

                tangentialAcceleration = -1440.74,

                finishColorBlue = 0.3699196,

                finishColorGreen = 0.5443883,

                blendFuncDestination = 1,

                startParticleSize = 40.95,

                startColorRed = 0.8373094,

                textureFileName = "fire.png",

                startColorVarianceAlpha = 1,

                maxParticles = 256,

                finishParticleSize = 54,

                duration = 0.25,

                finishColorRed = 1,

                maxRadiusVariance = 72.63,

                finishParticleSizeVariance = 250,

                gravityy = -671.05,

                speedVariance = 90.79,

                tangentialAccelVariance = -420.11,

                angleVariance = -142.62,

                angle = -244.11

            }

            local emitter = display.newEmitter( emitterParams )

            emitter.x = whereCollisonOccurredX

            emitter.y = whereCollisonOccurredY



        end

    end

end



function checkCharacterPosition( event )

    -- check every frame to see if character has fallen

    if Man.y > display.contentHeight + 500 then

        Man.x = display.contentCenterX

        Man.y = display.contentCenterY

    end

end



upArrow:addEventListener( "touch", upArrow )

downArrow:addEventListener( "touch", downArrow )

leftArrow:addEventListener( "touch", leftArrow )

rightArrow:addEventListener( "touch", rightArrow )

jumpButton:addEventListener( "touch", jumpButton )

shootButton:addEventListener( "touch", shootButton )

leftshootButton:addEventListener( "touch", leftshootButton )



Runtime:addEventListener( "enterFrame", checkCharacterPosition )

Runtime:addEventListener( "enterFrame", checkPlayerBulletsOutOfBounds )

Runtime:addEventListener( "collision", onCollision )



Man.collision = characterCollision

Man:addEventListener( "collision" )
