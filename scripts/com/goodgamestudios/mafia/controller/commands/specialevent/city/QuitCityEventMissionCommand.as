package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.commands.mission.ViewMissionCommand;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.quitmission.PBSpecialeventCityQuitmissionRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.quitmission.PBSpecialeventCityQuitmissionResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.quitmission.response.PBSpecialeventCityQuitmissionResult;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class QuitCityEventMissionCommand extends BasicProtobufCommand
   {
       
      
      public function QuitCityEventMissionCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityQuitmissionRequest = new PBSpecialeventCityQuitmissionRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityQuitmissionResponse = param1 as PBSpecialeventCityQuitmissionResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCityQuitmissionResult.OK:
               MafiaModel.userData.missionData.parseMissionResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaMissionEvent(MafiaMissionEvent.CHANGE_MISSION_RESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.missionData.missionResultData,FightType.Mission);
               return true;
            case PBSpecialeventCityQuitmissionResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastQuitQuest_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBSpecialeventCityQuitmissionResult.INVALID_MISSION:
               ViewMissionCommand.sendCommand();
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_PING,[]);
         }
         MafiaDialogHandler.getInstance().blockDialogs = false;
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityQuitmissionRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityQuitmissionResponse;
      }
   }
}
