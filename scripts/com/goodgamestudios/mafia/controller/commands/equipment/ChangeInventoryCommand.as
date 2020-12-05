package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changeinventory.PBEquipmentChangeInventoryRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changeinventory.PBEquipmentChangeInventoryResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changeinventory.response.PBEquipmentChangeInventoryResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ChangeInventoryCommand extends BasicProtobufCommand
   {
       
      
      public function ChangeInventoryCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int) : void
      {
         var _loc3_:PBEquipmentChangeInventoryRequest = new PBEquipmentChangeInventoryRequest();
         _loc3_.source = param1;
         _loc3_.target = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentChangeInventoryResponse = param1 as PBEquipmentChangeInventoryResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentChangeInventoryResult.OK:
               return true;
            case PBEquipmentChangeInventoryResult.SOURCE_EMPTY:
            case PBEquipmentChangeInventoryResult.TARGET_OCCUPIED:
            case PBEquipmentChangeInventoryResult.WRONG_SOURCE:
            case PBEquipmentChangeInventoryResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentChangeInventoryRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentChangeInventoryResponse;
      }
   }
}
