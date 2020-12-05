package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.participate.PBFamilyWarParticipateRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.participate.PBFamilyWarParticipateResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.war.participate.response.PBFamilyWarParticipateResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class ParticipateClanWarCommand extends BasicProtobufCommand
   {
       
      
      public function ParticipateClanWarCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:Boolean) : void
      {
         var _loc2_:PBFamilyWarParticipateRequest = new PBFamilyWarParticipateRequest();
         _loc2_.attack = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyWarParticipateResponse = param1 as PBFamilyWarParticipateResponse;
         switch(_loc2_.result)
         {
            case PBFamilyWarParticipateResult.OK:
               ShowClanCommand.sendCommand();
               return true;
            case PBFamilyWarParticipateResult.NOT_LONG_ENOUGH_IN_FAMILY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_information"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_9")));
               break;
            case PBFamilyWarParticipateResult.NO_ATTACK:
            case PBFamilyWarParticipateResult.NO_DEFENSE:
            case PBFamilyWarParticipateResult.NOT_A_FAMILY_MEMBER:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyWarParticipateRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyWarParticipateResponse;
      }
   }
}
