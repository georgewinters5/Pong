import Igis
import Scenes

class Paddle : RenderableEntity, KeyDownHandler
{
    var rectangle : Rectangle

    init(topLeft:Point, size:Size)
    {
        let rect = Rect(topLeft:topLeft, size:size)
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        super.init()

        handler.registerKeyDownHandler(handler:self)
    }
    override func teardown()
    {
        handler.unregisterKeyDownHandler(handler:self)
    }
    
    override func render(canvas:Canvas)
    {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        
        canvas.render(strokeStyle, fillStyle, lineWidth)
        canvas.render(rectangle)
    }   
    override func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        
    }
        
    func move(to:Point)
    {
        rectangle.rect.topLeft = to
    }
}
