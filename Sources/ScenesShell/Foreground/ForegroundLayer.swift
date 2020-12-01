import Igis
import Scenes

/*
 This class is responsible for the foreground Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class ForegroundLayer : Layer {
    let leftScoreboard = Scoreboard(position:.left)
    let rightScoreboard = Scoreboard(position:.right)
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:leftScoreboard, at:.front)
        insert(entity:rightScoreboard, at:.front)
    }
}
