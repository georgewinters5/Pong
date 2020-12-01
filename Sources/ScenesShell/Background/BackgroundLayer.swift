import Scenes
import Igis

/*
 This class is responsible for the background Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class BackgroundLayer : Layer {
<<<<<<< HEAD:Sources/ScenesShell/Background/BackgroundLayer.swift
    let background = Background()
    let net = Net()

    init() {
=======
    let background : Background
    let scoreboard : Scoreboard
    
    init()
    {
        background = Background()
        scoreboard = Scoreboard(location:Point(x:100, y:100))
        
>>>>>>> 27b6d11ea1124724d1befc4f122afc367d321270:Sources/ScenesShell/BackgroundLayer.swift
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:background, at:.back)
        insert(entity:net, at:.front)
    }
}
