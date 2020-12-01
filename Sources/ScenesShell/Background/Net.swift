import Igis
import Scenes

/*
 This class is responsible for rendering the net.
 */

class Net : RenderableEntity {
    // Settings
    let netColor = Color(red:255, green:255, blue:255)
    let dashSize = Size(width:6, height:24)
    let dashSpacing = 15

    // Constants
    let netFillStyle : FillStyle
    var net = [Rectangle]()
    
    init() {
        netFillStyle = FillStyle(color:netColor)

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Net")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        let centerX = canvasSize.center.x - (dashSize.width / 2)
        let dashSegmentLength = dashSize.height + dashSpacing
        let dashCount = (canvasSize.height / dashSegmentLength) + 1

        // Creates the specified number of dashes for the net
        for dashNumber in 0..<dashCount {
            let topLeft = Point(x:centerX, y:dashSegmentLength * dashNumber)
            let rect = Rect(topLeft:topLeft, size:dashSize)
            net.append(Rectangle(rect:rect, fillMode:.fill))
        }
    }

    override func render(canvas:Canvas) {
        // render the fillstyle before the net object
        canvas.render(netFillStyle)
        canvas.render(net)
    }
}
