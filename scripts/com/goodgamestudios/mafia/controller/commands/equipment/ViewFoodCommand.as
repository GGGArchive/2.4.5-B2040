package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewfood.PBEquipmentViewFoodRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewfood.PBEquipmentViewFoodResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewFoodCommand extends BasicProtobufCommand
   {
       
      
      public function ViewFoodCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBEquipmentViewFoodRequest = new PBEquipmentViewFoodRequest();
         _loc2_.playerId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.PROTOBUF_VIEW_FOOD;
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentViewFoodResponse = param1 as PBEquipmentViewFoodResponse;
         if(_loc2_.playerId == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.parseFoodDataPB(_loc2_.items);
            return true;
         }
         MafiaModel.otherUserData.parseFoodDataPB(_loc2_.items);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentViewFoodRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentViewFoodResponse;
      }
   }
}
