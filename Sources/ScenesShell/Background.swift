import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    // Settings
    let backgroundColor = Color(red:50, green:50, blue:50)
    let dividerColor = Color(red:255, green:255, blue:255)
    let dividerWidth = LineWidth(width:8)
    let lineDashLength = 25
    let lineDashSpacing = 15

    // We will set the background size in the setup() function
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
        background.rect.size = canvasSize

        let lineSegmentLength = lineDashLength + lineDashSpacing
        let lineCount = canvasSize.height / lineSegmentLength + 1
        let topLeftX = canvasSize.center.x - dividerWidth.width
        let size = Size(width:dividerWidth.width, height:lineDashLength)

        for lineNumber in 0..<lineCount {
            let topLeft = Point(x:topLeftX, y:lineSegmentLength * lineNumber)
            let lineRect = Rect(topLeft:topLeft, size:size)
            let line = Rectangle(rect:lineRect, fillMode:.fill)
            divider.append(line)
        }
    }

    override func render(canvas:Canvas) {
        canvas.render(backgroundFillStyle, background)
        canvas.render(dividerFillStyle)
        canvas.render(divider)
    }
}
