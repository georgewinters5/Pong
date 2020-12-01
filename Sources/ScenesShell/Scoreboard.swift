import Scenes
import Igis

/*
 This class is responsible for rendering the scoreboard.
 */

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
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas)
    {
        
    }

    override func render(canvas:Canvas) {
        
    }
    
    
}
