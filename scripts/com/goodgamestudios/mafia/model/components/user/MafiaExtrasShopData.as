package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.PBShopViewItemsResponse;
   import com.goodgamestudios.mafia.event.model.MafiaFeatureEvent;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.screens.MafiaShopScreen;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaExtrasShopData
   {
      
      public static const SLOT_SAFE:int = 9;
      
      public static const TIMER_EXPIRED:String = "shopTimerExpired";
       
      
      public var items:Vector.<ItemVO>;
      
      public var newFreeItemsTime:Number;
      
      public var location:ItemLocation;
      
      public var isActive:Boolean;
      
      public function MafiaExtrasShopData()
      {
         super();
      }
      
      public function parseShopData(param1:PBShopViewItemsResponse) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ItemVO = null;
         this.location = ProtobufEnumTranslator.translateProtoShopLocation(param1.shop);
         if(param1.hasRemaining)
         {
            _loc4_ = param1.remaining;
            if(_loc4_ > 0)
            {
               this.newFreeItemsTime = getTimer() + _loc4_ * Constants_Basic.SEC2MILLISEC;
            }
            else
            {
               this.newFreeItemsTime = 0;
            }
         }
         else
         {
            this.newFreeItemsTime = 0;
         }
         this.items = new Vector.<ItemVO>();
         var _loc2_:Array = param1.items;
         if(param1.items.length > 0 && this.newFreeItemsTime > 0)
         {
            this.isActive = true;
            BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_SHOP_STATE,[MafiaShopScreen.EXTRAS,true]));
         }
         else
         {
            this.isActive = false;
            BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_SHOP_STATE,[MafiaShopScreen.EXTRAS,false]));
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ = MafiaItemData.parseItem(_loc2_[_loc3_] as PBItem,this.location,_loc3_);
            this.items.push(_loc5_);
            _loc3_++;
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
            case ItemLocation.ShopExtras:
            case ItemLocation.ShopTournament:
               _loc4_ = MafiaFeatureEvent.CHANGE_ITEMS_IN_EXTRAS_SHOP_TIME;
               break;
            default:
               trace("shop with new item cooldown unknown! location: " + this.location);
         }
         if(_loc3_ <= 0)
         {
            this.newFreeItemsTime = 0;
            this.isActive = false;
            BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_SHOP_STATE,[MafiaShopScreen.EXTRAS,false]));
            _loc2_.push(MafiaShopData.TIMER_EXPIRED);
         }
         BasicController.getInstance().dispatchEvent(new MafiaFeatureEvent(_loc4_,_loc2_));
      }
   }
}
