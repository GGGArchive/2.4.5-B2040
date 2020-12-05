package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipgear.PBEquipmentUnequipGearRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipgear.PBEquipmentUnequipGearResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequipgear.response.PBEquipmentUnequipGearResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class UnequipGearCommand extends BasicProtobufCommand
   {
       
      
      public function UnequipGearCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int) : void
      {
         var _loc3_:PBEquipmentUnequipGearRequest = new PBEquipmentUnequipGearRequest();
         _loc3_.source = param1;
         _loc3_.target = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentUnequipGearResponse = param1 as PBEquipmentUnequipGearResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentUnequipGearResult.OK:
               return true;
            case PBEquipmentUnequipGearResult.SOURCE_EMPTY:
            case PBEquipmentUnequipGearResult.WRONG_ITEM_TYPE:
            case PBEquipmentUnequipGearResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentUnequipGearRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentUnequipGearResponse;
      }
   }
}
