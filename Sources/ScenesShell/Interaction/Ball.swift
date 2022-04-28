import Igis
import Scenes

/*
 This class is responsible for rendering the ball.
 */

class Ball :  RenderableEntity {
    let fillStyle : FillStyle
    let ellipse : Ellipse

    var velocityX : Int
    var velocityY : Int
    var time = 0
    var coordinatesSet = false
    init() {
        // Initialize objects
        fillStyle = FillStyle(color:Color(.purple))
        ellipse = Ellipse(center:Point(x:100, y:100), radiusX:25, radiusY:25, fillMode:.fill)
        
        velocityX = 20
        velocityY = 15
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Ball")
        
    }
    override func boundingRect() -> Rect {
        return ellipse.boundingRect()
    }
    override func calculate(canvasSize:Size) {
        //if velocityX > 0{
          //  velocityX = Int(20.0 + Double(time)/100.0)} else {
            //velocityX = Int(-20.0 - Double(time)/100.0)}
        //velocityY = Int(15.0 + Double(time)/100.0)
        guard let mainScene = scene as? MainScene else {
            fatalError("Ball expected owning scene to be type MainScene.")
        }
        
        if !coordinatesSet {
            ellipse.center = canvasSize.center
            coordinatesSet = true
        } else {
            /// First, move to the new position
            ellipse.center += Point(x:velocityX, y:velocityY)

            // Form a bounding rectangle around the canvas
            let canvasBoundingRect = Rect(size:canvasSize)

            // Form a bounding rect around the ball (ellipse)
            let ballBoundingRect = boundingRect()

            // Perform a hit test of the ball with the canvas bounding rect.
            let hitTest = canvasBoundingRect.containment(target:ballBoundingRect)

            // If we're too far to the top or bottom, we bounce the y velocity
            if hitTest.tooFarTop || hitTest.tooFarBottom {
                velocityY = -velocityY
            }

            // If we're too far to the left or right, we bounce the x velocity
            if hitTest.tooFarLeft || hitTest.tooFarRight {
                            velocityX = -velocityX
            }// If we're too far to the left or right, we need to reset the ball and tell the scene which player has scored
            if hitTest.tooFarLeft {
                coordinatesSet = false
                mainScene.addPoint(to:.right)
                time = 0
             } else if hitTest.tooFarRight {
                coordinatesSet = false
                mainScene.addPoint(to:.left)
                time = 0
            }
            if velocityX > 0{
                velocityX = Int(20.0 + Double(time)/300.0)} else {
                velocityX = Int(-20.0 - Double(time)/300.0)}
            if velocityY > 0{
                velocityY = Int(15.0 + Double(time)/300.0)} else {
                velocityY = Int(-15.0 - Double(time)/300.0)}
            
           
                                                                
        }
    }
        
    override func render(canvas:Canvas) {
        canvas.render(fillStyle, ellipse)
        canvas.render(ellipse)
        time += 1
    }
}
