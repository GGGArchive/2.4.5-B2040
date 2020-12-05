package com.goodgamestudios.mafia.controller.commands.specialevent.luckydevil
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.turncard.PBSpecialeventLuckydevilTurnCardRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.turncard.PBSpecialeventLuckydevilTurnCardResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.turncard.response.PBSpecialeventLuckydevilTurnCardResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.netease.protobuf.Message;
   
   public class TurnCardCommand extends BasicProtobufCommand
   {
       
      
      public function TurnCardCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventLuckydevilTurnCardRequest = new PBSpecialeventLuckydevilTurnCardRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventLuckydevilTurnCardResponse = null;
         var _loc3_:ItemVO = null;
         var _loc4_:BasicStandardOkDialogProperties = null;
         _loc2_ = param1 as PBSpecialeventLuckydevilTurnCardResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventLuckydevilTurnCardResult.OK:
               _loc3_ = MafiaItemData.parseItem(_loc2_.item,ItemLocation.None,0);
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.LUCKY_DEVIL_ITEM_RECEIVED,[_loc3_]));
               MafiaModel.specialEvent.luckyDevilEvent.hasCards = false;
               break;
            case PBSpecialeventLuckydevilTurnCardResult.INVENTORY_FULL:
               _loc4_ = new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_4"));
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,_loc4_);
               break;
            case PBSpecialeventLuckydevilTurnCardResult.NO_CARDS_AVAILABLE:
            case PBSpecialeventLuckydevilTurnCardResult.EVENT_NOT_ACTIVE:
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventLuckydevilTurnCardRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventLuckydevilTurnCardResponse;
      }
   }
}
