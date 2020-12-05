package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewGearCommand extends BasicProtobufCommand
   {
       
      
      public function ViewGearCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBEquipmentViewGearRequest = new PBEquipmentViewGearRequest();
         _loc2_.playerId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentViewGearResponse = param1 as PBEquipmentViewGearResponse;
         if(_loc2_.playerId == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.parseGearDataPB(_loc2_);
            return true;
         }
         if(_loc2_.playerId != MafiaModel.userData.playerID)
         {
            MafiaModel.otherUserData.parseGearDataPB(_loc2_);
            return true;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentViewGearRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentViewGearResponse;
      }
   }
}
