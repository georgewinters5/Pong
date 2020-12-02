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
     This specifies the framerate to be used when rendering.  Generally,
     anything above 30 will begin to lag (Since Igis uses server-side rendering,
     the frame rate is typically independent of the clients graphics).
     */
    override func framesPerSecond() -> Int {
        return 20
    }
}
