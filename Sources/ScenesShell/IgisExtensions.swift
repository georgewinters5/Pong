import Igis

/*
 This file provides a few extensions to Igis
 for a simplified hit testing interface
 */

extension Ellipse {
    func boundingRect() -> Rect {
        let topLeft = Point(x:self.center.x - self.radiusX, y:self.center.y - self.radiusY)
        let size = Size(width:self.radiusX * 2, height:self.radiusY * 2)
        return Rect(topLeft:topLeft, size:size)
    }
}

extension ContainmentSet {
    var tooFarLeft : Bool {
        return contains(.overlapsLeft)
    }

    var tooFarRight : Bool {
        return contains(.overlapsRight)
    }

    var tooFarUp : Bool {
        return contains(.overlapsTop)
    }

    var tooFarDown : Bool {
        return contains(.overlapsBottom)
    }
}
