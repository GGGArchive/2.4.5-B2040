package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.setactivearmament.PBEquipmentSetActiveArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.setactivearmament.PBEquipmentSetActiveArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.setactivearmament.response.PBEquipmentSetActiveArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SetActiveArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function SetActiveArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint) : void
      {
         var _loc2_:PBEquipmentSetActiveArmamentRequest = new PBEquipmentSetActiveArmamentRequest();
         _loc2_.armamentNumber = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentSetActiveArmamentResponse = param1 as PBEquipmentSetActiveArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentSetActiveArmamentResult.OK:
               return true;
            case PBEquipmentSetActiveArmamentResult.ARMAMENT_ALREADY_ACTIVE:
               break;
            case PBEquipmentSetActiveArmamentResult.ARMAMENT_LOCKED:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentSetActiveArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentSetActiveArmamentResponse;
      }
   }
}
