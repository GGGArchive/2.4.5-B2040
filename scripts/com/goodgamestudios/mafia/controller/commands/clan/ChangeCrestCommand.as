package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufVOTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.family.changecrest.PBFamilyChangeCrestRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.changecrest.PBFamilyChangeCrestResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.changecrest.response.PBFamilyChangeCrestResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.netease.protobuf.Message;
   
   public class ChangeCrestCommand extends BasicProtobufCommand
   {
       
      
      public function ChangeCrestCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:FamilyCrestVO) : void
      {
         var _loc2_:PBFamilyChangeCrestRequest = new PBFamilyChangeCrestRequest();
         _loc2_.crest = ProtobufVOTranslator.translateFamilyCrestToProto(param1);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyChangeCrestResponse = param1 as PBFamilyChangeCrestResponse;
         switch(_loc2_.result)
         {
            case PBFamilyChangeCrestResult.OK:
               ShowClanCommand.sendCommand();
               return true;
            case PBFamilyChangeCrestResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFamilyPurchase_copy")));
               break;
            case PBFamilyChangeCrestResult.NOT_AUTHORIZED:
            case PBFamilyChangeCrestResult.UNKNOWN_PRIMARY:
            case PBFamilyChangeCrestResult.UNKNOWN_SECONDARY:
            case PBFamilyChangeCrestResult.UNKNOWN_BANDEROLE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyChangeCrestRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyChangeCrestResponse;
      }
   }
}
