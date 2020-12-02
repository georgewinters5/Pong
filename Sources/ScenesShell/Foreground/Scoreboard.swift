import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the scoreboard.
 */

class Scoreboard : RenderableEntity {
    // Settings
    // Note: textLocation is relative to the canvas center y-axis
    let font = "22pt Arial"
    let textLocation = Point(x:175, y:40)
    let color = Color(.white)
    let onChangeColor = Color(.magenta)
    let playAnimation = false
    
    // Constants
    var fillStyle : FillStyle
    let position : Position
    let text : Text
    var score = 0 {
        didSet {
            text.text = String(score)
        }
    }
    
    // Animations are available through the ScenesAnimations library as an extension to the Scenes and Igis libraries
    var onChangeAnimation : Animation?
    let animationEasing = EasingStyle.outSine
    let animationDuration = 1.0
    
    init(position:Position) {
        fillStyle = FillStyle(color:color)
        
        self.position = position
        
        text = Text(location:Point.zero, text:"0")
        text.font = font
        text.alignment = .center
        text.baseline = .middle

        // Using a meaningful name can be helpful for debugging
        super.init(name:"Scoreboard")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        // Setup our Animation
        onChangeAnimation = Tween(from:onChangeColor, to:color, duration:animationDuration, ease:animationEasing) { newColor in
            self.fillStyle = FillStyle(color:newColor)
        }

        animationController.register(animation:onChangeAnimation!)
        
        // Set the text location based on specified position
        switch position {
        case .left:
            text.location = Point(x:canvasSize.center.x - textLocation.x, y:textLocation.y)
        case .right:
            text.location = Point(x:canvasSize.center.x + textLocation.x, y:textLocation.y)
        }
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifier before the text object
        canvas.render(fillStyle)
        canvas.render(text)
    }

    // This function will be invoked when a point needs to be added to
    // this scoreboard.
    func addPoint() {
        guard let mainScene = scene as? MainScene else {
            fatalError("Expected MainScene as scene to Scoreboard.")
        }

        // first, add 1 to the scoreboard
        score += 1

        // then, play animation if specified
        if playAnimation {
            fillStyle = FillStyle(color:onChangeColor)
            onChangeAnimation!.play()
        }

        // then, check if player has won the game
        if score >= mainScene.winningScore {
            mainScene.gameOver(winner:position)
        }
    }
}
