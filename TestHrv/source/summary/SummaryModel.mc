using Toybox.System;

class SummaryModel {
	function initialize(activitySummary) {
		me.elapsedTime = activitySummary.hrSummary.elapsedTimeSeconds; 
		me.maxHr = me.initializeHeartRate(activitySummary.hrSummary.maxHr);
		me.avgHr = me.initializeHeartRate(activitySummary.hrSummary.averageHr);
		me.minHr = me.initializeHeartRate(activitySummary.hrSummary.minHr);
				
		if (activitySummary.hrvSummary != null) {
			me.hrvRmssd = me.initializeHeartRateVariability(activitySummary.hrvSummary.rmssd);
			me.hrvSdrr = me.initializeHeartRateVariability(activitySummary.hrvSummary.first5MinSdrr);
			me.hrvPnn50 = me.initializePercentageValue(activitySummary.hrvSummary.pnn50);
			me.hrvPnn20 = me.initializePercentageValue(activitySummary.hrvSummary.pnn20);
		}		
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null || heartRate == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
		}
	}
		
	private function initializePercentageValue(stressScore) {
		if (stressScore == null) {
			return me.InvalidHeartRate;
		}
		else {
			return stressScore.format("%3.2f");
		}
	}
	
	private function initializeHeartRateVariability(hrv) {
		if (hrv == null) {
			return me.InvalidHeartRate;
		}
		else {
			return hrv.format("%3.2f");
		}
	}
		
	private const InvalidHeartRate = "--";
	
	var elapsedTime;
	
	var maxHr;
	var avgHr;
	var minHr;	
			
	var hrvRmssd;
	var hrvSdrr;
	var hrvPnn50;
	var hrvPnn20;
}