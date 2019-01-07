import UIKit

class CircularProgressLayer: CALayer {
    var progress: CGFloat?
    @objc var radius = 15.0
    @objc let outerRingWidth = 3.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init() {
        super.init();
        self.actions = [
            "bounds": NSNull(),
            "contents": NSNull(),
            "position": NSNull()
        ]
    }

    init(layer: CircularProgressLayer) {
        super.init(layer: layer)
        progress = layer.progress
        radius = layer.radius
    }

    override func draw(in ctx: CGContext) {
        let center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let progress = min(self.progress!, 1.0 - CGFloat.ulpOfOne)
        let radians = (progress * CGFloat.pi * 2.0) - CGFloat.pi

        ctx.setFillColor(self.backgroundColor!)
        ctx.fill(self.bounds)
        ctx.setBlendMode(.clear)
        ctx.setLineWidth(CGFloat(self.outerRingWidth))
        ctx.setStrokeColor(UIColor.clear.cgColor)
        ctx.addArc(
            center: center,
            radius: CGFloat(self.radius),
            startAngle: 0.0,
            endAngle: 2 * CGFloat.pi,
            clockwise: false
        )
        ctx.strokePath()

        if (progress > 0.0) {
            ctx.setFillColor(UIColor.clear.cgColor)
            let progressPath = CGMutablePath()
            progressPath.move(to: center)
            progressPath.addArc(
                center: center,
                radius: CGFloat(self.radius),
                startAngle: 3.0 * CGFloat.pi,
                endAngle: radians,
                clockwise: false
            )
            ctx.closePath()
            ctx.addPath(progressPath)
            ctx.fillPath()
        }
    }
}
