package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.PBEquipmentViewArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.PBEquipmentViewArmamentResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.netease.protobuf.Message;
   
   public class ViewArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function ViewArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint) : void
      {
         var _loc2_:PBEquipmentViewArmamentRequest = new PBEquipmentViewArmamentRequest();
         if(param1 == MafiaModel.userData.playerID)
         {
            _loc2_.armamentNumber = MafiaModel.userData.armamentPresetData.activeArmament;
         }
         else
         {
            _loc2_.playerId = param1;
         }
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentViewArmamentResponse = param1 as PBEquipmentViewArmamentResponse;
         MafiaLayoutManager.getInstance().dragManager.stopDragging();
         if(_loc2_.playerId == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.armament.parseData(_loc2_);
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_DATA));
         }
         else if(_loc2_.playerId != MafiaModel.userData.playerID)
         {
            MafiaModel.otherUserData.armament.parseData(_loc2_);
            if(_loc2_.playerId == MafiaModel.userData.preCombatData.opponentId)
            {
               MafiaModel.userData.preCombatData.opponentArmament = MafiaModel.otherUserData.armament;
            }
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_ARMAMENT_DATA));
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentViewArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentViewArmamentResponse;
      }
   }
}
