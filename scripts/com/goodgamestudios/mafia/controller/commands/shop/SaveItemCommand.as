package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.shop.saveitem.PBShopSaveItemRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.saveitem.PBShopSaveItemResponse;
   import com.goodgamestudios.mafia.controller.protobuf.shop.saveitem.response.PBShopSaveItemResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SaveItemCommand extends BasicProtobufCommand
   {
       
      
      public function SaveItemCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:ItemLocation) : void
      {
         var _loc3_:PBShopSaveItemRequest = new PBShopSaveItemRequest();
         _loc3_.shop = ProtobufEnumTranslator.translateShopLocationToProto(param2);
         _loc3_.source = param1;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBShopSaveItemResponse = param1 as PBShopSaveItemResponse;
         switch(_loc2_.result)
         {
            case PBShopSaveItemResult.OK:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
               return true;
            case PBShopSaveItemResult.SAFE_NOT_EMPTY:
               break;
            case PBShopSaveItemResult.SOURCE_EMPTY:
               break;
            case PBShopSaveItemResult.WRONG_SOURCE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopSaveItemRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopSaveItemResponse;
      }
   }
}
