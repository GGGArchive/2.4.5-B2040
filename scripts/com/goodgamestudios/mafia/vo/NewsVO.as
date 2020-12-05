package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   
   public class NewsVO
   {
       
      
      public var listPos:int;
      
      public var msgID:int;
      
      public var msgType:MessageType;
      
      public var fromPlayerID:int;
      
      public var fromPlayerName:String;
      
      public var secondTillSend:Number;
      
      public var sendDate:String;
      
      public var listType:int;
      
      public function NewsVO()
      {
         super();
      }
   }
}
