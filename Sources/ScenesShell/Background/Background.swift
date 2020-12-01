import Igis
import Scenes

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    // Settings
    let backgroundColor = Color(red:50, green:50, blue:50)
    
    // Constants
    let backgroundFillStyle : FillStyle
    let background = Rectangle(rect:Rect.zero, fillMode:.fill)
    
    init() {
        backgroundFillStyle = FillStyle(color:backgroundColor)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // set background size to canvas size
        background.rect.size = canvasSize
    }

    override func render(canvas:Canvas) {
        // render the fillstyle before the background object
        canvas.render(backgroundFillStyle)
        canvas.render(background)
    }
}
