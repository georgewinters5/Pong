import Igis
import Scenes

/*
 This class is responsible for rendering the net.
 */

class Net : RenderableEntity {
    // Mark: Net Styling
    let dashSize = Size(width:6, height:24)
    let dashSpacing = 15

    // Mark: Net Constants
    let fillStyle = FillStyle(color:MainScene.netColor)
    var rectangles = [Rectangle]()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Net")
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        // Define some constants necessary for creating the dashed line
        let centerX = canvasSize.center.x - (dashSize.width / 2)
        let dashSegmentLength = dashSize.height + dashSpacing
        let dashCount = (canvasSize.height / dashSegmentLength) + 1

        // Creates number of dashes specified by dashCount
        for dashNumber in 0..<dashCount {
            let topLeft = Point(x:centerX, y:dashSegmentLength * dashNumber)
            let rect = Rect(topLeft:topLeft, size:dashSize)
            rectangles.append(Rectangle(rect:rect, fillMode:.fill))
        }
    }

    // This function is responsible for rendering our objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle objects
        canvas.render(fillStyle)
        canvas.render(rectangles)
    }
}
