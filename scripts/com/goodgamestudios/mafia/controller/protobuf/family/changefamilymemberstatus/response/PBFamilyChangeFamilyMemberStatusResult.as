package com.goodgamestudios.mafia.controller.protobuf.family.changefamilymemberstatus.response
{
   public final class PBFamilyChangeFamilyMemberStatusResult
   {
      
      public static const OK:int = 1;
      
      public static const PLAYER_HAS_NO_FAMILY:int = 2;
      
      public static const PLAYER_IS_NOT_MEMBER_OF_FAMILY:int = 3;
      
      public static const FAMILY_RANK_TO_LOW:int = 4;
       
      
      public function PBFamilyChangeFamilyMemberStatusResult()
      {
         super();
      }
   }
}
