package com.goodgamestudios.mafia.vo.clan
{
   public class ClanChatVO
   {
       
      
      public var playerID:Number;
      
      public var isWar:Boolean = false;
      
      public var date:Number;
      
      public var nameText:ChatNameText;
      
      public var msgText:ChatMsgText;
      
      public function ClanChatVO()
      {
         super();
         this.nameText = new ChatNameText();
         this.msgText = new ChatMsgText();
      }
   }
}
