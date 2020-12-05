package com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.response
{
   public final class PBEquipmentEquipArmamentResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_SOURCE:int = 2;
      
      public static const WRONG_TARGET:int = 4;
      
      public static const SOURCE_EMPTY:int = 5;
      
      public static const SOURCE_NOT_ENOUGH:int = 6;
      
      public static const WRONG_ITEM_TYPE:int = 7;
      
      public static const INVENTORY_FULL:int = 8;
      
      public static const ARMAMENT_LOCKED:int = 9;
       
      
      public function PBEquipmentEquipArmamentResult()
      {
         super();
      }
   }
}
