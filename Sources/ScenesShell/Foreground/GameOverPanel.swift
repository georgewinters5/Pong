import Igis
import Scenes
import ScenesAnimations
import ScenesControls

/*
 This class is responsible for rendering the gameover panel.
 */

class GameOverPanel : RenderableEntityContainer {
    // Mark: GameOverPanel Styling
    let panelSize = Size(width:500, height:250)
    let buttonSize = Size(width:450, height:50)
    
    let animationEasing = EasingStyle.inOutSine
    let animationDuration = 0.6

    // Mark: GameOverPanel Constants
    let backgroundFillStyle = FillStyle(color:MainScene.panelBackgroundColor)
    var textFillStyle = FillStyle(color:MainScene.leftSideColor)

    // Buttons are available through the ScenesControls library
    // as an extension to the Scenes and Igis libraries
    let background = Rectangle(rect:Rect.zero, fillMode:.fill)
    let playAgain : Button
    let text : Text
    
    var playButtonSet = false
    var playAgainTopLeft = Point.zero
    var toggleVisibilityAnimation : Animation?

    init() {
        playAgain = Button(labelString:"Play Again", fixedSize:buttonSize)
        
        text = Text(location:Point.zero, text:"")
        text.alignment = .center
        text.baseline = .middle
        text.font = MainScene.textFont

        // Using meaningful names can be helpful for debugging
        super.init(name:"GameOver", fixedSize:nil)
    }

      func buttonClickHandler(control:Control, localLocation:Point) {
          guard let mainScene = scene as? MainScene else {
              fatalError("GameOverPanel expected MainScene as owning Scene.")
          }
                  
        toggleVisibilityAnimation?.direction = .reverse
        toggleVisibilityAnimation?.play()

        mainScene.restartGame()
    }

    // This function is invoked when setting up this RenderableEntity.
    override func setup(canvasSize:Size, canvas:Canvas) {
        let topLeft = canvasSize.center - Point(x:panelSize.width / 2, y:panelSize.height / 2)
        
        background.rect = Rect(topLeft:Point(x:topLeft.x, y:-panelSize.height), size:panelSize)
        playAgain.topLeft = Point(x:canvasSize.center.x - (playAgain.fixedSize!.width / 2), y:-panelSize.height)
        text.location = Point(x:canvasSize.center.x, y:-100)
        
        playAgain.clickHandler = buttonClickHandler

        // setup out Animation
        toggleVisibilityAnimation = Tween(from:-panelSize.height, to:topLeft.y, duration:animationDuration, ease:animationEasing) { newY in
            self.background.rect.topLeft.y = newY
            self.text.location.y = newY + self.buttonSize.height
            self.playAgain.topLeft.y = newY + self.panelSize.height - (3 * self.buttonSize.height / 2)
        }
        animationController.register(animation:toggleVisibilityAnimation!)

        // Insert the play button into this entity container
        insert(owningLayer:layer, entity:playAgain)
    }

    // This function is invoked when the game ends.
    func gameOver(winner:Position) {
        // Format the text depending on which player won.
        switch winner {
        case .left:
            text.text = "Left"
            textFillStyle = FillStyle(color:MainScene.leftSideColor)
        case .right:
            text.text = "Right"
            textFillStyle = FillStyle(color:MainScene.rightSideColor)
        }
        text.text += " side won!"
        
        toggleVisibilityAnimation?.direction = .normal
        toggleVisibilityAnimation?.play()
    }

    // This function is responsible for rendering our objects onto
    // the provided canvas.
    override func render(canvas:Canvas) {
        // render the fillstyle modifiers before the background and text
        // objects.
        canvas.render(backgroundFillStyle, background)
        canvas.render(textFillStyle, text)
    }
}
