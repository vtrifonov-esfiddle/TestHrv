using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;
using Toybox.Math;
using Toybox.Sensor;
using HrvAlgorithms.HrvTracking;

class TestHrvActivity extends HrvAlgorithms.ShortDetailedHrvActivity {
	private var mTestHrvModel;
		
	function initialize(testHrvModel, heartbeatIntervalsSensor) {
		var fitSessionSpec = HrvAlgorithms.FitSessionSpec.createGeneric("Test HRV");

		me.mTestHrvModel = testHrvModel;	
		HrvAlgorithms.ShortDetailedHrvActivity.initialize(fitSessionSpec, heartbeatIntervalsSensor);			
	}
								
	protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {	
		if (activityInfo.elapsedTime != null) {
			me.mTestHrvModel.elapsedTimeSec = activityInfo.elapsedTime / 1000;
		}
		
	    Ui.requestUpdate();
		
		if (me.mTestHrvModel.isHrvTestFinished()) {
			me.finishSession();
		}    	 
	}	   	
	
	private function finishSession() {
		Vibe.vibrateLongContinuous();
		me.stop();
		var summary = me.calculateSummaryFields();
		me.finish();
		me.mHeartbeatIntervalsSensor.stop();
		me.mHeartbeatIntervalsSensor.disableHrSensor();

		var summaryViewDelegate = new SummaryViewDelegate(summary);
		Ui.switchToView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT);		
	}
	
	function discardSession() {
		me.stop();
		me.mHeartbeatIntervalsSensor.disableHrSensor();
		me.discard();
		me.mHeartbeatIntervalsSensor.stop();
	}
	
	function calculateSummaryFields() {	
		var activitySummary = HrvAlgorithms.ShortDetailedHrvActivity.calculateSummaryFields();	
		var summaryModel = new SummaryModel(activitySummary);
		return summaryModel;
	}
}