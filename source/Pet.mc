class Pet {
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
