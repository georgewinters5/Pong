import Igis
import Scenes

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class InteractionLayer : Layer
{
    // This is where we create our objects that will be inside this layer
    let ball : Ball
    let leftPaddle : Paddle
    let rightPaddle : Paddle
    
    init()
    {
        // This is where we define our objects
        ball = Ball(size:15)
        leftPaddle = Paddle(topLeft:Point(), size:Size(width:0, height:0))
        rightPaddle = Paddle(topLeft:Point(), size:Size(width:0, height:0))
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:ball, at:.front)
        insert(entity:leftPaddle, at:.front)
        insert(entity:rightPaddle, at:.front)
    }
}
