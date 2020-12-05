package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBAttributes;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightAction;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightItem;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightTurn;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFighter;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionConsume;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionHit;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.hit.PBFightActionHitResult;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fighter.PBFighterType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.test.testfight.PBFightTestTestFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.test.testfight.PBFightTestTestFightResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.netease.protobuf.Message;
   import flash.utils.getDefinitionByName;
   
   public class TestFightCommand extends BasicProtobufCommand
   {
       
      
      public function TestFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBFightTestTestFightRequest = null;
         var _loc3_:PBFightTestTestFightResponse = null;
         if(Number(param1))
         {
            _loc2_ = new PBFightTestTestFightRequest();
            _loc2_.fightType = Number(param1);
            ProtobufController.getInstance().sendRequest(_loc2_);
         }
         else
         {
            _loc3_ = new PBFightTestTestFightResponse();
            _loc3_.fight = new PBFight();
            _loc3_.fight.leftFighter = generatePBFighter(MafiaFightResultData.FIGHTER_LEFT);
            _loc3_.fight.rightFighter = generatePBFighter(MafiaFightResultData.FIGHTER_RIGHT);
            switch(param1.toLowerCase())
            {
               case WeaponType.Pistol.toString().toLowerCase():
                  _loc3_.fight.turns = generateFightTurnList(WeaponType.Pistol.index);
                  break;
               case WeaponType.Smg.toString().toLowerCase():
                  _loc3_.fight.turns = generateFightTurnList(WeaponType.Smg.index);
                  break;
               case WeaponType.Shotgun.toString().toLowerCase():
                  _loc3_.fight.turns = generateFightTurnList(WeaponType.Shotgun.index);
                  break;
               case WeaponType.Assault.toString().toLowerCase():
                  _loc3_.fight.turns = generateFightTurnList(WeaponType.Assault.index);
                  break;
               case WeaponType.Sniper.toString().toLowerCase():
                  _loc3_.fight.turns = generateFightTurnList(WeaponType.Sniper.index);
                  break;
               case "heal":
                  _loc3_.fight.turns = generateHealTurnList();
            }
            ProtobufController.getInstance().handleTestResponse(Constants_SFS.PROTOBUF_TEST_FIGHT,_loc3_);
         }
      }
      
      private static function generateHealTurnList() : Array
      {
         var _loc2_:PBFightTurn = null;
         var _loc3_:ItemType = null;
         var _loc4_:int = 0;
         var _loc1_:Array = new Array();
         var _loc5_:PBFightAction = new PBFightAction();
         _loc5_.hit = new PBFightActionHit();
         _loc5_.type = PBFightActionType.HIT;
         _loc3_ = ItemType.Weapon;
         _loc4_ = 1;
         _loc5_.hit.weapon = new PBFightItem();
         _loc5_.hit.weapon.type = _loc3_.index;
         _loc5_.hit.weapon.subType = 1;
         _loc5_.hit.weapon.itemId = 1;
         _loc5_.hit.weapon.quality = _loc4_;
         _loc5_.hit.firstDmg = 1000;
         _loc5_.hit.result = PBFightActionHitResult.HIT;
         _loc2_ = new PBFightTurn();
         _loc2_.attacker = MafiaFightResultData.FIGHTER_RIGHT;
         _loc2_.actions = new Array();
         _loc2_.actions.push(_loc5_);
         _loc1_.push(_loc2_);
         _loc5_ = new PBFightAction();
         _loc5_.hit = null;
         _loc5_.consume = new PBFightActionConsume();
         _loc5_.type = PBFightActionType.CONSUME;
         _loc5_.consume.heal = 2000000;
         _loc5_.consume.item = new PBFightItem();
         _loc5_.consume.item.type = ItemType.Consumable.index;
         _loc5_.consume.item.itemId = 16;
         _loc2_ = new PBFightTurn();
         _loc2_.attacker = MafiaFightResultData.FIGHTER_LEFT;
         _loc2_.actions = new Array();
         _loc2_.actions.push(_loc5_);
         _loc1_.push(_loc2_);
         _loc5_ = new PBFightAction();
         _loc5_.consume = null;
         _loc5_.hit = new PBFightActionHit();
         _loc5_.type = PBFightActionType.HIT;
         _loc3_ = ItemType.Weapon;
         _loc4_ = 1;
         _loc5_.hit.weapon = new PBFightItem();
         _loc5_.hit.weapon.type = _loc3_.index;
         _loc5_.hit.weapon.subType = 1;
         _loc5_.hit.weapon.itemId = 1;
         _loc5_.hit.weapon.quality = _loc4_;
         _loc5_.hit.firstDmg = 1000;
         _loc5_.hit.result = PBFightActionHitResult.HIT;
         _loc2_ = new PBFightTurn();
         _loc2_.attacker = MafiaFightResultData.FIGHTER_RIGHT;
         _loc2_.actions = new Array();
         _loc2_.actions.push(_loc5_);
         _loc1_.push(_loc2_);
         return _loc1_;
      }
      
      private static function isWeaponCat(param1:String) : Boolean
      {
         var _loc2_:Array = [WeaponType.Pistol.toString().toLowerCase(),WeaponType.Shotgun.toString().toLowerCase(),WeaponType.Assault.toString().toLowerCase(),WeaponType.Sniper.toString().toLowerCase(),WeaponType.Smg.toString().toLowerCase()];
         return false;
      }
      
      private static function generateFightTurnList(param1:int, param2:int = 1, param3:int = 100) : Array
      {
         var action:PBFightAction = null;
         var type:ItemType = null;
         var quality:int = 0;
         var itemString:String = null;
         var itemClass:Class = null;
         var subCat:int = param1;
         var firstItemID:int = param2;
         var lastItemID:int = param3;
         var turns:Array = new Array();
         var turn:PBFightTurn = new PBFightTurn();
         turn.attacker = MafiaFightResultData.FIGHTER_LEFT;
         turns.push(turn);
         turn.actions = new Array();
         var actionList:Array = new Array();
         var errorLoading:Boolean = false;
         var id:int = firstItemID;
         while(id <= lastItemID)
         {
            action = new PBFightAction();
            action.hit = new PBFightActionHit();
            action.type = PBFightActionType.HIT;
            type = ItemType.Weapon;
            quality = 1;
            action.hit.weapon = new PBFightItem();
            action.hit.weapon.type = type.index;
            action.hit.weapon.subType = subCat;
            action.hit.weapon.itemId = id;
            action.hit.weapon.quality = quality;
            action.hit.firstDmg = 1000;
            action.hit.result = PBFightActionHitResult.HIT;
            itemString = MafiaItemData.getInstance().generateItemPicClassname(type,subCat,id,quality);
            try
            {
               itemClass = getDefinitionByName(itemString) as Class;
               actionList.push(action);
            }
            catch(e:Error)
            {
            }
            id++;
         }
         (turns[0] as PBFightTurn).actions = actionList;
         return turns;
      }
      
      private static function generatePBFighter(param1:int) : PBFighter
      {
         var _loc2_:PBFighter = new PBFighter();
         _loc2_.attributes = new PBAttributes();
         _loc2_.characterClass = 1;
         _loc2_.gender = 1;
         _loc2_.currentHp = 15000;
         _loc2_.totalHp = 20000;
         _loc2_.level = 213;
         _loc2_.type = PBFighterType.PLAYER;
         if(param1 == MafiaFightResultData.FIGHTER_LEFT)
         {
            _loc2_.name = "Mister Left";
            _loc2_.picString = "2!0~0~2~0~0~4~0~0!0~1~2~0~3~1~5~1~1~0~1~7";
         }
         else
         {
            _loc2_.name = "Mister Right";
            _loc2_.picString = "2!0~5~2~5~4~0~0~0!0~3~0~1~4~6~0~4~4~0~4~7";
         }
         return _loc2_;
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightTestTestFightResponse = param1 as PBFightTestTestFightResponse;
         MafiaDialogHandler.getInstance().blockDialogs = true;
         MafiaModel.userData.duelData.pvpData.createDuelResultData(_loc2_.fight,_loc2_.reward);
         layoutManager.state = Constants_LayoutStates.STATE_DUEL_FIGHT;
         MafiaFightController.getInstance().startFight(MafiaModel.userData.duelData.pvpData.duelResultData,FightType.Duel);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightTestTestFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightTestTestFightResponse;
      }
   }
}
