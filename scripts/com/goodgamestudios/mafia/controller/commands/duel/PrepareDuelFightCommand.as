package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.PBFightPrepareDuelFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.PBFightPrepareDuelFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.response.PBFightPrepareDuelFightResult;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class PrepareDuelFightCommand extends BasicProtobufCommand
   {
       
      
      public function PrepareDuelFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBFightPrepareDuelFightRequest = new PBFightPrepareDuelFightRequest();
         _loc2_.opponentName = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightPrepareDuelFightResponse = null;
         _loc2_ = param1 as PBFightPrepareDuelFightResponse;
         switch(_loc2_.result)
         {
            case PBFightPrepareDuelFightResult.OK:
               MafiaModel.userData.duelData.pvpData.nextFreeDuelFightTime = 0;
               MafiaModel.userData.preCombatData.opponentId = _loc2_.opponentId;
               MafiaModel.userData.preCombatData.opponentData = null;
               MafiaModel.userData.preCombatData.opponentArmament = null;
               ViewArmamentCommand.sendCommand(_loc2_.opponentId);
               PlayerProfileCommand.sendCommand(_loc2_.opponentId,true);
               layoutManager.state = Constants_LayoutStates.STATE_DUEL_PREPARE;
               return true;
            case PBFightPrepareDuelFightResult.NOT_ENOUGH_GOLD:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastDuel_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBFightPrepareDuelFightResult.PLAYER_NOT_EXISTS:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_3",[MafiaModel.userData.duelData.pvpData.lastDuelEnemy])));
               break;
            case PBFightPrepareDuelFightResult.MAX_ATTACK_COUNT_REACHED:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_toomanyattacks",[MafiaModel.userData.duelData.pvpData.lastDuelEnemy,_loc2_.maxAttacks])));
               break;
            case PBFightPrepareDuelFightResult.SELF_ATTACK:
               MafiaDialogHandler.getInstance().blockDialogs = false;
         }
         BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.DUEL_REJECTED));
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightPrepareDuelFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightPrepareDuelFightResponse;
      }
   }
}
