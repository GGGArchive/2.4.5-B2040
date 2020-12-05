package com.goodgamestudios.mafia.controller.protobuf.family.createfamily.response
{
   public final class PBFamilyCreateFamilyResult
   {
      
      public static const OK:int = 1;
      
      public static const NAME_INVALID:int = 2;
      
      public static const NAME_TOO_LONG:int = 3;
      
      public static const NAME_TOO_SHORT:int = 4;
      
      public static const NAME_ALREADY_EXISTS:int = 5;
      
      public static const NOT_ENOUGH_GOLD:int = 6;
      
      public static const ALREADY_IN_FAMILY:int = 7;
       
      
      public function PBFamilyCreateFamilyResult()
      {
         super();
      }
   }
}
