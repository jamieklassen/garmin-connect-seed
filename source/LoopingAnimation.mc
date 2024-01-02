import Toybox.Lang;

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
