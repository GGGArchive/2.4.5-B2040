package com.goodgamestudios.mafia.controller.commands.mission
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.quitmission.PBMissionQuitMissionRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.quitmission.PBMissionQuitMissionResponse;
   import com.goodgamestudios.mafia.controller.protobuf.mission.quitmission.response.PBMissionQuitMissionResult;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class QuitMissionCommand extends BasicProtobufCommand
   {
       
      
      public function QuitMissionCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMissionQuitMissionRequest = new PBMissionQuitMissionRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionQuitMissionResponse = param1 as PBMissionQuitMissionResponse;
         switch(_loc2_.result)
         {
            case PBMissionQuitMissionResult.OK:
               MafiaModel.userData.missionData.parseMissionResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaMissionEvent(MafiaMissionEvent.CHANGE_MISSION_RESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.missionData.missionResultData,FightType.Mission);
               return true;
            case PBMissionQuitMissionResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastQuitQuest_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBMissionQuitMissionResult.INVALID_MISSION:
               ViewMissionCommand.sendCommand();
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_PING,[]);
         }
         MafiaDialogHandler.getInstance().blockDialogs = false;
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionQuitMissionRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionQuitMissionResponse;
      }
   }
}
