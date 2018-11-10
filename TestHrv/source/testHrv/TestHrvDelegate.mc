using Toybox.WatchUi;

class TestHrvDelegate extends WatchUi.BehaviorDelegate {

    function initialize(heartbeatIntervalsSensor) {
        BehaviorDelegate.initialize();
        
        me.mTestHrvModel = new TestHrvModel();
        me.mTestHrvActivity = new TestHrvActivity(me.mTestHrvModel, heartbeatIntervalsSensor);
    }
	
	private var mTestHrvModel;
	private var mTestHrvActivity;
	
	function createTestHrvView() {
		return new TestHrvView(me.mTestHrvModel);
	}
	
	function onBack() {
		if (me.mTestHrvActivity != null) {
			me.mTestHrvActivity.discardSession();
			me.mTestHrvActivity = null;
		}
		return false;//exit
	}
}