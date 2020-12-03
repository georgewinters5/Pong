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

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:ball, at:.front)
        insert(entity:leftPaddle, at:.front)
        insert(entity:rightPaddle, at:.front)
    }

    // Calculate if the ball comes into contact with a paddle, and
    // handle it accordingly.
    override func postCalculate(canvas: Canvas) {
        let leftPaddleHitTest = leftPaddle.rectangle.rect.containment(target:ball.hitBox).contains(.contact)
        let rightPaddleHitTest = rightPaddle.rectangle.rect.containment(target:ball.hitBox).contains(.contact)

        if leftPaddleHitTest {
            ball.velocityX = Ball.speedX
        } else if rightPaddleHitTest {
            ball.velocityX = -Ball.speedX
        }
    }

    func gameOver() {
        ball.freeze()
    }

    func gameContinue() {
        ball.unfreeze()
    }
}
