using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class WaitingHrvDelegate extends ScreenPicker.ScreenPickerDelegate {
	function initialize(heartbeatIntervalsSensor) {
		ScreenPickerDelegate.initialize(0, 1);
		
		me.mNoHrvSeconds = MinSecondsNoHrvDetected;
		me.mHrvReadySuccessCount = 0;
		me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
		me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(method(:onIsHrvReadyListener));		
		me.mHeartbeatIntervalsSensor.start();
		me.isStartInProgress = false;
	}
			
	private var mHeartbeatIntervalsSensor;
	private var mNoHrvSeconds;
	private var mHrvReadySuccessCount;
	private const MinSecondsNoHrvDetected = 3;
	private const MinHrvReadySuccessCount = 2;
	
	function onIsHrvReadyListener(heartBeatIntervals) {
		if (heartBeatIntervals.size() == 0) {
			me.mNoHrvSeconds++;
		}
		else {
			me.mNoHrvSeconds = 0;
		}
		if (me.mNoHrvSeconds < MinSecondsNoHrvDetected) {
			me.mHrvReadySuccessCount++;
		}
		else {
			me.mHrvReadySuccessCount = 0;
		}
		if (me.mHrvReadySuccessCount >= MinHrvReadySuccessCount) {
			me.autoStartTestHrvActivity();
		}
	}
	
	private function autoStartTestHrvActivity() {
		Vibe.vibrateMediumPulsating();
		startTestHrvActivity();
	}
	
	private function startTestHrvActivity() {
		if (me.isStartInProgress == false) {
			me.isStartInProgress = true;
			me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
			var testHrvDelegate = new TestHrvDelegate(me.mHeartbeatIntervalsSensor);
			Ui.switchToView(testHrvDelegate.createTestHrvView(), testHrvDelegate, Ui.SLIDE_LEFT);		
		}
	}
	
	private var isStartInProgress;
		
	private function createWaitingHrvDetailsModel() {
		var details = new ScreenPicker.DetailsModel();
		
		details.titleColor = Gfx.COLOR_TRANSPARENT;
		details.color = Gfx.COLOR_WHITE;
		details.backgroundColor = Gfx.COLOR_BLACK;
		
		var hrvIcon = new ScreenPicker.HrvIcon({});
		hrvIcon.setStatusWarning();
	    details.detailLines[2].icon = hrvIcon;
        details.detailLines[2].value.text = "Waiting sensor";
		details.detailLines[3].value.text = "Keep still";
		
		var iconsXPos = App.getApp().getProperty("waitingHrvIconsXPos");
		var textXPos = App.getApp().getProperty("waitingHrvTextXPos");
		details.setAllIconsXPos(iconsXPos);
        details.setAllValuesXPos(textXPos);
		return details;
	}
	
	function createScreenPickerView() {
		var details = me.createWaitingHrvDetailsModel();
		return new ScreenPicker.ScreenPickerDetailsSinglePageView(details);
	}
	
	function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.startTestHrvActivity();
	    	return true;
	  	}
	  	return false;
    }
	
	function onBack() {
		me.mHeartbeatIntervalsSensor.stop();
		return false;//exit
	}
}