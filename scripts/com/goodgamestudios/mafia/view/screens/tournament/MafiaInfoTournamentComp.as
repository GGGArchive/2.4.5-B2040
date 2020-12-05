package com.goodgamestudios.mafia.view.screens.tournament
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.event.MafiaSliderEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.helper.SliderHelper;
   import com.goodgamestudios.mafia.view.panels.MafiaIngameHelpComponents.MafiaHelpSite;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MafiaInfoTournamentComp
   {
       
      
      private var tab:MovieClip;
      
      private var site:MovieClip;
      
      protected var helpHeight:int = 0;
      
      protected var helpslider:SliderHelper;
      
      public function MafiaInfoTournamentComp(param1:MovieClip)
      {
         super();
         this.tab = param1;
         this.helpslider = new SliderHelper(this.tab.mc_helpslider);
         this.tab.mc_helpslider.btn_slider.visible = false;
         this.helpslider.StepSize = 20;
         this.tab.helpHolder.mask = this.tab.mc_mask;
      }
      
      public function show() : void
      {
         this.tab.mc_helpslider.addEventListener(MafiaSliderEvent.ON_SLIDING,this.onChatSliding);
         this.tab.mc_helpslider.addEventListener(MafiaSliderEvent.ARROW_UP,this.onChatSliding);
         this.tab.mc_helpslider.addEventListener(MafiaSliderEvent.ARROW_DOWN,this.onChatSliding);
         this.initTextfields();
         this.showHelpText();
      }
      
      public function hide() : void
      {
         this.tab.mc_helpslider.removeEventListener(MafiaSliderEvent.ON_SLIDING,this.onChatSliding);
         this.tab.mc_helpslider.removeEventListener(MafiaSliderEvent.ARROW_UP,this.onChatSliding);
         this.tab.mc_helpslider.removeEventListener(MafiaSliderEvent.ARROW_DOWN,this.onChatSliding);
      }
      
      private function showHelpText() : void
      {
         var _loc2_:TextField = null;
         MovieClipHelper.clearMovieClip(this.tab.helpHolder);
         if(this.site)
         {
            this.site = null;
         }
         this.site = new MafiaHelpSite(new TournamentSiteMC());
         this.tab.helpHolder.addChild(this.site);
         var _loc1_:String = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_58") + "\n\n" + MafiaModel.languageData.getTextById("event_lastmanstanding_copy_59") + "\n\n" + MafiaModel.languageData.getTextById("event_lastmanstanding_copy_60") + "\n\n" + MafiaModel.languageData.getTextById("event_lastmanstanding_copy_61") + "\n\n" + MafiaModel.languageData.getTextById("event_lastmanstanding_copy_62");
         this.site.createText(_loc1_);
         this.site.y = 2;
         this.tab.helpHolder.y = this.tab.mc_mask.y;
         for each(_loc2_ in this.findTextFields(this.site))
         {
            this.updateTextField(_loc2_);
         }
         this.site.setStyle();
         this.helpHeight = this.site.height;
         this.tab.mc_helpslider.visible = this.helpHeight > this.tab.mc_mask.height;
         this.updateSlider();
      }
      
      private function updateSlider() : void
      {
         if(this.extraHelpHeight < this.tab.mc_mask.height)
         {
            return;
         }
         var _loc1_:int = this.tab.helpHolder.y - this.tab.mc_mask.y;
         var _loc2_:int = -(this.extraHelpHeight - this.tab.mc_mask.height);
         var _loc3_:int = 100 - (_loc2_ - _loc1_) / _loc2_ * 100;
         this.tab.mc_helpslider.btn_slider.y = this.tab.mc_helpslider.mc_sliderbar.y + this.tab.mc_helpslider.mc_sliderbar.height * _loc3_ * 0.01;
      }
      
      private function onChatSliding(param1:MafiaSliderEvent) : void
      {
         if(this.extraHelpHeight <= this.tab.mc_mask.height)
         {
            return;
         }
         this.tab.helpHolder.y = this.tab.mc_mask.y - (this.extraHelpHeight - this.tab.mc_mask.height) * param1.slidePos * 0.01;
      }
      
      protected function get extraHelpHeight() : int
      {
         return this.helpHeight + 5;
      }
      
      public function initTextfields() : void
      {
         this.tab.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_34");
      }
      
      private function updateTextField(param1:TextField) : void
      {
         var _loc2_:TextFormat = null;
         if(!BasicLanguageFontManager.getInstance().useDefaultFont && param1.styleSheet == null)
         {
            _loc2_ = param1.defaultTextFormat;
            if(_loc2_.font != "MafiaFont1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode)
            {
               _loc2_.font = "MafiaFont1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode;
               param1.defaultTextFormat = _loc2_;
               param1.setTextFormat(_loc2_);
            }
         }
         param1.height = param1.textHeight + 5;
      }
      
      private function findTextFields(param1:DisplayObjectContainer) : Array
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc4_ is TextField)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_ is DisplayObjectContainer)
            {
               _loc5_ = this.findTextFields(_loc4_ as DisplayObjectContainer);
               _loc2_ = _loc2_.concat(_loc5_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
