using Toybox.Lang;

class TimeFormatter {
	static function format(timeInSec) {		
		var timeCalc = timeInSec;
		var seconds = timeCalc % 60;
		timeCalc /= 60;
		var minutes = timeCalc % 60;
		timeCalc /= 60;
		var hours = timeCalc % 24;
		
		var formattedTime = Lang.format("$1$:$2$", [minutes.format("%1d"), seconds.format("%02d")]);
		return formattedTime;
	}
}