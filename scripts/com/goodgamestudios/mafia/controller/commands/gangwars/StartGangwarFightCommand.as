package com.goodgamestudios.mafia.controller.commands.gangwars
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startgangwar.PBFightStartgangwarRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startgangwar.PBFightStartgangwarResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startgangwar.response.PBFightStartgangwarResult;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class StartGangwarFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartGangwarFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFightStartgangwarRequest = new PBFightStartgangwarRequest();
         _loc2_.gangWarId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartgangwarResponse = param1 as PBFightStartgangwarResponse;
         switch(_loc2_.result)
         {
            case PBFightStartgangwarResult.OK:
               MafiaModel.userData.gangwarData.parseGangwarResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_RESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.gangwarData.gangwarResultData,FightType.GangWar);
               return true;
            case PBFightStartgangwarResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForWanted_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               return false;
            default:
               trace("SDFCommand error " + _loc2_.result);
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartgangwarRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartgangwarResponse;
      }
   }
}
