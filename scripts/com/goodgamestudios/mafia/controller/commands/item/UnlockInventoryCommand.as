package com.goodgamestudios.mafia.controller.commands.item
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockinventory.PBEquipmentUnlockInventoryRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockinventory.PBEquipmentUnlockInventoryResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockinventory.response.PBEquipmentUnlockInventoryResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class UnlockInventoryCommand extends BasicProtobufCommand
   {
       
      
      public function UnlockInventoryCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBEquipmentUnlockInventoryRequest = new PBEquipmentUnlockInventoryRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentUnlockInventoryResponse = param1 as PBEquipmentUnlockInventoryResponse;
         switch(_loc2_)
         {
            case PBEquipmentUnlockInventoryResult.OK:
               return true;
            case PBEquipmentUnlockInventoryResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBuyInventory_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentUnlockInventoryRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentUnlockInventoryResponse;
      }
   }
}
