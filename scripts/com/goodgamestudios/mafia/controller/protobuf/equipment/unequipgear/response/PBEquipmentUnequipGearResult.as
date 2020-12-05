package com.goodgamestudios.mafia.controller.protobuf.equipment.unequipgear.response
{
   public final class PBEquipmentUnequipGearResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_TARGET:int = 2;
      
      public static const SOURCE_EMPTY:int = 3;
      
      public static const WRONG_ITEM_TYPE:int = 4;
       
      
      public function PBEquipmentUnequipGearResult()
      {
         super();
      }
   }
}
