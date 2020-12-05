package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.event.MafiaSliderEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ChatHelper
   {
      
      public static const ADMIN_MSG:int = -100;
       
      
      protected var chatslider:SliderHelper;
      
      protected var chatHeight:int = 0;
      
      protected var _chatkomponent:MovieClip;
      
      protected var shown:Boolean;
      
      public function ChatHelper(param1:MovieClip, param2:int = 0)
      {
         super();
         this._chatkomponent = param1;
         this.chatslider = new SliderHelper(this._chatkomponent.mc_chatslider,param2);
         this._chatkomponent.addEventListener(MouseEvent.CLICK,this.onClick);
         this._chatkomponent.mc_chatslider.addEventListener(MafiaSliderEvent.ON_SLIDING,this.onChatSliding);
         this._chatkomponent.mc_chatslider.addEventListener(MafiaSliderEvent.ARROW_UP,this.onChatSliding);
         this._chatkomponent.mc_chatslider.addEventListener(MafiaSliderEvent.ARROW_DOWN,this.onChatSliding);
         this.chatslider.StepSize = 20;
         this._chatkomponent.mc_textholder.mask = this.chatkomponent.mc_mask;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.target == this._chatkomponent.btn_chatenter)
         {
            BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
            this.onSendMsg();
         }
      }
      
      public function enableSendMsg(param1:Boolean) : void
      {
         (this._chatkomponent.btn_chatenter as MovieClip).enableButton = param1;
      }
      
      public function enableSliderButtons(param1:Boolean) : void
      {
         (this._chatkomponent.mc_chatslider.btn_up as MovieClip).enableButton = param1;
         (this._chatkomponent.mc_chatslider.btn_down as MovieClip).enableButton = param1;
         (this._chatkomponent.mc_chatslider.btn_slider as MovieClip).enableButton = param1;
      }
      
      public function onSendMsg() : void
      {
      }
      
      protected function scrollToEnd() : void
      {
         if(this.extraChatHeight > this._chatkomponent.mc_mask.height)
         {
            this._chatkomponent.mc_textholder.y = this._chatkomponent.mc_mask.y - (this.extraChatHeight - this._chatkomponent.mc_mask.height);
         }
         this.updateSlider();
      }
      
      private function onChatSliding(param1:MafiaSliderEvent) : void
      {
         if(this.extraChatHeight <= this._chatkomponent.mc_mask.height)
         {
            return;
         }
         this._chatkomponent.mc_textholder.y = this._chatkomponent.mc_mask.y - (this.extraChatHeight - this._chatkomponent.mc_mask.height) * param1.slidePos * 0.01;
      }
      
      private function updateSlider() : void
      {
         if(this.extraChatHeight < this._chatkomponent.mc_mask.height)
         {
            return;
         }
         var _loc1_:int = this._chatkomponent.mc_textholder.y - this._chatkomponent.mc_mask.y;
         var _loc2_:int = -(this.extraChatHeight - this._chatkomponent.mc_mask.height);
         var _loc3_:int = 100 - (_loc2_ - _loc1_) / _loc2_ * 100;
         this._chatkomponent.mc_chatslider.btn_slider.y = this._chatkomponent.mc_chatslider.mc_sliderbar.y + this._chatkomponent.mc_chatslider.mc_sliderbar.height * _loc3_ * 0.01;
      }
      
      protected function get extraChatHeight() : int
      {
         return this.chatHeight + 5;
      }
      
      public function show() : void
      {
         this.shown = true;
      }
      
      public function hide() : void
      {
         this.shown = false;
      }
      
      public function init() : void
      {
         this.chatHeight = 0;
         this._chatkomponent.txt_chatmsg.text = "";
         this._chatkomponent.txt_chatmsg.maxChars = 6000;
         MovieClipHelper.clearMovieClip(this._chatkomponent.mc_textholder);
         this._chatkomponent.mc_textholder.y = this._chatkomponent.mc_mask.y;
      }
      
      public function get isInFocus() : Boolean
      {
         return this.shown;
      }
      
      public function destroy() : void
      {
         this._chatkomponent.removeEventListener(MouseEvent.CLICK,this.onClick);
         this._chatkomponent.mc_chatslider.removeEventListener(MafiaSliderEvent.ON_SLIDING,this.onChatSliding);
         this._chatkomponent.mc_chatslider.removeEventListener(MafiaSliderEvent.ARROW_UP,this.onChatSliding);
         this._chatkomponent.mc_chatslider.removeEventListener(MafiaSliderEvent.ARROW_DOWN,this.onChatSliding);
         if(this.chatslider)
         {
            this.chatslider.destroy();
         }
         this.chatslider = null;
      }
      
      public function get chatkomponent() : MovieClip
      {
         return this._chatkomponent;
      }
   }
}
