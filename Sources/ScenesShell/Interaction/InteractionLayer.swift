import Igis
import Scenes

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class InteractionLayer : Layer {
    /*
     Layers typically include one or more RenderableEntities.
     Commonly, the interaction layer contains most interactive
     game components such as a character, enviornment, or ball.
     */
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

    // This function will be invoked after the calculate functions
    // for this Scenes RenderableEntities.
    override func postCalculate(canvas:Canvas) {
        let leftPaddleRect = leftPaddle.rectangle.rect
        let rightPaddleRect = rightPaddle.rectangle.rect

        // These calculate the balls position relative to the
        // specified paddle to determine if they have come into contact.
        let leftPaddleHitTest = leftPaddleRect.containment(target:ball.hitBox)
        let rightPaddleHitTest = rightPaddleRect.containment(target:ball.hitBox)

        // If the hit results specify the ball has come into contact
        // with the paddle, we want to change its velocity.
        if leftPaddleHitTest.contains(.contact) {
            ball.velocityX = ball.speedX
        } else if rightPaddleHitTest.contains(.contact) {
            ball.velocityX = -ball.speedX
        }
    }

    // This function is invoked when the game ends.
    func gameOver() {
        ball.freeze()
    }

    // This function is invoked when the game restarts.
    func restartGame() {
        ball.unfreeze()
    }
}
