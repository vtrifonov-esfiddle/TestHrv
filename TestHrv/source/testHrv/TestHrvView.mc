using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TestHrvView extends Ui.View {
	private var mTestHrvModel;
	private var mElapsedDurationRenderer;
	private var mElapsedTimeText;
	private var mMeasuringHrvText;
	
    function initialize(testHrvModel) {
        View.initialize();
        
        me.mTestHrvModel = testHrvModel;        
    }

    function onLayout(dc) {
    	renderBackground(dc);   
        renderLayoutElapsedTime(dc); 
        renderTestingHrvText(dc);
        
        var durationArcRadius = dc.getWidth() / 2;
        var elapsedDurationArcWidth = dc.getWidth() / 4;
        me.mElapsedDurationRenderer = new ElapsedDuationRenderer(me.mTestHrvModel.ElapsedTimeColor, durationArcRadius, elapsedDurationArcWidth);        
    }
    
    private function renderBackground(dc) {				        
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);        
        dc.clear();        
    }
    
    private static const TextFont = Gfx.FONT_MEDIUM;
    
    private function getYPosOffsetFromCenter(dc, lineOffset) {
    	return dc.getHeight() / 2 + lineOffset * dc.getFontHeight(TextFont);
    }
    
    private function renderTestingHrvText(dc) {
    	var xPosCenter = dc.getWidth() / 2;
    	var yPosCenter = dc.getHeight() / 2;
        me.mMeasuringHrvText = new Ui.Text({
        	:text => "Testing HRV",
        	:font => TextFont,
        	:color => Gfx.COLOR_WHITE,
        	:justification =>Gfx.TEXT_JUSTIFY_CENTER,
        	:locX => xPosCenter,
        	:locY => yPosCenter
    	});
    }
    
    private function renderLayoutElapsedTime(dc) { 	
    	var xPosCenter = dc.getWidth() / 2;
    	var yPosCenter = getYPosOffsetFromCenter(dc, -1);
    	me.mElapsedTimeText = new Ui.Text({
        	:text => "",
        	:font => TextFont,
        	:color => me.mTestHrvModel.ElapsedTimeColor,
        	:justification => Gfx.TEXT_JUSTIFY_CENTER,
        	:locX => xPosCenter,
        	:locY => yPosCenter
    	});
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        
        me.mMeasuringHrvText.draw(dc);
        
        me.mElapsedTimeText.setText(TimeFormatter.format(me.mTestHrvModel.getRemainingTime()));
        me.mElapsedTimeText.draw(dc);
        
        me.mElapsedDurationRenderer.drawOverallElapsedTime(dc, me.mTestHrvModel.elapsedTimeSec, me.mTestHrvModel.SessionTimeSec);
    }
}
