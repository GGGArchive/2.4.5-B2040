package com.goodgamestudios.mafia.model.components.user.duel
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.DuelOpponentVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaPvpData
   {
       
      
      public var duelOpponent:DuelOpponentVO;
      
      public var lastDuelEnemy:String;
      
      public var nextFreeDuelFightTime:Number;
      
      public var duelResultData:MafiaFightResultData;
      
      public var duelResultLogData:MafiaFightResultData;
      
      public var reward:RewardVO;
      
      public function MafiaPvpData()
      {
         super();
         this.nextFreeDuelFightTime = 0;
         this.lastDuelEnemy = "";
      }
      
      public function parseData(param1:Array) : void
      {
         param1.shift();
         if(param1[0] > 0)
         {
            this.nextFreeDuelFightTime = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            param1.shift();
            this.nextFreeDuelFightTime = 0;
         }
         var _loc2_:Array = String(param1.shift()).split("+");
         if(_loc2_.length <= 1)
         {
            return;
         }
         this.duelOpponent = new DuelOpponentVO();
         this.duelOpponent.playerID = _loc2_.shift();
         this.duelOpponent.playerName = _loc2_.shift();
         this.duelOpponent.level = _loc2_.shift();
         this.duelOpponent.clanName = _loc2_.shift();
         this.duelOpponent.gender = CharacterGender.getById(_loc2_.shift());
         this.duelOpponent.picString = _loc2_.shift();
         this.duelOpponent.typePic = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(this.duelOpponent.picString),Constants_ViewScales.SCALE_AVATAR_DUEL_SEARCH,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_DUEL_SEARCH);
         this.duelOpponent.characterClass = CharacterClass.getById(_loc2_.shift());
         this.duelOpponent.classPic = AvatarHelper.createClassSymbol(this.duelOpponent.characterClass);
         this.lastDuelEnemy = this.duelOpponent.playerName;
         BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.CHANGE_DUEL_DATA));
      }
      
      public function createDuelResultData(param1:PBFight, param2:PBReward = null) : void
      {
         this.duelResultData = new MafiaFightResultData();
         this.duelResultLogData = new MafiaFightResultData();
         this.duelResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.duelResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         this.duelResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.duelResultData.isLeftFighterWinner = param1.winner == MafiaFightResultData.FIGHTER_LEFT;
         this.duelResultLogData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.duelResultLogData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.duelResultLogData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.duelResultLogData.isLeftFighterWinner = param1.winner == MafiaFightResultData.FIGHTER_LEFT;
         this.duelResultLogData.left_ammunition = MafiaFightDataParser.parseFightAmmunition(param1.leftAmmunition);
         this.duelResultLogData.right_ammunition = MafiaFightDataParser.parseFightAmmunition(param1.rightAmmunition);
      }
      
      public function checkDuelTime(param1:Number) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = this.nextFreeDuelFightTime - param1;
         if(_loc2_ <= 0)
         {
            this.nextFreeDuelFightTime = 0;
            BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.REMOVE_DUELTIMER));
         }
         else
         {
            _loc3_ = new Array();
            _loc3_.push(TimeStringHelper.getShortTimeString(this.nextFreeDuelFightTime - param1));
            BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.CHANGE_DUEL_TIMER,_loc3_));
         }
      }
   }
}
