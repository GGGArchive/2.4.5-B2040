package com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.response
{
   public final class PBEquipmentOpenContainerResult
   {
      
      public static const OK:int = 1;
      
      public static const NO_CONTAINER_AT_SLOT:int = 2;
      
      public static const MERGING_STACKS_NOT_POSSIBLE:int = 3;
      
      public static const ITEM_AMOUNT_LIMIT_REACHED:int = 4;
       
      
      public function PBEquipmentOpenContainerResult()
      {
         super();
      }
   }
}
