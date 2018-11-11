using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;

class SummaryViewDelegate extends ScreenPicker.ScreenPickerDelegate {
	private var mSummaryModel;

	function initialize(summaryModel) {		
		me.mPagesCount = PagesCount;
		setPageIndexes();
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = summaryModel;
        me.mSummaryLinesYOffset = App.getApp().getProperty("summaryLinesYOffset");
	}
		
	private var mSummaryLinesYOffset;
			
	private const PagesCount = 4;
	
	private function setPageIndexes() {			
		me.mHrvRmssdPageIndex = 0;			
		me.mHrvPnnxPageIndex = 1;	
		me.mHrvSdrrPageIndex = 2;
		me.mHrPageIndex = 3;
	}
	
	private var mPagesCount;
	
	private var mHrvRmssdPageIndex;
	private var mHrvSdrrPageIndex;
	private var mHrvPnnxPageIndex;
	private var mStressPageIndex;
	private var mHrPageIndex;
	
	private const InvalidPageIndex = -1;

	function onBack() {		
		return false;
	}
	
	function createScreenPickerView() {
		var details;
		if (me.mSelectedPageIndex == mHrPageIndex) {
			details = me.createDetailsPageHr();
		} 
		else if (me.mSelectedPageIndex == mHrvRmssdPageIndex){
			details = me.createDetailsPageHrvRmssd();
		}
		else if (me.mSelectedPageIndex == mHrvPnnxPageIndex){
			details = me.createDetailsPageHrvPnnx();
		} 
		else if (me.mSelectedPageIndex == mHrvSdrrPageIndex){
			details = me.createDetailsPageHrvSdrr();
		} 
		else {
			details = me.createDetailsPageHrvRmssd();
		}
		return new ScreenPicker.ScreenPickerDetailsView(details);
	}	
				
	private function formatHr(hr) {
		return hr + " bpm";
	}
		
	private function createDetailsPageHr() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary HR";
        details.titleColor = Gfx.COLOR_BLACK;
        
        var hrMinIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrMin,
        	:color=>Graphics.COLOR_RED   	
    	});     
        details.detailLines[2].icon = hrMinIcon;
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = me.formatHr(me.mSummaryModel.minHr);
                
        var hrAvgIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrAvg,
        	:color=>Graphics.COLOR_RED   	
    	});            
        details.detailLines[3].icon = hrAvgIcon;
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = me.formatHr(me.mSummaryModel.avgHr);
        
        var hrMaxIcon = new ScreenPicker.Icon({       
        	:font => StatusIconFonts.fontMeditateIcons,
        	:symbol => StatusIconFonts.Rez.Strings.meditateFontHrMax,
        	:color=>Graphics.COLOR_RED   	
    	});              
        details.detailLines[4].icon = hrMaxIcon;    
        details.detailLines[4].value.color = Gfx.COLOR_BLACK; 
        details.detailLines[4].value.text = me.formatHr(me.mSummaryModel.maxHr);
		
        var hrIconsXPos = App.getApp().getProperty("summaryHrIconsXPos");
        var hrValueXPos = App.getApp().getProperty("summaryHrValueXPos");                
        details.setAllIconsXPos(hrIconsXPos);
        details.setAllValuesXPos(hrValueXPos);   
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
			
	private function createDetailsPageHrvRmssd() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV RMSSD";
        details.titleColor = Gfx.COLOR_BLACK;
                             
        details.detailLines[3].icon = new ScreenPicker.HrvIcon({});              
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvRmssd]);
                 
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
	
	private function createDetailsPageHrvPnnx() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV pNNx";
        details.titleColor = Gfx.COLOR_BLACK;
                            
        var hrvIcon = new ScreenPicker.HrvIcon({});            
        details.detailLines[2].icon = hrvIcon;      
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;        
        details.detailLines[2].value.text = "pNN20";
        
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ %", [me.mSummaryModel.hrvPnn20]);
        
    	details.detailLines[4].icon = hrvIcon;
    	details.detailLines[4].value.color = Gfx.COLOR_BLACK;
        details.detailLines[4].value.text = "pNN50";
        details.detailLines[5].value.color = Gfx.COLOR_BLACK;
        details.detailLines[5].value.text = Lang.format("$1$ %", [me.mSummaryModel.hrvPnn50]);  
         
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
	
	private function createDetailsPageHrvSdrr() {
		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary\n HRV SDRR";
        details.titleColor = Gfx.COLOR_BLACK;
                                
        var hrvIcon = new ScreenPicker.HrvIcon({});            
        details.detailLines[3].icon = hrvIcon; 
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;
        details.detailLines[3].value.text = Lang.format("$1$ ms", [me.mSummaryModel.hrvSdrr]);
                 
        var hrvIconsXPos = App.getApp().getProperty("summaryHrvIconsXPos");
        var hrvValueXPos = App.getApp().getProperty("summaryHrvValueXPos");
        details.setAllIconsXPos(hrvIconsXPos);
        details.setAllValuesXPos(hrvValueXPos); 
        details.setAllLinesYOffset(me.mSummaryLinesYOffset);
        
        return details;
	}	
}