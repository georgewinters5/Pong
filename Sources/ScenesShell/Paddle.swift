import Igis
import Scenes

class Paddle : RenderableEntity, KeyDownHandler, KeyUpHandler
{
    var rectangle : Rectangle

    init(topLeft:Point, size:Size)
    {
        let rect = Rect(topLeft:topLeft, size:size)
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
    }

    func paint(canvas:Canvas)
    {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        canvas.paint(strokeStyle, fillStyle, lineWidth)
        canvas.paint(rectangle)
    }

    func move(to:Point)
    {
        rectangle.rect.topLeft = to
    }
}
