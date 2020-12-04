import Igis
import Scenes

/*
 This class is responsible for rendering the net.
 */

class Net : RenderableEntity {
    let fillStyle : FillStyle
    var rectangles : [Rectangle]
    
    init() {
        // Initialize Objects
        fillStyle = FillStyle(color:Color(.gray))
        rectangles = []
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Net")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // Define the size and spacing for our dashed line
        let dashSize = Size(width:6, height:24)
        let dashSpacing = 15
        
        // Define some constants to help create the dashed line
        let topLeftX = canvasSize.center.x - (dashSize.width / 2)
        let dashSegmentLength = dashSize.height + dashSpacing
        let dashCount = (canvasSize.height / dashSegmentLength) + 1

        // Create the dashed line (a series of rectangles)
        for dashNumber in 0..<dashCount {
            let topLeft = Point(x:topLeftX, y:dashSegmentLength * dashNumber)
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
