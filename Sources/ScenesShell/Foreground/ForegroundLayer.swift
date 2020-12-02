import Igis
import Scenes

/*
 This class is responsible for the foreground Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class ForegroundLayer : Layer {
    // Create the necessary RenderableEntities for the ForegroundLayer
    let leftScoreboard = Scoreboard(position:.left)
    let rightScoreboard = Scoreboard(position:.right)
    let gameOver = GameOver()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:leftScoreboard, at:.back)
        insert(entity:rightScoreboard, at:.back)
        insert(entity:gameOver, at:.front)
    }

    // This function will be invoked by the scene to add points to
    // the scoreboards.
    func addPoint(to side:Position) {
        switch side {
        case .left:
            leftScoreboard.addPoint()
        case .right:
            rightScoreboard.addPoint()
        }
    }
}
