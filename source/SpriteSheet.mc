import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class SpriteSheet {
    private const resolutionScale = 6.0;

    private var sheet;

    public function initialize(sheet as WatchUi.BitmapResource) {
        self.sheet = sheet;
    }

    public function drawFrame(
        boundingBox as Graphics.BoundingBox,
        originX as Lang.Number,
        originY as Lang.Number,
        tintColor as Lang.Number,
        dc as Dc
    ) as Void {
        var transform = new Graphics.AffineTransform();
        transform.setToScale(resolutionScale, resolutionScale);
        transform.translate(
            -boundingBox.x - boundingBox.width.toFloat()/2,
            -boundingBox.y - boundingBox.height.toFloat()/2
        );
        dc.drawBitmap2(originX, originY, sheet, {
            :bitmapX => boundingBox.x,
            :bitmapY => boundingBox.y,
            :bitmapWidth => boundingBox.width,
            :bitmapHeight => boundingBox.height,
            :tintColor => tintColor,
            :transform => transform
        });
    }
}

