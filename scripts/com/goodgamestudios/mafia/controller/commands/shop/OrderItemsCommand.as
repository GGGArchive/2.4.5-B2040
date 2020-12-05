package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.shop.orderitems.PBShopOrderItemsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.orderitems.PBShopOrderItemsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.shop.orderitems.response.PBShopOrderItemsResult;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class OrderItemsCommand extends BasicProtobufCommand
   {
       
      
      public function OrderItemsCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:ItemLocation) : void
      {
         var _loc2_:PBShopOrderItemsRequest = new PBShopOrderItemsRequest();
         _loc2_.shop = ProtobufEnumTranslator.translateShopLocationToProto(param1);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBShopOrderItemsResponse = param1 as PBShopOrderItemsResponse;
         switch(_loc2_.result)
         {
            case PBShopOrderItemsResult.OK:
               return true;
            case PBShopOrderItemsResult.CANNOT_AFFORD:
               controller.dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_NEW_SHOP_ITEMS_FAILED));
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForNewStock_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopOrderItemsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopOrderItemsResponse;
      }
   }
}
