import Igis
import Scenes

/*
 This class is responsible for rendering the scoreboard.
 */

class Scoreboard : RenderableEntity {
    // Settings
    static let textColor = Color(red:255, green:255, blue:255)
    
    // Constants
    let textFillStyle = FillStyle(color:textColor)
    let position : Position
    let text : Text
    
    init(position:Position) {
        self.position = position
        
        text = Text(location:Point.zero, text:"0")
        text.alignment = .center
        text.baseline = .middle
        text.font = "16pt Arial"
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        switch position {
        case .left:
            text.location = Point(x:canvasSize.center.x - 200, y:50)
        case .right:
            text.location = Point(x:canvasSize.center.x + 200, y:50)
        }
    }

    override func render(canvas:Canvas) {
        canvas.render(textFillStyle)
        canvas.render(text)
    }

    func addPoint() {
        text.text = String(Int(text.text)! + 1)

        if Int(text.text)! == 9 {
            if let scene = scene as? MainScene {
                scene.gameOver(winner:position)
            }
        }
    }
}
