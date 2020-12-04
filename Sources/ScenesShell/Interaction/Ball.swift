import Igis
import Scenes

/*
 This class is responsible for rendering the ball.
 */

class Ball :  RenderableEntity {
    var velocityX : Int
    var velocityY : Int
    
    init() {
        // Initialize objects
        velocityX = 15
        velocityY = 10
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Ball")
    }
}
