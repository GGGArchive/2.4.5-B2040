package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   
   public class MafiaReadMsgData
   {
       
      
      public var readMsgType:MessageType;
      
      public var readMsgText:String;
      
      public var readMsgSender:String;
      
      public var readMsgSenderId:int;
      
      public var doppler_count:int;
      
      public var receiver:String = "";
      
      public function MafiaReadMsgData()
      {
         super();
      }
   }
}
