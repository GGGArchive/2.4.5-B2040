package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaItemAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.AttributeBonusItemComponent;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class MafiaItemAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaItemAdvancedTooltip";
       
      
      private const XPOS:int = -101;
      
      private const PROPERTIEHEIGHT:int = 19;
      
      private var yPos:Number;
      
      private var shopLine:CompareItemLine;
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private const NORMAL:int = 1;
      
      private const SHOP_BUY_CASH:int = 2;
      
      private const SHOP_BUY_GOLD:int = 3;
      
      private const AVATAR_SALE:int = 4;
      
      private const COMPARE:int = 5;
      
      private const DURATION:int = 6;
      
      private const EXTRAS_SHOP:int = 7;
      
      public function MafiaItemAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      override protected function applyProperties() : void
      {
         var _loc2_:ItemVO = null;
         var _loc8_:Vector.<GearVO> = null;
         var _loc9_:GearVO = null;
         var _loc10_:AttributeBonusItemComponent = null;
         var _loc11_:uint = 0;
         var _loc13_:ItemProperties = null;
         var _loc14_:int = 0;
         var _loc15_:ItemProperties = null;
         var _loc16_:Number = NaN;
         var _loc17_:FoodVO = null;
         var _loc18_:Number = NaN;
         var _loc19_:ItemProperties = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:ItemProperties = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:ItemProperties = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:ItemProperties = null;
         var _loc29_:TextField = null;
         var _loc30_:TextField = null;
         var _loc31_:TextField = null;
         var _loc32_:TextField = null;
         var _loc33_:TextField = null;
         var _loc34_:TextField = null;
         var _loc35_:TextField = null;
         var _loc36_:TextField = null;
         var _loc37_:ItemProperties = null;
         var _loc38_:ItemProperties = null;
         var _loc39_:ItemProperties = null;
         this.resetTooltip();
         this.advancedTooltip.bg.height = 97;
         this.advancedTooltip.compareItemLine.y = 18;
         this.advancedTooltip.compareItemLine.visible = false;
         TextFieldHelper.changeTextFromatSizeByTextWidth(19,this.advancedTooltip.txt_name,this.advancedTooltipProperties.item.name);
         var _loc1_:String = this.advancedTooltipProperties.item.categoryName;
         if(this.advancedTooltipProperties.item.subcategoryName != "")
         {
            _loc1_ = _loc1_ + (" - " + this.advancedTooltipProperties.item.subcategoryName);
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_category,_loc1_);
         this.advancedTooltip.txt_category.textColor = MafiaItemData.getColorForItemQuality(this.advancedTooltipProperties.item);
         this.yPos = 59;
         var _loc3_:int = 0;
         if(this.advancedTooltipProperties.item.type == ItemType.Extra)
         {
            _loc13_ = this.itemProperties(this.EXTRAS_SHOP,MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemMysteryBox_1"),"",false);
            _loc13_.y = this.yPos;
            _loc13_.x = this.XPOS;
            _loc13_.txt_description.height = _loc13_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
            this.advancedTooltip.addChildAt(_loc13_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + _loc13_.txt_description.height;
         }
         if(this.advancedTooltipProperties.item.type == ItemType.Food)
         {
            _loc14_ = 0;
            while(_loc14_ < MafiaModel.userData.foodData.food.length)
            {
               _loc2_ = MafiaModel.userData.foodData.food[_loc14_];
               if(MafiaModel.userData.foodData.isAFoodSlotEmpty && !_loc2_)
               {
                  _loc3_ = _loc14_;
               }
               if(_loc2_ && _loc2_.id == this.advancedTooltipProperties.item.id)
               {
                  _loc3_ = _loc2_.slotId;
                  break;
               }
               _loc14_++;
            }
         }
         var _loc4_:Vector.<ItemProperties> = new Vector.<ItemProperties>();
         var _loc5_:Vector.<ItemProperties> = new Vector.<ItemProperties>();
         var _loc6_:AttributeBonusItemComponent = this.advancedTooltipProperties.item.getComponent(AttributeBonusItemComponent) as AttributeBonusItemComponent;
         if(_loc6_ && _loc6_.attack > 0)
         {
            _loc15_ = this.itemProperties(this.NORMAL,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack"),NumberStringHelper.groupString(_loc6_.attack,MafiaModel.languageData.getTextById),_loc6_.attackPerc);
            _loc15_.y = this.yPos;
            _loc15_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc15_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         var _loc7_:FoodVO = MafiaModel.userData.foodData.food[_loc3_];
         if(this.advancedTooltipProperties.item.type == ItemType.Gear)
         {
            _loc8_ = MafiaModel.userData.gearData.items;
            _loc9_ = _loc8_[this.advancedTooltipProperties.item.subtype.index - 1];
            if(_loc9_ != null)
            {
               _loc10_ = _loc9_.attributeBonusComponent;
            }
            else
            {
               _loc10_ = null;
            }
         }
         if(_loc6_ && this.advancedTooltipProperties.item.location != ItemLocation.Gear && !_loc6_.attackPerc)
         {
            _loc17_ = this.advancedTooltipProperties.item as FoodVO;
            if(!_loc17_)
            {
               if(_loc9_ != null)
               {
                  _loc16_ = _loc10_.attack;
               }
               else
               {
                  _loc16_ = 0;
               }
            }
            else if(_loc7_)
            {
               _loc16_ = _loc7_.attributeBonusComponent.attack;
            }
            else
            {
               _loc16_ = 0;
            }
            _loc18_ = _loc6_.attack;
            if(_loc16_ > _loc18_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack"),"- " + NumberStringHelper.groupString(_loc16_ - _loc18_,MafiaModel.languageData.getTextById)));
            }
            else if(_loc16_ < _loc18_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack"),"+ " + NumberStringHelper.groupString(_loc16_ - _loc18_,MafiaModel.languageData.getTextById).substr(1)));
            }
         }
         if(_loc6_ && _loc6_.endurance > 0)
         {
            _loc19_ = this.itemProperties(this.NORMAL,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance"),NumberStringHelper.groupString(_loc6_.endurance,MafiaModel.languageData.getTextById),_loc6_.endurancePerc);
            _loc19_.y = this.yPos;
            _loc19_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc19_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         if(_loc6_ && this.advancedTooltipProperties.item.location != ItemLocation.Gear && !_loc6_.endurancePerc)
         {
            if(!_loc17_)
            {
               if(_loc9_ != null)
               {
                  _loc20_ = _loc10_.endurance;
               }
               else
               {
                  _loc20_ = 0;
               }
            }
            else if(_loc7_)
            {
               _loc20_ = _loc7_.attributeBonusComponent.endurance;
            }
            else
            {
               _loc20_ = 0;
            }
            _loc21_ = _loc6_.endurance;
            if(_loc20_ > _loc21_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance"),"- " + NumberStringHelper.groupString(_loc20_ - _loc21_,MafiaModel.languageData.getTextById)));
            }
            else if(_loc20_ < _loc21_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance"),"+ " + NumberStringHelper.groupString(_loc20_ - _loc21_,MafiaModel.languageData.getTextById).substr(1)));
            }
         }
         if(this.advancedTooltipProperties.item.hasComponent(AttributeBonusItemComponent))
         {
            if((this.advancedTooltipProperties.item.getComponent(AttributeBonusItemComponent) as AttributeBonusItemComponent).luck > 0)
            {
               _loc22_ = this.itemProperties(this.NORMAL,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck"),NumberStringHelper.groupString(_loc6_.luck,MafiaModel.languageData.getTextById),_loc6_.luckPerc);
               _loc22_.y = this.yPos;
               _loc22_.x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc22_,this.advancedTooltip.numChildren);
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
            }
         }
         if(_loc6_ && this.advancedTooltipProperties.item.location != ItemLocation.Gear && !_loc6_.luckPerc)
         {
            if(!_loc17_)
            {
               if(_loc9_ != null)
               {
                  _loc23_ = _loc10_.luck;
               }
               else
               {
                  _loc23_ = 0;
               }
            }
            else if(_loc7_)
            {
               _loc23_ = _loc7_.attributeBonusComponent.luck;
            }
            else
            {
               _loc23_ = 0;
            }
            _loc24_ = _loc6_.luck;
            if(_loc23_ > _loc24_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck"),"- " + NumberStringHelper.groupString(_loc23_ - _loc24_,MafiaModel.languageData.getTextById)));
            }
            else if(_loc23_ < _loc24_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck"),"+ " + NumberStringHelper.groupString(_loc23_ - _loc24_,MafiaModel.languageData.getTextById).substr(1)));
            }
         }
         if(_loc6_ && _loc6_.toughness > 0)
         {
            _loc25_ = this.itemProperties(this.NORMAL,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough"),NumberStringHelper.groupString(_loc6_.toughness,MafiaModel.languageData.getTextById),_loc6_.toughnessPerc);
            _loc25_.y = this.yPos;
            _loc25_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc25_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         if(_loc6_ && this.advancedTooltipProperties.item.location != ItemLocation.Gear && !_loc6_.toughnessPerc)
         {
            if(!_loc17_)
            {
               if(_loc9_ != null)
               {
                  _loc26_ = _loc10_.toughness;
               }
               else
               {
                  _loc26_ = 0;
               }
            }
            else if(_loc7_)
            {
               _loc26_ = _loc7_.attributeBonusComponent.toughness;
            }
            else
            {
               _loc26_ = 0;
            }
            _loc27_ = _loc6_.toughness;
            if(_loc26_ > _loc27_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough"),"- " + NumberStringHelper.groupString(_loc26_ - _loc27_,MafiaModel.languageData.getTextById)));
            }
            else if(_loc26_ < _loc27_)
            {
               _loc4_.push(this.itemProperties(this.COMPARE,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough"),"+ " + NumberStringHelper.groupString(_loc26_ - _loc27_,MafiaModel.languageData.getTextById).substr(1)));
            }
         }
         if(this.advancedTooltipProperties.item is FoodVO && (this.advancedTooltipProperties.item as FoodVO).expiringComponent.duration > 0)
         {
            _loc28_ = this.itemProperties(this.DURATION,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_foodduration"),String(TimeStringHelper.getTimeToString((this.advancedTooltipProperties.item as FoodVO).expiringComponent.duration,TimeStringHelper.ONE_TIME_FORMAT,MafiaModel.languageData.getTextById)));
            _loc28_.y = this.yPos;
            _loc28_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc28_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + (this.yPos - 85);
         this.advancedTooltip.compareItemLine.y = this.yPos;
         this.advancedTooltip.compareItemLine.visible = false;
         this.yPos = this.yPos + this.PROPERTIEHEIGHT * 0.5;
         var _loc12_:DropShadowFilter = new DropShadowFilter(1,45,3355443,0.5,1,1,1,1);
         _loc11_ = 0;
         while(_loc11_ < _loc5_.length)
         {
            this.advancedTooltip.compareItemLine.visible = true;
            _loc29_ = _loc5_[_loc11_].getChildByName("txt_value") as TextField;
            _loc30_ = _loc5_[_loc11_].getChildByName("txt_description") as TextField;
            if(String(_loc29_.text).indexOf("+",0) != -1)
            {
               _loc29_.textColor = _loc30_.textColor = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc29_.filters = [_loc12_];
               _loc30_.filters = [_loc12_];
               _loc5_[_loc11_].y = this.yPos;
               _loc5_[_loc11_].x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc5_[_loc11_],this.advancedTooltip.numChildren);
               this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.PROPERTIEHEIGHT;
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc5_.length)
         {
            this.advancedTooltip.compareItemLine.visible = true;
            _loc31_ = _loc5_[_loc11_].getChildByName("txt_value") as TextField;
            _loc32_ = _loc5_[_loc11_].getChildByName("txt_description") as TextField;
            if(String(_loc31_.text).indexOf("-",0) != -1)
            {
               _loc31_.textColor = _loc32_.textColor = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc31_.filters = [_loc12_];
               _loc32_.filters = [_loc12_];
               _loc5_[_loc11_].y = this.yPos;
               _loc5_[_loc11_].x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc5_[_loc11_],this.advancedTooltip.numChildren);
               this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.PROPERTIEHEIGHT;
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc4_.length)
         {
            this.advancedTooltip.compareItemLine.visible = true;
            _loc33_ = _loc4_[_loc11_].getChildByName("txt_value") as TextField;
            _loc34_ = _loc4_[_loc11_].getChildByName("txt_description") as TextField;
            if(String(_loc33_.text).indexOf("+",0) != -1)
            {
               _loc33_.textColor = _loc34_.textColor = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc4_[_loc11_].y = this.yPos;
               _loc4_[_loc11_].x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc4_[_loc11_],this.advancedTooltip.numChildren);
               this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.PROPERTIEHEIGHT;
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc4_.length)
         {
            this.advancedTooltip.compareItemLine.visible = true;
            _loc35_ = _loc4_[_loc11_].getChildByName("txt_value") as TextField;
            _loc36_ = _loc4_[_loc11_].getChildByName("txt_description") as TextField;
            if(String(_loc35_.text).indexOf("-",0) != -1)
            {
               _loc35_.textColor = _loc36_.textColor = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc4_[_loc11_].y = this.yPos;
               _loc4_[_loc11_].x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc4_[_loc11_],this.advancedTooltip.numChildren);
               this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.PROPERTIEHEIGHT;
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
            }
            _loc11_++;
         }
         if(layoutManager.actState == Constants_LayoutStates.STATE_SHOP)
         {
            this.shopLine = new CompareItemLine();
            this.shopLine.x = this.advancedTooltip.compareItemLine.x;
            this.shopLine.y = this.yPos;
            this.advancedTooltip.addChild(this.shopLine);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT * 0.5;
            if(MafiaItemData.isShopLocation(this.advancedTooltipProperties.item.location))
            {
               if(this.advancedTooltipProperties.item.cash > 0)
               {
                  _loc37_ = this.itemProperties(this.SHOP_BUY_CASH,"",NumberStringHelper.groupString(this.advancedTooltipProperties.item.cash,MafiaModel.languageData.getTextById));
                  _loc37_.y = this.yPos;
                  _loc37_.x = this.XPOS;
                  this.advancedTooltip.addChildAt(_loc37_,this.advancedTooltip.numChildren);
                  this.yPos = this.yPos + (this.PROPERTIEHEIGHT + 5);
                  this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + (this.PROPERTIEHEIGHT + 10);
               }
               if(this.advancedTooltipProperties.item.gold > 0)
               {
                  _loc38_ = this.itemProperties(this.SHOP_BUY_GOLD,"",String(this.advancedTooltipProperties.item.gold));
                  _loc38_.y = this.yPos;
                  _loc38_.x = this.XPOS;
                  this.advancedTooltip.addChildAt(_loc38_,this.advancedTooltip.numChildren);
                  this.yPos = this.yPos + (this.PROPERTIEHEIGHT + 5);
                  this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + (this.PROPERTIEHEIGHT + 10);
               }
            }
            else
            {
               _loc39_ = this.itemProperties(this.AVATAR_SALE,"",NumberStringHelper.groupString(this.advancedTooltipProperties.item.saleCash,MafiaModel.languageData.getTextById));
               _loc39_.y = this.yPos;
               _loc39_.x = this.XPOS;
               this.advancedTooltip.addChildAt(_loc39_,this.advancedTooltip.numChildren);
               this.yPos = this.yPos + this.PROPERTIEHEIGHT;
               this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + (this.PROPERTIEHEIGHT + 10);
            }
         }
      }
      
      private function itemProperties(param1:int, param2:String, param3:String, param4:Boolean = false) : ItemProperties
      {
         var _loc5_:ItemProperties = new ItemProperties();
         _loc5_.txt_description.text = param2;
         switch(param1)
         {
            case 1:
               if(param4)
               {
                  param3 = "+ " + param3 + "%";
               }
               _loc5_.shop.visible = false;
               break;
            case 2:
               _loc5_.shop.visible = true;
               _loc5_.shop.gotoAndStop(1);
               break;
            case 3:
               _loc5_.shop.visible = true;
               _loc5_.shop.gotoAndStop(2);
               break;
            case 4:
               _loc5_.shop.visible = true;
               _loc5_.shop.gotoAndStop(1);
               break;
            case 5:
               if(this.advancedTooltipProperties.item.type == ItemType.Food)
               {
                  param3 = param3 + " %";
               }
               _loc5_.shop.visible = false;
               break;
            case 6:
               if(param4)
               {
                  param3 = "+ " + param3 + "%";
               }
               _loc5_.shop.visible = false;
               break;
            case 7:
               _loc5_.shop.visible = false;
               param3 = "";
         }
         _loc5_.txt_value.text = param3;
         updateTextField(_loc5_.txt_description);
         updateTextField(_loc5_.txt_value);
         return _loc5_;
      }
      
      override public function destroy() : void
      {
         this.resetTooltip();
         super.destroy();
      }
      
      override public function hide() : void
      {
         this.resetTooltip();
         super.hide();
      }
      
      private function resetTooltip() : void
      {
         while(this.advancedTooltip.numChildren > 5)
         {
            this.advancedTooltip.removeChildAt(5);
         }
      }
      
      protected function get advancedTooltip() : MafiaItemTooltip
      {
         return disp as MafiaItemTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaItemAdvancedTooltipProperties
      {
         return properties as MafiaItemAdvancedTooltipProperties;
      }
   }
}
