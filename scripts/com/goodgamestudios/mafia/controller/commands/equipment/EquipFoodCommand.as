package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipfood.PBEquipmentEquipFoodRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipfood.PBEquipmentEquipFoodResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipfood.response.PBEquipmentEquipFoodResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class EquipFoodCommand extends BasicProtobufCommand
   {
       
      
      public function EquipFoodCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int) : void
      {
         var _loc3_:PBEquipmentEquipFoodRequest = new PBEquipmentEquipFoodRequest();
         _loc3_.source = param1;
         _loc3_.target = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentEquipFoodResponse = param1 as PBEquipmentEquipFoodResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentEquipFoodResult.OK:
               return true;
            case PBEquipmentEquipFoodResult.FOOD_EQUIPED:
            case PBEquipmentEquipFoodResult.SOURCE_EMPTY:
            case PBEquipmentEquipFoodResult.TARGET_OCCUPIED:
            case PBEquipmentEquipFoodResult.WRONG_ITEM_TYPE:
            case PBEquipmentEquipFoodResult.WRONG_SOURCE:
            case PBEquipmentEquipFoodResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentEquipFoodRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentEquipFoodResponse;
      }
   }
}
