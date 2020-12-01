import Igis
import Scenes

class Paddle : RenderableEntity, KeyDownHandler, KeyUpHandler
{
    let rect : Rect
    let controls : [String]
    let rate : Int

    var isMovingUp : Bool = false
    var isMovingDown : Bool = false

    init(_ rect:Rect, _ controlKeys:[String], _ rate:Int)
    {
        precondition(controlKeys.count == 2)
        self.rect = rect
        controls = controlKeys
        self.rate = rate
        
        super.init(name:"Paddle")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerKeyDownHandler(handler:self)
        dispatcher.registerKeyUpHandler(handler:self)
    }

    override func render(canvas:Canvas)
    {
        let fillStyle : FillStyle = FillStyle(color:Color(.white))
        let strokeStyle : StrokeStyle = StrokeStyle(color:Color(.black))
        
        let rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        canvas.render(fillStyle, strokeStyle, rectangle)
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
        dispatcher.unregisterKeyUpHandler(handler:self)
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        isMovingUp = key == controls[0] ? true : isMovingUp
        isMovingDown = key == controls[1] ? true : isMovingDown
    }
    func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        isMovingUp = key == controls[0] ? true : isMovingUp
        isMovingDown = key == controls[1] ? true : isMovingDown
    }
}
