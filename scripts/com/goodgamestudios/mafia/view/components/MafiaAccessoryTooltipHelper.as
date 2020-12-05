package com.goodgamestudios.mafia.view.components
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.items.AccessoryVO;
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class MafiaAccessoryTooltipHelper
   {
      
      private static var _tooltipHelper:MafiaAccessoryTooltipHelper;
       
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private var specialFontOffset:int;
      
      public function MafiaAccessoryTooltipHelper(param1:SingletonEnforcer#123)
      {
         super();
         if(_tooltipHelper)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : MafiaAccessoryTooltipHelper
      {
         if(_tooltipHelper == null)
         {
            _tooltipHelper = new MafiaAccessoryTooltipHelper(new SingletonEnforcer#123());
         }
         return _tooltipHelper;
      }
      
      public function createTooltipBody(param1:AccessoryVO, param2:MovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc9_:ArmamentItemProperties = null;
         var _loc10_:ArmamentCompareItemLine = null;
         var _loc11_:int = 0;
         var _loc12_:ArmamentItemProperties = null;
         var _loc13_:ArmamentItemProperties = null;
         var _loc14_:ArmamentCompareItemLine = null;
         var _loc15_:ArmamentItemProperties = null;
         var _loc16_:ArmamentCompareItemLine = null;
         var _loc3_:String = BasicLanguageFontManager.getInstance().getFontNameByGGSLanguageCode(GGSCountryController.instance.currentCountry.ggsLanguageCode);
         this.specialFontOffset = 0;
         if(BasicLanguageFontManager.getInstance().isRuntimeLoadedFont(_loc3_))
         {
            this.specialFontOffset = 19;
         }
         var _loc5_:ArmamentItemProperties = this.createDependencyOptionalLine(param1);
         if(_loc5_)
         {
            param2.addChild(_loc5_);
            _loc4_ = _loc4_ + _loc5_.height;
         }
         var _loc6_:ArmamentNameItemLine = this.createItemNameLine(param1.name);
         param2.addChild(_loc6_);
         _loc6_.y = _loc4_;
         _loc4_ = _loc4_ + _loc6_.height;
         var _loc7_:ArmamentItemProperties = this.createAlertLine(param1);
         if(_loc7_)
         {
            param2.addChild(_loc7_);
            _loc7_.y = _loc4_;
            _loc4_ = _loc4_ + _loc7_.height;
         }
         var _loc8_:int = 0;
         while(_loc8_ < param1.effectComponent.effects.length)
         {
            _loc9_ = this.createEffect(param1.effectComponent.effects[_loc8_]);
            if(_loc9_)
            {
               if(_loc8_ < param1.effectComponent.effects.length - 1)
               {
                  _loc10_ = new ArmamentCompareItemLine();
               }
               param2.addChild(_loc9_);
               if(_loc10_)
               {
                  param2.addChild(_loc10_);
               }
               _loc9_.y = _loc4_;
               _loc4_ = _loc4_ + _loc9_.height;
               if(_loc10_)
               {
                  _loc10_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc10_.height;
               }
            }
            _loc8_++;
         }
         if(param1.location != ItemLocation.Armament)
         {
            _loc11_ = 0;
            while(_loc11_ < param1.effectComponent.effects.length)
            {
               _loc12_ = this.createCompareEffect(param1.effectComponent.effects[_loc11_],param1);
               if(_loc12_)
               {
                  param2.addChild(_loc12_);
                  _loc12_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc12_.height;
               }
               _loc11_++;
            }
         }
         if(param1.location == ItemLocation.ShopBlackMarket || param1.location == ItemLocation.ShopBlackMarket)
         {
            _loc13_ = this.createPriceLine(param1.cash,param1.gold);
            _loc14_ = new ArmamentCompareItemLine();
            param2.addChild(_loc13_);
            param2.addChild(_loc14_);
            _loc13_.y = param2.height;
            _loc14_.y = _loc13_.y - this.MAGIC_FOUR_OFFSET;
         }
         else if(param1.location == ItemLocation.Inventory)
         {
            if(MafiaLayoutManager.getInstance().actState == Constants_LayoutStates.STATE_SHOP)
            {
               _loc15_ = this.marketPriceLine(param1.saleCash);
               _loc16_ = new ArmamentCompareItemLine();
               param2.addChild(_loc15_);
               param2.addChild(_loc16_);
               _loc15_.y = param2.height;
               _loc16_.y = _loc15_.y - this.MAGIC_FOUR_OFFSET;
            }
         }
      }
      
      private function createDependencyOptionalLine(param1:AccessoryVO) : ArmamentItemProperties
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = false;
         var _loc3_:* = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dependency") + " ";
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
            _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
         }
         else
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      private function createItemNameLine(param1:String) : ArmamentNameItemLine
      {
         var _loc2_:ArmamentNameItemLine = new ArmamentNameItemLine();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.leading = 0;
         _loc2_.txt_name.defaultTextFormat = _loc3_;
         _loc2_.txt_name.text = param1;
         _loc2_.txt_name.height = _loc2_.txt_name.textHeight + this.MAGIC_FOUR_OFFSET;
         _loc2_.line.y = _loc2_.height;
         return _loc2_;
      }
      
      private function createAlertLine(param1:AccessoryVO) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
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
      
      private function createEffect(param1:ItemEffectVO) : ArmamentItemProperties
      {
         var _loc2_:TextFormat = new TextFormat();
         var _loc3_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.leading = 0;
         _loc3_.txt_description.defaultTextFormat = _loc2_;
         _loc3_.shop.visible = false;
         _loc3_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffect_" + param1.id,[param1.firstValue,param1.secondValue]);
         _loc3_.txt_description.height = _loc3_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
         return _loc3_;
      }
      
      private function createCompareEffect(param1:ItemEffectVO, param2:AccessoryVO) : ArmamentItemProperties
      {
         var _loc3_:Dictionary = MafiaModel.userData.armament.getItemEffectsToCompare(param2);
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc4_.leading = 0;
         _loc5_.shop.visible = false;
         if(DictionaryUtil.containsKey(MafiaModel.userData.armament.getItemEffectsToCompare(param2),param1.id))
         {
            if(_loc3_[param1.id][0] > param1.firstValue)
            {
               _loc4_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getCompareText(param2.id);
               _loc5_.txt_value.text = String(param1.firstValue - _loc3_[param1.id][0]);
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][0] < param1.firstValue)
            {
               _loc4_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getCompareText(param2.id);
               _loc5_.txt_value.text = "+" + String(param1.firstValue - _loc3_[param1.id][0]);
               _loc5_.txt_description.height = _loc5_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
               return _loc5_;
            }
            if(_loc3_[param1.id][0] == param1.firstValue)
            {
               return _loc5_ = null;
            }
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
      
      private function isWeaponActive(param1:Vector.<WeaponType>) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(MafiaModel.userData.armament.isWeaponTypeActive(ItemType.Weapon,param1[_loc2_]))
            {
               return true;
            }
            if(param1[_loc2_].index == WeaponType.Any.index && MafiaModel.userData.armament.isAtLeastOneWeaponActive())
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function getCompareText(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 1:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_1");
               break;
            case 2:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_2");
               break;
            case 3:
            case 4:
            case 5:
            case 6:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_hitchance");
               break;
            case 7:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_12");
               break;
            case 8:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_3");
         }
         return _loc2_;
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

class SingletonEnforcer#123
{
    
   
   function SingletonEnforcer#123()
   {
      super();
   }
}
