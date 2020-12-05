package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipgear.PBEquipmentEquipGearRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipgear.PBEquipmentEquipGearResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equipgear.response.PBEquipmentEquipGearResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class EquipGearCommand extends BasicProtobufCommand
   {
       
      
      public function EquipGearCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBEquipmentEquipGearRequest = new PBEquipmentEquipGearRequest();
         _loc2_.source = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentEquipGearResponse = param1 as PBEquipmentEquipGearResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentEquipGearResult.OK:
               return true;
            case PBEquipmentEquipGearResult.SOURCE_EMPTY:
            case PBEquipmentEquipGearResult.WRONG_ITEM_TYPE:
            case PBEquipmentEquipGearResult.WRONG_SOURCE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentEquipGearRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentEquipGearResponse;
      }
   }
}
