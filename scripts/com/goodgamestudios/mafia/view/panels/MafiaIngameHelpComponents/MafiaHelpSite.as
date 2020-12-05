package com.goodgamestudios.mafia.view.panels.MafiaIngameHelpComponents
{
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import flash.display.MovieClip;
   import flash.events.TextEvent;
   import flash.text.StyleSheet;
   
   public class MafiaHelpSite extends MovieClip
   {
       
      
      private var _switchFunction:Function;
      
      private var style:StyleSheet;
      
      private var link:Object;
      
      private var p:Object;
      
      private var helpSiteMC:MovieClip;
      
      public function MafiaHelpSite(param1:MovieClip)
      {
         this.style = new StyleSheet();
         this.link = new Object();
         this.p = new Object();
         super();
         this.helpSiteMC = param1;
         this.addChild(this.helpSiteMC);
         var _loc2_:Object = new Object();
         _loc2_.textDecoration = "underline";
         var _loc3_:Object = new Object();
         _loc3_.textDecoration = "underline";
         this.link.color = "#7EC2D2";
         this.p.fontfamily = "MafiaFont1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode;
         this.style.setStyle("a:hover",_loc2_);
         this.style.setStyle("a:active",_loc3_);
         this.style.setStyle("a:link",this.link);
      }
      
      public function setup(param1:Function) : void
      {
         this._switchFunction = param1;
      }
      
      public function createText(param1:String) : void
      {
         var _loc2_:Array = param1.split("<");
         var _loc3_:Boolean = false;
         var _loc4_:* = "<p>";
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc3_)
            {
               _loc4_ = _loc4_ + this.createLinkElement(_loc2_[_loc5_]);
               _loc3_ = false;
            }
            else
            {
               _loc4_ = _loc4_ + String(_loc2_[_loc5_]);
               _loc3_ = true;
            }
            _loc5_++;
         }
         _loc4_ = _loc4_ + "</p>";
         this.helpSiteMC.txt_copy.htmlText = _loc4_;
         this.helpSiteMC.txt_copy.height = Math.max(310,this.helpSiteMC.txt_copy.textHeight + 8);
         this.helpSiteMC.txt_copy.addEventListener(TextEvent.LINK,this.onHyperLinkEvent);
      }
      
      public function setStyle() : void
      {
         this.helpSiteMC.txt_copy.styleSheet = this.style;
      }
      
      private function createLinkElement(param1:String) : String
      {
         var _loc4_:uint = 0;
         var _loc2_:String = "";
         var _loc3_:* = "";
         while(_loc4_ < param1.length)
         {
            if(!isNaN(Number(param1.substr(_loc4_,1))))
            {
               _loc2_ = _loc2_ + param1.substr(_loc4_,1);
               _loc4_++;
               continue;
            }
            break;
         }
         _loc3_ = param1.substr(_loc2_.length);
         _loc3_ = "<a href=\"event:" + _loc2_ + "\">" + _loc3_ + "</a>";
         return _loc3_;
      }
      
      private function onHyperLinkEvent(param1:TextEvent) : void
      {
         this._switchFunction(param1.text);
      }
   }
}
