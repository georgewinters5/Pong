import Igis
import Scenes
import ScenesAnimations
import ScenesControls

/*
 This class is responsible for rendering the gameover panel.
 */

class GameOver : RenderableEntityContainer {
    let backgroundColor = Color(red:125, green:125, blue:125)
    
    var toggleVisibilityAnimation : Animation?
    let animationEasing = EasingStyle.inOutSine
    let animationDuration = 0.6

    let backgroundFillStyle : FillStyle
    let background = Rectangle(rect:Rect.zero, fillMode:.fill)
    let playAgain : Button
    var playButtonSet = false
    var playAgainTopLeft = Point.zero

    init() {
        backgroundFillStyle = FillStyle(color:backgroundColor)
        playAgain = Button(labelString:"Play Again", fixedSize:Size(width:500, height:50))
        
        // Using meaningful names can be helpful for debugging
        super.init(name:"GameOver", fixedSize:nil)
    }

    func onPlayAgainClickHandler(control:Control, localLocation:Point) {
        toggleVisibilityAnimation?.direction = .reverse
        toggleVisibilityAnimation?.play()

        guard let scene = scene as? MainScene else {
            fatalError()
        }

        scene.restartGame()
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        let size = Size(width:600, height:300)
        let topLeft = canvasSize.center - Point(x:size.width / 2, y:size.height / 2)
        background.rect = Rect(topLeft:topLeft, size:size)

        playAgainTopLeft = canvasSize.center - Point(x:250, y:-75)
        playAgain.topLeft.y = -100
        playAgain.clickHandler = onPlayAgainClickHandler

        // setup out Animation
        toggleVisibilityAnimation = Tween(from:-650, to:background.rect.topLeft.y, duration:animationDuration, ease:animationEasing) { newY in
            self.background.rect.topLeft.y = newY
            self.playAgain.topLeft.y = newY + 225
        }
        animationController.register(animation:toggleVisibilityAnimation!)
        background.rect.topLeft.y = -650

        insert(owningLayer:layer, entity:playAgain)
    }

    // Displays the game over screen with the specified winner.
    func showGameOverScreen(winner:Position) {
        toggleVisibilityAnimation?.direction = .normal
        toggleVisibilityAnimation?.play()
    }

    override func render(canvas:Canvas) {
        canvas.render(backgroundFillStyle, background)
    }
}
