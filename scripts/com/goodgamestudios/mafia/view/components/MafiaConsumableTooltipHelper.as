package com.goodgamestudios.mafia.view.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ConsumableType;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.screens.MafiaPreCombatScreen;
   import com.goodgamestudios.mafia.vo.items.ConsumableVO;
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class MafiaConsumableTooltipHelper
   {
      
      private static var _tooltipHelper:MafiaConsumableTooltipHelper;
       
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private var specialFontOffset:int;
      
      private var specialFontNameLineOffset:int;
      
      private var specialFontCompareOffset:int;
      
      public function MafiaConsumableTooltipHelper(param1:SingletonEnforcer#124)
      {
         super();
         if(_tooltipHelper)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : MafiaConsumableTooltipHelper
      {
         if(_tooltipHelper == null)
         {
            _tooltipHelper = new MafiaConsumableTooltipHelper(new SingletonEnforcer#124());
         }
         return _tooltipHelper;
      }
      
      public function createTooltipBody(param1:ConsumableVO, param2:MovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc9_:ArmamentItemProperties = null;
         var _loc10_:ArmamentItemProperties = null;
         var _loc11_:ArmamentCompareItemLine = null;
         var _loc12_:ArmamentItemProperties = null;
         var _loc13_:ArmamentCompareItemLine = null;
         var _loc14_:int = 0;
         var _loc15_:ArmamentItemCompare = null;
         var _loc16_:ArmamentItemCompare = null;
         var _loc17_:int = 0;
         var _loc18_:ArmamentItemCompare = null;
         var _loc19_:ArmamentItemProperties = null;
         var _loc20_:ArmamentCompareItemLine = null;
         var _loc21_:ArmamentItemProperties = null;
         var _loc22_:ArmamentCompareItemLine = null;
         this.specialFontOffset = 0;
         this.specialFontNameLineOffset = 0;
         this.specialFontCompareOffset = 0;
         var _loc3_:String = BasicLanguageFontManager.getInstance().getFontNameByGGSLanguageCode(GGSCountryController.instance.currentCountry.ggsLanguageCode);
         if(BasicLanguageFontManager.getInstance().isRuntimeLoadedFont(_loc3_))
         {
            this.specialFontCompareOffset = 9;
            this.specialFontOffset = 19;
            this.specialFontNameLineOffset = 10;
         }
         var _loc5_:ArmamentItemProperties = this.createConsumableOptionalLine(param1);
         if(_loc5_)
         {
            param2.addChild(_loc5_);
            _loc4_ = _loc4_ + _loc5_.height;
         }
         var _loc6_:ArmamentNameItemLine = this.createItemNameLine(param1.name);
         if(_loc6_)
         {
            param2.addChild(_loc6_);
            _loc6_.y = _loc4_;
            _loc4_ = _loc4_ + _loc6_.height;
         }
         var _loc7_:ArmamentItemProperties = this.createAlertLine(param1);
         if(MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_OTHERPROFILE && _loc7_)
         {
            param2.addChild(_loc7_);
            _loc7_.y = _loc4_;
            _loc4_ = _loc4_ + _loc7_.height;
         }
         if(MafiaLayoutManager.getInstance().currentState == Constants_LayoutStates.STATE_DUEL_PREPARE && !MafiaPreCombatScreen.useConsumables && MafiaModel.userData.armament.containsItem(param1))
         {
            _loc9_ = this.createPreCombatOptionalLine();
            if(_loc9_)
            {
               param2.addChild(_loc9_);
               _loc9_.y = _loc4_;
               _loc4_ = _loc4_ + _loc9_.height;
            }
         }
         var _loc8_:int = 0;
         while(_loc8_ < param1.effectComponent.effects.length)
         {
            _loc10_ = this.createEffect(param1.effectComponent.effects[_loc8_],param1.rounds);
            if(_loc10_)
            {
               if(_loc8_ < param1.effectComponent.effects.length - 1)
               {
                  _loc11_ = new ArmamentCompareItemLine();
               }
               param2.addChild(_loc10_);
               if(_loc11_)
               {
                  param2.addChild(_loc11_);
               }
               _loc10_.y = _loc4_;
               _loc4_ = _loc4_ + _loc10_.height;
               if(_loc11_)
               {
                  _loc11_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc11_.height;
               }
            }
            _loc8_++;
         }
         if(MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_OTHERPROFILE && (MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_DUEL_PREPARE || (MafiaModel.userData.armament.containsItem(param1) || MafiaModel.userData.inventory.containsItem(param1))))
         {
            _loc12_ = this.createAmountLine(param1.amount);
            if(_loc12_)
            {
               _loc13_ = new ArmamentCompareItemLine();
               param2.addChild(_loc13_);
               param2.addChild(_loc12_);
               _loc13_.y = _loc4_;
               _loc4_ = _loc4_ + _loc13_.height;
               _loc12_.y = _loc4_;
               _loc4_ = _loc4_ + _loc12_.height;
            }
         }
         if(param1.location != ItemLocation.Armament && param1.subtype != ConsumableType.Ammunition)
         {
            _loc14_ = 0;
            while(_loc14_ < param1.effectComponent.effects.length)
            {
               _loc15_ = this.createCompareEffectFirstValue(param1.effectComponent.effects[_loc14_],param1);
               if(_loc15_)
               {
                  param2.addChild(_loc15_);
                  _loc15_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc15_.height;
               }
               _loc16_ = this.createCompareEffectSecondValue(param1.effectComponent.effects[_loc14_],param1);
               if(_loc16_)
               {
                  param2.addChild(_loc16_);
                  _loc16_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc16_.height;
               }
               _loc14_++;
            }
         }
         else if(param1.subtype == ConsumableType.Ammunition && this.isWeaponActive(param1.dependencyComponent.dependencies))
         {
            _loc17_ = 0;
            while(_loc17_ < param1.effectComponent.effects.length)
            {
               _loc18_ = this.createCompareEffectFirstValue(param1.effectComponent.effects[_loc17_],param1);
               if(_loc18_)
               {
                  param2.addChild(_loc18_);
                  _loc18_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc18_.height;
               }
               _loc17_++;
            }
         }
         if(param1.location == ItemLocation.ShopConsumables)
         {
            _loc19_ = this.createPriceLine(param1.cash,param1.gold);
            _loc20_ = new ArmamentCompareItemLine();
            param2.addChild(_loc19_);
            param2.addChild(_loc20_);
            _loc19_.y = param2.height;
            _loc20_.y = _loc19_.y - this.MAGIC_FOUR_OFFSET;
         }
         else if(param1.location == ItemLocation.Inventory)
         {
            if(MafiaLayoutManager.getInstance().actState == Constants_LayoutStates.STATE_SHOP)
            {
               _loc21_ = this.marketPriceLine(param1.saleCash);
               _loc22_ = new ArmamentCompareItemLine();
               param2.addChild(_loc21_);
               param2.addChild(_loc22_);
               _loc21_.y = param2.height;
               _loc22_.y = _loc21_.y - this.MAGIC_FOUR_OFFSET;
            }
         }
      }
      
      private function createConsumableOptionalLine(param1:ConsumableVO) : ArmamentItemProperties
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = false;
         var _loc3_:* = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dependency") + "\n";
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.leading = 0;
         if(param1.dependencyComponent.dependencies.length != 0)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.dependencyComponent.dependencies.length)
            {
               if(param1.dependencyComponent.dependencies[_loc6_].index == WeaponType.Any.index)
               {
                  _loc7_ = MafiaModel.languageData.getTextById("item_type_3");
               }
               else
               {
                  _loc7_ = MafiaModel.languageData.getTextById(MafiaItemData.getPrefixByType(ItemType.Weapon) + "type_" + param1.dependencyComponent.dependencies[_loc6_].index);
               }
               _loc3_ = _loc3_ + (_loc7_ + ", ");
               _loc5_ = _loc3_;
               _loc6_++;
            }
            _loc2_.txt_description.defaultTextFormat = _loc4_;
            _loc2_.txt_description.text = _loc5_.slice(0,_loc5_.length - 2);
            _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontNameLineOffset;
         }
         else
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      private function createPreCombatOptionalLine() : ArmamentItemProperties
      {
         var _loc1_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 16711680;
         _loc2_.leading = 0;
         _loc1_.shop.visible = false;
         _loc1_.txt_description.defaultTextFormat = _loc2_;
         _loc1_.txt_description.text = MafiaModel.languageData.getTextById("MafiaPreFightScreen_5");
         _loc1_.txt_description.height = _loc1_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
         return _loc1_;
      }
      
      private function createItemNameLine(param1:String) : ArmamentNameItemLine
      {
         var _loc2_:ArmamentNameItemLine = new ArmamentNameItemLine();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.leading = 0;
         _loc2_.txt_name.defaultTextFormat = _loc3_;
         _loc2_.txt_name.text = param1;
         _loc2_.txt_name.height = _loc2_.txt_name.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontNameLineOffset;
         _loc2_.line.y = _loc2_.height;
         return _loc2_;
      }
      
      private function createAlertLine(param1:ConsumableVO) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = 16711680;
         _loc3_.leading = 0;
         _loc2_.shop.visible = false;
         _loc2_.txt_description.defaultTextFormat = _loc3_;
         if(this.isWeaponActive(param1.dependencyComponent.dependencies))
         {
            if(MafiaModel.userData.armament.containsItem(param1) && !param1.armamentComponent.isActive)
            {
               _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_inactiveReason_2");
               _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
               return _loc2_;
            }
            return null;
         }
         if(!this.isWeaponActive(param1.dependencyComponent.dependencies) && param1.dependencyComponent.dependencies.length > 0)
         {
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_inactiveReason_3");
            _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
            return _loc2_;
         }
         if(!this.isWeaponActive(param1.dependencyComponent.dependencies) && MafiaModel.userData.armament.containsItem(param1) && !param1.armamentComponent.isActive)
         {
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_inactiveReason_2");
            _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
            return _loc2_;
         }
         return null;
      }
      
      private function createEffect(param1:ItemEffectVO, param2:uint) : ArmamentItemProperties
      {
         var _loc3_:TextFormat = new TextFormat();
         var _loc4_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc3_.leading = 0;
         _loc4_.txt_description.defaultTextFormat = _loc3_;
         _loc4_.shop.visible = false;
         _loc4_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffect_" + param1.id,[param1.firstValue,param1.secondValue,param2]);
         _loc4_.txt_description.height = _loc4_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
         return _loc4_;
      }
      
      private function createAmountLine(param1:uint) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = false;
         _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_quantity");
         _loc2_.txt_value.text = String(param1);
         return _loc2_;
      }
      
      private function createCompareEffectFirstValue(param1:ItemEffectVO, param2:ConsumableVO) : ArmamentItemCompare
      {
         var _loc3_:Dictionary = MafiaModel.userData.armament.getItemEffectsToCompare(param2);
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:ArmamentItemCompare = new ArmamentItemCompare();
         _loc4_.leading = 0;
         if(DictionaryUtil.containsKey(MafiaModel.userData.armament.getItemEffectsToCompare(param2),param1.id))
         {
            if(_loc3_[param1.id][0] > param1.firstValue)
            {
               _loc4_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getFirstValueCompareText(param2.id);
               _loc5_.txt_value.text = String(param1.firstValue - _loc3_[param1.id][0]) + "%";
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][0] < param1.firstValue)
            {
               _loc4_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getFirstValueCompareText(param2.id);
               _loc5_.txt_value.text = "+" + String(param1.firstValue - _loc3_[param1.id][0]) + "%";
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][0] == param1.firstValue)
            {
               return _loc5_ = null;
            }
            _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
         }
         return null;
      }
      
      private function createCompareEffectSecondValue(param1:ItemEffectVO, param2:ConsumableVO) : ArmamentItemCompare
      {
         var _loc3_:Dictionary = MafiaModel.userData.armament.getItemEffectsToCompare(param2);
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:ArmamentItemCompare = new ArmamentItemCompare();
         _loc4_.leading = 0;
         if(DictionaryUtil.containsKey(MafiaModel.userData.armament.getItemEffectsToCompare(param2),param1.id))
         {
            if(_loc3_[param1.id][1] > param1.secondValue)
            {
               _loc4_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getSecondValueCompareText(param2.id);
               _loc5_.txt_value.text = String(param1.secondValue - _loc3_[param1.id][1]) + "%";
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][1] < param1.secondValue)
            {
               _loc4_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getSecondValueCompareText(param2.id);
               _loc5_.txt_value.text = "+" + String(param1.secondValue - _loc3_[param1.id][1]) + "%";
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][1] == param1.secondValue)
            {
               return _loc5_ = null;
            }
            _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
         }
         return null;
      }
      
      private function createPriceLine(param1:Number, param2:Number) : ArmamentItemProperties
      {
         var _loc3_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc3_.shop.visible = true;
         if(param1 > 0)
         {
            _loc3_.shop.gotoAndStop(1);
            _loc3_.txt_value.text = String(param1);
         }
         else if(param2 > 0)
         {
            _loc3_.shop.gotoAndStop(2);
            _loc3_.txt_value.text = String(param2);
         }
         return _loc3_;
      }
      
      private function getFirstValueCompareText(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
               break;
            case 4:
            case 5:
            case 6:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_hitchance");
               break;
            case 7:
            case 8:
            case 9:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_6");
               break;
            case 10:
            case 11:
            case 12:
            case 13:
            case 18:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_chance");
               break;
            case 14:
            case 15:
            case 16:
            case 17:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_10");
               break;
            case 19:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_7");
         }
         return _loc2_;
      }
      
      private function getSecondValueCompareText(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 10:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
               break;
            case 11:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_13");
               break;
            case 13:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_3");
               break;
            case 18:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_10");
               break;
            case 14:
            case 15:
            case 16:
            case 17:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_10");
         }
         return _loc2_;
      }
      
      private function isWeaponActive(param1:Vector.<WeaponType>) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(MafiaModel.userData.armament.isWeaponTypeActive(ItemType.Weapon,param1[_loc2_]))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function marketPriceLine(param1:Number) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = true;
         _loc2_.shop.gotoAndStop(1);
         _loc2_.txt_value.text = String(param1);
         return _loc2_;
      }
   }
}

class SingletonEnforcer#124
{
    
   
   function SingletonEnforcer#124()
   {
      super();
   }
}
