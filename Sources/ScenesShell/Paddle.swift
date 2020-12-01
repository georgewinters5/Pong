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
        precondition(condition:controlKeys.count == 2)
        rect = rect
        controls = controlKey
        rate = rate
        
        super.init(name:"Paddle")
    }

    override func render(canvas:Canvas)
    {
        let fillStyle : FillStyle = FillStyle(color:Color(.white))
        let strokeStyle : StrokeStyle = StrokeStyle(color:Color(.black))
        
        let rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)

        canvas.render(fillStyle, strokeStyle, rectangle)
    }

    override func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        isMovingUp = key == controls[0] ? true : isMovingUp
        isMovingDown = key == controls[1] ? true : isMovingDown
    }
    override func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool)
    {
        isMovingUp = key == controls[0] ? true : isMovingUp
        isMovingDown = key == controls[1] ? true : isMovingDown
    }
}
