package com.goodgamestudios.mafia.view
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public dynamic class NewBasicStandartButton extends NewBasicInterfaceButton
   {
       
      
      protected var background:Sprite;
      
      protected var disablemask:Sprite;
      
      protected var goldInfo:MovieClip;
      
      protected var _goldInfoGoldText:String = "";
      
      protected var _goldInfoTimeText:String = "";
      
      protected var _goldInfoVisible:Boolean = false;
      
      protected var _goldInfoResizing:Boolean = false;
      
      protected var _isFixed:Boolean;
      
      protected var _state:String;
      
      protected var mouseOver:Boolean;
      
      protected var mouseDown:Boolean;
      
      public var textXOffset:int = 0;
      
      protected const STATE_NORMAL:String = "normal";
      
      protected const STATE_OVER:String = "over";
      
      protected const STATE_DOWN:String = "down";
      
      protected const STATE_DISABLE:String = "disable";
      
      protected const STATE_SELECTED:String = "selected";
      
      public function NewBasicStandartButton()
      {
         this._state = this.STATE_NORMAL;
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.mouseOver = false;
         this.mouseDown = false;
         this._isFixed = false;
         this.updateState();
      }
      
      public function update() : void
      {
         this.updateState();
      }
      
      protected function updateState() : void
      {
         if(enabled)
         {
            if(this._isFixed)
            {
               this.setState(this.STATE_SELECTED);
            }
            else if(this.mouseOver)
            {
               if(this.mouseDown)
               {
                  this.setState(this.STATE_DOWN);
               }
               else
               {
                  this.setState(this.STATE_OVER);
               }
            }
            else
            {
               this.setState(this.STATE_NORMAL);
            }
         }
         else
         {
            this.setState(this.STATE_DISABLE);
         }
      }
      
      protected function setState(param1:String) : void
      {
         this._state = param1;
         if(this.labelExists(param1))
         {
            gotoAndStop(param1);
         }
         else if(param1 == this.STATE_SELECTED)
         {
            gotoAndStop(this.STATE_DOWN);
         }
         textField = this.txt_label;
         this.background = this.mc_background;
         this.goldInfo = this.mc_goldTimer as MovieClip;
         this.disablemask = this.mc_disablemask;
         this.updateTextfield();
      }
      
      private function labelExists(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:FrameLabel = null;
         var _loc3_:int = currentLabels.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = currentLabels[_loc2_];
            if(_loc4_.name == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      override protected function updateTextfield() : void
      {
         if(textField)
         {
            textField.text = _label;
            this.updateTextfieldSize();
            this.updateTextfieldPosition();
         }
         this.updateBackground();
      }
      
      protected function updateTextfieldSize() : void
      {
         if(textField && textField.rotation == 0)
         {
            textField.width = textField.textWidth + 4;
         }
      }
      
      protected function updateTextfieldPosition() : void
      {
         if(textField && textField.rotation == 0)
         {
            textField.x = -(textField.width * 0.5) + this.textXOffset;
         }
      }
      
      override protected function updateBackground() : void
      {
         var _loc1_:Number = 0;
         if(textField)
         {
            _loc1_ = textField.width;
         }
         if(this.background)
         {
            this.updateBackgroundSize(_loc1_);
            this.updateBackgroundPosition();
            if(this._state == this.STATE_DISABLE)
            {
               this.updateDisableMask();
            }
         }
         this.updateGoldInfo();
      }
      
      protected function updateBackgroundSize(param1:Number) : void
      {
         if(this.background)
         {
            this.background.width = Math.max(_minWidth,param1 + this.textXOffset + 20);
         }
      }
      
      protected function updateBackgroundPosition() : void
      {
         if(this.background)
         {
            this.background.x = -(this.background.width * 0.5);
         }
      }
      
      protected function updateGoldInfo() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:* = 0;
         if(this.background)
         {
            _loc1_ = this.background.width;
         }
         if(this.goldInfo)
         {
            this.goldInfo.mouseChildren = false;
            this.goldInfo.mouseEnabled = false;
            this.goldInfo.visible = this._goldInfoVisible;
            if(this.goldInfo.txt_time)
            {
               this.goldInfo.txt_time.text = this._goldInfoTimeText;
            }
            if(this.goldInfo.txt_gold)
            {
               this.goldInfo.txt_gold.text = this._goldInfoGoldText;
            }
            this.updateGoldInfoPosition(_loc1_);
            if(this._goldInfoResizing)
            {
               if(this.goldInfo.txt_time)
               {
                  _loc2_ = this.goldInfo.txt_time.width;
                  _loc3_ = this.goldInfo.txt_time.textWidth + 4;
                  _loc4_ = _loc3_ - _loc2_;
                  this.goldInfo.txt_time.width = _loc3_;
                  this.goldInfo.bg.width = this.goldInfo.bg.width + _loc4_;
               }
            }
         }
      }
      
      protected function updateGoldInfoPosition(param1:Number) : void
      {
         if(this.goldInfo)
         {
            this.goldInfo.x = param1 * 0.5 + 5;
         }
      }
      
      override public function set enableButton(param1:Boolean) : void
      {
         enabled = param1;
         this.updateState();
      }
      
      public function set isFixed(param1:Boolean) : void
      {
         this._isFixed = param1;
         this.updateState();
      }
      
      public function get isFixed() : Boolean
      {
         return this._isFixed;
      }
      
      protected function updateDisableMask() : void
      {
         if(this.disablemask)
         {
            this.disablemask.width = this.background.width;
            this.disablemask.x = -(this.disablemask.width * 0.5);
         }
      }
      
      public function set goldInfoVisible(param1:Boolean) : void
      {
         this._goldInfoVisible = param1;
         this.updateGoldInfo();
      }
      
      public function set goldInfoResizing(param1:Boolean) : void
      {
         this._goldInfoResizing = param1;
         this.updateGoldInfo();
      }
      
      public function set goldInfoGoldText(param1:String) : void
      {
         this._goldInfoGoldText = param1;
         this.updateGoldInfo();
      }
      
      public function set goldInfoTimeText(param1:String) : void
      {
         this._goldInfoTimeText = param1;
         this.updateGoldInfo();
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         this.mouseOver = false;
         this.updateState();
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         this.mouseOver = true;
         this.updateState();
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpOutside);
         this.mouseDown = true;
         this.updateState();
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpOutside);
         this.mouseDown = false;
         this.updateState();
      }
      
      protected function onMouseUpOutside(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpOutside);
         this.mouseDown = false;
         this.updateState();
      }
   }
}
