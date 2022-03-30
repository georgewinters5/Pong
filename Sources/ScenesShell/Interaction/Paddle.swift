import Igis
import Scenes

/*
 This class is responsible for rendering the paddles.
 */

class Paddle : RenderableEntity, KeyDownHandler {
    // Settings
    let leftPaddleUpKey = "w"
    let leftPaddleDownKey = "s"
    let rightPaddleUpKey = "ArrowUp"
    let rightPaddleDownKey = "ArrowDown"

    let paddleMoveSpeed = 70
    let leftPaddleColor = Color(red:255, green:50, blue:50)
    let rightPaddleColor = Color(red:50, green:50, blue:255)
    
    let position : Position
    let upKey : String
    let downKey : String
    let fillStyle : FillStyle
    let rectangle : Rectangle
    var canvasBottom = 0

    init(position:Position) {
        self.position = position
        rectangle = Rectangle(rect:Rect(size:Size(width:16, height:160)), fillMode:.fill)

        // depending on the position, set necessary paddle properties
        switch position {
        case .left:
            upKey = leftPaddleUpKey
            downKey = leftPaddleDownKey
            fillStyle = FillStyle(color:leftPaddleColor)
        case .right:
            upKey = rightPaddleUpKey
            downKey = rightPaddleDownKey
            fillStyle = FillStyle(color:rightPaddleColor)
        }
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        var topLeft = Point(x:0, y:canvasSize.center.y - rectangle.rect.height/2)
        let paddleOffset = 24
        
        switch position {
        case .left:
            topLeft.x = paddleOffset
        case .right:
            topLeft.x = canvasSize.width - paddleOffset - rectangle.rect.width
        }
        rectangle.rect.topLeft = topLeft
        
        canvasBottom = canvasSize.height
        dispatcher.registerKeyDownHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }

    override func boundingRect() -> Rect {
        return rectangle.rect
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle object
        canvas.render(fillStyle, rectangle)
    }

    func move(by:Int) {
        rectangle.rect.topLeft.y += by

        // If the rectangle goes off the canvas, move back into view
        if rectangle.rect.top < 0 {
            rectangle.rect.topLeft.y = 0
        } else if rectangle.rect.bottom > canvasBottom {
            rectangle.rect.topLeft.y = canvasBottom - rectangle.rect.size.height
        }
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        // check if key pressed cooresponds to specified movement keys.
        if key == upKey {
            move(by:-paddleMoveSpeed)
        } else if key == downKey {
            move(by:paddleMoveSpeed)
        }
    }
}
