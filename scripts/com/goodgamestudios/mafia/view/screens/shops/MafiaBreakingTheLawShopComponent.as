package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaBreakingTheLawEvent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MafiaBreakingTheLawShopComponent extends MafiaShopComponent
   {
       
      
      private var breakingTheLawShop:MafiaBreakingTheLawShopComponent;
      
      public function MafiaBreakingTheLawShopComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
      }
      
      override public function get MAX_SHOPITEMS() : int
      {
         return 3;
      }
      
      public function fill(param1:MafiaBreakingTheLawEvent) : void
      {
         var _loc2_:Point = shop.btn_info.localToGlobal(new Point());
         _loc2_.x = (_loc2_.x - layoutManager.gameNullPoint) / layoutManager.scaleFactor;
         _loc2_.y = _loc2_.y / layoutManager.scaleFactor - 50;
         shop.btn_info.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("event_breakingthelaw_copy_6")),_loc2_,"",BasicCustomCursor.CURSOR_CLICK);
         shop.txt_badges_owned_headline.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_4");
         shop.txt_badges_owned.text = MafiaModel.specialEvent.breakingTheLawEvent.policeBadges.toString();
         shop.txt_tabShop.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_2");
         shop.txt_tabOverview.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_1");
         fillItemsInShop(MafiaModel.userData.breakingTheLawShop.items,ItemLocation.ShopBreakingTheLaw);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
      }
      
      public function updateCurrency() : void
      {
         fillItemsInShop(MafiaModel.userData.breakingTheLawShop.items,ItemLocation.ShopBreakingTheLaw);
         shop.txt_badges_owned.text = MafiaModel.specialEvent.breakingTheLawEvent.policeBadges.toString();
      }
      
      override protected function getItemTooltipPosition(param1:MovieClip, param2:int) : Point
      {
         var _loc3_:int = -15;
         var _loc4_:int = 0;
         var _loc5_:Point = new Point(param1.x + _loc4_,param1.y + _loc3_);
         _loc5_ = param1.parent.localToGlobal(_loc5_);
         _loc5_.x = _loc5_.x - layoutManager.gameNullPoint;
         _loc5_.x = _loc5_.x / layoutManager.scaleFactor;
         _loc5_.y = _loc5_.y / layoutManager.scaleFactor;
         return _loc5_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
      }
      
      override protected function fillOneItemInShop(param1:Vector.<ItemVO>, param2:uint, param3:ItemLocation) : void
      {
         super.fillOneItemInShop(param1,param2,param3);
         var _loc4_:EventDialog_8_Item = shop["shop" + param2] as EventDialog_8_Item;
         _loc4_.btn_buy.label = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_14");
         if(this.eventData.policeBadges >= this.eventData.badgeCosts[param2])
         {
            _loc4_.btn_buy.enableButton = true;
            _loc4_.btn_buy.toolTipText = null;
         }
         else
         {
            _loc4_.btn_buy.enableButton = false;
            _loc4_.btn_buy.toolTipText = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_8");
         }
         _loc4_.txt_cost.text = NumberStringHelper.groupString(this.eventData.badgeCosts[param2],MafiaModel.languageData.getTextById);
         _loc4_.price.gotoAndStop("policeBadge");
         updateAllTextFields();
         _loc4_.btn_buy.update();
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      override protected function configMouseChildren(param1:MovieClip) : void
      {
         param1.mouseChildren = true;
      }
      
      override protected function setItemTooltip(param1:MovieClip, param2:ItemVO, param3:uint, param4:int) : void
      {
         super.setItemTooltip(EventDialog_8_Item(param1).itemSize,param2,param3,BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function get eventData() : MafiaBreakingTheLawEvent
      {
         return MafiaModel.specialEvent.breakingTheLawEvent;
      }
   }
}
