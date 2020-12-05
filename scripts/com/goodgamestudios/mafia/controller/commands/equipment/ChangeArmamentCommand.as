package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.PBEquipmentChangeArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.PBEquipmentChangeArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.response.PBEquipmentChangeArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ChangeArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function ChangeArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PBEquipmentChangeArmamentRequest = new PBEquipmentChangeArmamentRequest();
         _loc5_.sourceX = param1;
         _loc5_.sourceY = param2;
         _loc5_.targetX = param3;
         _loc5_.targetY = param4;
         _loc5_.armamentNumber = MafiaModel.userData.armamentPresetData.activeArmament;
         ProtobufController.getInstance().sendRequest(_loc5_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:uint = 0;
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentChangeArmamentResponse = param1 as PBEquipmentChangeArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentChangeArmamentResult.OK:
               if(_loc2_.hasInventorySlot)
               {
                  _loc3_ = !!_loc2_.hasSwappedAmount?uint(_loc2_.swappedAmount):uint(0);
                  MafiaModel.userData.armament.startDragAfterSwap(_loc2_.inventorySlot,_loc3_);
               }
               return true;
            case PBEquipmentChangeArmamentResult.INVENTORY_FULL:
            case PBEquipmentChangeArmamentResult.SOURCE_EMPTY:
            case PBEquipmentChangeArmamentResult.TARGET_OCCUPIED:
            case PBEquipmentChangeArmamentResult.WRONG_SOURCE:
            case PBEquipmentChangeArmamentResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentChangeArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentChangeArmamentResponse;
      }
   }
}
