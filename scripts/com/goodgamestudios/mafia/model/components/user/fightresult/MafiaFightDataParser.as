package com.goodgamestudios.mafia.model.components.user.fightresult
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightAction;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightItem;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightTurn;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFighter;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionConsume;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionEffect;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionHit;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fighter.PBFighterType;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import com.goodgamestudios.mafia.vo.fight.FightTurnVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionConsumeVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionEffectVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionHitVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   
   public class MafiaFightDataParser
   {
       
      
      public function MafiaFightDataParser()
      {
         super();
      }
      
      public static function parseFighter(param1:PBFighter, param2:Number = 1.0, param3:Number = 1.0) : FighterVO
      {
         var _loc4_:FighterVO = new FighterVO();
         _loc4_.id = param1.id;
         _loc4_.totalHitpoints = param1.totalHp;
         _loc4_.currentHitpoints = param1.currentHp;
         _loc4_.attack = param1.attributes.attack;
         _loc4_.toughness = param1.attributes.toughness;
         _loc4_.endurance = param1.attributes.endurance;
         _loc4_.luck = param1.attributes.luck;
         _loc4_.characterClass = ProtobufEnumTranslator.translateProtoCharacterClass(param1.characterClass);
         _loc4_.characterClassMC = AvatarHelper.createClassSymbol(_loc4_.characterClass);
         _loc4_.level = param1.level;
         _loc4_.gender = ProtobufEnumTranslator.translateProtoCharacterGender(param1.gender);
         _loc4_.effects = new Vector.<FightActionEffectVO>();
         _loc4_.effectsLastRound = new Vector.<FightActionEffectVO>();
         if(param1.type == PBFighterType.NPC)
         {
            _loc4_.typeMC = AvatarHelper.createAvatarByPicID(param1.id);
            _loc4_.typeMC.scaleX = _loc4_.typeMC.scaleY = param2;
            _loc4_.name = "NPC";
         }
         else if(param1.type == PBFighterType.PLAYER)
         {
            if(param1.hasPicString)
            {
               _loc4_.typeMC = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(param1.picString),param2,true,param3);
            }
            else
            {
               trace("server error: picString is required for players");
            }
            if(param1.hasName)
            {
               _loc4_.name = param1.name;
            }
            else
            {
               trace("server error: name is required for players");
            }
         }
         return _loc4_;
      }
      
      public static function parseReward(param1:PBReward) : RewardVO
      {
         var _loc2_:RewardVO = new RewardVO();
         if(param1)
         {
            _loc2_.cash = param1.cash;
            _loc2_.gold = param1.gold;
            _loc2_.ap = param1.activity;
            _loc2_.xp = param1.xp;
            _loc2_.honor = param1.glory;
            if(param1.hasItem)
            {
               _loc2_.item = MafiaItemData.parseItem(param1.item,ItemLocation.Inventory,0);
            }
         }
         return _loc2_;
      }
      
      public static function parseFightTurns(param1:Array) : Vector.<FightTurnVO>
      {
         var _loc3_:PBFightTurn = null;
         var _loc4_:FightTurnVO = null;
         var _loc5_:FightTurnVO = null;
         var _loc2_:Vector.<FightTurnVO> = new Vector.<FightTurnVO>();
         for each(_loc3_ in param1)
         {
            _loc4_ = new FightTurnVO();
            _loc4_.fighterOnTurn = _loc3_.attacker;
            _loc4_.actions = parseFightActions(_loc3_.actions,_loc4_.fighterOnTurn);
            if(_loc2_.length > 0 && _loc2_[_loc2_.length - 1].fighterOnTurn == _loc4_.fighterOnTurn)
            {
               _loc5_ = new FightTurnVO();
               if(_loc4_.fighterOnTurn == MafiaFightResultData.FIGHTER_LEFT)
               {
                  _loc5_.fighterOnTurn = MafiaFightResultData.FIGHTER_RIGHT;
               }
               else
               {
                  _loc5_.fighterOnTurn = MafiaFightResultData.FIGHTER_LEFT;
               }
               _loc5_.actions = new Vector.<FightActionVO>();
               _loc2_.push(_loc5_);
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function parseFightAmmunition(param1:Array) : Vector.<FightItemVO>
      {
         var _loc3_:PBFightItem = null;
         var _loc4_:FightItemVO = null;
         var _loc2_:Vector.<FightItemVO> = new Vector.<FightItemVO>();
         for each(_loc3_ in param1)
         {
            _loc4_ = new FightItemVO();
            _loc4_ = parseFightItem(_loc3_);
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      private static function parseFightActions(param1:Array, param2:int) : Vector.<FightActionVO>
      {
         var _loc4_:PBFightAction = null;
         var _loc5_:FightActionVO = null;
         var _loc6_:FightActionVO = null;
         var _loc7_:FightItemVO = null;
         var _loc3_:Vector.<FightActionVO> = new Vector.<FightActionVO>();
         for each(_loc4_ in param1)
         {
            _loc5_ = new FightActionVO();
            _loc6_ = null;
            _loc7_ = null;
            if(_loc4_.hasHit)
            {
               _loc5_.hit = parseFightActionHit(_loc4_.hit);
               _loc7_ = _loc5_.hit.weapon;
               if(_loc4_.hasConsume)
               {
                  _loc6_ = new FightActionVO();
                  _loc6_.consume = parseFightActionConsume(_loc4_.consume);
                  _loc6_.type = PBFightActionType.CONSUME;
               }
            }
            else if(_loc4_.hasConsume)
            {
               _loc5_.consume = parseFightActionConsume(_loc4_.consume);
               _loc7_ = _loc5_.consume.item;
            }
            if(_loc4_.hasEffect)
            {
               _loc5_.effect = parseFightActionEffect(_loc4_.effect,param2,_loc7_);
            }
            _loc5_.type = _loc4_.type;
            _loc3_.push(_loc5_);
            if(_loc6_)
            {
               _loc3_.push(_loc6_);
            }
         }
         return _loc3_;
      }
      
      private static function parseFightActionConsume(param1:PBFightActionConsume) : FightActionConsumeVO
      {
         var _loc2_:FightActionConsumeVO = new FightActionConsumeVO();
         _loc2_.item = parseFightItem(param1.item);
         if(param1.hasDamage)
         {
            _loc2_.damage = param1.damage;
         }
         if(param1.hasHeal)
         {
            _loc2_.heal = param1.heal;
         }
         return _loc2_;
      }
      
      private static function parseFightActionEffect(param1:PBFightActionEffect, param2:int, param3:FightItemVO) : FightActionEffectVO
      {
         var _loc4_:FightActionEffectVO = new FightActionEffectVO();
         _loc4_.id = param1.id;
         _loc4_.duration = param1.duration * 2;
         _loc4_.durationLeft = _loc4_.duration;
         _loc4_.target = param1.target;
         _loc4_.item = param3;
         switch(_loc4_.id)
         {
            case 15:
               _loc4_.description = MafiaModel.languageData.getTextById("MafiaFightScreen_buff_copy_2");
               break;
            case 10:
            case 23:
               _loc4_.description = MafiaModel.languageData.getTextById("MafiaFightScreen_buff_copy_3");
               break;
            case 16:
               _loc4_.description = MafiaModel.languageData.getTextById("MafiaFightScreen_buff_copy_4");
               break;
            case 12:
               _loc4_.description = MafiaModel.languageData.getTextById("MafiaFightScreen_buff_copy_5");
               break;
            case 37:
               _loc4_.description = MafiaModel.languageData.getTextById("MafiaFightScreen_buff_copy_7");
               break;
            default:
               _loc4_.description = "Error: Tooltip text missing";
         }
         if(_loc4_.target == param2)
         {
            _loc4_.buffType = FightActionEffectVO.BUFF;
         }
         else
         {
            _loc4_.buffType = FightActionEffectVO.DEBUFF;
         }
         return _loc4_;
      }
      
      private static function parseFightActionHit(param1:PBFightActionHit) : FightActionHitVO
      {
         var _loc2_:FightActionHitVO = new FightActionHitVO();
         _loc2_.result = param1.result;
         _loc2_.weapon = parseFightItem(param1.weapon);
         _loc2_.firstDamage = param1.firstDmg;
         _loc2_.secondDamage = param1.secondDmg;
         _loc2_.isCritical = param1.critical;
         return _loc2_;
      }
      
      private static function parseFightItem(param1:PBFightItem) : FightItemVO
      {
         var _loc2_:FightItemVO = new FightItemVO();
         _loc2_.id = param1.itemId;
         _loc2_.type = ProtobufEnumTranslator.translateProtoItemType(param1.type);
         if(param1.hasSubType)
         {
            _loc2_.subtype = ProtobufEnumTranslator.translateProtoItemSubtype(_loc2_.type,param1.subType);
         }
         _loc2_.quality = ProtobufEnumTranslator.translateProtoItemQuality(param1.quality);
         return _loc2_;
      }
   }
}
