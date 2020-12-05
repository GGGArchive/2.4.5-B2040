package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.commands.travels.ShowTravelPossibilitiesCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.PBSpecialeventCityCityEventProgressResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.response.PBSpecialeventCityShowCityEventOpponentsOpponent;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.PBSpecialeventCityEventResponse;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianFinishedDialog;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarOpponentVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaSicilianEvent extends MafiaSpecialEvent
   {
      
      public static const MISSION_GIVER_ID:int = 4;
      
      public static const PROGRESS_STATE_INACTIVE:uint = 1;
      
      public static const PROGRESS_STATE_MISSION_PHASE:uint = 2;
      
      public static const PROGRESS_STATE_FIGHT:uint = 3;
      
      public static const PROGRESS_STATE_FIGHT_ON_MAP:uint = 4;
      
      public static const PROGRESS_STATE_FINISHED_SUCCESS:uint = 5;
      
      public static const PROGRESS_STATE_FINISHED_FAILURE:uint = 6;
       
      
      private var _goldCosts:int;
      
      private var _restTimeForMissionPhase:int;
      
      private var _restTimeForFightPhase:int;
      
      public var gangwarOpponents:Vector.<GangwarOpponentVO>;
      
      public var gangwarProgress:int = 0;
      
      public var gangwarFightResultData:MafiaFightResultData;
      
      public var reward:RewardVO;
      
      private var _missionCooldown:int;
      
      private var _fightCooldown:int;
      
      private var _solvedMissions:int;
      
      private var _gangwarEnemiesKilled:int;
      
      private var _item:ItemVO;
      
      private var _totalMissions:uint;
      
      private var _state:uint;
      
      private var _isFlyingFromSicilia:Boolean;
      
      private var _isFlyingToSicilia:Boolean;
      
      private const SICILIAN_BEAST_REWARD:int = 193;
      
      public function MafiaSicilianEvent()
      {
         _eventId = Constants_SpecialEvents.ID_SICILIAN;
         super();
      }
      
      public function get solvedMissions() : int
      {
         return Math.min(this._solvedMissions,this._totalMissions);
      }
      
      public function parseGangwarData(param1:Array, param2:int, param3:Number) : void
      {
         var _loc6_:PBSpecialeventCityShowCityEventOpponentsOpponent = null;
         var _loc7_:GangwarOpponentVO = null;
         var _loc8_:Class = null;
         this.gangwarProgress = param2;
         this.gangwarOpponents = new Vector.<GangwarOpponentVO>();
         var _loc4_:Array = param1;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_] as PBSpecialeventCityShowCityEventOpponentsOpponent;
            _loc7_ = new GangwarOpponentVO();
            _loc7_.picID = _loc6_.picureId;
            _loc7_.nameID = _loc6_.nameId;
            _loc7_.opponentLevel = _loc6_.level;
            _loc7_.gender = CharacterGender.getById(int(_loc6_.gender));
            _loc8_ = getDefinitionByName("Enemy" + _loc7_.picID) as Class;
            _loc7_.picMC = new _loc8_();
            this.gangwarOpponents.push(_loc7_);
            _loc5_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_OPPONENT_DATA,[this.gangwarOpponents,this.gangwarProgress]));
      }
      
      public function parseGangwarResultData(param1:PBFight, param2:PBReward) : void
      {
         var _loc3_:Class = null;
         this.gangwarFightResultData = new MafiaFightResultData();
         this.gangwarFightResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.gangwarFightResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         if(param2.hasItem && param2.item.id == this.SICILIAN_BEAST_REWARD)
         {
            MafiaDialogHandler.getInstance().registerDialogs(MafiaSicilianFinishedDialog.NAME,null,true,BasicDialogHandler.PRIORITY_HIGH);
         }
         _loc3_ = getDefinitionByName("Enemy" + this.gangwarFightResultData.fighterRight.id) as Class;
         this.gangwarFightResultData.fighterRight.typeMC = new _loc3_();
         this.gangwarFightResultData.fighterRight.typeMC.scaleX = Constants_ViewScales.SCALE_GANGWAR_PICS_IN_FIGHT;
         this.gangwarFightResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_GANGWAR_PICS_IN_FIGHT;
         this.gangwarFightResultData.fighterRight.name = MafiaModel.languageData.getTextById("event_sicilianbeast_enemy_" + this.gangwarOpponents[this.gangwarProgress].nameID);
         this.gangwarFightResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.gangwarFightResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
      }
      
      public function parseEventDetails(param1:PBSpecialeventCityEventResponse) : void
      {
         this.checkGangwarStatus(this._state,param1.state);
         this._state = param1.state;
         this._restTimeForMissionPhase = getTimer() + param1.timeForMission * Constants_Basic.SEC2MILLISEC;
         this._restTimeForFightPhase = getTimer() + param1.timeToEnd * Constants_Basic.SEC2MILLISEC;
         this._goldCosts = param1.instantMissionCooldownGold;
         this._item = MafiaItemData.parseItem(param1.finalReward,ItemLocation.None,0);
         this.completeParsing();
      }
      
      public function parseProgressDetails(param1:PBSpecialeventCityCityEventProgressResponse) : void
      {
         this.checkGangwarStatus(this._state,param1.state);
         this._state = param1.state;
         this._solvedMissions = param1.mission;
         this._totalMissions = param1.missionCount;
         this._gangwarEnemiesKilled = param1.fight;
         this._missionCooldown = getTimer() + param1.missionCooldown * Constants_Basic.SEC2MILLISEC;
         this._fightCooldown = getTimer() + param1.fightCooldown * Constants_Basic.SEC2MILLISEC;
         this._isFlyingFromSicilia = param1.isFlyingFromEvent;
         this._isFlyingToSicilia = param1.isFlyingToEvent;
         this.completeParsing();
      }
      
      private function completeParsing() : void
      {
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,[this]));
         if(this._state == PROGRESS_STATE_INACTIVE || this._state == PROGRESS_STATE_FINISHED_FAILURE || this._state == PROGRESS_STATE_FINISHED_SUCCESS)
         {
            ShowGangWarsCommand.sendCommand();
            ShowTravelPossibilitiesCommand.sendCommand();
         }
         if(this._state == PROGRESS_STATE_INACTIVE || this._state == PROGRESS_STATE_FINISHED_FAILURE)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,[eventId]));
         }
      }
      
      private function checkGangwarStatus(param1:int, param2:int) : void
      {
         if(param1 != PROGRESS_STATE_FIGHT_ON_MAP && param2 == PROGRESS_STATE_FIGHT_ON_MAP)
         {
            ShowGangWarsCommand.sendCommand();
         }
         if(param1 != PROGRESS_STATE_FIGHT && param2 == PROGRESS_STATE_FIGHT)
         {
            ShowGangWarsCommand.sendCommand();
         }
      }
      
      override public function get runTimeString() : String
      {
         return TimeStringHelper.getTimeToString(this.runTimeInSeconds,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
      }
      
      override public function get runTimeInSeconds() : Number
      {
         var _loc1_:Number = NaN;
         if(this.state == PROGRESS_STATE_MISSION_PHASE)
         {
            _loc1_ = this.restTimeForMissionPhase;
         }
         else if(this.state == PROGRESS_STATE_FIGHT || this.state == PROGRESS_STATE_FIGHT_ON_MAP)
         {
            _loc1_ = this.restTimeForFightPhase;
         }
         return _loc1_ * Constants_Basic.MILLISEC2SEC;
      }
      
      public function get missionCooldownTimeString() : String
      {
         return TimeStringHelper.getTimeToString(this.missionCooldown,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
      }
      
      public function get fightCooldownTimeString() : String
      {
         return TimeStringHelper.getTimeToString(this.fightCooldown,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
      }
      
      public function get isSicilianMission() : Boolean
      {
         return isEventActive && !this.isMissionPhaseFinished && MafiaModel.userData.progressData.missionGiverID == MISSION_GIVER_ID;
      }
      
      public function get isMissionPhaseFinished() : Boolean
      {
         return this._state != PROGRESS_STATE_MISSION_PHASE;
      }
      
      public function get missionGiverActive() : Boolean
      {
         var _loc1_:Boolean = true;
         switch(this.state)
         {
            case PROGRESS_STATE_FINISHED_FAILURE:
            case PROGRESS_STATE_FINISHED_SUCCESS:
            case PROGRESS_STATE_INACTIVE:
               _loc1_ = false;
            default:
               _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function get isEventOver() : Boolean
      {
         return this.state == PROGRESS_STATE_FINISHED_FAILURE || this.state == PROGRESS_STATE_INACTIVE;
      }
      
      public function get isMissionGiverActive() : Boolean
      {
         return this.state != PROGRESS_STATE_FINISHED_FAILURE && this.state != PROGRESS_STATE_INACTIVE && this.state != PROGRESS_STATE_FINISHED_SUCCESS;
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(isEventActive)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,[this.runTimeString]));
         }
      }
      
      public function get gangwarEnemiesKilled() : int
      {
         return this._gangwarEnemiesKilled;
      }
      
      public function set gangwarEnemiesKilled(param1:int) : void
      {
         this._gangwarEnemiesKilled = param1;
      }
      
      public function get totalMissions() : uint
      {
         return this._totalMissions;
      }
      
      public function get item() : ItemVO
      {
         return this._item;
      }
      
      public function get state() : uint
      {
         return this._state;
      }
      
      public function get finishedSicilian() : Boolean
      {
         return this._state == PROGRESS_STATE_FINISHED_FAILURE || this._state == PROGRESS_STATE_FINISHED_SUCCESS;
      }
      
      public function get finishedSicilianSuccess() : Boolean
      {
         return this._state == PROGRESS_STATE_FINISHED_SUCCESS;
      }
      
      public function get isSicilyAndFightOnMap() : Boolean
      {
         return this._state == PROGRESS_STATE_FIGHT_ON_MAP;
      }
      
      public function get restTimeForMissionPhase() : int
      {
         return this._restTimeForMissionPhase - getTimer();
      }
      
      public function get restTimeForFightPhase() : int
      {
         return this._restTimeForFightPhase - getTimer();
      }
      
      public function get missionCooldown() : int
      {
         return (this._missionCooldown - getTimer()) * Constants_Basic.MILLISEC2SEC;
      }
      
      public function get fightCooldown() : int
      {
         return (this._fightCooldown - getTimer()) * Constants_Basic.MILLISEC2SEC;
      }
      
      public function get goldCosts() : int
      {
         return this._goldCosts;
      }
      
      public function set missionCooldown(param1:int) : void
      {
         this._missionCooldown = getTimer() + param1 * Constants_Basic.SEC2MILLISEC;
      }
      
      public function get isFlyingFromSicilia() : Boolean
      {
         return this._isFlyingFromSicilia;
      }
      
      public function get isFlyingToSicilia() : Boolean
      {
         return this._isFlyingToSicilia;
      }
   }
}
