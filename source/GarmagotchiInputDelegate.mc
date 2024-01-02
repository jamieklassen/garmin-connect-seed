import Toybox.Lang;
import Toybox.WatchUi;

//! TODO document class
class GarmagotchiInputDelegate extends WatchUi.InputDelegate {
    private var model;

    //! TODO document constructor
    //! Constructor
    //! @param model ???
    public function initialize(model as Pet) {
        self.model = model;
        InputDelegate.initialize();
    }

    //! bumps yoshi's mood based on key pressed
    //! @return true if key is mapped, false otherwise
    public function onKey(keyEvent) as Lang.Boolean {
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

