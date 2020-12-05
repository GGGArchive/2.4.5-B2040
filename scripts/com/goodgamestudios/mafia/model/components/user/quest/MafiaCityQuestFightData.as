package com.goodgamestudios.mafia.model.components.user.quest
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_City_Quests;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaCityQuestFightData
   {
       
      
      private var _picId:int;
      
      private var _level:int;
      
      private var _items:Vector.<ItemVO>;
      
      public var cityBonusFightResultData:MafiaFightResultData;
      
      public var reward:RewardVO;
      
      public var cityEnemyName:String;
      
      public var nextFreeDuelFightTime:Number;
      
      public var lastGangwarVO:GangwarVO;
      
      public function MafiaCityQuestFightData()
      {
         super();
      }
      
      public function parseCityFightItems(param1:Array, param2:int, param3:int) : void
      {
         var _loc4_:PBItem = null;
         var _loc5_:ItemVO = null;
         this.picId = param2;
         this.level = param3;
         this.items = new Vector.<ItemVO>();
         for each(_loc4_ in param1)
         {
            _loc5_ = new ItemVO();
            _loc5_ = MafiaItemData.parseItem(_loc4_,ItemLocation.None,0);
            this.items.push(_loc5_);
         }
         BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_CITY_FIGHT_ITEMS_DATA));
      }
      
      public function parseCityFight(param1:int, param2:int, param3:Number = 0) : void
      {
         if(param3 > 0)
         {
            this.nextFreeDuelFightTime = getTimer() + param3 * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            this.nextFreeDuelFightTime = 0;
         }
         this.picId = param1;
         this.level = param2;
         BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_CITY_FIGHT_DATA));
      }
      
      public function get picId() : int
      {
         return this._picId;
      }
      
      public function set picId(param1:int) : void
      {
         this._picId = param1;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get items() : Vector.<ItemVO>
      {
         return this._items;
      }
      
      public function set items(param1:Vector.<ItemVO>) : void
      {
         this._items = param1;
      }
      
      public function parseCityFightResultData(param1:PBFight, param2:PBReward) : void
      {
         var _loc5_:String = null;
         this.cityBonusFightResultData = new MafiaFightResultData();
         this.cityEnemyName = "";
         this.cityBonusFightResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.cityBonusFightResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         var _loc3_:Class = getDefinitionByName("Enemy" + Constants_City_Quests.ENEMY_PIC_ID_LIST[this.cityBonusFightResultData.fighterRight.id - 1][1]) as Class;
         this.cityBonusFightResultData.fighterRight.typeMC = new _loc3_();
         this.cityBonusFightResultData.fighterRight.typeMC.scaleX = this.cityBonusFightResultData.fighterRight.typeMC.scaleY = 0.5;
         var _loc4_:int = this.cityBonusFightResultData.fighterRight.id - 1;
         if(Constants_City_Quests.ENEMY_NAME_LIST[_loc4_][2] == true)
         {
            _loc5_ = "MafiaEnemyName_male_";
         }
         else
         {
            _loc5_ = "MafiaEnemyName_female_";
         }
         this.cityEnemyName = MafiaModel.languageData.getTextById(_loc5_ + Constants_City_Quests.ENEMY_NAME_LIST[_loc4_][0]);
         this.cityEnemyName = this.cityEnemyName + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_" + Constants_City_Quests.ENEMY_NAME_LIST[_loc4_][1]));
         this.cityBonusFightResultData.fighterRight.name = this.cityEnemyName;
         this.cityBonusFightResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.cityBonusFightResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
      }
      
      public function checkDuelTime(param1:Number) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = this.nextFreeDuelFightTime - param1;
         if(_loc2_ <= 0)
         {
            this.nextFreeDuelFightTime = 0;
            BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.REMOVE_CITY_FIGHT_TIMER));
         }
         else
         {
            _loc3_ = new Array();
            _loc3_.push(TimeStringHelper.getShortTimeString(this.nextFreeDuelFightTime - param1));
            BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_CITY_FIGHT_TIMER,_loc3_));
         }
      }
   }
}
