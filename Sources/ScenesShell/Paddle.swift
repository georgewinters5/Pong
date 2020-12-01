import Igis
import Scenes

class Paddle : RenderableEntity, KeyDownHandler, KeyUpHandler
{
    var rectangle : Rectangle
    
    init(topLeft:Point, size:Size)
    {
<<<<<<< HEAD
        let rect = Rect(topLeft:topLeft, size:size)
        rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
    }
    
    func paint(canvas:Canvas)
=======
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
>>>>>>> b7cd53a669c0235a54ea77615a920024908d73cd
    {
        let strokeStyle = StrokeStyle(color:Color(.black))
        let fillStyle = FillStyle(color:Color(.white))
        let lineWidth = LineWidth(width:2)
        canvas.paint(strokeStyle, fillStyle, lineWidth)
        canvas.paint(rectangle)
    }

<<<<<<< HEAD
    func move(to:Point)
=======
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
>>>>>>> b7cd53a669c0235a54ea77615a920024908d73cd
    {
        rectangle.rect.topLeft = to
    }
}
