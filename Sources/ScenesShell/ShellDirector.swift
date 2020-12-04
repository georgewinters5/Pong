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
     Generally, a framerate over 30 will lag (Since Igis uses server-side
     rendering, the framerate is independent of the clients machine).
     */
    override func framesPerSecond() -> Int {
        return 20
    }
}
