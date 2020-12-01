import Igis
import Scenes

/*
 This class is responsible for rendering the scoreboard.
 */

class Scoreboard : RenderableEntity {
    // Constants
    let position : Position
    
    init(position:Position) {
        self.position = position
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        
    }

    override func render(canvas:Canvas) {
        
    }    
}
