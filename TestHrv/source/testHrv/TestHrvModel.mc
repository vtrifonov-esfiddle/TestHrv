using Toybox.Graphics as Gfx;

class TestHrvModel {
	function initialize() {
		me.elapsedTimeSec = 0;
	}

	var elapsedTimeSec;
	const SessionTimeSec = 180;
	const ElapsedTimeColor = Gfx.COLOR_BLUE;
	
	function isHrvTestFinished() {
		return me.elapsedTimeSec >= SessionTimeSec;
	}
	
	function getRemainingTime() {		
        return SessionTimeSec - me.elapsedTimeSec;
	}
}