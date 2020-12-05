package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventfight.PBSpecialeventCityStartCityEventFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventfight.PBSpecialeventCityStartCityEventFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventfight.response.PBSpecialeventCityStartCityEventFightResult;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class StartCityEventFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartCityEventFightCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityStartCityEventFightRequest = new PBSpecialeventCityStartCityEventFightRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityStartCityEventFightResponse = param1 as PBSpecialeventCityStartCityEventFightResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCityStartCityEventFightResult.OK:
               MafiaModel.specialEvent.sicilianEvent.parseGangwarResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_RESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.specialEvent.sicilianEvent.gangwarFightResultData,FightType.GangWar);
               return true;
            case PBSpecialeventCityStartCityEventFightResult.GANG_WAR_COMPLETED:
               trace("GANG_WAR_COMPLETED");
               break;
            case PBSpecialeventCityStartCityEventFightResult.GANG_WAR_INVALID:
               trace("GANG_WAR_INVALID");
               break;
            case PBSpecialeventCityStartCityEventFightResult.GANG_WAR_LOCKED:
               trace("GANG_WAR_LOCKED");
               break;
            case PBSpecialeventCityStartCityEventFightResult.INVALID_EVENT_STATE:
               trace("INVALID_EVENT_STATE");
               break;
            case PBSpecialeventCityStartCityEventFightResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForWanted_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               return false;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityStartCityEventFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityStartCityEventFightResponse;
      }
   }
}
