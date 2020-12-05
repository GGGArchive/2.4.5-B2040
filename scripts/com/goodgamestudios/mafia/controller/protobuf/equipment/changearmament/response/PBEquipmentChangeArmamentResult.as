package com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.response
{
   public final class PBEquipmentChangeArmamentResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_SOURCE:int = 2;
      
      public static const WRONG_TARGET:int = 3;
      
      public static const SOURCE_EMPTY:int = 4;
      
      public static const TARGET_OCCUPIED:int = 5;
      
      public static const INVENTORY_FULL:int = 6;
      
      public static const ARMAMENT_LOCKED:int = 7;
       
      
      public function PBEquipmentChangeArmamentResult()
      {
         super();
      }
   }
}
