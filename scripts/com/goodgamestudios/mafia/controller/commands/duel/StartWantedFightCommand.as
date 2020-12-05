package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startwantedfight.PBFightStartWantedFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startwantedfight.PBFightStartWantedFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startwantedfight.response.PBFightStartWantedFightResult;
   import com.goodgamestudios.mafia.event.model.MafiaWantedEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class StartWantedFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartWantedFightCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFightStartWantedFightRequest = new PBFightStartWantedFightRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartWantedFightResponse = param1 as PBFightStartWantedFightResponse;
         switch(_loc2_.result)
         {
            case PBFightStartWantedFightResult.OK:
               MafiaDialogHandler.getInstance().blockDialogs = true;
               MafiaModel.userData.duelData.wantedData.parseWantedResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaWantedEvent(MafiaWantedEvent.CHANGE_WANTEDRESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.duelData.wantedData.wantedResultData,FightType.Wanted);
               return true;
            case PBFightStartWantedFightResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForWanted_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBFightStartWantedFightResult.NOT_ENOUGH_LEVEL:
               trace("Error in " + Object(this).constructor + ": Level not high enough");
         }
         MafiaDialogHandler.getInstance().blockDialogs = false;
         BasicController.getInstance().dispatchEvent(new MafiaWantedEvent(MafiaWantedEvent.WANTED_REJECTED));
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartWantedFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartWantedFightResponse;
      }
   }
}
