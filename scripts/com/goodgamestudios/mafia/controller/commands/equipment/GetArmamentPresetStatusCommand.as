package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus.PBEquipmentGetArmamentPresetStatusRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus.PBEquipmentGetArmamentPresetStatusResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GetArmamentPresetStatusCommand extends BasicProtobufCommand
   {
       
      
      public function GetArmamentPresetStatusCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBEquipmentGetArmamentPresetStatusRequest = new PBEquipmentGetArmamentPresetStatusRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentGetArmamentPresetStatusResponse = param1 as PBEquipmentGetArmamentPresetStatusResponse;
         MafiaModel.userData.armamentPresetData.activeArmament = _loc2_.activeArmament;
         MafiaModel.userData.armamentPresetData.unlockCost = _loc2_.unlockCost;
         MafiaModel.userData.armamentPresetData.unlockedArmaments = _loc2_.unlockedArmaments;
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA));
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentGetArmamentPresetStatusRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentGetArmamentPresetStatusResponse;
      }
   }
}
