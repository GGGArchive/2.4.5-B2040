package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.shop.sellitem.PBShopSellItemRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.sellitem.PBShopSellItemResponse;
   import com.goodgamestudios.mafia.controller.protobuf.shop.sellitem.response.PBShopSellItemResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SellItemCommand extends BasicProtobufCommand
   {
       
      
      public function SellItemCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int = 1) : void
      {
         var _loc3_:PBShopSellItemRequest = new PBShopSellItemRequest();
         _loc3_.source = param1;
         _loc3_.amount = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBShopSellItemResponse = param1 as PBShopSellItemResponse;
         MafiaModel.userData.unlockAllItems();
         switch(_loc2_.result)
         {
            case PBShopSellItemResult.OK:
               controller.soundController.playSoundEffect(MafiaSoundController.SND_SOLD);
               return true;
            default:
               trace("SellItemCommand Error: " + _loc2_.result);
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopSellItemRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopSellItemResponse;
      }
   }
}
