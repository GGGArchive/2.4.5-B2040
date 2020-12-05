package com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.response
{
   public final class PBEquipmentUnequipArmamentResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_SOURCE:int = 2;
      
      public static const WRONG_TARGET:int = 3;
      
      public static const SOURCE_EMPTY:int = 4;
      
      public static const WRONG_ITEM_TYPE:int = 5;
      
      public static const ARMAMENT_LOCKED:int = 6;
      
      public static const TARGET_OCCUPIED:int = 7;
       
      
      public function PBEquipmentUnequipArmamentResult()
      {
         super();
      }
   }
}
