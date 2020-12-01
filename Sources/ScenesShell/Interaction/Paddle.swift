import Igis
import Scenes

/*
 This class is responsible for rendering the paddles.
 */

class Paddle : RenderableEntity, KeyDownHandler {
    // Settings
    static let paddleSize = Size(width:16, height:120)
    static let paddleOffset = 24
    static let paddleSpeed = 8

    static let leftPaddleColor = Color(red:255, green:50, blue:50)
    static let rightPaddleColor = Color(red:50, green:50, blue:255)

    static let leftPaddleUpKey = "w"
    static let leftPaddleDownKey = "s"
    static let rightPaddleUpKey = "ArrowUp"
    static let rightPaddleDownKey = "ArrowDown"
    
    // Constants
    let position : Position
    let upKey : String
    let downKey : String

    let paddleFillStyle : FillStyle
    let rectangle : Rectangle
    var canvasBottom = 0

    init(position:Position) {
        self.position = position

        switch position {
        case .left:
            upKey = Paddle.leftPaddleUpKey
            downKey = Paddle.leftPaddleDownKey
            paddleFillStyle = FillStyle(color:Paddle.leftPaddleColor)
        case .right:
            upKey = Paddle.rightPaddleUpKey
            downKey = Paddle.rightPaddleDownKey
            paddleFillStyle = FillStyle(color:Paddle.rightPaddleColor)
        }
        
        rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        var topLeft = Point.zero
        
        switch position {
        case .left:
            topLeft.x = Paddle.paddleOffset
        case .right:
            topLeft.x = canvasSize.width - Paddle.paddleOffset - Paddle.paddleSize.width
        }
        
        rectangle.rect = Rect(topLeft:topLeft, size:Paddle.paddleSize)
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
        if key == upKey {
            move(by:-Paddle.paddleSpeed)
        } else if key == downKey {
            move(by:Paddle.paddleSpeed)
        }
    }
}
