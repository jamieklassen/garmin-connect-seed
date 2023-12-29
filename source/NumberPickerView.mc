//
// Copyright 2015-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

//! Do nothing with input, leave things static
class MinimalInputDelegate extends WatchUi.BehaviorDelegate {
    //! Constructor
    //! @param view The current view
    public function initialize() {
        BehaviorDelegate.initialize();
    }

    //! On select behavior, do nothing
    //! @return false
    public function onSelect() as Boolean {
        return false;
    }
}

//! Shows a static message
class MinimalView extends WatchUi.View {
    //! Constructor
    public function initialize() {
        View.initialize();
    }

    //! Load the resources
    //! @param dc Device context
    public function onLayout(dc as Dc) as Void {
    }

    //! Restore the state of the app and prepare the view to be shown
    public function onShow() as Void {
    }

    //! Update the view to show the value picked
    //! @param dc Device context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;

        dc.drawText(centerX, (centerY - 50), Graphics.FONT_SMALL, "PlAcEhOlDeR tExT", Graphics.TEXT_JUSTIFY_CENTER);
    }
}
