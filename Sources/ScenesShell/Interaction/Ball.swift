import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the ball.
 */

class Ball :  RenderableEntity {
    // Settings
    static let ballRadius = 20
    static let speedX = 12
    static let speedY = 8

    let color = Color(red:255, green:255, blue:255)
    
    // Constants
    let fillStyle : FillStyle
    let ellipse : Ellipse
    
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

    var isFrozen = false

    // Animations are available through the ScenesAnimations library
    // as an extension to the Scenes and Igis libraries
    var resetAnimation : Animation?
    let resetDelay = 0.75

    var canvasCenter = Point.zero
    
    init() {
        fillStyle = FillStyle(color:color)
        ellipse = Ellipse(center:Point.zero, radiusX:Ball.ballRadius, radiusY:Ball.ballRadius, fillMode:.fill)
    }
    
    var hitBox : Rect {
        let topLeft = Point(x:ellipse.center.x - ellipse.radiusX, y:ellipse.center.y - ellipse.radiusY)
        let size = Size(width:ellipse.radiusX * 2, height:ellipse.radiusY * 2)
        return Rect(topLeft:topLeft, size:size)
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        // setup the reset animation (adds delay before continuing
        // ball motion)
        resetAnimation = Tween(from:0, to:0, delay:0.75, duration:0.01) { result in
            self.velocityX = Bool.random()
              ? Ball.speedX
              : -Ball.speedX
            self.velocityY = Bool.random()
              ? Ball.speedY
              : -Ball.speedY
        }
        animationController.register(animation:resetAnimation!)

        canvasCenter = canvasSize.center

        // start the game by reseting the ball
        resetBall()
    }

    override func calculate(canvasSize:Size) {
        ellipse.center += Point(x:velocityX, y:velocityY)

        // check if the ball makes contact with the edge of the
        // canvas, and handle accordingly.
        let canvasBoundingRect = Rect(size:canvasSize)
        let hitResults = canvasBoundingRect.containment(target:hitBox)

        for result in hitResults {
            switch result {
            case .overlapsTop:
                velocityY = Ball.speedY
            case .overlapsBottom:
                velocityY = -Ball.speedY
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

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the ellipse object
        canvas.render(fillStyle)
        canvas.render(ellipse)
    }

    func resetBall() {
        velocityX = 0
        velocityY = 0
        ellipse.center = canvasCenter
        resetAnimation!.play()
    }

    func freeze() {
        isFrozen = true
        resetBall()
    }

    func unfreeze() {
        isFrozen = false
        resetBall()
    }
}
