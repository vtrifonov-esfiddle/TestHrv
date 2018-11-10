using Toybox.Attention;

class Vibe {
	static function vibrateLongContinuous() {
		var vibeProfile =  [
			new Attention.VibeProfile(100, 4000)
		];
		Attention.vibrate(vibeProfile);
	}
		
	static function vibrateMediumPulsating() {
		var vibeProfile = [
			new Attention.VibeProfile(100, 1000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
		Attention.vibrate(vibeProfile);
	}
}