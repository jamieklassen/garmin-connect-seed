import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class SpriteSheet {
    private const resolutionScale = 6.0;
    private const spriteFrameWidth = 16;
    private const spriteFrameHeight = 16;
    private const spriteFrameBorderWidth = 1;
    private const spriteFrameBorderHeight = 1;

    private var sheet;

    public function initialize(sheet as WatchUi.BitmapResource) {
        self.sheet = sheet;
    }

    public function drawFrame(
        frameCoordX as Lang.Number,
        frameCoordY as Lang.Number,
        originX as Lang.Number,
        originY as Lang.Number,
        tintColor as Lang.Number,
        dc as Dc
    ) as Void {
        var bitmapX = frameCoordX * (spriteFrameWidth + spriteFrameBorderWidth);
        var bitmapY = frameCoordY * (spriteFrameHeight + spriteFrameBorderHeight);
        var transform = new Graphics.AffineTransform();
        transform.setToScale(resolutionScale, resolutionScale);
        transform.translate(
            -bitmapX - spriteFrameWidth.toFloat()/2,
            -bitmapY - spriteFrameHeight.toFloat()/2
        );
        dc.drawBitmap2(originX, originY, sheet, {
            :bitmapX => bitmapX,
            :bitmapY => bitmapY,
            :bitmapWidth => spriteFrameWidth,
            :bitmapHeight => spriteFrameHeight,
            :tintColor => tintColor,
            :transform => transform
        });
    }
}

