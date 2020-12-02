import Igis
import Scenes

/*
 This class is responsible for rendering the net.
 */

class Net : RenderableEntity {
    // Settings
    let dashSize = Size(width:6, height:24)
    let dashSpacing = 15
    let color = Color(.white)
    let alpha = Alpha(alphaValue:0.5)

    // Constants
    let fillStyle : FillStyle
    var rectangles = [Rectangle]()
    
    init() {
        fillStyle = FillStyle(color:color)
        
         // Using a meaningful name can be helpful for debugging
        super.init(name:"Net")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        setAlpha(alpha:alpha)
        // Define some constants necessary for created the dashed line
        let centerX = canvasSize.center.x - (dashSize.width / 2)
        let dashSegmentLength = dashSize.height + dashSpacing
        let dashCount = (canvasSize.height / dashSegmentLength) + 1

        // Creates the number of dashes specified by the constant dashCount
        for dashNumber in 0..<dashCount {
            let topLeft = Point(x:centerX, y:dashSegmentLength * dashNumber)
            let rect = Rect(topLeft:topLeft, size:dashSize)
            rectangles.append(Rectangle(rect:rect, fillMode:.fill))
        }
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle objects
        canvas.render(fillStyle)
        canvas.render(rectangles)
    }
}
