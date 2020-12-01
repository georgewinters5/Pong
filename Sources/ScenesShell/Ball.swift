import Igis
import Scenes

class Ball :  RenderableEntity{
    var ellipse : Ellipse
    var velocityX : Int
    var velocityY : Int
    init(size:Int) {
        ellipse = Ellipse(center:Point(x:0, y:0), radiusX:size, radiusY:size, fillMode:.fillAndStroke)
        velocityX = 0
        velocityY = 0
    }

    func paint(canvas:Canvas) {
        canvas.render(ellipse)
    }

    func move(to:Point) {
        ellipse.center = to
    }
    func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocityX = velocityX
        self.velocityY = velocityY
    }
    override func calculate(canvasSize:Size) {
        // First, move to the new position
        ellipse.center += Point(x:velocityX, y:velocityY)

        // Form a bounding rectangle around the canvas
        let canvasBoundingRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)

        // Form a bounding rect around the ball (ellipse)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY),
                                    size:Size(width:ellipse.radiusX*2, height:ellipse.radiusY*2))

        // Determine if we've moved outside of the canvas boundary rect
        let tooFarLeft = ballBoundingRect.topLeft.x < canvasBoundingRect.topLeft.x
        let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width > canvasBoundingRect.topLeft.x + canvasBoundingRect.size.width

        let tooFarUp = ballBoundingRect.topLeft.y < canvasBoundingRect.topLeft.y
        let tooFarDown = ballBoundingRect.topLeft.y + ballBoundingRect.size.height > canvasBoundingRect.topLeft.y + canvasBoundingRect.size.height 

        // If we're too far to the left or right, we bounce the x velocity
        if tooFarLeft || tooFarRight {
            velocityX = -velocityX
        }
        // If we're too far to the top or bottom, we bounce the y velocity
        if tooFarUp || tooFarDown {
            velocityY = -velocityY
        }
        
    }
}
