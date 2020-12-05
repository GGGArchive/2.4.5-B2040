package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FamilyBoosterQuality;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.PBFamilyUpdatefamilyboosterRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.PBFamilyUpdatefamilyboosterResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.response.PBFamilyUpdatefamilyboosterResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class UpdateClanBonusCommand extends BasicProtobufCommand
   {
       
      
      public function UpdateClanBonusCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:FamilyBoosterQuality, param2:FamilyBoosterQuality, param3:Boolean = false) : void
      {
         var _loc4_:PBFamilyUpdatefamilyboosterRequest = new PBFamilyUpdatefamilyboosterRequest();
         if(param1 != FamilyBoosterQuality.None)
         {
            _loc4_.cashBonus = ProtobufEnumTranslator.translateFamilyBoosterQualityToProto(param1);
         }
         if(param2 != FamilyBoosterQuality.None)
         {
            _loc4_.xpBonus = ProtobufEnumTranslator.translateFamilyBoosterQualityToProto(param2);
         }
         if(param3)
         {
            _loc4_.upgradeMaxMembers = param3;
         }
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyUpdatefamilyboosterResponse = param1 as PBFamilyUpdatefamilyboosterResponse;
         switch(_loc2_.result)
         {
            case PBFamilyUpdatefamilyboosterResult.OK:
               ShowClanCommand.sendCommand();
               return true;
            case PBFamilyUpdatefamilyboosterResult.CANNOT_BUY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFamilyPurchase_copy")));
               break;
            case PBFamilyUpdatefamilyboosterResult.FAMILY_NOT_MEMBER:
               break;
            case PBFamilyUpdatefamilyboosterResult.FAMILY_RANK_TO_LOW:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyUpdatefamilyboosterRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyUpdatefamilyboosterResponse;
      }
   }
}
