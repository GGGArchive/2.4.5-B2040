package com.goodgamestudios.mafia.controller.commands.specialevent.luckydevil
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.buycards.PBSpecialeventLuckydevilBuyCardsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.buycards.PBSpecialeventLuckydevilBuyCardsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.buycards.response.PBSpecialeventLuckydevilBuyCardsResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class BuyCardsCommand extends BasicProtobufCommand
   {
       
      
      public function BuyCardsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventLuckydevilBuyCardsRequest = new PBSpecialeventLuckydevilBuyCardsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:BasicProperties = null;
         var _loc2_:PBSpecialeventLuckydevilBuyCardsResponse = param1 as PBSpecialeventLuckydevilBuyCardsResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventLuckydevilBuyCardsResult.OK:
               MafiaModel.specialEvent.luckyDevilEvent.hasCards = true;
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.LUCKY_DEVIL_CARDS_BOUGHT,[]));
               break;
            case PBSpecialeventLuckydevilBuyCardsResult.NOT_ENOUGH_GOLD:
               MafiaModel.specialEvent.luckyDevilEvent.hasCards = false;
               _loc3_ = new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("event_luckydevil_copy_10"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no"));
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,_loc3_);
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.LUCKY_DEVIL_CARDS_BOUGHT,[true]));
               break;
            case PBSpecialeventLuckydevilBuyCardsResult.CARDS_ALREADY_BOUGHT:
            case PBSpecialeventLuckydevilBuyCardsResult.EVENT_NOT_ACTIVE:
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventLuckydevilBuyCardsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventLuckydevilBuyCardsResponse;
      }
   }
}
