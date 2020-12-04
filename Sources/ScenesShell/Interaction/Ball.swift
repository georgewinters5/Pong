import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the ball.
 */

class Ball :  RenderableEntity {
    // Mark: Ball Styling
    let ballRadius = 20
    let speedX = 12
    let speedY = 8

    // Animations are available through the ScenesAnimations library
    // as an extension to the Scenes and Igis libraries
    let resetDelay = 0.75

    // Mark: Ball Constants
    let fillStyle = FillStyle(color:MainScene.ballColor)
    let ellipse : Ellipse
    var resetAnimation : Animation?
    var canvasCenter = Point.zero

    var isFrozen = false
    var velocityX = 0 {
        didSet {
            if isFrozen && velocityX != 0 {
                velocityX = 0
            }
        }
    }
    var velocityY = 0 {
        didSet {
            if isFrozen && velocityY != 0 {
                velocityY = 0
            }
        }
    }
    
    init() {
        ellipse = Ellipse(center:Point.zero, radiusX:ballRadius, radiusY:ballRadius, fillMode:.fill)
    }

    // This calculates a rectangle around the ball for use in
    // hit testing.
    var hitBox : Rect {
        let topLeft = Point(x:ellipse.center.x - ellipse.radiusX, y:ellipse.center.y - ellipse.radiusY)
        let size = Size(width:ellipse.radiusX * 2, height:ellipse.radiusY * 2)
        return Rect(topLeft:topLeft, size:size)
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        // Define our animation
        resetAnimation = Tween(from:0, to:0, delay:resetDelay, duration:0.01) { result in
            self.velocityX = Bool.random()
              ? self.speedX
              : -self.speedX
            self.velocityY = Bool.random()
              ? self.speedY
              : -self.speedY
        }
        animationController.register(animation:resetAnimation!)

        canvasCenter = canvasSize.center

        // start the game by reseting the ball
        resetBall()
    }

    // This function is invoked before rendering this object for
    // any motion calculations.
    override func calculate(canvasSize:Size) {
        // move the ball by its current velocity
        ellipse.center += Point(x:velocityX, y:velocityY)

        // check if the hitBox hits the canvas border and handle accordingly.
        let canvasBoundingRect = Rect(size:canvasSize)
        let hitResults = canvasBoundingRect.containment(target:hitBox)

        for result in hitResults {
            switch result {
            case .overlapsTop:
                velocityY = speedY
            case .overlapsBottom:
                velocityY = -speedY
            case .overlapsLeft, .overlapsRight:
                resetBall()
                if let scene = scene as? MainScene {
                    let position = (result == .overlapsLeft)
                      ? Position.right
                      : Position.left
                    scene.addPoint(to:position)
                }
            default:
                break
            }
        }
    }

    // This function is responsible for rendering out objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the ellipse object
        canvas.render(fillStyle)
        canvas.render(ellipse)
    }

    // This function is invoked after a point is scored to reset the
    // ball for the next round.
    func resetBall() {
        velocityX = 0
        velocityY = 0
        ellipse.center = canvasCenter
        resetAnimation!.play()
    }

    // Whenever the game ends, we want to stop the balls motion.
    func freeze() {
        isFrozen = true
        resetBall()
    }

    // Whenever the game restarts, we want to reset the balls motion.
    func unfreeze() {
        isFrozen = false
        resetBall()
    }
}
