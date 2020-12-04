import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the scoreboard.
 */

class Scoreboard : RenderableEntity {
    let playAnimation = true    
    let relativeTextLocation = Point(x:175, y:40)
    let defaultColor = Color(.white)
    let animationColor = Color(.magenta)
    let animationEasing = EasingStyle.outSine
    let animationDuration = 1.0

    let position : Position
    let text : Text
    var fillStyle : FillStyle
    var onScoreAnimation : Animation?
    var score = 0 {
        didSet {
            text.text = String(score)
        }
    }
    
    init(position:Position) {
        self.position = position

        fillStyle = FillStyle(color:defaultColor)
        text = Text(location:Point.zero, text:String(score))
        text.font = "20pt Arial"
        text.alignment = .center
        text.baseline = .middle

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // Define our animation
        onScoreAnimation = Tween(from:animationColor, to:defaultColor, duration:animationDuration, ease:animationEasing) { newColor in
            self.fillStyle = FillStyle(color:newColor)
        }
        animationController.register(animation:onScoreAnimation!)
        
        // Set the text location based on relative position
        switch position {
        case .left:
            text.location = Point(x:canvasSize.center.x - relativeTextLocation.x, y:relativeTextLocation.y)
        case .right:
            text.location = Point(x:canvasSize.center.x + relativeTextLocation.x, y:relativeTextLocation.y)
        }
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the text object
        canvas.render(fillStyle, text)
    }

    func addPoint() {
        guard let foreground = layer as? ForegroundLayer else {
            fatalError("Scoreboard expected MainScene as its owning Scene.")
        }
        
        // first, add 1 to the scoreboard
        score += 1

        // then, play animation if specified
        if playAnimation {
            fillStyle = FillStyle(color:animationColor)
            onScoreAnimation?.play()
        }

        // then, check if player has won the game
        if score >= MainScene.winningScore {
            foreground.gameOver(winner:position)
        }
    }

    func reset() {
        score = 0
    }
}
