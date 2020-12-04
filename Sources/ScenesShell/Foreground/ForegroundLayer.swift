import Igis
import Scenes

/*
 This class is responsible for the foreground Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class ForegroundLayer : Layer {
    /*
     Layers typically include one or more RenderableEntities.
     Commonly, the foreground contains text, such as scoreboards,
     and other informational entities such as healthbars and game
     over panels.
     */
    let leftScoreboard = Scoreboard(position:.left)
    let rightScoreboard = Scoreboard(position:.right)
    let gameOverPanel = GameOverPanel()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:leftScoreboard, at:.back)
        insert(entity:rightScoreboard, at:.back)
        insert(entity:gameOverPanel, at:.front)
    }

    // This function is invoked when a player scores a point.
    func addPoint(to side:Position) {
        // determine which scoreboard to add the point to.
        switch side {
        case .left:
            leftScoreboard.addPoint()
        case .right:
            rightScoreboard.addPoint()
        }
    }

    // This function is invoked when the game ends.
    func gameOver(winner:Position) {
        gameOverPanel.gameOver(winner:winner)
    }

    // This function is invoked when the game restarts.
    func restartGame() {
        leftScoreboard.reset()
        rightScoreboard.reset()
    }
}
