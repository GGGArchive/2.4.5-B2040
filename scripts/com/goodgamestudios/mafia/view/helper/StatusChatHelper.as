package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.vo.clan.ClanChatVO;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   
   public class StatusChatHelper extends ChatHelper
   {
      
      public static const ADMIN_MSG:int = -100;
       
      
      public function StatusChatHelper(param1:MovieClip)
      {
         super(param1);
         chatslider.StepSize = 2;
      }
      
      public function onAddMsg(param1:Vector.<ClanChatVO>) : void
      {
         var _loc2_:ClanChatVO = null;
         var _loc3_:TextFormat = null;
         MovieClipHelper.clearMovieClip(_chatkomponent.mc_textholder);
         for each(_loc2_ in param1)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc2_.msgText.txt_msg);
            BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc2_.nameText.txt_msg);
            _loc2_.nameText.txt_msg.width = _loc2_.nameText.txt_msg.textWidth + 5;
            _loc2_.nameText.txt_msg.height = _loc2_.nameText.txt_msg.textHeight + 3;
            _loc3_ = _loc2_.msgText.txt_msg.defaultTextFormat;
            _loc3_.indent = _loc2_.nameText.txt_msg.width;
            _loc2_.msgText.txt_msg.setTextFormat(_loc3_);
            _loc2_.msgText.txt_msg.width = _chatkomponent.mc_mask.width;
            _loc2_.msgText.txt_msg.height = _loc2_.msgText.txt_msg.textHeight + 5;
            _loc2_.msgText.y = _loc2_.nameText.y = _chatkomponent.mc_textholder.height + 2.5;
            _chatkomponent.mc_textholder.addChild(_loc2_.msgText);
            _chatkomponent.mc_textholder.addChild(_loc2_.nameText);
            chatHeight = _chatkomponent.mc_textholder.height;
         }
         scrollToEnd();
      }
      
      override public function show() : void
      {
         _chatkomponent.bg_status.gotoAndStop(1);
         _chatkomponent.btn_status.y = -15.5;
         super.show();
      }
      
      override public function hide() : void
      {
         _chatkomponent.bg_status.gotoAndStop(2);
         _chatkomponent.btn_status.y = -11.5;
         super.hide();
      }
      
      override public function init() : void
      {
         _chatkomponent.btn_chatenter.visible = false;
         _chatkomponent.txt_chatmsg.visible = false;
         _chatkomponent.input_BG.visible = false;
         super.init();
      }
   }
}
