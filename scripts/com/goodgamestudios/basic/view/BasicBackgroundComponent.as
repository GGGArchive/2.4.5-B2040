package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.misc.SupportUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class BasicBackgroundComponent extends FlashUIComponent
   {
       
      
      public var customCursor:BasicCustomCursor;
      
      private var loadingTextUpdateTimer:Timer;
      
      private var progressTimer:Timer;
      
      private var progressStartTime:Number;
      
      protected var randomLoadingTextCount:uint = 1;
      
      private var _progressBarEnabled:Boolean = true;
      
      public function BasicBackgroundComponent(param1:DisplayObject)
      {
         super(param1);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      protected function get backgroundView() : MovieClip
      {
         return disp as MovieClip;
      }
      
      public function updateLoadingProgress(param1:Number) : void
      {
         this.progressBar.progressBarStatus.scaleX = param1 / 100;
      }
      
      protected function get progressBar() : MovieClip
      {
         return this.backgroundView.mc_progressBar;
      }
      
      protected function get supportBtn() : MovieClip
      {
         return this.backgroundView.mc_bg.btn_mailsupport;
      }
      
      protected function get background() : MovieClip
      {
         return this.backgroundView.mc_bg;
      }
      
      protected function get versionTextfield() : TextField
      {
         return this.backgroundView.mc_bg.txt_version;
      }
      
      override public function show() : void
      {
         super.show();
         this.backgroundView.play();
         var _loc1_:int = 0;
         while(_loc1_ < this.backgroundView.numChildren)
         {
            if(this.backgroundView.getChildAt(_loc1_) is MovieClip && (this.backgroundView.getChildAt(_loc1_) as MovieClip).framesLoaded > 1)
            {
               (this.backgroundView.getChildAt(_loc1_) as MovieClip).play();
            }
            else
            {
               this.backgroundView.getChildAt(_loc1_).cacheAsBitmap = true;
            }
            _loc1_++;
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(this.background)
         {
            _loc1_ = this.background.getBounds(null);
            _loc2_ = this.backgroundView.stage.stageWidth / _loc1_.width;
            if(_loc1_.height * _loc2_ > this.backgroundView.stage.stageHeight)
            {
               _loc2_ = this.backgroundView.stage.stageHeight / _loc1_.height;
            }
            this.backgroundView.mc_progressBar.x = this.backgroundView.stage.stageWidth * 0.5;
            this.backgroundView.mc_progressBar.y = this.backgroundView.stage.stageHeight * 0.5;
            this.background.scaleX = this.background.scaleY = _loc2_;
            this.backgroundView.mc_bg.x = (this.backgroundView.stage.stageWidth - _loc1_.width * _loc2_) * 0.5;
            this.backgroundView.mc_bg.y = this.backgroundView.stage.stageHeight - _loc1_.height * _loc2_;
         }
      }
      
      public function get scaleFactor() : Number
      {
         return this.background.scaleX;
      }
      
      public function get gameNullPoint() : Number
      {
         return this.background.x;
      }
      
      public function startProgressBar() : void
      {
         this.progressText = this.getRandomLoadingText();
         this.updateLoadingProgress(0);
         this.progressStartTime = getTimer();
         if(!this.progressTimer)
         {
            this.progressTimer = new Timer(20);
         }
         this.progressTimer.addEventListener(TimerEvent.TIMER,this.onProgressTimer);
         this.progressTimer.start();
         if(!this.loadingTextUpdateTimer)
         {
            this.loadingTextUpdateTimer = new Timer(BasicConstants.AUTOMATIC_LOADING_BAR_UPDATE_TIME);
         }
         this.loadingTextUpdateTimer.addEventListener(TimerEvent.TIMER,this.updateRandomLoadingText);
         this.loadingTextUpdateTimer.start();
      }
      
      public function stopProgressBar() : void
      {
         if(this.progressTimer)
         {
            this.progressTimer.stop();
            this.progressTimer.removeEventListener(TimerEvent.TIMER,this.onProgressTimer);
         }
         if(this.loadingTextUpdateTimer)
         {
            this.loadingTextUpdateTimer.removeEventListener(TimerEvent.TIMER,this.updateRandomLoadingText);
            this.loadingTextUpdateTimer.stop();
         }
      }
      
      public function updateRandomLoadingText(param1:TimerEvent = null) : void
      {
         if(this.progressBar.parent == null || this.progressBar.visible == false)
         {
            return;
         }
         this.progressText = this.getRandomLoadingText();
      }
      
      protected function getRandomLoadingText() : String
      {
         if(this.randomLoadingTextCount > this.maxLoadingTextCount)
         {
            this.randomLoadingTextCount = 1;
         }
         var _loc1_:String = this.loadingTextIdPrefix + this.randomLoadingTextCount;
         this.randomLoadingTextCount++;
         if(BasicModel.languageData)
         {
            return BasicModel.languageData.getTextById(_loc1_);
         }
         return "";
      }
      
      public function updateLoadingText(param1:String) : void
      {
         switch(param1)
         {
            case BasicConstants.ITEM_XML_LOADER:
               this.progressText = BasicModel.languageData.getTextById("loading_text_itemXML");
               break;
            default:
               this.progressText = this.getRandomLoadingText();
         }
      }
      
      public function set progressText(param1:String) : void
      {
         if(this.env.showLoadingText && "txt_progress" in this.progressBar)
         {
            this.progressBar.txt_progress.text = param1;
         }
      }
      
      protected function onProgressTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = Math.sin((getTimer() - this.progressStartTime) % BasicConstants.AUTOMATIC_LOADING_BAR_UPDATE_TIME / BasicConstants.AUTOMATIC_LOADING_BAR_UPDATE_TIME * (Math.PI * 0.5));
         _loc2_ = _loc2_ * 100;
         var _loc3_:int = _loc2_ > 0?int(int(_loc2_ + 0.5)):int(int(_loc2_ - 0.5));
         this.updateLoadingProgress(_loc3_);
      }
      
      public function hideProgressBar() : void
      {
         if(this.progressBar)
         {
            this.progressBar.visible = false;
            this.progressText = "";
         }
      }
      
      public function showProgressBar() : void
      {
         if(this._progressBarEnabled)
         {
            this.progressBar.visible = true;
            this.progressText = this.getRandomLoadingText();
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         this.backgroundView.stop();
         var _loc1_:int = 0;
         while(_loc1_ < this.backgroundView.numChildren)
         {
            if(this.backgroundView.getChildAt(_loc1_) is MovieClip)
            {
               (this.backgroundView.getChildAt(_loc1_) as MovieClip).stop();
            }
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         super.destroy();
      }
      
      override protected function init() : void
      {
         updateAllTextFields();
         this.versionTextfield.text = this.env.versionText;
         this.versionTextfield.visible = this.env.showVersion;
         this.updateLoadingProgress(0);
         if(this.supportBtn)
         {
            this.supportBtn.visible = this.env.useexternallinks;
            this.supportBtn.addEventListener(MouseEvent.CLICK,this.onClick);
            this.supportBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onOverSupport);
            this.supportBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onOutSupport);
         }
      }
      
      public function showVersion() : void
      {
         this.versionTextfield.text = this.env.versionText;
         this.versionTextfield.visible = this.env.showVersion;
         if(this.supportBtn)
         {
            this.supportBtn.visible = this.env.useexternallinks;
         }
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
      }
      
      protected function onOverSupport(param1:MouseEvent) : void
      {
         this.supportBtn.scaleX = this.supportBtn.scaleY = 1.05;
         if(this.customCursor)
         {
            this.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      protected function onOutSupport(param1:MouseEvent) : void
      {
         this.supportBtn.scaleX = this.supportBtn.scaleY = 1;
         if(this.customCursor)
         {
            this.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target == this.supportBtn)
         {
            SupportUtil.navigateToSupport(this.env.gameId,BasicModel.instanceProxy.selectedInstanceVO.instanceId,this.env.versionText,this.env.networkId,this.env.gameTitle,"-",-1,-1,GGSCountryController.instance.currentCountry.ggsLanguageCode,this.env.referrer);
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
      
      public function set progressBarEnabled(param1:Boolean) : void
      {
         this._progressBarEnabled = param1;
         if(this._progressBarEnabled)
         {
            this.showProgressBar();
         }
         else
         {
            this.hideProgressBar();
         }
      }
      
      protected function get loadingTextIdPrefix() : String
      {
         return "loading_text_";
      }
      
      protected function get maxLoadingTextCount() : int
      {
         return BasicConstants.NUM_RANDOM_LOADINGTEXT_ELEMENTS_AVAILABLE;
      }
   }
}
