package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.event.MafiaSliderEvent;
   import com.goodgamestudios.mafia.view.NewBasicUIButton;
   import com.goodgamestudios.math.MathBase;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class SliderHelper
   {
       
      
      private var sliderMC:MovieClip;
      
      private var buttonDown:NewBasicUIButton;
      
      private var buttonUp:NewBasicUIButton;
      
      private var buttonSlider:NewBasicUIButton;
      
      private var sliderBar:MovieClip;
      
      private var currentPos:int;
      
      public var StepSize:int = 10;
      
      public function SliderHelper(param1:MovieClip, param2:int = 0)
      {
         super();
         this.currentPos = param2;
         this.sliderMC = param1;
         if(this.sliderMC.hasOwnProperty("btn_up"))
         {
            this.buttonUp = this.sliderMC["btn_up"];
            this.buttonUp.addEventListener(MouseEvent.CLICK,this.onClickButtonUp);
         }
         if(this.sliderMC.hasOwnProperty("btn_down"))
         {
            this.buttonDown = this.sliderMC["btn_down"];
            this.buttonDown.addEventListener(MouseEvent.CLICK,this.onClickButtonDown);
         }
         if(this.sliderMC.hasOwnProperty("btn_slider"))
         {
            this.buttonSlider = this.sliderMC["btn_slider"];
            this.buttonSlider.addEventListener(MouseEvent.MOUSE_DOWN,this.onSliderMouseDown);
         }
         if(this.sliderMC.hasOwnProperty("mc_sliderbar"))
         {
            this.sliderBar = this.sliderMC["mc_sliderbar"];
            this.sliderBar.addEventListener(MouseEvent.CLICK,this.onClickSlider);
         }
         this.sliderMC.parent.addEventListener(MouseEvent.ROLL_OVER,this.onOverChat);
         this.sliderMC.parent.addEventListener(MouseEvent.ROLL_OUT,this.onOutChat);
      }
      
      private function onOverChat(param1:MouseEvent) : void
      {
         this.sliderMC.parent.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onOutChat(param1:MouseEvent) : void
      {
         this.sliderMC.parent.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function onSliderMouseDown(param1:MouseEvent) : void
      {
         if(!this.buttonSlider.enabled)
         {
            return;
         }
         this.buttonSlider.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onSliding);
         this.buttonSlider.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStopSliding);
      }
      
      private function onStopSliding(param1:MouseEvent) : void
      {
         this.buttonDown.enableButton = true;
         this.buttonUp.enableButton = true;
         this.buttonSlider.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onSliding);
         this.buttonSlider.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStopSliding);
      }
      
      private function onSliding(param1:MouseEvent) : void
      {
         this.buttonDown.enableButton = false;
         this.buttonUp.enableButton = false;
         if(!param1.buttonDown)
         {
            return;
         }
         if(this.sliderBar.height > this.sliderBar.width)
         {
            this.verticalSlider(this.sliderBar.mouseY - this.currentPos * this.sliderBar.height / 100);
         }
         else
         {
            this.horizontalSlider(this.sliderBar.mouseX - this.currentPos * this.sliderBar.width / 100);
         }
         this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ON_SLIDING,this.currentPos,param1.buttonDown));
      }
      
      private function verticalSlider(param1:Number) : void
      {
         var _loc2_:int = this.buttonSlider.y + param1;
         if(_loc2_ <= this.sliderBar.height - this.sliderBar.y && _loc2_ >= this.sliderBar.y)
         {
            this.buttonSlider.y = _loc2_;
         }
         var _loc3_:int = this.buttonSlider.y - this.sliderBar.y;
         var _loc4_:int = this.sliderBar.height;
         this.currentPos = 100 - (_loc4_ - _loc3_) / _loc4_ * 100;
      }
      
      private function horizontalSlider(param1:Number) : void
      {
         var _loc2_:int = this.buttonSlider.x + param1;
         if(_loc2_ <= this.sliderBar.width + this.sliderBar.x && _loc2_ >= this.sliderBar.x)
         {
            this.buttonSlider.x = _loc2_;
         }
         var _loc3_:int = this.buttonSlider.x - this.sliderBar.x;
         var _loc4_:int = this.sliderBar.width;
         this.currentPos = 100 - (_loc4_ - _loc3_) / _loc4_ * 100;
      }
      
      private function onClickButtonUp(param1:MouseEvent) : void
      {
         if(!this.buttonUp.enabled)
         {
            return;
         }
         BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
         this.currentPos = MathBase.min(100,this.currentPos + this.StepSize);
         this.updateSliderButton();
         this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ARROW_UP,this.currentPos,param1.buttonDown));
      }
      
      private function onClickButtonDown(param1:MouseEvent) : void
      {
         if(!this.buttonDown.enabled)
         {
            return;
         }
         BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
         this.currentPos = MathBase.max(0,this.currentPos - this.StepSize);
         this.updateSliderButton();
         this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ARROW_DOWN,this.currentPos,param1.buttonDown));
      }
      
      private function onClickSlider(param1:MouseEvent) : void
      {
         if(!this.buttonSlider.enabled)
         {
            return;
         }
         if(this.sliderBar.height > this.sliderBar.width)
         {
            this.verticalSlider(param1.localY - this.currentPos * this.sliderBar.height / 100);
         }
         else
         {
            this.horizontalSlider(param1.localX - this.currentPos * this.sliderBar.width / 100);
         }
         this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ON_SLIDING,this.currentPos,param1.buttonDown));
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            if(!this.buttonDown.enabled)
            {
               return;
            }
            this.currentPos = MathBase.max(0,this.currentPos - this.StepSize);
            this.updateSliderButton();
            this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ARROW_DOWN,this.currentPos,false));
         }
         else if(param1.delta < 0)
         {
            if(!this.buttonUp.enabled || this.currentPos == 100)
            {
               return;
            }
            this.currentPos = MathBase.min(100,this.currentPos + this.StepSize);
            this.updateSliderButton();
            this.sliderMC.dispatchEvent(new MafiaSliderEvent(MafiaSliderEvent.ARROW_UP,this.currentPos,false));
         }
      }
      
      private function updateSliderButton() : void
      {
         if(this.buttonSlider)
         {
            if(this.sliderBar.height > this.sliderBar.width)
            {
               this.buttonSlider.y = this.sliderBar.height * this.currentPos / 100 + this.sliderBar.y;
            }
            else
            {
               this.buttonSlider.x = this.sliderBar.width * this.currentPos / 100 + this.sliderBar.x;
            }
         }
      }
      
      public function setSliderPosition(param1:int, param2:int, param3:int) : void
      {
         param3 = MathBase.max(param1,MathBase.min(param2,param3));
         this.currentPos = Math.ceil((param3 - param1) / ((param2 - param1) / 100));
         this.updateSliderButton();
      }
      
      public function destroy() : void
      {
         if(this.buttonDown)
         {
            this.buttonDown.removeEventListener(MouseEvent.CLICK,this.onClickButtonDown);
         }
         if(this.buttonUp)
         {
            this.buttonUp.removeEventListener(MouseEvent.CLICK,this.onClickButtonUp);
         }
         if(this.buttonSlider)
         {
            this.buttonSlider.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSliderMouseDown);
         }
         if(this.sliderBar)
         {
            this.sliderBar.removeEventListener(MouseEvent.CLICK,this.onClickSlider);
         }
         this.sliderMC.parent.addEventListener(MouseEvent.ROLL_OVER,this.onOverChat);
         this.sliderMC.parent.addEventListener(MouseEvent.ROLL_OUT,this.onOutChat);
      }
   }
}
