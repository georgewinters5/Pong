import Igis
import Scenes

/*
 This class is primarily responsible for transitioning between Scenes.
 At a minimum, it must enqueue the first Scene.
 */

class ShellDirector : Director {
    required init() {
        super.init()
        enqueueScene(scene:MainScene())
    }

    /*
     This function returns the framerate to be used for rendering.
     Generally, anything over 30 fps will lag
     */
    override func framesPerSecond() -> Int {
        return 20
    }
}
