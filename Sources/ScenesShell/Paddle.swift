import Igis
import Scenes

class Paddle : RenderableEntity, KeyDownHandler
{
    var rect : Rect

    init(topLeft:Point, size:Size)
    {
        rect = Rect(topLeft:topLeft, size:size)

        super.init()

        dispatcher.registerKeyDownHandler(handler:self)
    }
    override func teardown()
    {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }
    
    override func render(canvas:Canvas)
    {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        canvas.render(strokeStyle, fillStyle, lineWidth)

        let rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)        
        canvas.render(rectangle)
    }   

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        
    }
        
    func move(to:Point)
    {
        rect.topLeft = to
    }
}
