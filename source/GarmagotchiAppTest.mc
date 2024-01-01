using Toybox.Test;

(:test)
function initialMoodIs100(logger) {
    var model = new Garmagotchi();
    Test.assert(model.mood == 100);
    return true;
}
