import Igis
import Scenes

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    // Settings
    static let backgroundColor = Color(red:50, green:50, blue:50)
    
    // Constants
    let backgroundFillStyle = FillStyle(color:Background.backgroundColor)
    let rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // set rectangle size to canvas size
        rectangle.rect.size = canvasSize
    }

    override func render(canvas:Canvas) {
        // render the fillstyle before the background object
        canvas.render(backgroundFillStyle)
        canvas.render(rectangle)
    }
}
