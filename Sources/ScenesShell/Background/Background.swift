import Igis
import Scenes

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    // Settings
    let color = Color(red:50, green:50, blue:50)
    
    // Constants
    let fillStyle : FillStyle
    let rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    
    init() {
        fillStyle = FillStyle(color:color)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // set rectangle size to the canvas size (anything rendered
        // outside of the canvas won't appear on screen
        rectangle.rect.size = canvasSize
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle object
        canvas.render(fillStyle)
        canvas.render(rectangle)
    }
}
