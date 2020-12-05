package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.controller.commands.clan.FamilyMessageCommand;
   import com.goodgamestudios.mafia.vo.clan.ClanChatVO;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class TableChatHelper extends ChatHelper
   {
      
      public static const ADMIN_MSG:int = -100;
      
      private static const MAX_MESSAGES_IN_VIEW:int = 10;
      
      private static const LEFT_MARGIN:int = 2;
       
      
      private const SLIDER_START_POSITION:int = 100;
      
      public function TableChatHelper(param1:MovieClip)
      {
         super(param1,this.SLIDER_START_POSITION);
         chatkomponent.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         chatslider.StepSize = 2;
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.onSendMsg();
         }
      }
      
      override public function onSendMsg() : void
      {
         var _loc1_:String = null;
         if(chatkomponent.txt_chatmsg.text.length > 0)
         {
            _loc1_ = TextValide.getCleanChatText(chatkomponent.txt_chatmsg.text);
            if(_loc1_.length > 0)
            {
               FamilyMessageCommand.sendCommand(_loc1_);
               chatkomponent.txt_chatmsg.text = "";
            }
         }
      }
      
      public function onAddMsg(param1:Vector.<ClanChatVO>) : void
      {
         var _loc3_:ClanChatVO = null;
         var _loc4_:TextFormat = null;
         MovieClipHelper.clearMovieClip(chatkomponent.mc_textholder);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 10066329;
         if(param1.length <= MAX_MESSAGES_IN_VIEW)
         {
            enableSliderButtons(false);
         }
         else
         {
            enableSliderButtons(true);
         }
         for each(_loc3_ in param1)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc3_.msgText.txt_msg);
            BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc3_.nameText.txt_msg);
            _loc3_.nameText.txt_msg.width = _loc3_.nameText.txt_msg.textWidth + 5;
            _loc3_.nameText.txt_msg.height = _loc3_.nameText.txt_msg.textHeight + 3;
            _loc4_ = _loc3_.msgText.txt_msg.defaultTextFormat;
            _loc4_.indent = _loc3_.nameText.txt_msg.width - LEFT_MARGIN;
            _loc4_.leftMargin = LEFT_MARGIN;
            _loc3_.msgText.txt_msg.setTextFormat(_loc4_);
            _loc3_.nameText.txt_msg.setTextFormat(_loc2_);
            _loc3_.msgText.txt_msg.width = chatkomponent.mc_mask.width;
            _loc3_.msgText.txt_msg.height = _loc3_.msgText.txt_msg.textHeight + 5;
            _loc3_.msgText.y = _loc3_.nameText.y = chatkomponent.mc_textholder.height + 2.5;
            chatkomponent.mc_textholder.addChild(_loc3_.msgText);
            chatkomponent.mc_textholder.addChild(_loc3_.nameText);
            chatHeight = chatkomponent.mc_textholder.height;
         }
         scrollToEnd();
      }
      
      override public function show() : void
      {
         chatkomponent.bg_chat.gotoAndStop(1);
         chatkomponent.btn_chat.y = -15.5;
         super.show();
      }
      
      override public function hide() : void
      {
         chatkomponent.bg_chat.gotoAndStop(2);
         chatkomponent.btn_chat.y = -11.5;
         super.hide();
      }
      
      override public function init() : void
      {
         if(BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(chatkomponent.txt_chatmsg);
         }
         else
         {
            chatkomponent.txt_chatmsg.embedFonts = false;
         }
         super.init();
      }
      
      override public function destroy() : void
      {
         chatkomponent.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         super.destroy();
      }
   }
}
