import Igis
import Scenes

/*
 This class is responsible for rendering the paddles.
 */

class Paddle : RenderableEntity, KeyDownHandler {
    enum Position {
        case left
        case right
    }
    
    // Settings
    let leftPaddleColor = Color(red:255, green:50, blue:50)
    let rightPaddleColor = Color(red:50, green:50, blue:255)
    let paddleSize = Size(width:10, height:75)
    let paddleOffset = 20
    let movementInterval = 5
    
    // Constants
    let moveUpKey : String
    let moveDownKey : String
    let position : Position
    let paddleFillStyle : FillStyle
    var rectangle : Rectangle
    var canvasBottom = 0

    init(position:Position, moveUpKey:String, moveDownKey:String) {
        self.moveUpKey = moveUpKey
        self.moveDownKey = moveDownKey
        self.position = position
        self.paddleFillStyle = FillStyle(color:position == .left ? leftPaddleColor : rightPaddleColor)
        rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        var topLeft = Point.zero
        switch position {
        case .left:
            topLeft.x = paddleOffset
        case .right:
            topLeft.x = canvasSize.width - paddleOffset - paddleSize.width
        }
        
        rectangle.rect = Rect(topLeft:topLeft, size:paddleSize)
        canvasBottom = canvasSize.height
        
        dispatcher.registerKeyDownHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }

    override func render(canvas:Canvas) {
        canvas.render(paddleFillStyle)
        canvas.render(rectangle)
    }

    func move(by:Int) {
        rectangle.rect.topLeft.y += by

        if rectangle.rect.top < 0 {
            rectangle.rect.topLeft.y = 0
        } else if rectangle.rect.bottom > canvasBottom {
            rectangle.rect.topLeft.y = canvasBottom - rectangle.rect.size.height
        }
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if key == moveUpKey {
            move(by:-movementInterval)
        } else if key == moveDownKey {
            move(by:movementInterval)
        }
    }
}
