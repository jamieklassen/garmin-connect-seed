import Toybox.Test;

(:test)
function initialMoodIs10(logger as Test.Logger) {
    var model = new Pet();
    Test.assertEqualMessage(model.mood, 10, "mood was not initially 10");
    return true;
}

(:test)
function moodDoesNotExceed10(logger as Test.Logger) {
    var model = new Pet();
    model.moodUp();
    Test.assertEqualMessage(model.mood, 10, "mood should not exceed 10");
    return true;
}

(:test)
function moodStaysNonnegative(logger as Test.Logger) {
    var model = new Pet();
    for (var i = 0; i < 11; i++) {
        model.moodDown();
    }
    Test.assertEqualMessage(model.mood, 0, "mood should not go below 0");
    return true;
}
