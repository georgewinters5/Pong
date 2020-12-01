import Igis
import Scenes

/*
 This class is responsible for rendering the scoreboard.
 */

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
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        
    }

    override func render(canvas:Canvas) {
        
    }    
}
