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
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import com.goodgamestudios.mafia.vo.items.SkillVO;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class MafiaSkillTooltipHelper
   {
      
      private static var _tooltipHelper:MafiaSkillTooltipHelper;
       
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private var specialFontOffset:int;
      
      private const SPECIAL_EFFECT_ID:int = 6;
      
      public function MafiaSkillTooltipHelper(param1:SingletonEnforcer#122)
      {
         super();
         if(_tooltipHelper)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : MafiaSkillTooltipHelper
      {
         if(_tooltipHelper == null)
         {
            _tooltipHelper = new MafiaSkillTooltipHelper(new SingletonEnforcer#122());
         }
         return _tooltipHelper;
      }
      
      public function createTooltipBody(param1:SkillVO, param2:MovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc9_:ArmamentItemProperties = null;
         var _loc10_:ArmamentCompareItemLine = null;
         var _loc11_:int = 0;
         var _loc12_:ArmamentItemProperties = null;
         var _loc13_:ArmamentItemProperties = null;
         var _loc14_:int = 0;
         var _loc15_:ArmamentItemProperties = null;
         var _loc16_:ArmamentItemProperties = null;
         var _loc17_:ArmamentCompareItemLine = null;
         var _loc18_:ArmamentItemProperties = null;
         var _loc19_:ArmamentCompareItemLine = null;
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
         if(this.isWeaponActive(param1.dependencyComponent.dependencies) && param1.location != ItemLocation.Armament)
         {
            _loc11_ = 0;
            while(_loc11_ < param1.effectComponent.effects.length)
            {
               _loc12_ = this.createCompareEffectFirstValue(param1.effectComponent.effects[_loc11_],param1);
               if(_loc12_)
               {
                  param2.addChild(_loc12_);
                  _loc12_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc12_.height;
               }
               _loc13_ = this.createCompareEffectSecondValue(param1.effectComponent.effects[_loc11_],param1);
               if(_loc13_)
               {
                  param2.addChild(_loc13_);
                  _loc13_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc13_.height;
               }
               _loc11_++;
            }
         }
         else if(param1.dependencyComponent.dependencies.length == 0)
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
               _loc14_++;
            }
         }
         if(param1.location == ItemLocation.ShopBlackMarket || param1.location == ItemLocation.ShopSafe)
         {
            _loc16_ = this.createPriceLine(param1.cash,param1.gold);
            _loc17_ = new ArmamentCompareItemLine();
            param2.addChild(_loc16_);
            param2.addChild(_loc17_);
            _loc16_.y = param2.height;
            _loc17_.y = _loc16_.y - this.MAGIC_FOUR_OFFSET;
         }
         else if(param1.location == ItemLocation.Inventory)
         {
            if(MafiaLayoutManager.getInstance().actState == Constants_LayoutStates.STATE_SHOP)
            {
               _loc18_ = this.marketPriceLine(param1.saleCash);
               _loc19_ = new ArmamentCompareItemLine();
               param2.addChild(_loc18_);
               param2.addChild(_loc19_);
               _loc18_.y = param2.height;
               _loc19_.y = _loc18_.y - this.MAGIC_FOUR_OFFSET;
            }
         }
      }
      
      private function createAlertLine(param1:SkillVO) : ArmamentItemProperties
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
      
      private function createDependencyOptionalLine(param1:SkillVO) : ArmamentItemProperties
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
      
      private function createCompareEffectFirstValue(param1:ItemEffectVO, param2:SkillVO) : ArmamentItemProperties
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
               _loc5_.txt_description.text = this.getFirstValueCompareText(param2.id);
               _loc5_.txt_value.text = String(param1.firstValue - _loc3_[param1.id][0]);
               return _loc5_;
            }
            if(_loc3_[param1.id][0] < param1.firstValue)
            {
               _loc4_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_value.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getFirstValueCompareText(param2.id);
               _loc5_.txt_value.text = "+" + String(param1.firstValue - _loc3_[param1.id][0]);
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
      
      private function createCompareEffectSecondValue(param1:ItemEffectVO, param2:SkillVO) : ArmamentItemProperties
      {
         var _loc3_:Dictionary = MafiaModel.userData.armament.getItemEffectsToCompare(param2);
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc4_.leading = 0;
         _loc5_.shop.visible = false;
         if(DictionaryUtil.containsKey(MafiaModel.userData.armament.getItemEffectsToCompare(param2),param1.id))
         {
            if(param2.id != this.SPECIAL_EFFECT_ID && _loc3_[param1.id][1] > param1.secondValue)
            {
               _loc4_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getSecondValueCompareText(param2.id) + " " + String(param1.secondValue - _loc3_[param1.id][1]);
               return _loc5_;
            }
            if(_loc3_[param1.id][1] < param1.secondValue)
            {
               _loc4_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
               _loc5_.txt_description.defaultTextFormat = _loc4_;
               _loc5_.txt_description.text = this.getSecondValueCompareText(param2.id) + " +" + String(param1.secondValue - _loc3_[param1.id][1]);
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
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_6");
               break;
            case 2:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_11");
               break;
            case 3:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_3");
               break;
            case 4:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_4");
               break;
            case 5:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_12");
               break;
            case 6:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_chance");
               break;
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_hitchance");
         }
         return _loc2_;
      }
      
      private function getSecondValueCompareText(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 6:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
            default:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
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
            if(param1[_loc2_].index == WeaponType.Any.index && MafiaModel.userData.armament.isAtLeastOneWeaponActive())
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

class SingletonEnforcer#122
{
    
   
   function SingletonEnforcer#122()
   {
      super();
   }
}
