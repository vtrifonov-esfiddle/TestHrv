using Toybox.Application;
using Toybox.WatchUi;

class TestHrvApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	HrvAlgorithms.HrActivity.enableHrSensor(); 	        	
    	var heartbeatIntervalsSensor = new HrvAlgorithms.HeartbeatIntervalsSensor();
    	var waitingHrvDelegate = new WaitingHrvDelegate(heartbeatIntervalsSensor);
        return [ waitingHrvDelegate.createScreenPickerView(), waitingHrvDelegate ];
    }

}
