package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.PBShopViewItemsResponse;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaShopData
   {
      
      public static const SLOT_SAFE:int = 9;
      
      public static const TIMER_EXPIRED:String = "shopTimerExpired";
       
      
      public var items:Vector.<ItemVO>;
      
      public var newFreeItemsTime:Number;
      
      public var location:ItemLocation;
      
      public function MafiaShopData()
      {
         super();
         this.items = new Vector.<ItemVO>();
      }
      
      public function parseShopData(param1:PBShopViewItemsResponse) : void
      {
         var _loc5_:ItemVO = null;
         var _loc6_:ItemVO = null;
         this.location = ProtobufEnumTranslator.translateProtoShopLocation(param1.shop);
         var _loc2_:int = param1.refresh;
         if(_loc2_ > 0)
         {
            this.newFreeItemsTime = getTimer() + _loc2_ * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            this.newFreeItemsTime = 0;
         }
         this.items = new Vector.<ItemVO>();
         var _loc3_:Array = param1.items;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = MafiaItemData.parseItem(_loc3_[_loc4_] as PBItem,this.location,_loc4_);
            this.items.push(_loc5_);
            _loc4_++;
         }
         if(param1.hasSafe)
         {
            _loc6_ = MafiaItemData.parseItem(param1.safe as PBItem,this.location,SLOT_SAFE);
            this.items.push(_loc6_);
         }
      }
      
      public function checkNewItemsTime(param1:Number) : void
      {
         var _loc4_:String = null;
         var _loc2_:Array = new Array();
         var _loc3_:Number = this.newFreeItemsTime - param1;
         _loc2_.push(TimeStringHelper.getShortTimeString(_loc3_));
         switch(this.location)
         {
            case ItemLocation.ShopBlackMarket:
               _loc4_ = MafiaShopEvent.CHANGE_NEW_ITEMS_IN_WEAPON_SHOP_TIME;
               break;
            case ItemLocation.ShopKiosk:
               _loc4_ = MafiaShopEvent.CHANGE_NEW_ITEMS_IN_KIOSK_SHOP_TIME;
               break;
            case ItemLocation.ShopConsumables:
               _loc4_ = MafiaShopEvent.CHANGE_NEW_ITEMS_IN_CONSUMABLES_SHOP_TIME;
               break;
            default:
               trace("shop with new item cooldown unknown! location: " + this.location);
         }
         if(_loc3_ <= 0)
         {
            _loc2_.push(MafiaShopData.TIMER_EXPIRED);
         }
         BasicController.getInstance().dispatchEvent(new MafiaShopEvent(_loc4_,_loc2_));
      }
   }
}
