package com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response
{
   public final class PBMessageReadMessagesResult
   {
      
      public static const OK:int = 1;
      
      public static const MESSAGE_ID_DOESNT_MATCH_REQUESTER:int = 2;
      
      public static const MESSAGE_ID_DOESNT_EXIST:int = 3;
       
      
      public function PBMessageReadMessagesResult()
      {
         super();
      }
   }
}
