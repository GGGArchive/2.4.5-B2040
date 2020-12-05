package com.goodgamestudios.mafia.controller.protobuf.family.inviteplayertofamily.response
{
   public final class PBFamilyInvitePlayerToFamilyResult
   {
      
      public static const OK:int = 1;
      
      public static const INVITING_PLAYER_NOT_IN_FAMILY:int = 2;
      
      public static const FAMILY_FULL:int = 3;
      
      public static const PLAYER_ALREADY_IN_FAMILY:int = 4;
      
      public static const RANK_TOO_LOW:int = 5;
       
      
      public function PBFamilyInvitePlayerToFamilyResult()
      {
         super();
      }
   }
}
