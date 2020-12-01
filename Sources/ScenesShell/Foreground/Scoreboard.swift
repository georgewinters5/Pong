import Igis
import Scenes

/*
 This class is responsible for rendering the scoreboard.
 */

<<<<<<< HEAD:Sources/ScenesShell/Foreground/Scoreboard.swift
class Scoreboard : RenderableEntity {

    // We establish our variables first
    var leftScore : Int = 0
    var rightScore : Int = 0
    static var location = Point(x:100, y:100)
    var text = Text(location:location, text:"test", fillMode:.fill)
    
    init() {

        // Then we give our variables their starting values
        
        //self.location = Point(x:100, y:100)
        //self.text = Text(location:location, text:"test", fillMode:.fill)
=======
class Scoreboard : RenderableEntity
{
    // First, we create the variables that will be set in the inililizers
    var text : Text
    
    // Next, we create the variables that are used during runtime
    var leftScore : Int = 0
    var rightScore : Int = 0
    
    init(location:Point)
    {
        // This is where we set our variables
        text = Text(location:location, text:"test", fillMode:.fill)
>>>>>>> 27b6d11ea1124724d1befc4f122afc367d321270:Sources/ScenesShell/Scoreboard.swift
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas)
    {
        
    }

    override func render(canvas:Canvas) {
        
    }    
}
