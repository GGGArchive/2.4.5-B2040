package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_Tournament;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.TournamentRoundReportsCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.PBSpecialeventTournamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.response.PBSpecialeventTournamentPlayerState;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.response.PBSpecialeventTournamentState;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.searchtournamentplayer.PBSpecialeventTournamentSearchtournamentplayerResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response.PBSpecialeventTournamentShowTournamentFinalsDuelInfo;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.PBSpecialeventTournamentShowTournamentInfosResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosPlayerRound;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosPlayerStatus;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosTournamentStatus;
   import com.goodgamestudios.mafia.controller.protobuf.tournaments.PBPlayerInfo;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaTournamentResultData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaTournamentRoundReportDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaTournamentWinnerDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentRoundReportDialog;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentWinnerDialog;
   import com.goodgamestudios.mafia.vo.PlayerVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentFightHistoryVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentFinalFightVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentOpponentVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentRemainingPlayerVO;
   import com.goodgamestudios.mafia.vo.tournament.TournamentRoundReportVO;
   import flash.utils.getTimer;
   
   public class MafiaTournamentEvent extends MafiaSpecialEvent
   {
       
      
      private const TOURNAMENT_STATE_APPLICATION:String = "tournament_state_application";
      
      private const TOURNAMENT_STATE_RUNNING:String = "tournament_state_running";
      
      private const TOURNAMENT_STATE_ENDED:String = "tournament_state_ended";
      
      private const PLAYER_STATE_NOT_ENTERED:String = "player_state_not_entered";
      
      private const PLAYER_STATE_ENTERED:String = "player_state_entered";
      
      private const PLAYER_STATE_ELIMINATED:String = "player_state_eliminated";
      
      private const NEXT_OPPONENT_STATE_UNKNOWN:String = "next_opponent_state_unknown";
      
      private const NEXT_OPPONENT_STATE_KNOWN:String = "next_opponent_state_known";
      
      private const NEXT_OPPONENT_STATE_FREE_TICKET:String = "next_opponent_state_free_ticket";
      
      public var tournamentState:String;
      
      public var playerState:String;
      
      public var currentRound:int;
      
      private var timeToNextFight:int;
      
      private var timeToRefresh:int;
      
      private var roundIsRunning:Boolean;
      
      public var rewardIndex:int;
      
      public var numRegisteredPlayers:uint;
      
      public var numRemainingPlayers:uint;
      
      public var winner:TournamentOpponentVO;
      
      public var currentHealth:int;
      
      public var cashCostToHeal:int;
      
      public var nextOpponentState:String;
      
      public var nextOpponent:TournamentOpponentVO;
      
      public var nextRewardXP:int;
      
      public var nextRewardCash:int;
      
      public var nextRewardGlory:int;
      
      public var nextRewardAP:int;
      
      public var nextRewardCustomizeID:int;
      
      public var playerFightHistory:Vector.<TournamentFightHistoryVO>;
      
      public var opponentFightHistory:Vector.<TournamentFightHistoryVO>;
      
      private var finalFights:Vector.<TournamentFinalFightVO>;
      
      public var remainingTournamentPlayers:Vector.<TournamentRemainingPlayerVO>;
      
      private var roundReports:Vector.<TournamentRoundReportVO>;
      
      public var fightResultData:MafiaTournamentResultData;
      
      public var reward:RewardVO;
      
      public var playerRequestedTournamentInfo:Boolean = false;
      
      public function MafiaTournamentEvent()
      {
         this.finalFights = new Vector.<TournamentFinalFightVO>(15);
         _eventId = Constants_SpecialEvents.ID_TOURNAMENT;
         super();
      }
      
      public function parseEventDetails(param1:PBSpecialeventTournamentResponse) : void
      {
         switch(param1.tournamentStatus)
         {
            case PBSpecialeventTournamentState.REGISTRATION:
               this.tournamentState = this.TOURNAMENT_STATE_APPLICATION;
               break;
            case PBSpecialeventTournamentState.RUNNING:
               this.tournamentState = this.TOURNAMENT_STATE_RUNNING;
               break;
            case PBSpecialeventTournamentState.ENDED:
               this.tournamentState = this.TOURNAMENT_STATE_ENDED;
         }
         switch(param1.playerStatus)
         {
            case PBSpecialeventTournamentPlayerState.NOT_ENTERED:
               this.playerState = this.PLAYER_STATE_NOT_ENTERED;
               break;
            case PBSpecialeventTournamentPlayerState.ENTERED:
               this.playerState = this.PLAYER_STATE_ENTERED;
               break;
            case PBSpecialeventTournamentPlayerState.ELIMINATED:
               this.playerState = this.PLAYER_STATE_ELIMINATED;
         }
         this.numRegisteredPlayers = param1.currentRegisteredPlayers;
         this.timeToNextFight = getTimer() / 1000 + param1.timeToNextRound;
         this.rewardIndex = param1.rewardIndex;
      }
      
      public function parseTournamentInfo(param1:PBSpecialeventTournamentShowTournamentInfosResponse) : void
      {
         var _loc2_:int = 0;
         switch(param1.status)
         {
            case PBSpecialeventTournamentShowTournamentInfosTournamentStatus.APPLICATION:
               this.tournamentState = this.TOURNAMENT_STATE_APPLICATION;
               break;
            case PBSpecialeventTournamentShowTournamentInfosTournamentStatus.RUNNING:
               this.tournamentState = this.TOURNAMENT_STATE_RUNNING;
               break;
            case PBSpecialeventTournamentShowTournamentInfosTournamentStatus.ENDED:
               this.tournamentState = this.TOURNAMENT_STATE_ENDED;
         }
         switch(param1.playerStatus)
         {
            case PBSpecialeventTournamentShowTournamentInfosPlayerStatus.NOT_ENTERED:
               this.playerState = this.PLAYER_STATE_NOT_ENTERED;
               break;
            case PBSpecialeventTournamentShowTournamentInfosPlayerStatus.ENTERED:
               this.playerState = this.PLAYER_STATE_ENTERED;
               break;
            case PBSpecialeventTournamentShowTournamentInfosPlayerStatus.ELIMINATED:
               this.playerState = this.PLAYER_STATE_ELIMINATED;
         }
         this.currentRound = param1.round;
         this.timeToNextFight = getTimer() / 1000 + param1.timeToNextFight;
         this.numRegisteredPlayers = param1.participantsCount;
         this.numRemainingPlayers = param1.remainingParticipantsCount;
         this.timeToRefresh = getTimer() / 1000 + param1.timeToRefresh;
         if(this.isTournamentOver)
         {
            this.winner = new TournamentOpponentVO();
            this.winner.ID = param1.winner.id;
            this.winner.name = param1.winner.name;
            this.winner.clanName = param1.winner.familyName;
            this.winner.level = param1.winner.level;
            this.winner.characterClass = CharacterClass.getById(param1.winner.characterClass);
            this.winner.avatarPicString = param1.winner.avatarPicString;
            this.winner.typeMC = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(this.winner.avatarPicString),Constants_ViewScales.SCALE_AVATAR_TOURNAMENT_WINNER,true,Constants_ViewScales.SCALE_AVATAR_TOURNAMENT_WINNER);
         }
         else
         {
            this.winner = null;
         }
         if(this.isPlayerInTournament && (this.isTournamentRunning || this.isTournamentApplicationOpen))
         {
            this.currentHealth = param1.currentHealth;
            this.cashCostToHeal = param1.healingCosts;
         }
         if(this.isPlayerInTournament && this.isTournamentRunning)
         {
            this.playerFightHistory = this.parseFightHistory(param1.playerRounds);
            this.nextRewardXP = param1.nextRewardXp;
            this.nextRewardCash = param1.nextRewardCash;
            this.nextRewardGlory = param1.nextRewardGlory;
            this.nextRewardAP = param1.nextRewardAp;
            _loc2_ = param1.nextOpponentId;
            if(_loc2_ == -1)
            {
               this.nextOpponentState = this.NEXT_OPPONENT_STATE_UNKNOWN;
            }
            else if(_loc2_ == 0)
            {
               this.nextOpponentState = this.NEXT_OPPONENT_STATE_FREE_TICKET;
            }
            else
            {
               this.nextOpponentState = this.NEXT_OPPONENT_STATE_KNOWN;
            }
            if(this.nextOpponentState == this.NEXT_OPPONENT_STATE_KNOWN)
            {
               this.nextOpponent = new TournamentOpponentVO();
               this.nextOpponent.ID = _loc2_;
               this.nextOpponent.level = param1.opponent.level;
               this.nextOpponent.levelProgress = param1.opponent.levelProgress;
               this.nextOpponent.characterClass = CharacterClass.getById(param1.opponent.characterClass);
               this.nextOpponent.HP = param1.opponent.health;
               this.nextOpponent.name = param1.opponent.name;
               this.nextOpponent.clanName = param1.opponent.familyName;
               this.nextOpponent.avatarPicString = param1.opponent.avatarPicString;
               this.nextOpponent.typeMC = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(this.nextOpponent.avatarPicString),Constants_ViewScales.SCALE_AVATAR_TOURNAMENT_OPPONENT,false);
               this.opponentFightHistory = this.parseFightHistory(param1.opponentRounds);
            }
            else
            {
               this.nextOpponent = null;
               this.opponentFightHistory = null;
            }
         }
         else
         {
            this.nextOpponent = null;
            this.playerFightHistory = null;
            this.opponentFightHistory = null;
         }
      }
      
      private function parseFightHistory(param1:Array) : Vector.<TournamentFightHistoryVO>
      {
         var _loc3_:PBSpecialeventTournamentShowTournamentInfosPlayerRound = null;
         var _loc4_:TournamentFightHistoryVO = null;
         var _loc2_:Vector.<TournamentFightHistoryVO> = new Vector.<TournamentFightHistoryVO>();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_] as PBSpecialeventTournamentShowTournamentInfosPlayerRound;
            _loc4_ = new TournamentFightHistoryVO();
            _loc4_.round = _loc3_.round;
            _loc4_.opponentID = _loc3_.playerId;
            _loc4_.opponentName = _loc3_.playerName;
            _loc4_.fightResult = ProtobufEnumTranslator.translateProtoFighterState(_loc3_.fightResult);
            _loc2_.push(_loc4_);
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function parseFight(param1:PBFight, param2:PBReward) : void
      {
         this.fightResultData = new MafiaTournamentResultData();
         this.fightResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.fightResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         this.fightResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.fightResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
         if(this.fightResultData.fighterLeft.id != MafiaModel.userData.playerID && this.fightResultData.fighterRight.id != MafiaModel.userData.playerID)
         {
            this.fightResultData.isSpectator = true;
         }
         else
         {
            this.fightResultData.isSpectator = false;
         }
      }
      
      public function parseRoundReport(param1:Array) : void
      {
         var _loc3_:PBPlayerInfo = null;
         var _loc4_:TournamentRoundReportVO = null;
         this.roundReports = new Vector.<TournamentRoundReportVO>();
         var _loc2_:Array = param1;
         while(_loc2_.length > 0 && _loc2_[0] != "")
         {
            _loc3_ = _loc2_.shift() as PBPlayerInfo;
            _loc4_ = new TournamentRoundReportVO();
            _loc4_.opponentID = _loc3_.id;
            if(_loc3_.hasName)
            {
               _loc4_.opponentName = _loc3_.name;
            }
            _loc4_.fightResult = ProtobufEnumTranslator.translateProtoFighterState(_loc3_.state);
            if(_loc3_.hasRoundNumber)
            {
               _loc4_.nextRound = _loc3_.roundNumber;
            }
            if(_loc3_.hasReward)
            {
               _loc4_.cash = _loc3_.reward.cash;
               _loc4_.xp = _loc3_.reward.xp;
               _loc4_.ap = _loc3_.reward.activity;
               _loc4_.glory = _loc3_.reward.glory;
            }
            this.roundReports.push(_loc4_);
         }
         while(this.roundReports.length != 0)
         {
            _loc4_ = this.roundReports.shift();
            if(_loc4_.fightResult == FighterState.Won && _loc4_.nextRound == -1)
            {
               MafiaDialogHandler.getInstance().registerDialogs(MafiaTournamentWinnerDialog.NAME,new MafiaTournamentWinnerDialogProperties(_loc4_),true);
            }
            else
            {
               MafiaDialogHandler.getInstance().registerDialogs(MafiaTournamentRoundReportDialog.NAME,new MafiaTournamentRoundReportDialogProperties(_loc4_),true);
            }
         }
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(isEventActive)
         {
            if(this.isTournamentApplicationOpen)
            {
               if(this.tournamentRegisterTimeLeft > 0)
               {
                  BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_REGISTER_REMAINING_TIME,[this.tournamentRegisterTimeLeft]));
               }
               else
               {
                  this.endRegistration();
                  BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_REGISTRATION_ENDED,[]));
               }
            }
            if(this.hasPlayerEntered || this.isTournamentRunning || this.isTournamentOver)
            {
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_TIME_UPDATE,[]));
               if(this.roundIsRunning && this.secondsUntilRefresh < 0)
               {
                  if(this.isPlayerInTournament)
                  {
                     TournamentRoundReportsCommand.sendCommand();
                  }
                  BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_TIME_ROUND_ENDED,[]));
               }
            }
            this.roundIsRunning = this.secondsUntilRefresh >= 0;
         }
      }
      
      private function endRegistration() : void
      {
         this.tournamentState = this.TOURNAMENT_STATE_RUNNING;
         this.currentRound = 0;
         this.nextOpponentState = this.NEXT_OPPONENT_STATE_UNKNOWN;
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,[]));
      }
      
      public function get tournamentRegisterTimeLeft() : Number
      {
         if(this.isTournamentApplicationOpen)
         {
            return this.timeToNextFight - getTimer() / 1000;
         }
         return -1;
      }
      
      public function parseSearchTournamentPlayer(param1:PBSpecialeventTournamentSearchtournamentplayerResponse) : void
      {
         var _loc2_:TournamentRemainingPlayerVO = new TournamentRemainingPlayerVO();
         _loc2_.playerID = param1.playerId;
         _loc2_.name = param1.name;
         _loc2_.playerTournamentStatus = ProtobufEnumTranslator.translateProtoPlayerTournamentStatus(param1.state);
         _loc2_.playerReachedRound = param1.round;
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_SEARCHED_PLAYER_UPDATED,[_loc2_]));
      }
      
      public function parseRemainingPlayersData(param1:Array) : void
      {
         var _loc4_:PBPlayerInfo = null;
         var _loc5_:TournamentRemainingPlayerVO = null;
         this.remainingTournamentPlayers = new Vector.<TournamentRemainingPlayerVO>();
         var _loc2_:Array = param1;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as PBPlayerInfo;
            _loc5_ = new TournamentRemainingPlayerVO();
            _loc5_.playerID = _loc4_.id;
            if(_loc4_.hasName)
            {
               _loc5_.name = _loc4_.name;
            }
            if(_loc4_.hasLevel)
            {
               _loc5_.level = _loc4_.level;
            }
            if(_loc4_.hasCharacterClass)
            {
               _loc5_.characterClass = ProtobufEnumTranslator.translateProtoCharacterClass(_loc4_.characterClass);
            }
            _loc5_.clanID = _loc4_.familyId;
            _loc5_.clanName = _loc4_.familyName;
            this.remainingTournamentPlayers.push(_loc5_);
            _loc3_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_REMAINING_PLAYERS_UPDATED,[]));
      }
      
      public function parseTournamentFinalsOverview(param1:Array) : void
      {
         var _loc4_:PBSpecialeventTournamentShowTournamentFinalsDuelInfo = null;
         var _loc5_:TournamentFinalFightVO = null;
         this.finalFights = new Vector.<TournamentFinalFightVO>();
         var _loc2_:Array = param1;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as PBSpecialeventTournamentShowTournamentFinalsDuelInfo;
            _loc5_ = new TournamentFinalFightVO();
            _loc5_.fighter1 = new PlayerVO();
            _loc5_.fighter2 = new PlayerVO();
            _loc5_.state = ProtobufEnumTranslator.translateProtoTournamentFinalsState(_loc4_.state);
            _loc5_.fighterState1 = ProtobufEnumTranslator.translateProtoFighterState(_loc4_.firstPlayerInfo.state);
            _loc5_.fighterState2 = ProtobufEnumTranslator.translateProtoFighterState(_loc4_.secondPlayerInfo.state);
            _loc5_.fighter1.playerID = _loc4_.firstPlayerInfo.id;
            _loc5_.fighter1.name = _loc4_.firstPlayerInfo.name;
            _loc5_.fighter1.level = _loc4_.firstPlayerInfo.level;
            _loc5_.fighterClanId1 = _loc4_.firstPlayerInfo.familyId;
            _loc5_.fighterClanName1 = _loc4_.firstPlayerInfo.familyName;
            _loc5_.avatarPicString1 = _loc4_.firstPlayerInfo.avatarPicString;
            _loc5_.fighter2.playerID = _loc4_.secondPlayerInfo.id;
            _loc5_.fighter2.name = _loc4_.secondPlayerInfo.name;
            _loc5_.fighter2.level = _loc4_.secondPlayerInfo.level;
            _loc5_.fighterClanId2 = _loc4_.secondPlayerInfo.familyId;
            _loc5_.fighterClanName2 = _loc4_.secondPlayerInfo.familyName;
            _loc5_.avatarPicString2 = _loc4_.secondPlayerInfo.avatarPicString;
            this.finalFights.push(_loc5_);
            _loc3_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_FINALS_OVERVIEW_UPDATED,[]));
      }
      
      public function getFinalFightVO(param1:uint, param2:uint) : TournamentFinalFightVO
      {
         switch(param1)
         {
            case Constants_Tournament.RO16_ROUNDOFSIXTEEN:
               return this.finalFights[param2];
            case Constants_Tournament.RO16_QUARTERFINAL:
               return this.finalFights[8 + param2];
            case Constants_Tournament.RO16_SEMIFINAL:
               return this.finalFights[12 + param2];
            case Constants_Tournament.RO16_FINAL:
               return this.finalFights[14];
            default:
               return null;
         }
      }
      
      public function get isTournamentApplicationOpen() : Boolean
      {
         return this.tournamentState == this.TOURNAMENT_STATE_APPLICATION;
      }
      
      public function get isTournamentRunning() : Boolean
      {
         return this.tournamentState == this.TOURNAMENT_STATE_RUNNING;
      }
      
      public function get isTournamentOver() : Boolean
      {
         return this.tournamentState == this.TOURNAMENT_STATE_ENDED;
      }
      
      public function get isPlayerInTournament() : Boolean
      {
         return this.playerState == this.PLAYER_STATE_ENTERED;
      }
      
      public function get isPlayerEliminated() : Boolean
      {
         return this.playerState == this.PLAYER_STATE_ELIMINATED;
      }
      
      public function get hasPlayerEntered() : Boolean
      {
         return this.playerState == this.PLAYER_STATE_ENTERED || this.playerState == this.PLAYER_STATE_ELIMINATED;
      }
      
      public function get isRegistrationTimeOver() : Boolean
      {
         return this.tournamentRegisterTimeLeft < 0;
      }
      
      public function get isNextOpponentKnown() : Boolean
      {
         return this.nextOpponentState == this.NEXT_OPPONENT_STATE_KNOWN;
      }
      
      public function get isNextOpponentUnknown() : Boolean
      {
         return this.nextOpponentState == this.NEXT_OPPONENT_STATE_UNKNOWN;
      }
      
      public function get isNextOpponentFreeTicket() : Boolean
      {
         return this.nextOpponentState == this.NEXT_OPPONENT_STATE_FREE_TICKET;
      }
      
      public function get canPlayerViewTournamentScreen() : Boolean
      {
         return this.isTournamentRunning || this.isTournamentOver || this.isTournamentApplicationOpen && this.hasPlayerEntered;
      }
      
      public function getCurrentRoundname() : String
      {
         return this.getRoundname(this.currentRound);
      }
      
      public function getRoundname(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 >= 0)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_21",[param1 + 1]);
         }
         else if(param1 == Constants_Tournament.ROUND_ROUNDOFSIXTEEN)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_22");
         }
         else if(param1 == Constants_Tournament.ROUND_QUARTERFINAL)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_23");
         }
         else if(param1 == Constants_Tournament.ROUND_SEMIFINAL)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_24");
         }
         else if(param1 == Constants_Tournament.ROUND_FINAL)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_25");
         }
         return _loc2_;
      }
      
      public function getPlayerHistoryFightVO(param1:int) : TournamentFightHistoryVO
      {
         var _loc2_:TournamentFightHistoryVO = null;
         if(param1 >= 0 && this.playerFightHistory && this.playerFightHistory.length > param1)
         {
            _loc2_ = this.playerFightHistory[param1];
         }
         return _loc2_;
      }
      
      public function getHistoryFightDescription(param1:TournamentFightHistoryVO) : String
      {
         var _loc2_:String = "";
         switch(param1.fightResult)
         {
            case FighterState.Freecard:
               _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_18");
               break;
            case FighterState.Won:
               _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_19",[param1.opponentName]);
               break;
            case FighterState.Lost:
               _loc2_ = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_20",[param1.opponentName]);
         }
         return _loc2_;
      }
      
      public function get secondsUntilNextFight() : int
      {
         return this.timeToNextFight - getTimer() / 1000;
      }
      
      public function get secondsUntilRefresh() : int
      {
         return this.timeToRefresh - getTimer() / 1000;
      }
   }
}
