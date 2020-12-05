package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemSubtype;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemEffect;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.items.AccessoryVO;
   import com.goodgamestudios.mafia.vo.items.ConsumableVO;
   import com.goodgamestudios.mafia.vo.items.ExtraVO;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.SkillVO;
   import com.goodgamestudios.mafia.vo.items.WeaponVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemDependencyComponent;
   import com.goodgamestudios.mafia.vo.items.components.AttributeBonusItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.EffectItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.ExpiringComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import com.goodgamestudios.mafia.vo.items.components.WeaponDamageItemComponent;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaItemData
   {
      
      protected static var itemData:MafiaItemData;
      
      public static const POSITIVE_COMPARE_TEXT_COLOR:int = 7057715;
      
      public static const NEGATIVE_COMPARE_TEXT_COLOR:int = 15356484;
      
      public static const PERC:String = "P";
      
      private static const FORCE_EMBED:Array = [GridSizeIconAccessory,GridSizeIconConsumable,GridSizeIconSkill,GridSizeIconWeapon];
       
      
      private var _blackOutline:GlowFilter;
      
      private var _blackOutlineCombatLog:GlowFilter;
      
      private var _whiteOutline:GlowFilter;
      
      private var _normalColor:int = 5196099;
      
      private var _epicOutline:GlowFilter;
      
      private var _epicColor:int = 15356484;
      
      private var _legendaryOutline:GlowFilter;
      
      private var _legendaryColor:int = 10237433;
      
      private var _premiumOutline:GlowFilter;
      
      public function MafiaItemData()
      {
         super();
         this.init();
         if(itemData)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : MafiaItemData
      {
         if(!itemData)
         {
            itemData = new MafiaItemData();
         }
         return itemData as MafiaItemData;
      }
      
      public static function parseItem(param1:PBItem, param2:ItemLocation, param3:int) : ItemVO
      {
         var _loc4_:ItemVO = null;
         var _loc12_:int = 0;
         var _loc14_:AttributeBonusItemComponent = null;
         var _loc15_:ArmamentItemComponent = null;
         var _loc16_:WeaponDamageItemComponent = null;
         var _loc17_:StackableComponent = null;
         var _loc18_:ExpiringComponent = null;
         var _loc19_:EffectItemComponent = null;
         var _loc20_:PBItemEffect = null;
         var _loc21_:ItemEffectVO = null;
         var _loc22_:ItemEffectVO = null;
         var _loc23_:ArmamentItemDependencyComponent = null;
         var _loc24_:int = 0;
         if(param1 == null || param1.id == 0)
         {
            return null;
         }
         var _loc5_:int = param1.id;
         var _loc6_:ItemType = ProtobufEnumTranslator.translateProtoItemType(param1.type);
         var _loc7_:ItemSubtype = ProtobufEnumTranslator.translateProtoItemSubtype(_loc6_,param1.subType);
         var _loc8_:ItemQuality = ProtobufEnumTranslator.translateProtoItemQuality(param1.quality);
         var _loc9_:int = param1.levels.min;
         var _loc10_:int = param1.levels.max;
         var _loc11_:uint = param1.rounds;
         switch(_loc6_)
         {
            case ItemType.Accessory:
               _loc4_ = new AccessoryVO();
               break;
            case ItemType.Consumable:
               _loc4_ = new ConsumableVO();
               break;
            case ItemType.Food:
               _loc4_ = new FoodVO();
               break;
            case ItemType.Gear:
               _loc4_ = new GearVO();
               break;
            case ItemType.Skill:
               _loc4_ = new SkillVO();
               break;
            case ItemType.Weapon:
               _loc4_ = new WeaponVO();
               break;
            case ItemType.Extra:
               _loc4_ = new ExtraVO();
               break;
            default:
               trace("unknown item type: " + _loc6_);
               return null;
         }
         _loc4_.id = _loc5_;
         _loc4_.type = _loc6_;
         _loc4_.subtype = _loc7_;
         _loc4_.quality = _loc8_;
         _loc4_.minUnlockLevel = _loc9_;
         _loc4_.maxUnlockLevel = _loc10_;
         _loc4_.cash = !param1.isGoldPrice?Number(param1.costs.buy):Number(0);
         _loc4_.gold = !!param1.isGoldPrice?Number(param1.costs.buy):Number(0);
         _loc4_.saleCash = param1.costs.sell;
         _loc4_.location = param2;
         _loc4_.slotId = param3;
         _loc4_.rounds = _loc11_;
         if(_loc4_.type == ItemType.Consumable)
         {
            _loc12_ = 0;
         }
         else
         {
            _loc12_ = _loc4_.subtype.index;
         }
         var _loc13_:String = getPrefixByType(_loc4_.type) + _loc12_ + "_" + _loc4_.id + "_" + _loc4_.quality.index;
         _loc4_.name = MafiaModel.languageData.getTextById(_loc13_);
         _loc4_.categoryName = MafiaModel.languageData.getTextById("item_type_" + _loc4_.type.index);
         _loc4_.categoryNameWithoutQuality = MafiaModel.languageData.getTextById("item_type_" + _loc4_.type.index);
         _loc4_.subcategoryName = MafiaModel.languageData.getTextById(getPrefixByType(_loc4_.type) + "type_" + _loc4_.subtype.index);
         if(_loc4_.quality == ItemQuality.Epic)
         {
            _loc4_.qualityName = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_epic");
            _loc4_.categoryName = _loc4_.categoryName + (" <" + _loc4_.qualityName + ">");
         }
         if(_loc4_.quality == ItemQuality.Legendary)
         {
            _loc4_.qualityName = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_legendary");
            _loc4_.categoryName = _loc4_.categoryName + (" <" + _loc4_.qualityName + ">");
         }
         if(_loc4_.hasComponent(AttributeBonusItemComponent))
         {
            _loc14_ = _loc4_.getComponent(AttributeBonusItemComponent) as AttributeBonusItemComponent;
            _loc14_.attack = param1.attributes.attack;
            _loc14_.toughness = param1.attributes.toughness;
            _loc14_.endurance = param1.attributes.endurance;
            _loc14_.luck = param1.attributes.luck;
            if(_loc4_.type == ItemType.Food)
            {
               _loc14_.attackPerc = true;
               _loc14_.toughnessPerc = true;
               _loc14_.endurancePerc = true;
               _loc14_.luckPerc = true;
            }
         }
         if(_loc4_.hasComponent(ArmamentItemComponent))
         {
            _loc15_ = _loc4_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
            _loc15_.widthInGrid = param1.shape.width;
            _loc15_.heightInGrid = param1.shape.height;
         }
         if(_loc4_.hasComponent(WeaponDamageItemComponent))
         {
            _loc16_ = _loc4_.getComponent(WeaponDamageItemComponent) as WeaponDamageItemComponent;
            _loc16_.minDamage = param1.damage.min;
            _loc16_.maxDamage = param1.damage.max;
            _loc16_.minDamageWithBoni = param1.damage.min;
            _loc16_.maxDamageWithBoni = param1.damage.max;
         }
         if(_loc4_.hasComponent(StackableComponent))
         {
            _loc17_ = _loc4_.getComponent(StackableComponent) as StackableComponent;
            _loc17_.amount = param1.amount;
         }
         if(_loc4_.hasComponent(ExpiringComponent))
         {
            _loc18_ = _loc4_.getComponent(ExpiringComponent) as ExpiringComponent;
            _loc18_.duration = param1.duration.total;
            _loc18_.endTime = getTimer() + param1.duration.remaining * Constants_Basic.SEC2MILLISEC;
            _loc18_.remainingTime = TimeStringHelper.getTimeToString(param1.duration.remaining,TimeStringHelper.ONE_TIME_FORMAT,MafiaModel.languageData.getTextById);
         }
         if(_loc4_.hasComponent(EffectItemComponent))
         {
            _loc19_ = _loc4_.getComponent(EffectItemComponent) as EffectItemComponent;
            _loc19_.effects = new Vector.<ItemEffectVO>();
            for each(_loc20_ in param1.effects)
            {
               _loc21_ = new ItemEffectVO();
               _loc21_.id = _loc20_.id;
               _loc21_.firstValue = Math.round(_loc20_.first * 100);
               if(_loc20_.hasSecond)
               {
                  _loc21_.secondValue = Math.round(_loc20_.second * 100);
               }
               _loc19_.effects.push(_loc21_);
            }
            if(_loc4_.hasComponent(WeaponDamageItemComponent))
            {
               for each(_loc22_ in _loc19_.effects)
               {
                  if(_loc22_.id == 35)
                  {
                     _loc16_.hitChance = _loc22_.firstValue;
                  }
               }
            }
         }
         if(_loc4_.hasComponent(ArmamentItemDependencyComponent))
         {
            _loc23_ = _loc4_.getComponent(ArmamentItemDependencyComponent) as ArmamentItemDependencyComponent;
            _loc23_.dependencies = new Vector.<WeaponType>();
            for each(_loc24_ in param1.dependencies)
            {
               _loc23_.dependencies.push(ProtobufEnumTranslator.translateProtoItemSubtype(ItemType.Weapon,_loc24_) as WeaponType);
            }
         }
         return _loc4_;
      }
      
      public static function getPrefixByType(param1:ItemType) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case ItemType.Gear:
               _loc2_ = "gear_";
               break;
            case ItemType.Food:
               _loc2_ = "food_";
               break;
            case ItemType.Weapon:
               _loc2_ = "weapon_";
               break;
            case ItemType.Consumable:
               _loc2_ = "consumable_";
               break;
            case ItemType.Skill:
               _loc2_ = "skill_";
               break;
            case ItemType.Accessory:
               _loc2_ = "accessory_";
               break;
            case ItemType.Extra:
               _loc2_ = "extras_";
               break;
            case ItemType.None:
               _loc2_ = "Inv0";
         }
         return _loc2_;
      }
      
      public static function shouldUserBeAskedForAmount(param1:ItemVO) : Boolean
      {
         var _loc2_:StackableComponent = param1.getComponent(StackableComponent) as StackableComponent;
         return _loc2_ != null && _loc2_.amount > 1 && param1.type != ItemType.Food;
      }
      
      public static function shouldUserBeAskedForAmountToSell(param1:ItemVO) : Boolean
      {
         var _loc2_:StackableComponent = param1.getComponent(StackableComponent) as StackableComponent;
         return _loc2_ != null && _loc2_.amount > 1;
      }
      
      public static function isShopLocation(param1:ItemLocation) : Boolean
      {
         return param1 == ItemLocation.ShopBlackMarket || param1 == ItemLocation.ShopKiosk || param1 == ItemLocation.ShopConsumables || param1 == ItemLocation.ShopEvent || param1 == ItemLocation.ShopExtras || param1 == ItemLocation.ShopTournament;
      }
      
      public static function getShopLocationByName(param1:String) : ItemLocation
      {
         switch(param1)
         {
            case "weapon":
               return ItemLocation.ShopBlackMarket;
            case "kiosk":
               return ItemLocation.ShopKiosk;
            default:
               return ItemLocation.None;
         }
      }
      
      public static function getColorForItemQuality(param1:ItemVO) : int
      {
         switch(param1.quality)
         {
            case ItemQuality.Epic:
               return getInstance().epicColor;
            case ItemQuality.Legendary:
               return getInstance().legendaryColor;
            default:
               return getInstance().normalColor;
         }
      }
      
      public function init() : void
      {
         this._blackOutline = new GlowFilter(0,1,1.5 * this.scaleFactor,1.5 * this.scaleFactor,20,BitmapFilterQuality.HIGH);
         this._blackOutlineCombatLog = new GlowFilter(0,1,1.25 * this.scaleFactor,1.25 * this.scaleFactor,10,BitmapFilterQuality.HIGH);
         this._whiteOutline = new GlowFilter(16774118,1,1.5 * this.scaleFactor,1.5 * this.scaleFactor,30,BitmapFilterQuality.HIGH);
         this._epicOutline = new GlowFilter(this._epicColor,1,5 * this.scaleFactor,5 * this.scaleFactor,2,BitmapFilterQuality.HIGH);
         this._legendaryOutline = new GlowFilter(this._legendaryColor,1,5 * this.scaleFactor,5 * this.scaleFactor,2,BitmapFilterQuality.HIGH);
      }
      
      public function generateItemIcon(param1:ItemVO) : MovieClip
      {
         var _loc2_:MovieClip = new MovieClip();
         _loc2_.properties = param1;
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         _loc2_.name = "itemIcon";
         var _loc3_:MovieClip = this.generateItemPic(param1.type,param1.subtype,param1.id,param1.quality);
         _loc3_.name = "itemPic";
         _loc2_.addChild(_loc3_);
         var _loc4_:Array = [];
         if(!this.isItemWithoutItemStandardOutline(param1))
         {
            _loc4_.push(this._blackOutline);
         }
         switch(param1.quality)
         {
            case ItemQuality.Normal:
            case ItemQuality.Premium:
               break;
            case ItemQuality.Legendary:
               _loc4_.push(this._whiteOutline,this._legendaryOutline);
               break;
            case ItemQuality.Epic:
               _loc4_.push(this._whiteOutline,this._epicOutline);
         }
         _loc3_.filters = _loc4_;
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(0,0);
         _loc5_.graphics.drawRect(0 - _loc3_.width * 0.5,0 - _loc3_.height * 0.5,_loc3_.width,_loc3_.height);
         _loc5_.graphics.endFill();
         _loc5_.name = "hitbox";
         _loc2_.addChild(_loc5_);
         return _loc2_;
      }
      
      public function generateItemGridSizeIcon(param1:ItemVO) : MovieClip
      {
         var _loc3_:ArmamentItemComponent = null;
         var _loc4_:Class = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:MovieClip = null;
         var _loc2_:MovieClip = null;
         if(param1.hasComponent(ArmamentItemComponent))
         {
            _loc2_ = new MovieClip();
            _loc3_ = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
            switch(param1.type)
            {
               case ItemType.Accessory:
                  _loc4_ = getDefinitionByName("GridSizeIconAccessory") as Class;
                  break;
               case ItemType.Consumable:
                  _loc4_ = getDefinitionByName("GridSizeIconConsumable") as Class;
                  break;
               case ItemType.Skill:
                  _loc4_ = getDefinitionByName("GridSizeIconSkill") as Class;
                  break;
               case ItemType.Weapon:
                  _loc4_ = getDefinitionByName("GridSizeIconWeapon") as Class;
            }
            _loc5_ = 5;
            _loc6_ = 2.5;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.widthInGrid)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc3_.heightInGrid)
               {
                  _loc9_ = new _loc4_();
                  _loc9_.scaleX = _loc9_.scaleY = _loc6_;
                  _loc9_.x = _loc7_ * _loc5_;
                  _loc9_.y = _loc8_ * _loc5_;
                  _loc2_.addChild(_loc9_);
                  _loc8_++;
               }
               _loc7_++;
            }
         }
         return _loc2_;
      }
      
      public function generatePlaceholder(param1:ItemLocation) : MovieClip
      {
         var itemClass:Class = null;
         var placeholder:String = null;
         var location:ItemLocation = param1;
         var item:MovieClip = null;
         switch(location)
         {
            case ItemLocation.ShopBlackMarket:
            case ItemLocation.ShopConsumables:
            case ItemLocation.ShopEvent:
            case ItemLocation.ShopKiosk:
            case ItemLocation.ShopBreakingTheLaw:
            case ItemLocation.ShopExtras:
            case ItemLocation.ShopTournament:
               placeholder = "placeholder_slot";
               break;
            case ItemLocation.ShopSafe:
               placeholder = "placeholder_safe";
               break;
            default:
               placeholder = "";
         }
         try
         {
            itemClass = getDefinitionByName(placeholder) as Class;
            item = new itemClass();
            item.mouseEnabled = false;
            item.mouseChildren = false;
         }
         catch(e:Error)
         {
            trace(e.message);
         }
         return item;
      }
      
      public function generateItemPic(param1:ItemType, param2:ItemSubtype, param3:int, param4:ItemQuality, param5:Boolean = false) : MovieClip
      {
         var itemString:String = null;
         var itemClass:Class = null;
         var type:ItemType = param1;
         var subtype:ItemSubtype = param2;
         var itemID:int = param3;
         var quality:ItemQuality = param4;
         var isCombatLogItem:Boolean = param5;
         var qualityIndex:int = quality.index;
         while(itemClass == null && qualityIndex > 0)
         {
            itemString = this.generateItemPicClassname(type,subtype.index,itemID,qualityIndex);
            try
            {
               itemClass = getDefinitionByName(itemString) as Class;
            }
            catch(e:Error)
            {
               qualityIndex--;
               continue;
            }
         }
         var item:MovieClip = null;
         if(itemClass == null)
         {
            trace("-------------------");
            trace("ITEM PIC NOT FOUND!");
            trace(itemString);
            trace("real item quality: " + quality);
            trace("-------------------");
            itemClass = getDefinitionByName("pic_missing") as Class;
         }
         item = new itemClass();
         if(isCombatLogItem)
         {
            item.filters = [this.combatLogGlowFilter];
         }
         else
         {
            item.filters = [this.itemGlowfilter];
         }
         item.mouseEnabled = false;
         item.mouseChildren = false;
         return item;
      }
      
      public function generateItemPicClassname(param1:ItemType, param2:int, param3:int, param4:int) : String
      {
         var _loc5_:* = "";
         switch(param1)
         {
            case ItemType.Gear:
               _loc5_ = _loc5_ + "gear";
               break;
            case ItemType.Food:
               _loc5_ = _loc5_ + "food";
               break;
            case ItemType.Weapon:
               _loc5_ = _loc5_ + "weapon";
               break;
            case ItemType.Consumable:
               _loc5_ = _loc5_ + "consumables";
               break;
            case ItemType.Skill:
               _loc5_ = _loc5_ + "skill";
               break;
            case ItemType.Accessory:
               _loc5_ = _loc5_ + "accessory";
               break;
            case ItemType.Extra:
               _loc5_ = _loc5_ + "extra";
               break;
            case ItemType.None:
               return "Inv0";
         }
         _loc5_ = _loc5_ + ("_" + param1.index + "_" + param2 + "_" + param3 + "_" + param4);
         return _loc5_;
      }
      
      public function get epicGlowfilter() : GlowFilter
      {
         return this._whiteOutline;
      }
      
      public function get epicTwoGlowfilter() : GlowFilter
      {
         return this._epicOutline;
      }
      
      public function get itemGlowfilter() : GlowFilter
      {
         return this._blackOutline;
      }
      
      public function get combatLogGlowFilter() : GlowFilter
      {
         return this._blackOutlineCombatLog;
      }
      
      public function get legendaryGlowfilter() : GlowFilter
      {
         return this._legendaryOutline;
      }
      
      private function get scaleFactor() : Number
      {
         if(MafiaLayoutManager.getInstance())
         {
            return MafiaLayoutManager.getInstance().scaleFactor;
         }
         return 1;
      }
      
      public function get normalColor() : int
      {
         return this._normalColor;
      }
      
      public function set normalColor(param1:int) : void
      {
         this._normalColor = param1;
         this.init();
      }
      
      public function get epicColor() : int
      {
         return this._epicColor;
      }
      
      public function set epicColor(param1:int) : void
      {
         this._epicColor = param1;
         this.init();
      }
      
      public function get legendaryColor() : int
      {
         return this._legendaryColor;
      }
      
      public function set legendaryColor(param1:int) : void
      {
         this._legendaryColor = param1;
         this.init();
      }
      
      private function isItemWithoutItemStandardOutline(param1:ItemVO) : Boolean
      {
         if(param1.type == ItemType.Skill)
         {
            return true;
         }
         return false;
      }
   }
}
