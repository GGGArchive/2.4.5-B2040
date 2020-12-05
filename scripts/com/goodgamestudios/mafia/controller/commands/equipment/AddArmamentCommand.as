package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.addarmament.PBEquipmentAddArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.addarmament.PBEquipmentAddArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.addarmament.response.PBEquipmentAddArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.vo.ArmamentGridVO;
   import com.netease.protobuf.Message;
   
   public class AddArmamentCommand extends BasicProtobufCommand
   {
       
      
      private var grid:ArmamentGridVO;
      
      public function AddArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBEquipmentAddArmamentRequest = new PBEquipmentAddArmamentRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentAddArmamentResponse = param1 as PBEquipmentAddArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentAddArmamentResult.OK:
               controller.soundController.playSoundEffect(MafiaSoundController.SND_SOLD);
               return true;
            case PBEquipmentAddArmamentResult.NOT_ENOUGH_GOLD:
               MafiaLayoutManager.getInstance().showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForExpandArmament_copy"),BasicController.getInstance().onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentAddArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentAddArmamentResponse;
      }
   }
}
