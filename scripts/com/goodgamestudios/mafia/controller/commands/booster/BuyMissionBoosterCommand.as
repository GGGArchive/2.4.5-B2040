package com.goodgamestudios.mafia.controller.commands.booster
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.buymissionbooster.PBMissionBoosterBuyMissionBoosterRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.buymissionbooster.PBMissionBoosterBuyMissionBoosterResponse;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.buymissionbooster.response.PBMissionBoosterBuyMissionBoosterResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class BuyMissionBoosterCommand extends BasicProtobufCommand
   {
       
      
      public function BuyMissionBoosterCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBMissionBoosterBuyMissionBoosterRequest = new PBMissionBoosterBuyMissionBoosterRequest();
         _loc2_.boosterID = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionBoosterBuyMissionBoosterResponse = param1 as PBMissionBoosterBuyMissionBoosterResponse;
         switch(_loc2_.result)
         {
            case PBMissionBoosterBuyMissionBoosterResult.OK:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               return true;
            case PBMissionBoosterBuyMissionBoosterResult.INVALID_PARAMETER_VALUE:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBooster_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionBoosterBuyMissionBoosterRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionBoosterBuyMissionBoosterResponse;
      }
   }
}
