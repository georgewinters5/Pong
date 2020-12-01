import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    // Settings
    let backgroundColor = Color(red:50, green:50, blue:50)
    
    let dividerColor = Color(red:255, green:255, blue:255)
    let lineDashSize = Size(width:6, height:24)
    let lineDashSpacing = 15

    // We will setup the background and divider in the setup() function below
    let background = Rectangle(rect:Rect(), fillMode:.fill)
    var divider = [Rectangle]()
    
    let backgroundFillStyle : FillStyle
    let dividerFillStyle : FillStyle
    
    init() {
        backgroundFillStyle = FillStyle(color:backgroundColor)
        dividerFillStyle = FillStyle(color:dividerColor)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // set background size to canvas size
        background.rect.size = canvasSize

        // set divider constants
        let lineSegmentLength = lineDashSize.height + lineDashSpacing
        let topLeftX = canvasSize.center.x - (lineDashSize.width / 2)
        let lineDashCount = (canvasSize.height / lineSegmentLength) + 1

        for lineNumber in 0..<lineDashCount {
            let topLeft = Point(x:topLeftX, y:lineSegmentLength * lineNumber)
            let lineRect = Rect(topLeft:topLeft, size:lineDashSize)
            let line = Rectangle(rect:lineRect, fillMode:.fill)
            divider.append(line)
        }
    }

    override func render(canvas:Canvas) {
        canvas.render(backgroundFillStyle, background, dividerFillStyle)
        canvas.render(divider)
    }
}
