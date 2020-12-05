package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBShopType;
   import com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.PBShopViewItemsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.PBShopViewItemsResponse;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewItemsCommand extends BasicProtobufCommand
   {
       
      
      public function ViewItemsCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:ItemLocation) : void
      {
         var _loc2_:PBShopViewItemsRequest = new PBShopViewItemsRequest();
         _loc2_.shop = ProtobufEnumTranslator.translateShopLocationToProto(param1);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      public static function sendPoliceCommand() : void
      {
         var _loc1_:PBShopViewItemsRequest = new PBShopViewItemsRequest();
         _loc1_.shop = PBShopType.POLICE;
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBShopViewItemsResponse = param1 as PBShopViewItemsResponse;
         switch(_loc2_.shop)
         {
            case PBShopType.BLACK_MARKET:
               MafiaModel.userData.weaponShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_WEAPON_SHOP_DATA));
               return true;
            case PBShopType.CONSUMABLES:
               MafiaModel.userData.consumablesShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_CONSUMABLE_SHOP_DATA));
               return true;
            case PBShopType.KIOSK:
               MafiaModel.userData.kioskShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_KIOSK_SHOP_DATA));
               return true;
            case PBShopType.POLICE:
               MafiaModel.userData.breakingTheLawShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_BREAKING_THE_LAW_SHOP_DATA));
               return true;
            case PBShopType.EXTRAS:
               MafiaModel.userData.extrasShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_EXTRAS_SHOP_DATA));
               return true;
            case PBShopType.TOURNAMENT:
               MafiaModel.userData.extrasShop.parseShopData(_loc2_);
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_EXTRAS_SHOP_DATA));
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopViewItemsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopViewItemsResponse;
      }
   }
}
