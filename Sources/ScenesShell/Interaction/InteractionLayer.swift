import Igis
import Scenes

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class InteractionLayer : Layer {
    let ball = Ball()
    let leftPaddle = Paddle(position:.left)
    let rightPaddle = Paddle(position:.right)

    var enableHitTesting = true

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:ball, at:.front)
        insert(entity:leftPaddle, at:.front)
        insert(entity:rightPaddle, at:.front)
    }
    

    override func postCalculate(canvas:Canvas) {
        if enableHitTesting {
            let leftPaddleBoundingRect = leftPaddle.boundingRect()
            let rightPaddleBoundingRect = rightPaddle.boundingRect()
            
            let ballBoundingRect = ball.boundingRect()
            
            // calculate the balls position relative to the
            // specified paddle to determine if they have come into contact.
            let leftPaddleHitTest = leftPaddleBoundingRect.containment(target:ballBoundingRect)
            let rightPaddleHitTest = rightPaddleBoundingRect.containment(target:ballBoundingRect)
            
            // If the hit results specify the ball has come into contact
            // with the paddle, we want to change its velocity.
            if leftPaddleHitTest.contains(.contact) && ball.velocityX < 0 {
                ball.velocityX = -ball.velocityX
            } else if rightPaddleHitTest.contains(.contact) && ball.velocityX > 0 {
                ball.velocityX = -ball.velocityX
            }
        }
    }
}
