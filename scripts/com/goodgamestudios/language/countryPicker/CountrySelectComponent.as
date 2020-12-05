package com.goodgamestudios.language.countryPicker
{
   import com.goodgamestudios.assetmanager.AssetManager;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class CountrySelectComponent extends EventDispatcher
   {
       
      
      private const DEFAULT_COUNTRYS_PER_LINE:uint = 2;
      
      private const DEFAULT_BUTTON_OFFSET_X:uint = 10;
      
      private const DEFAULT_BUTTON_OFFSET_Y:uint = 10;
      
      private const DEFAULT_ARROW_UP:uint = 1;
      
      private const DEFAULT_ARROW_DOWN:uint = 2;
      
      private const DEFAULT_BGOFFSET_HEIGHT:uint = 0;
      
      private const DEFAULT_TOOLTIP_OFFSETX:uint = 20;
      
      private const DEFAULT_TOOLTIP_OFFSETY:uint = 18;
      
      private const DEFAULT_TOOLTIP_OFFSET:uint = 20;
      
      protected var _countryList:Vector.<AbstractGGSCountry>;
      
      protected var _selectedCountry:AbstractGGSCountry = null;
      
      private var _glowFilter:GlowFilter;
      
      private var _choiceCountryHeight:Number;
      
      protected var _countryMC:MovieClip;
      
      protected var _buttonOffsetX:int = 10;
      
      protected var _buttonOffsetY:int = 10;
      
      protected var _bgOffsetHeight:int = 0;
      
      protected var _countriesPerLine:uint;
      
      protected var getTextByIDFunction:Function;
      
      protected var _tooltipDisp:Sprite;
      
      protected var _tooltipBackground:Sprite;
      
      protected var _tooltipOffsetX:uint = 20;
      
      protected var _tooltipOffsetY:uint = 18;
      
      protected var _tooltipOffset:uint = 20;
      
      public function CountrySelectComponent(param1:MovieClip, param2:MovieClip, param3:Vector.<AbstractGGSCountry>, param4:int = 2, param5:Function = null)
      {
         super();
         this._countryMC = param1;
         this._tooltipBackground = param2;
         this._countryList = param3;
         this._countriesPerLine = param4;
         this.getTextByIDFunction = param5;
         this._glowFilter = new GlowFilter(16777215);
         this.addCountryButtons();
         this._countryMC.btn_arrow.addEventListener(MouseEvent.CLICK,this.toggleCountryPopUp);
      }
      
      public function destroy() : void
      {
         this._countryMC.btn_arrow.removeEventListener(MouseEvent.CLICK,this.toggleCountryPopUp);
         var _loc1_:int = 0;
         while(_loc1_ <= this._countryMC.numChildren)
         {
            this._countryMC.mc_flagholder.getChildAt(_loc1_).removeEventListener(MouseEvent.MOUSE_OVER,this.showCountryNameTooltip);
            this._countryMC.mc_flagholder.getChildAt(_loc1_).removeEventListener(MouseEvent.MOUSE_OVER,this.hideCountryNameTooltip);
            _loc1_++;
         }
      }
      
      protected function toggleCountryPopUp(param1:MouseEvent) : void
      {
         if(this._countryMC.mc_bg.scaleY > 1)
         {
            this.hideChoiceCountry();
         }
         else
         {
            this.showChoiceCountry();
         }
      }
      
      protected function addCountryButtons(param1:Vector.<AbstractGGSCountry> = null) : void
      {
         var country:AbstractGGSCountry = null;
         var mcClass:Class = null;
         var countryBtn:MovieClip = null;
         var countryList:Vector.<AbstractGGSCountry> = param1;
         if(countryList)
         {
            this._countryList = countryList;
         }
         while(this._countryMC.mc_flagholder.numChildren > 0)
         {
            this._countryMC.mc_flagholder.getChildAt(0).removeEventListener(MouseEvent.CLICK,this.onClickCountry);
            this._countryMC.mc_flagholder.removeChildAt(0);
         }
         this._countryMC.mc_flagholder.visible = false;
         if(this._countryList.length == 1)
         {
            this._countryMC.visible = false;
         }
         var i:int = 0;
         while(i < this._countryList.length)
         {
            country = this._countryList[i];
            try
            {
               mcClass = AssetManager.manager.getClass("country_" + country.ggsCountryCode) as Class;
               countryBtn = new mcClass();
               if(countryBtn)
               {
                  countryBtn.country = country;
                  countryBtn.name = "country_" + country.ggsCountryCode;
                  this._countryMC.mc_flagholder.addChild(countryBtn);
                  countryBtn.mouseChildren = false;
                  countryBtn.addEventListener(MouseEvent.CLICK,this.onClickCountry);
                  countryBtn.addEventListener(MouseEvent.MOUSE_OVER,this.showCountryNameTooltip);
                  countryBtn.addEventListener(MouseEvent.MOUSE_OUT,this.hideCountryNameTooltip);
               }
            }
            catch(e:Error)
            {
               trace("CountrySelectComponent, addCountryButtons() -> ERROR: country unkown: " + country.ggsCountryCode);
            }
            i++;
         }
         this.positionCountryBtn();
         this.hideChoiceCountry();
      }
      
      protected function showCountryNameTooltip(param1:MouseEvent) : void
      {
         var mcClass:Class = null;
         var CountryNameText:MovieClip = null;
         var event:MouseEvent = param1;
         var countryBtn:MovieClip = event.currentTarget as MovieClip;
         try
         {
            mcClass = AssetManager.manager.getClass("CountryName_" + countryBtn.country.ggsCountryCode) as Class;
            CountryNameText = new mcClass();
            this._tooltipBackground.width = CountryNameText.width + this._tooltipOffsetX;
            this._tooltipBackground.height = CountryNameText.height + this._tooltipOffsetY;
            CountryNameText.y = -(this._tooltipOffsetY / 3);
            this._tooltipDisp = new Sprite();
            this._tooltipDisp.addChild(this._tooltipBackground);
            this._tooltipDisp.addChild(CountryNameText);
            this._tooltipDisp.x = countryBtn.x;
            this._tooltipDisp.y = countryBtn.y - this._tooltipOffset;
            this._countryMC.mc_flagholder.addChild(this._tooltipDisp);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      protected function hideCountryNameTooltip(param1:MouseEvent) : void
      {
         if(this._tooltipDisp)
         {
            this._countryMC.mc_flagholder.removeChild(this._tooltipDisp);
            this._tooltipDisp = null;
         }
      }
      
      protected function onClickCountry(param1:MouseEvent) : void
      {
         var _loc2_:AbstractGGSCountry = param1.target.country as AbstractGGSCountry;
         this.selectedCountryButton(_loc2_);
         this.hideChoiceCountry();
      }
      
      protected function positionCountryBtn() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._countryMC.mc_flagholder.numChildren)
         {
            _loc2_ = this._countryMC.mc_flagholder.getChildAt(_loc1_) as MovieClip;
            if(_loc2_)
            {
               _loc2_.x = (_loc2_.width + this._buttonOffsetX) * (_loc1_ % this._countriesPerLine);
               _loc2_.y = (_loc2_.height + this._buttonOffsetY) * int(_loc1_ / this._countriesPerLine) + 12;
               this._choiceCountryHeight = _loc2_.height + _loc2_.y;
            }
            _loc1_++;
         }
         this._countryMC.mc_flagholder.y = -(this._choiceCountryHeight + this._countryMC.mc_bg.height);
      }
      
      public function hideChoiceCountry() : void
      {
         this._countryMC.mc_flagholder.visible = false;
         this._countryMC.mc_bg.scaleY = 1;
         this._countryMC.btn_arrow.gotoAndStop(this.DEFAULT_ARROW_UP);
         dispatchEvent(new CountrySelectComponentEvent(CountrySelectComponentEvent.COUNTRY_VIEW_CLOSED));
      }
      
      public function showChoiceCountry() : void
      {
         this._countryMC.mc_flagholder.visible = true;
         var _loc1_:Number = this._countryMC.mc_bg.height + this._choiceCountryHeight - this._countryMC.mc_currentflag.y + this._bgOffsetHeight;
         this._countryMC.mc_bg.scaleY = _loc1_ / this._countryMC.mc_bg.height;
         this._countryMC.btn_arrow.gotoAndStop(this.DEFAULT_ARROW_DOWN);
         dispatchEvent(new CountrySelectComponentEvent(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED));
      }
      
      protected function selectedCountryButton(param1:AbstractGGSCountry) : void
      {
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         if(!this._countryList || this._countryList.length <= 1)
         {
            this._countryMC.visible = false;
            return;
         }
         if(!this._selectedCountry || this._selectedCountry.ggsCountryCode != param1.ggsCountryCode)
         {
            this.selectChild(this._countryMC.mc_flagholder.getChildByName("country_" + param1.ggsCountryCode));
            if(this._selectedCountry)
            {
               this.deselectedChild(this._countryMC.mc_flagholder.getChildByName("country_" + this._selectedCountry.ggsCountryCode));
            }
            while(this._countryMC.mc_currentflag.numChildren > 0)
            {
               this._countryMC.mc_currentflag.removeChildAt(0);
            }
            _loc2_ = AssetManager.manager.getClass("country_" + param1.ggsCountryCode) as Class;
            _loc3_ = new _loc2_();
            if(_loc3_)
            {
               _loc3_.name = param1.ggsCountryCode;
               this._countryMC.mc_currentflag.addChild(_loc3_);
            }
            this._selectedCountry = param1;
            dispatchEvent(new CountrySelectComponentEvent(CountrySelectComponentEvent.COUNTRY_CHANGED,this._selectedCountry));
         }
      }
      
      public function setDefaultCountry(param1:AbstractGGSCountry) : void
      {
         this.selectedCountryButton(param1);
      }
      
      protected function selectChild(param1:MovieClip) : void
      {
         param1.filters = [this._glowFilter];
      }
      
      protected function deselectedChild(param1:MovieClip) : void
      {
         if(param1.filters.length > 0)
         {
            param1.filters = [];
         }
      }
      
      public function set glowFilter(param1:GlowFilter) : void
      {
         this._glowFilter = param1;
      }
   }
}
