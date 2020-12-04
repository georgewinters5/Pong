import Igis
import Scenes

/*
 This class is responsible for the foreground Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class ForegroundLayer : Layer {
    let leftScoreboard = Scoreboard(position:.left)
    let rightScoreboard = Scoreboard(position:.right)
    let gameOverPanel = GameOverPanel()
    
    var gameOver = false
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:leftScoreboard, at:.back)
        insert(entity:rightScoreboard, at:.back)
        insert(entity:gameOverPanel, at:.front)
    }

    func addPoint(to side:Position) {
        if !gameOver {
            // determine which scoreboard to add the point to.
            switch side {
            case .left:
                leftScoreboard.addPoint()
            case .right:
                rightScoreboard.addPoint()
            }
        }
    }

    func gameOver(winner:Position) {
        gameOver = true
        gameOverPanel.gameOver(winner:winner)
    }

    func restartGame() {
        gameOver = false
        leftScoreboard.reset()
        rightScoreboard.reset()
    }
}
