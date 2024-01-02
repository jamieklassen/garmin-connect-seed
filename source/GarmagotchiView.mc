//
// Copyright 2015-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

//! TODO document class
class GarmagotchiView extends WatchUi.View {
    var model;
    var yoshiSheet;
    var animation;

    //! Constructor
    public function initialize(model as Pet) {
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
