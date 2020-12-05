package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipfood.PBEquipmentUnequipFoodRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipfood.PBEquipmentUnequipFoodResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipfood.response.PBEquipmentUnequipFoodResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class UnequipFoodCommand extends BasicProtobufCommand
   {
       
      
      public function UnequipFoodCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBEquipmentUnequipFoodRequest = new PBEquipmentUnequipFoodRequest();
         _loc2_.source = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentUnequipFoodResponse = param1 as PBEquipmentUnequipFoodResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentUnequipFoodResult.OK:
               return true;
            case PBEquipmentUnequipFoodResult.SOURCE_EMPTY:
            case PBEquipmentUnequipFoodResult.WRONG_SOURCE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentUnequipFoodRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentUnequipFoodResponse;
      }
   }
}
