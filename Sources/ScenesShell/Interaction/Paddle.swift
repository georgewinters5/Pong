import Igis
import Scenes

/*
 This class is responsible for rendering the paddles.
 */

class Paddle : RenderableEntity, KeyDownHandler {
    // Mark: Paddle Styling
    let paddleSize = Size(width:16, height:120)
    let paddleOffset = 24

    let leftPaddleUpKey = "w"
    let leftPaddleDownKey = "s"
    let rightPaddleUpKey = "ArrowUp"
    let rightPaddleDownKey = "ArrowDown"
    
    // Mark: Paddle Constants
    let position : Position
    let upKey : String
    let downKey : String

    let fillStyle : FillStyle
    let rectangle = Rectangle(rect:Rect.zero, fillMode:.fill)
    var canvasBottom = 0

    init(position:Position) {
        self.position = position

        // depending on the position, set necessary paddle properties
        switch position {
        case .left:
            upKey = leftPaddleUpKey
            downKey = leftPaddleDownKey
            fillStyle = FillStyle(color:MainScene.leftSideColor)
        case .right:
            upKey = rightPaddleUpKey
            downKey = rightPaddleDownKey
            fillStyle = FillStyle(color:MainScene.rightSideColor)
        }
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        // calculate the paddle position based on relative position
        var topLeft = Point.zero
        
        switch position {
        case .left:
            topLeft.x = paddleOffset
        case .right:
            topLeft.x = canvasSize.width - paddleOffset - paddleSize.width
        }

        // set the paddle size and position
        rectangle.rect = Rect(topLeft:topLeft, size:paddleSize)
        
        canvasBottom = canvasSize.height
        dispatcher.registerKeyDownHandler(handler:self)
    }

    // This function is responsible for rendering our objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the rectangle object
        canvas.render(fillStyle)
        canvas.render(rectangle)
    }

    // This function is invoked whenever the paddle needs to be
    // up or down.
    func move(by:Int) {
        rectangle.rect.topLeft.y += by

        // If the rectangle goes off the canvas, move back into view
        if rectangle.rect.top < 0 {
            rectangle.rect.topLeft.y = 0
        } else if rectangle.rect.bottom > canvasBottom {
            rectangle.rect.topLeft.y = canvasBottom - rectangle.rect.size.height
        }
    }

    // This function is invoked whenever keyboard input is detected.
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        // check if key pressed cooresponds to specified movement keys.
        if key == upKey {
            move(by:-MainScene.paddleMoveSpeed)
        } else if key == downKey {
            move(by:MainScene.paddleMoveSpeed)
        }
    }

    // This function is invoked when deleting this RenderableEntity.
    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }
}
