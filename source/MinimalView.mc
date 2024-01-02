//
// Copyright 2015-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

//! TODO documen tclass
class GarmagotchiInputDelegate extends WatchUi.InputDelegate {
    private var model;
    
    //! TODO document constructor
    //! Constructor
    //! @param model ???
    public function initialize(model as Garmagotchi) {
        self.model = model;
        InputDelegate.initialize();
    }

    //! bumps yoshi's mood based on key pressed
    //! @return true if key is mapped, false otherwise
    public function onKey(keyEvent) as Boolean {
        switch (keyEvent.getKey()) {
        case WatchUi.KEY_ENTER:
            model.moodUp();
            return true;
        case WatchUi.KEY_ESC:
            model.moodDown();
            return true;
        default:
            return false;
        }
    }
}

//! TODO document class
class MinimalView extends WatchUi.View {
    var model;
    var yoshiSheet;
    var animation;

    //! Constructor
    public function initialize(model as Garmagotchi) {
        View.initialize();
        self.model = model;
    }

    //! Load the resources
    //! @param dc Device context
    public function onLayout(dc as Dc) as Void {
        yoshiSheet = new SpriteSheet(WatchUi.loadResource(Rez.Drawables.YoshiSheet));
        animation = new LoopingAnimation([[0,2],[1,2]], 2, 5);
    }

    //! Restore the state of the app and prepare the view to be shown
    public function onShow() as Void {
    }

    //! Update the view to show the value picked
    //! @param dc Device context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        var screenCenterX = dc.getWidth() / 2;
        var screenCenterY = dc.getHeight() / 2;

        var currentFrame = animation.currentFrame();
        var frameCoordX = currentFrame[0];
        var frameCoordY = currentFrame[1];

        var moodScale = model.mood.toFloat() / model.MAX_MOOD * 255;
        yoshiSheet.drawFrame(
            frameCoordX,
            frameCoordY,
            screenCenterX,
            screenCenterY,
            Graphics.createColor(0, moodScale, moodScale, 255),
            dc
        );
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var moodString = Lang.format("mood: $1$", [model.mood.format("%d")]);
        dc.drawText(
            screenCenterX,
            (screenCenterY + 50),
            Graphics.FONT_SMALL,
            moodString,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
}

class LoopingAnimation {
    private var frames;
    private var numFrames;
    private var currentFrameIndex;

    public function initialize(
        frames as Array<Array<Number>>,
        numFrames as Number,
        frameRate as Number
    ) {
        self.frames = frames;
        self.numFrames = numFrames;
        self.currentFrameIndex = 0;

        // TODO a more generic implementation might accept the global framerate
        // timer as a constructor parameter rather than instantiating a local
        // one here
        var animationTimer = new Timer.Timer();
        animationTimer.start(method(:timerCallback), 1000 / frameRate, true);
    }

    public function currentFrame() as Array<Number> {
        return frames[currentFrameIndex];
    }

    function timerCallback() as Void {
        currentFrameIndex = (currentFrameIndex + 1) % numFrames;
        WatchUi.requestUpdate();
    }
}

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
