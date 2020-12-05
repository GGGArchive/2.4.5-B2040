package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.initiate.PBFamilyWarInitiateRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.initiate.PBFamilyWarInitiateResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.initiate.response.PBFamilyWarInitiateResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class InitiateClanWarCommand extends BasicProtobufCommand
   {
       
      
      public function InitiateClanWarCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFamilyWarInitiateRequest = new PBFamilyWarInitiateRequest();
         _loc2_.targetId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyWarInitiateResponse = param1 as PBFamilyWarInitiateResponse;
         switch(_loc2_.result)
         {
            case PBFamilyWarInitiateResult.OK:
               ShowClanCommand.sendCommand();
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
               return true;
            case PBFamilyWarInitiateResult.GLORY_DIFFERNCE_TO_BIG:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_information"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_10")));
               break;
            case PBFamilyWarInitiateResult.NOT_LONG_ENOUGH_IN_FAMILY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_information"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_9")));
               break;
            case PBFamilyWarInitiateResult.FAMILY_ALREADY_IN_WAR:
            case PBFamilyWarInitiateResult.INVALID_TARGET:
            case PBFamilyWarInitiateResult.NOT_A_FAMILY_MEMBER:
            case PBFamilyWarInitiateResult.RANK_TO_LOW:
            case PBFamilyWarInitiateResult.TARGET_ALREADY_IN_WAR:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyWarInitiateRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyWarInitiateResponse;
      }
   }
}
