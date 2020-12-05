package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.shop.clearsafe.PBShopClearSafeRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.clearsafe.PBShopClearSafeResponse;
   import com.goodgamestudios.mafia.controller.protobuf.shop.clearsafe.response.PBShopClearSafeResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ClearSafeCommand extends BasicProtobufCommand
   {
       
      
      public function ClearSafeCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:ItemLocation) : void
      {
         var _loc2_:PBShopClearSafeRequest = new PBShopClearSafeRequest();
         _loc2_.shop = ProtobufEnumTranslator.translateShopLocationToProto(param1);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBShopClearSafeResponse = param1 as PBShopClearSafeResponse;
         switch(_loc2_.result)
         {
            case PBShopClearSafeResult.OK:
               return true;
            case PBShopClearSafeResult.SAFE_EMPTY:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopClearSafeRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopClearSafeResponse;
      }
   }
}
