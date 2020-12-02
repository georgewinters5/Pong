import Igis
import Scenes

/*
 This class is responsible for implementing a single Scene.
 Scenes projects require at least one Scene but may have many.
 A Scene is comprised of one or more Layers.
 Layers are generally added in the constructor.
 */

class MainScene : Scene {
    // Settings
    let winningScore = 9
    
    /* Scenes typically include one or more Layers.
       A common approach is to use three Layers:
       One for the background, one for interaction,
       and one for the foreground.
     */
    
    let backgroundLayer = BackgroundLayer()
    let interactionLayer = InteractionLayer()
    let foregroundLayer = ForegroundLayer()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Main")
        
        // We insert our Layers in the constructor
        // We place each layer in front of the previous layer
        insert(layer:backgroundLayer, at:.back)
        insert(layer:interactionLayer, at:.inFrontOf(object:backgroundLayer))
        insert(layer:foregroundLayer, at:.front)
    }

    // This function will be invoked when the ball goes off screen
    // to add points to the scoreboards.
    func addPoint(to side:Position) {
        foregroundLayer.addPoint(to:side)
    }

    // This function will be invoked when the game ends to display
    // the gameOver panel and provide the player with options to
    // start a new game.
    func gameOver(winner:Position) {
        
    }
}
