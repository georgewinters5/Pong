import Igis
import Scenes

/*
 This class is responsible for implementing a single Scene.
 Scenes projects require at least one Scene but may have many.
 A Scene is comprised of one or more Layers.
 Layers are generally added in the constructor.
 */

class MainScene : Scene {
    // MARK: Game Settings
    static let winningScore = 11
    static let paddleMoveSpeed = 8

    // MARK: Game Styling
    static let backgroundColor = Color(red:50, green:50, blue:50)
    static let netColor = Color(.lightgray)
    static let ballColor = Color(.white)
    
    static let leftSideColor = Color(red:255, green:50, blue:50)
    static let rightSideColor = Color(red:50, green:50, blue:255)
    static let panelBackgroundColor = Color(red:125, green:125, blue:125)
    static let textColor = Color(.white)

    static let textFont = "20pt Arial"
    
    /* Scenes typically include one or more Layers.
       A common approach is to use three Layers:
       One for the background, one for interaction,
       and one for the foreground.
     */
    
    let backgroundLayer = BackgroundLayer()
    let interactionLayer = InteractionLayer()
    let foregroundLayer = ForegroundLayer()

    init() {
        // Using a meaningful name can be helpful for debugging.
        super.init(name:"Main")
        
        // We insert our Layers in the constructor
        // We place each layer in front of the previous layer
        insert(layer:backgroundLayer, at:.back)
        insert(layer:interactionLayer, at:.inFrontOf(object:backgroundLayer))
        insert(layer:foregroundLayer, at:.front)
    }

    // This function is invoked when a player scores a point.
    func addPoint(to side:Position) {
        foregroundLayer.addPoint(to:side)
    }

    // This function is invoked when the game ends.
    func gameOver(winner:Position) {
        foregroundLayer.gameOver(winner:winner)
        interactionLayer.gameOver()
    }

    // This function is invoked when the game restarts.
    func restartGame() {
        foregroundLayer.restartGame()
        interactionLayer.restartGame()
    }
}
