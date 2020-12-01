import Igis
import Scenes

/*
 This class is responsible for rendering the net.
 */

class Net : RenderableEntity {
    // Settings
    static let dashSize = Size(width:6, height:24)
    static let dashSpacing = 15

    static let netColor = Color(red:255, green:255, blue:255)

    // Constants
    let netFillStyle = FillStyle(color:netColor)
    var netRectangles = [Rectangle]()
    
    init() {
         // Using a meaningful name can be helpful for debugging
        super.init(name:"Net")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // define some constants necessary for created the dashed line
        let centerX = canvasSize.center.x - (Net.dashSize.width / 2)
        let dashSegmentLength = Net.dashSize.height + Net.dashSpacing
        let dashCount = (canvasSize.height / dashSegmentLength) + 1

        // Creates the specified number of dashes for the net
        for dashNumber in 0..<dashCount {
            let topLeft = Point(x:centerX, y:dashSegmentLength * dashNumber)
            let rect = Rect(topLeft:topLeft, size:Net.dashSize)
            netRectangles.append(Rectangle(rect:rect, fillMode:.fill))
        }
    }

    override func render(canvas:Canvas) {
        // render the fillstyle before the net objects
        canvas.render(netFillStyle)
        canvas.render(netRectangles)
    }
}
