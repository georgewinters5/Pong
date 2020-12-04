import Igis
import Scenes
import ScenesAnimations
import ScenesControls

/*
 This class is responsible for rendering the gameover panel.
 */

class GameOverPanel : RenderableEntityContainer {
    let panelSize = Size(width:500, height:250)
    let buttonSize = Size(width:450, height:50)
    let animationEasing = EasingStyle.inOutSine
    let animationDuration = 0.6

    let backgroundFillStyle : FillStyle
    var textFillStyle : FillStyle
    let background : Rectangle
    let button : Button
    let text : Text
    var buttonSet = false
    var buttonTopLeft = Point.zero
    var toggleVisibilityAnimation : Animation?

    init() {
        backgroundFillStyle = FillStyle(color:Color(red:125, green:125, blue:125))
        textFillStyle = FillStyle(color:Color(.white))

        background = Rectangle(rect:Rect.zero, fillMode:.fill)
        button = Button(labelString:"Play Again", fixedSize:buttonSize)
        text = Text(location:Point.zero, text:"")
        text.alignment = .center
        text.baseline = .middle
        text.font = "24pt Arial"

        // Using meaningful names can be helpful for debugging
        super.init(name:"GameOver", fixedSize:nil)
    }

    func buttonClickHandler(control:Control, localLocation:Point) {
        guard let foreground = layer as? ForegroundLayer else {
            fatalError("GameOverPanel expected MainScene as owning Scene.")
        }
        
        toggleVisibilityAnimation?.direction = .reverse
        toggleVisibilityAnimation?.play()
        
        foreground.restartGame()
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        let topLeft = canvasSize.center - Point(x:panelSize.width / 2, y:panelSize.height / 2)
        
        background.rect = Rect(topLeft:Point(x:topLeft.x, y:-panelSize.height), size:panelSize)
        button.topLeft = Point(x:canvasSize.center.x - (button.fixedSize!.width / 2), y:-panelSize.height)
        text.location = Point(x:canvasSize.center.x, y:-100)
        
        button.clickHandler = buttonClickHandler

        // setup our Animation
        toggleVisibilityAnimation = Tween(from:-panelSize.height, to:topLeft.y, duration:animationDuration, ease:animationEasing) { newY in
            self.background.rect.topLeft.y = newY
            self.text.location.y = newY + self.buttonSize.height
            self.button.topLeft.y = newY + self.panelSize.height - (3 * self.buttonSize.height / 2)
        }
        animationController.register(animation:toggleVisibilityAnimation!)

        // Insert the play button into this entity container
        insert(owningLayer:layer, entity:button)
    }

    func gameOver(winner:Position) {
        guard let mainScene = scene as? MainScene else {
            fatalError("GameOverPanel expected MainScene as owning scene.")
        }
        
        // Format the text depending on which player won.
        switch winner {
        case .left:
            text.text = "Left"
            textFillStyle = mainScene.interactionLayer.leftPaddle.fillStyle
        case .right:
            text.text = "Right"
            textFillStyle = mainScene.interactionLayer.rightPaddle.fillStyle
        }
        text.text += " side won!"
        
        toggleVisibilityAnimation?.direction = .normal
        toggleVisibilityAnimation?.play()
    }

    override func render(canvas:Canvas) {
        // render the fillstyle modifiers before the background and text objects.
        canvas.render(backgroundFillStyle, background)
        canvas.render(textFillStyle, text)
    }
}
