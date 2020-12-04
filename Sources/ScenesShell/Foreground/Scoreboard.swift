import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the scoreboard.
 */

class Scoreboard : RenderableEntity {
    // Mark: Scoreboard Styling
    let playAnimation = true    
    let relativeTextLocation = Point(x:175, y:40)
    
    // Animations are available through the ScenesAnimations library
    // as an extension to the Scenes and Igis libraries
    let animationColor = Color(.magenta)
    let animationEasing = EasingStyle.outSine
    let animationDuration = 1.0

    // Mark: Scoreboard Constants
    let position : Position
    let text : Text
    var onScoreAnimation : Animation?
    
    var fillStyle = FillStyle(color:MainScene.textColor)
    var score = 0 {
        didSet {
            text.text = String(score)
        }
    }
    
    init(position:Position) {
        self.position = position
        
        text = Text(location:Point.zero, text:String(score))
        text.font = MainScene.textFont
        text.alignment = .center
        text.baseline = .middle

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        // Define our animation
        onScoreAnimation = Tween(from:animationColor, to:MainScene.textColor, duration:animationDuration, ease:animationEasing) { newColor in
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

    // This function is responsible for rendering our objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the text object
        canvas.render(fillStyle)
        canvas.render(text)
    }

    // This function is invoked when a player scores a point.
    func addPoint() {
        guard let mainScene = scene as? MainScene else {
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
            mainScene.gameOver(winner:position)
        }
    }

    // This function is invoked when the game restarts.
    func reset() {
        score = 0
    }
}
