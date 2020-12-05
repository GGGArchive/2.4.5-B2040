package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory.PBEquipmentViewInventoryRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory.PBEquipmentViewInventoryResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.netease.protobuf.Message;
   
   public class ViewInventoryCommand extends BasicProtobufCommand
   {
       
      
      public function ViewInventoryCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBEquipmentViewInventoryRequest = new PBEquipmentViewInventoryRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentViewInventoryResponse = param1 as PBEquipmentViewInventoryResponse;
         MafiaLayoutManager.getInstance().dragManager.stopDragging();
         if(_loc2_.items)
         {
            MafiaModel.userData.inventory.parseInventoryDataPB(_loc2_);
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_INVENTORY_DATA));
            return true;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentViewInventoryRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentViewInventoryResponse;
      }
   }
}
