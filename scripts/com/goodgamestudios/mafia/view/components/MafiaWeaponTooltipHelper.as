package com.goodgamestudios.mafia.view.components
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.language.countries.GGSCountryCodes;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import com.goodgamestudios.mafia.vo.items.WeaponVO;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   
   public class MafiaWeaponTooltipHelper
   {
      
      private static var _tooltipHelper:MafiaWeaponTooltipHelper;
       
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private const BONUS_MALUS_EFFECT:int = 36;
      
      private var specialFontOffset:int;
      
      public function MafiaWeaponTooltipHelper(param1:SingletonEnforcer#121)
      {
         super();
         if(_tooltipHelper)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : MafiaWeaponTooltipHelper
      {
         if(_tooltipHelper == null)
         {
            _tooltipHelper = new MafiaWeaponTooltipHelper(new SingletonEnforcer#121());
         }
         return _tooltipHelper;
      }
      
      public function createTooltipBody(param1:WeaponVO, param2:MovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc10_:ArmamentItemProperties = null;
         var _loc11_:ArmamentCompareItemLine = null;
         var _loc12_:ArmamentItemProperties = null;
         var _loc13_:ArmamentCompareItemLine = null;
         var _loc14_:ArmamentItemProperties = null;
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
         param2.addChild(_loc5_);
         _loc4_ = _loc4_ + _loc5_.height;
         var _loc6_:ArmamentNameItemLine = this.createItemNameLine(param1.name);
         param2.addChild(_loc6_);
         _loc6_.y = _loc4_;
         _loc4_ = _loc4_ + _loc6_.height;
         if(MafiaModel.userData.armament.containsItem(param1))
         {
            _loc10_ = this.createAlertLine(param1);
            if(_loc10_)
            {
               param2.addChild(_loc10_);
               _loc10_.y = _loc4_;
               _loc4_ = _loc4_ + _loc10_.height;
            }
         }
         var _loc7_:ArmamentItemProperties = this.createDamageLine(param1.weaponDamage.minDamageWithBoni,param1.weaponDamage.maxDamageWithBoni);
         param2.addChild(_loc7_);
         _loc7_.y = _loc4_;
         _loc4_ = _loc4_ + _loc7_.height;
         var _loc8_:ArmamentItemCompare = this.createhitChanceLine(param1.weaponDamage.hitChance);
         param2.addChild(_loc8_);
         if(param1.effectComponent.effects.length > 1)
         {
            _loc11_ = new ArmamentCompareItemLine();
            param2.addChild(_loc11_);
         }
         _loc8_.y = _loc4_;
         _loc4_ = _loc4_ + _loc8_.height;
         if(GGSCountryController.instance.currentCountry.ggsCountryCode == GGSCountryCodes.GREECE)
         {
            _loc4_ = _loc4_ - 13;
         }
         if(_loc11_)
         {
            _loc11_.y = _loc4_;
            _loc4_ = _loc4_ + _loc11_.height;
         }
         var _loc9_:int = 1;
         while(_loc9_ < param1.effectComponent.effects.length)
         {
            _loc12_ = this.createEffect(param1.effectComponent.effects[_loc9_]);
            param2.addChild(_loc12_);
            _loc12_.y = _loc4_;
            _loc4_ = _loc4_ + _loc12_.height;
            if(GGSCountryController.instance.currentCountry.ggsCountryCode == GGSCountryCodes.GREECE)
            {
               _loc4_ = _loc4_ - 13;
            }
            _loc9_++;
         }
         if(MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_OTHERPROFILE && (MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_DUEL_PREPARE || (MafiaModel.userData.armament.containsItem(param1) || MafiaModel.userData.inventory.containsItem(param1))))
         {
            if(this.createMinDamageCompare(param1) || this.createMaxDamageCompare(param1))
            {
               _loc13_ = new ArmamentCompareItemLine();
               if(_loc13_)
               {
                  param2.addChild(_loc13_);
                  _loc13_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc13_.height;
               }
            }
            if(this.createMinDamageCompare(param1))
            {
               _loc14_ = this.createMinDamageCompare(param1);
               param2.addChild(_loc14_);
               _loc14_.y = _loc4_;
               _loc4_ = _loc4_ + _loc14_.height;
            }
            if(this.createMaxDamageCompare(param1))
            {
               _loc15_ = this.createMaxDamageCompare(param1);
               param2.addChild(_loc15_);
               _loc15_.y = _loc4_;
               _loc4_ = _loc4_ + _loc15_.height;
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
      
      private function createDependencyOptionalLine(param1:WeaponVO) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = false;
         _loc2_.txt_description.text = String(param1.subcategoryName);
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
         _loc2_.line.y = _loc2_.height;
         return _loc2_;
      }
      
      private function createAlertLine(param1:WeaponVO) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.color = 16711680;
         _loc3_.leading = 0;
         _loc2_.shop.visible = false;
         _loc2_.txt_description.defaultTextFormat = _loc3_;
         param1.armamentComponent.isActive;
         if(param1.armamentComponent.isActive)
         {
            return null;
         }
         if(!param1.armamentComponent.isActive)
         {
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_inactiveReason_2");
            _loc2_.txt_description.height = _loc2_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
            return _loc2_;
         }
         return null;
      }
      
      private function createDamageLine(param1:Number, param2:Number) : ArmamentItemProperties
      {
         var _loc3_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc3_.shop.visible = false;
         _loc3_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
         _loc3_.txt_value.text = param1 + "-" + param2;
         return _loc3_;
      }
      
      private function createhitChanceLine(param1:Number) : ArmamentItemCompare
      {
         var _loc2_:TextFormat = new TextFormat();
         var _loc3_:ArmamentItemCompare = new ArmamentItemCompare();
         _loc2_.leading = 0;
         _loc3_.txt_description.defaultTextFormat = _loc2_;
         _loc3_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_hitchance");
         _loc3_.txt_description.height = _loc3_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET;
         _loc3_.txt_value.text = String(param1) + "%";
         return _loc3_;
      }
      
      private function createEffect(param1:ItemEffectVO) : ArmamentItemProperties
      {
         var _loc2_:TextFormat = new TextFormat();
         var _loc3_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.leading = 0;
         _loc3_.txt_description.defaultTextFormat = _loc2_;
         _loc3_.shop.visible = false;
         if(param1.id == this.BONUS_MALUS_EFFECT)
         {
            _loc3_.txt_description.text = this.bonusDamageText(param1.firstValue,ProtobufEnumTranslator.translateProtoCharacterClass(param1.secondValue));
         }
         else
         {
            _loc3_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffect_" + param1.id,[param1.firstValue,param1.secondValue]);
         }
         _loc3_.txt_description.height = _loc3_.txt_description.textHeight + this.MAGIC_FOUR_OFFSET + this.specialFontOffset;
         return _loc3_;
      }
      
      private function createMaxDamageCompare(param1:WeaponVO) : ArmamentItemProperties
      {
         var _loc6_:int = 0;
         var _loc7_:WeaponVO = null;
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc3_:TextFormat = new TextFormat();
         _loc2_.shop.visible = false;
         var _loc4_:Number = 0;
         var _loc5_:Vector.<ArmamentItemVO> = MafiaModel.userData.armament.getActiveItemsByType(ItemType.Weapon);
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc6_] as WeaponVO;
            if(_loc7_.weaponDamage.maxDamageWithBoni > _loc4_)
            {
               _loc4_ = _loc7_.weaponDamage.maxDamageWithBoni;
            }
            _loc6_++;
         }
         if(_loc4_ < param1.weaponDamage.maxDamageWithBoni)
         {
            _loc3_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
            _loc2_.txt_description.defaultTextFormat = _loc3_;
            _loc2_.txt_value.defaultTextFormat = _loc3_;
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_maxdmg");
            _loc2_.txt_value.text = "+" + (param1.weaponDamage.maxDamageWithBoni - _loc4_);
         }
         else if(_loc4_ > param1.weaponDamage.maxDamageWithBoni)
         {
            _loc3_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
            _loc2_.txt_description.defaultTextFormat = _loc3_;
            _loc2_.txt_value.defaultTextFormat = _loc3_;
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_maxdmg");
            _loc2_.txt_value.text = String(param1.weaponDamage.maxDamageWithBoni - _loc4_);
         }
         else if(_loc4_ == param1.weaponDamage.maxDamageWithBoni)
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      private function createMinDamageCompare(param1:WeaponVO) : ArmamentItemProperties
      {
         var _loc6_:int = 0;
         var _loc7_:WeaponVO = null;
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         var _loc3_:TextFormat = new TextFormat();
         _loc2_.shop.visible = false;
         var _loc4_:Number = 0;
         var _loc5_:Vector.<ArmamentItemVO> = MafiaModel.userData.armament.getActiveItemsByType(ItemType.Weapon);
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc6_] as WeaponVO;
            if(_loc7_.weaponDamage.minDamageWithBoni > _loc4_)
            {
               _loc4_ = _loc7_.weaponDamage.minDamageWithBoni;
            }
            _loc6_++;
         }
         if(_loc4_ < param1.weaponDamage.minDamageWithBoni)
         {
            _loc3_.color = MafiaItemData.POSITIVE_COMPARE_TEXT_COLOR;
            _loc2_.txt_description.defaultTextFormat = _loc3_;
            _loc2_.txt_value.defaultTextFormat = _loc3_;
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_mindmg");
            _loc2_.txt_value.text = "+" + (param1.weaponDamage.minDamageWithBoni - _loc4_);
         }
         else if(_loc4_ > param1.weaponDamage.minDamageWithBoni)
         {
            _loc3_.color = MafiaItemData.NEGATIVE_COMPARE_TEXT_COLOR;
            _loc2_.txt_description.defaultTextFormat = _loc3_;
            _loc2_.txt_value.defaultTextFormat = _loc3_;
            _loc2_.txt_description.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_mindmg");
            _loc2_.txt_value.text = String(param1.weaponDamage.minDamageWithBoni - _loc4_);
         }
         else if(_loc4_ == param1.weaponDamage.minDamageWithBoni)
         {
            _loc2_ = null;
         }
         return _loc2_;
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
      
      private function marketPriceLine(param1:Number) : ArmamentItemProperties
      {
         var _loc2_:ArmamentItemProperties = new ArmamentItemProperties();
         _loc2_.shop.visible = true;
         _loc2_.shop.gotoAndStop(1);
         _loc2_.txt_value.text = String(param1);
         return _loc2_;
      }
      
      private function bonusDamageText(param1:int, param2:CharacterClass) : String
      {
         var _loc3_:String = null;
         switch(param2)
         {
            case CharacterClass.Bully:
               if(param1 > 0)
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamagePositive_class1",[param1]);
               }
               else
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamageNegative_class1",[param1 * -1]);
               }
               break;
            case CharacterClass.Rogue:
               if(param1 > 0)
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamagePositive_class2",[param1]);
               }
               else
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamageNegative_class2",[param1 * -1]);
               }
               break;
            case CharacterClass.Tactician:
               if(param1 > 0)
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamagePositive_class3",[param1]);
               }
               else
               {
                  _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_bonusDamageNegative_class3",[param1 * -1]);
               }
         }
         return _loc3_;
      }
   }
}

class SingletonEnforcer#121
{
    
   
   function SingletonEnforcer#121()
   {
      super();
   }
}
