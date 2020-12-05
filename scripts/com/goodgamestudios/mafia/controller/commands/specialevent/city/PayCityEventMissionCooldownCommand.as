package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.paycityeventmissioncooldown.PBSpecialeventCityPayCityEventMissionCooldownRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.paycityeventmissioncooldown.PBSpecialeventCityPayCityEventMissionCooldownResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.paycityeventmissioncooldown.response.PBSpecialeventCityPayCityEventMissionCooldownResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   import com.netease.protobuf.Message;
   
   public class PayCityEventMissionCooldownCommand extends BasicProtobufCommand
   {
       
      
      public function PayCityEventMissionCooldownCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityPayCityEventMissionCooldownRequest = new PBSpecialeventCityPayCityEventMissionCooldownRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:MafiaMissionScreen = null;
         var _loc2_:PBSpecialeventCityPayCityEventMissionCooldownResponse = param1 as PBSpecialeventCityPayCityEventMissionCooldownResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCityPayCityEventMissionCooldownResult.OK:
               MafiaModel.specialEvent.sicilianEvent.missionCooldown = 0;
               layoutManager.state = Constants_LayoutStates.STATE_MISSION;
               if(MafiaModel.userData.missionData.missions.length > 3)
               {
                  _loc3_ = layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen;
                  _loc3_.openSicilianMissionPanel(MafiaModel.userData.missionData.missions[3]);
               }
               break;
            case PBSpecialeventCityPayCityEventMissionCooldownResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastQuitQuest_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBSpecialeventCityPayCityEventMissionCooldownResult.INVALID_EVENT_STATE:
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityPayCityEventMissionCooldownRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityPayCityEventMissionCooldownResponse;
      }
   }
}
