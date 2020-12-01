import Igis
import Scenes

/*
 This class is responsible for rendering the ball.
 */

class Ball :  RenderableEntity {
    // Settings
    static let ballRadius = 20
    static let speedX = 10
    static let speedY = 6

    static let ballColor = Color(red:255, green:255, blue:255)
    
    // Constants
    let ballFillStyle = FillStyle(color:ballColor)
    let ellipse : Ellipse
    
    var velocityX = speedX
    var velocityY = speedY
    
    init() {
        ellipse = Ellipse(center:Point.zero, radiusX:Ball.ballRadius, radiusY:Ball.ballRadius, fillMode:.fill)
    }

    override func calculate(canvasSize:Size) {
        ellipse.center += Point(x:velocityX, y:velocityY)

        let canvasBoundingRect = Rect(size:canvasSize)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x - ellipse.radiusX, y:ellipse.center.y - ellipse.radiusY),
                                    size:Size(width:ellipse.radiusX * 2, height:ellipse.radiusY * 2))

        let hitResults = canvasBoundingRect.containment(target:ballBoundingRect)

        for result in hitResults {
            switch result {
            case .overlapsTop:
                velocityY = Ball.speedY
            case .overlapsBottom:
                velocityY = -Ball.speedY
            case .overlapsLeft:
                velocityX = Ball.speedX
            case .overlapsRight:
                velocityX = -Ball.speedX
            default:
                break
            }
        }
    }

    override func render(canvas:Canvas) {
        canvas.render(ballFillStyle)
        canvas.render(ellipse)
    }
}
