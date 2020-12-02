import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for rendering the gameover panel.
 */

class GameOver : RenderableEntity {
    var toggleVisibilityAnimation : Animation?
    let animationEasing = EasingStyle.inOutSine
    let animationDuration = 0.6
    
    init() {
        // Using meaningful names can be helpful for debugging
        super.init(name:"GameOver")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        // setup out Animation
        toggleVisibilityAnimation = Tween(from:0.0, to:1.0, duration:animationDuration, ease:animationEasing) { newAlpha in
            self.setAlpha(alpha:Alpha(alphaValue:newAlpha))

            // Once animation has player, move panel so it
            // doesn't interfere with hit testing
            if newAlpha == 0 {
                
            }
        }
        animationController.register(animation:toggleVisibilityAnimation!)
    }

    // Displays the game over screen with the specified winner.
    func showGameOverScreen(winner:Position) {
        toggleVisibilityAnimation?.direction = .normal
        toggleVisibilityAnimation?.play()
    }
}
