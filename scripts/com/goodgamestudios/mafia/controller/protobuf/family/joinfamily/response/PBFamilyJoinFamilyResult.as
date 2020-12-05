package com.goodgamestudios.mafia.controller.protobuf.family.joinfamily.response
{
   public final class PBFamilyJoinFamilyResult
   {
      
      public static const OK:int = 1;
      
      public static const ALREADY_IN_FAMILY:int = 2;
      
      public static const INVALID_HASH:int = 3;
      
      public static const INVALID_MSG_ID:int = 4;
      
      public static const INVALID_FAMILY_ID:int = 5;
      
      public static const CANNOT_JOIN_FAMILY:int = 6;
       
      
      public function PBFamilyJoinFamilyResult()
      {
         super();
      }
   }
}
