package com.goodgamestudios.mafia.controller.protobuf.family.war.initiate.response
{
   public final class PBFamilyWarInitiateResult
   {
      
      public static const OK:int = 1;
      
      public static const NOT_A_FAMILY_MEMBER:int = 2;
      
      public static const NOT_LONG_ENOUGH_IN_FAMILY:int = 3;
      
      public static const RANK_TO_LOW:int = 4;
      
      public static const INVALID_TARGET:int = 5;
      
      public static const GLORY_DIFFERNCE_TO_BIG:int = 6;
      
      public static const FAMILY_ALREADY_IN_WAR:int = 7;
      
      public static const TARGET_ALREADY_IN_WAR:int = 8;
       
      
      public function PBFamilyWarInitiateResult()
      {
         super();
      }
   }
}
