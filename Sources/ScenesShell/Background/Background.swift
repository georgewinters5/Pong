import Igis
import Scenes

/*
 This class is responsible for rendering the background.
 */

class Background : RenderableEntity {
    let fillStyle = FillStyle(color:MainScene.backgroundColor)
    let rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        rectangle.rect.size = canvasSize
    }

    // This function is responsible for rendering our objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle object
        canvas.render(fillStyle)
        canvas.render(rectangle)
    }
}
