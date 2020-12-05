package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSurvivalController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.PBFightStartSurvivalFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.PBFightStartSurvivalFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.response.PBFightStartSurvivalFightResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class StartSurvivalFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartSurvivalFightCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFightStartSurvivalFightRequest = new PBFightStartSurvivalFightRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartSurvivalFightResponse = param1 as PBFightStartSurvivalFightResponse;
         switch(_loc2_.result)
         {
            case PBFightStartSurvivalFightResult.OK:
               MafiaModel.userData.duelData.survivalData.parseSurvivalResultData(_loc2_);
               MafiaSurvivalController.getInstance().startMultiFight(MafiaModel.userData.duelData.survivalData);
               return true;
            case PBFightStartSurvivalFightResult.COOLDOWN_ACTIVE:
               layoutManager.state = Constants_LayoutStates.STATE_SURVIVAL;
               break;
            case PBFightStartSurvivalFightResult.NOT_ENOUGH_ENERGY:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForWanted_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
         MafiaDialogHandler.getInstance().blockDialogs = false;
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartSurvivalFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartSurvivalFightResponse;
      }
   }
}
