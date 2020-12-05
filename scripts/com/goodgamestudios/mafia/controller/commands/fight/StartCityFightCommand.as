package com.goodgamestudios.mafia.controller.commands.fight
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.PBFightStartCityFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.PBFightStartCityFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.response.PBFightStartCityFightResult;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class StartCityFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartCityFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFightStartCityFightRequest = new PBFightStartCityFightRequest();
         _loc2_.districtId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartCityFightResponse = param1 as PBFightStartCityFightResponse;
         switch(_loc2_.result)
         {
            case PBFightStartCityFightResult.OK:
               MafiaModel.userData.cityQuestFightData.parseCityFightResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_CITY_FIGHT_RESULT_DATA));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.cityQuestFightData.cityBonusFightResultData,FightType.GangWar);
               return true;
            case PBFightStartCityFightResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastQuitQuest_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBFightStartCityFightResult.CITY_FIGHT_INVALID:
               break;
            case PBFightStartCityFightResult.CITY_FIGHT_UNAVAILABLE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartCityFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartCityFightResponse;
      }
   }
}
