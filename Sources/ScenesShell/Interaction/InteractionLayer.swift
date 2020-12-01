import Igis
import Scenes

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */

class InteractionLayer : Layer {
    let ball = Ball(size:15)
    let leftPaddle = Paddle(position:.left, moveUpKey:"w", moveDownKey:"s")
    let rightPaddle = Paddle(position:.right, moveUpKey:"ArrowUp", moveDownKey:"ArrowDown")

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:ball, at:.front)
        insert(entity:leftPaddle, at:.front)
        insert(entity:rightPaddle, at:.front)
    }
}
