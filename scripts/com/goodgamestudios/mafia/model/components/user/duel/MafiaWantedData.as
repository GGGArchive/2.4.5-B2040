package com.goodgamestudios.mafia.model.components.user.duel
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.event.model.MafiaWantedEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaWantedResultData;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaWantedData
   {
      
      public static const MAXEPICENEMYPICS:int = 18;
       
      
      public var nextFreeWantedFightTime:Number;
      
      public var wantedEnemyPicID:int;
      
      public var characterClass:int;
      
      public var wantedEnemyName:String;
      
      public var character:CharacterClass;
      
      public var wantedResultData:MafiaWantedResultData;
      
      public var reward:RewardVO;
      
      public function MafiaWantedData()
      {
         super();
         this.nextFreeWantedFightTime = 0;
      }
      
      public function parseWantedFightData(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         param1.shift();
         if(param1[0] > 0)
         {
            this.nextFreeWantedFightTime = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            param1.shift();
            this.nextFreeWantedFightTime = 0;
         }
         this.wantedEnemyPicID = param1.shift();
         this.characterClass = param1.shift();
         switch(this.characterClass)
         {
            case CharacterClass.Bully.index:
               this.character = CharacterClass.Bully;
               break;
            case CharacterClass.Rogue.index:
               this.character = CharacterClass.Rogue;
               break;
            case CharacterClass.Tactician.index:
               this.character = CharacterClass.Tactician;
         }
         if(this.wantedEnemyPicID == Constants_SpecialEvents.CAPO_VITO_PIC_ID)
         {
            this.wantedEnemyName = MafiaModel.languageData.getTextById("event_capovito_title");
         }
         else if(this.wantedEnemyPicID == Constants_SpecialEvents.NIGHT_OF_HORROR_PIC_ID)
         {
            this.wantedEnemyName = MafiaModel.languageData.getTextById("event_halloween_enemy");
         }
         else if(this.wantedEnemyPicID >= MafiaCalendarEvent.START_PIC_ID && MafiaModel.specialEvent.calendarEvent.isEventActive)
         {
            if(this.wantedEnemyPicID == MafiaCalendarEvent.BOSS_PIC_ID)
            {
               this.wantedEnemyName = MafiaModel.specialEvent.calendarEvent.bossName;
            }
            else
            {
               _loc2_ = this.wantedEnemyPicID - MafiaCalendarEvent.START_PIC_ID;
               if(MafiaCalendarEvent.ENEMY_NAME_LIST[_loc2_][2] == true)
               {
                  _loc3_ = "MafiaEnemyName_male_";
               }
               else
               {
                  _loc3_ = "MafiaEnemyName_female_";
               }
               this.wantedEnemyName = MafiaModel.languageData.getTextById(_loc3_ + MafiaCalendarEvent.ENEMY_NAME_LIST[_loc2_][0]);
               this.wantedEnemyName = this.wantedEnemyName + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_" + MafiaCalendarEvent.ENEMY_NAME_LIST[_loc2_][1]));
            }
         }
         else if(this.wantedEnemyPicID >= MafiaEddyFrostEvent.START_PIC_ID && MafiaModel.specialEvent.eddyFrostEvent.isEventActive)
         {
            if(this.wantedEnemyPicID == MafiaEddyFrostEvent.BOSS_PIC_ID)
            {
               this.wantedEnemyName = MafiaModel.specialEvent.eddyFrostEvent.bossName;
            }
            else
            {
               _loc4_ = this.wantedEnemyPicID - MafiaEddyFrostEvent.START_PIC_ID;
               if(MafiaEddyFrostEvent.ENEMY_NAME_LIST[_loc4_][2] == true)
               {
                  _loc5_ = "MafiaEnemyName_male_";
               }
               else
               {
                  _loc5_ = "MafiaEnemyName_female_";
               }
               this.wantedEnemyName = MafiaModel.languageData.getTextById(_loc5_ + MafiaEddyFrostEvent.ENEMY_NAME_LIST[_loc4_][0]);
               this.wantedEnemyName = this.wantedEnemyName + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_" + MafiaEddyFrostEvent.ENEMY_NAME_LIST[_loc4_][1]));
            }
         }
         else
         {
            this.wantedEnemyName = MafiaModel.languageData.getTextById("MafiaGodfatherScreen_copy_2");
         }
         BasicController.getInstance().dispatchEvent(new MafiaWantedEvent(MafiaWantedEvent.CHANGE_WANTEDDATA));
      }
      
      public function checkWantedTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.nextFreeWantedFightTime - param1));
         BasicController.getInstance().dispatchEvent(new MafiaWantedEvent(MafiaWantedEvent.CHANGE_WANTEDTIMER,_loc2_));
         if(param1 > this.nextFreeWantedFightTime)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         }
      }
      
      public function parseWantedResultData(param1:PBFight, param2:PBReward = null) : MafiaWantedResultData
      {
         var _loc4_:CalendarWantedLayerBG = null;
         var _loc5_:EddyWantedLayerBG = null;
         this.wantedResultData = new MafiaWantedResultData();
         this.wantedResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.wantedResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         this.wantedResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.wantedResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
         this.wantedResultData.wantedEnemyPicID = this.wantedEnemyPicID;
         var _loc3_:Class = getDefinitionByName("Enemy" + this.wantedResultData.wantedEnemyPicID) as Class;
         this.wantedResultData.fighterRight.typeMC = new _loc3_();
         if(this.wantedResultData.wantedEnemyPicID >= MafiaCalendarEvent.START_PIC_ID && MafiaModel.specialEvent.calendarEvent.isEventActive)
         {
            _loc4_ = new CalendarWantedLayerBG();
            this.wantedResultData.fighterRight.typeMC.addChildAt(_loc4_,0);
            _loc4_.scaleX = _loc4_.scaleY = 2.5;
            this.wantedResultData.fighterRight.typeMC.scaleX = this.wantedResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_AVATAR_SPECIAL_WANTED_EVENT;
            _loc4_.x = -_loc4_.width / 2;
            _loc4_.y = -_loc4_.height * 0.75;
         }
         else if(this.wantedResultData.wantedEnemyPicID >= MafiaEddyFrostEvent.START_PIC_ID && MafiaModel.specialEvent.eddyFrostEvent.isEventActive)
         {
            _loc5_ = new EddyWantedLayerBG();
            this.wantedResultData.fighterRight.typeMC.addChildAt(_loc5_,0);
            _loc5_.scaleX = _loc5_.scaleY = 2.5;
            this.wantedResultData.fighterRight.typeMC.scaleX = this.wantedResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_AVATAR_SPECIAL_WANTED_EVENT;
            _loc5_.x = -_loc5_.width / 2;
            _loc5_.y = -_loc5_.height * 0.75;
         }
         else if(this.isSpecialWantedEventOpponent(this.wantedResultData.wantedEnemyPicID))
         {
            this.wantedResultData.fighterRight.typeMC.scaleX = this.wantedResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_AVATAR_SPECIAL_WANTED_EVENT;
         }
         else
         {
            this.wantedResultData.fighterRight.typeMC.scaleX = this.wantedResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_GANGWAR_PICS_IN_FIGHT;
         }
         this.wantedResultData.fighterRight.name = this.wantedEnemyName;
         return this.wantedResultData;
      }
      
      private function isSpecialWantedEventOpponent(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 > 100 && param1 < 151)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function giveChristmasGuy() : Sprite
      {
         var _loc2_:Sprite = null;
         var _loc1_:Class = getDefinitionByName("AP30") as Class;
         _loc2_ = new _loc1_();
         _loc2_.scaleX = _loc2_.scaleY = Constants_ViewScales.SCALE_GANGWAR_PICS_IN_FIGHT;
         return _loc2_;
      }
   }
}
