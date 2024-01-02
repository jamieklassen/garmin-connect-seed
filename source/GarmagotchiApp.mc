//
// Copyright 2015-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

//! This app demonstrates how to use the Number Picker.
class GarmagotchiApp extends Application.AppBase {

    //! Constructor
    public function initialize() {
        AppBase.initialize();
    }

    //! Handle app startup
    //! @param state Startup arguments
    public function onStart(state as Dictionary?) as Void {
    }

    //! Handle app shutdown
    //! @param state Shutdown arguments
    public function onStop(state as Dictionary?) as Void {
    }

    //! Return the initial views for the app
    //! @return Array Pair [View, InputDelegate]
    public function getInitialView() as Array<Views or InputDelegates>? {
        var model = new Garmagotchi();
        var view = new $.MinimalView(model);
        var delegate = new $.GarmagotchiInputDelegate(model);
        return [view, delegate] as Array<Views or InputDelegates>;
    }
}

class Garmagotchi {
    public const MAX_MOOD = 10;
    public var mood;

    public function initialize() {
        mood = MAX_MOOD;
    }

    public function moodUp() {
        if (mood < MAX_MOOD) {
            mood += 1;
        }
    }

    public function moodDown() {
        if (mood > 0) {
            mood -= 1;
        }
    }
}
