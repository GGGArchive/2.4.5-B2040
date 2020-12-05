package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockarmament.PBEquipmentUnlockArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockarmament.PBEquipmentUnlockArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unlockarmament.response.PBEquipmentUnlockArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class UnlockArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function UnlockArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBEquipmentUnlockArmamentRequest = new PBEquipmentUnlockArmamentRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentUnlockArmamentResponse = param1 as PBEquipmentUnlockArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentUnlockArmamentResult.OK:
               controller.soundController.playSoundEffect(MafiaSoundController.SND_SOLD);
               return true;
            case PBEquipmentUnlockArmamentResult.NOT_ENOUGH_GOLD:
               MafiaLayoutManager.getInstance().showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForExpandArmament_copy"),BasicController.getInstance().onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBEquipmentUnlockArmamentResult.MAX_SIZE_REACHED:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentUnlockArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentUnlockArmamentResponse;
      }
   }
}
