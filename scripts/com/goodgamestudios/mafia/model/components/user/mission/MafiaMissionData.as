package com.goodgamestudios.mafia.model.components.user.mission
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.commands.avatar.OUDCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBMission;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.mission.view.PBMissionViewResponse;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.MissionVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.math.Random;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class MafiaMissionData
   {
       
      
      public var missions:Vector.<MissionVO>;
      
      public var missionEnergy:int;
      
      public var energyRefill:int;
      
      public var freeEnergyDrinks:int;
      
      public var maxEnergyRefill:int = 10;
      
      public var nextEnergyUpdateTime:Number = 0;
      
      public var energyUpdateValue:int;
      
      public var missionResultData:MafiaFightResultData;
      
      public var reward:RewardVO;
      
      private var _missionPosList:Vector.<Point>;
      
      private var _missionNameList:Vector.<String>;
      
      private var _currentMissionId:int;
      
      private var lastUpdate:int = 0;
      
      public function MafiaMissionData()
      {
         super();
         this.nextEnergyUpdateTime = 0;
      }
      
      public function parseMissionData(param1:PBMissionViewResponse) : void
      {
         var _loc3_:PBMission = null;
         var _loc4_:MissionVO = null;
         var _loc6_:int = 0;
         this.missionEnergy = param1.missionEnergy;
         this.energyRefill = param1.energyRefiller;
         this.maxEnergyRefill = param1.maxEnergyRefill;
         this.freeEnergyDrinks = param1.freeMissionEnergyDrinks;
         this.missions = new Vector.<MissionVO>();
         var _loc2_:Array = param1.missions;
         this._missionPosList = new Vector.<Point>();
         this._missionNameList = new Vector.<String>();
         switch(MafiaModel.userData.profileData.city)
         {
            case City.NewYork:
               this._missionPosList.push(new Point(530,150),new Point(620,150),new Point(620,130),new Point(620,130),new Point(295,100 + (!!MafiaModel.userData.profileData.isBarkeeperUnlocked?0:80)),new Point(495,100 + (!!MafiaModel.userData.profileData.isWorkUnlocked?0:100)));
               this._missionNameList.push(MafiaModel.languageData.getTextById("MafiaGodfatherScreen_0_NPC_2"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_0_NPC_1"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_0_NPC_3"),"!Sicilian",MafiaModel.languageData.getTextById("MafiaGodfatherScreen_0_NPC_5"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_0_NPC_4"));
               break;
            case City.Miami:
               this._missionPosList.push(new Point(500,100),new Point(250,160),new Point(530,160),new Point(530,160),new Point(555,145),new Point(360,82));
               this._missionNameList.push(MafiaModel.languageData.getTextById("MafiaGodfatherScreen_1_NPC_2"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_1_NPC_1"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_1_NPC_4"),"!Sicilian",MafiaModel.languageData.getTextById("MafiaGodfatherScreen_1_NPC_5"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_1_NPC_3"));
               break;
            case City.Hongkong:
               this._missionPosList.push(new Point(350,95),new Point(305,95),new Point(495,95),new Point(530,160),new Point(565,135),new Point(295,135));
               this._missionNameList.push(MafiaModel.languageData.getTextById("MafiaGodfatherScreen_2_NPC_3"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_2_NPC_2"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_2_NPC_1"),"!Sicilian",MafiaModel.languageData.getTextById("MafiaGodfatherScreen_2_NPC_5"),MafiaModel.languageData.getTextById("MafiaGodfatherScreen_2_NPC_4"));
               break;
            default:
               throw Error("NO CITY ID: " + MafiaModel.userData.profileData.city.index);
         }
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_] as PBMission;
            _loc4_ = new MissionVO();
            _loc4_.missionNr = _loc5_;
            _loc4_.missionID = _loc3_.id;
            _loc4_.c1 = _loc3_.cash;
            _loc4_.xp = _loc3_.xp;
            _loc4_.ap = _loc3_.activity;
            _loc4_.time = _loc3_.time;
            _loc4_.cIcon = ProtobufEnumTranslator.translateProtoCharacterClass(_loc3_.opponentClass);
            _loc4_.item = MafiaItemData.parseItem(_loc3_.item,ItemLocation.Inventory,0);
            _loc4_.staticPosition = this._missionPosList[_loc5_];
            _loc4_.name = this._missionNameList[_loc5_];
            this.missions.push(_loc4_);
            _loc5_++;
         }
         if(param1.cityEventMission)
         {
            _loc6_ = 3;
            _loc3_ = param1.cityEventMission as PBMission;
            _loc4_ = new MissionVO();
            _loc4_.missionNr = _loc6_;
            _loc4_.missionID = _loc3_.id;
            _loc4_.c1 = _loc3_.cash;
            _loc4_.xp = _loc3_.xp;
            _loc4_.ap = _loc3_.activity;
            _loc4_.time = _loc3_.time;
            _loc4_.cIcon = ProtobufEnumTranslator.translateProtoCharacterClass(_loc3_.opponentClass);
            _loc4_.item = MafiaItemData.parseItem(_loc3_.item,ItemLocation.Inventory,0);
            _loc4_.staticPosition = this._missionPosList[_loc6_];
            _loc4_.name = this._missionNameList[_loc6_];
            this.missions.push(_loc4_);
         }
         BasicController.getInstance().dispatchEvent(new MafiaMissionEvent(MafiaMissionEvent.CHANGE_MISSION_DATA));
      }
      
      public function parseMissionResultData(param1:PBFight, param2:PBReward) : void
      {
         var _loc3_:AvatarVO = null;
         var _loc4_:* = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         this.currentMissionId = MafiaModel.userData.progressData.missionGiverID;
         this.missionResultData = new MafiaFightResultData();
         this.reward = MafiaFightDataParser.parseReward(param2);
         this.missionResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.missionResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         if(MafiaTutorialController.getInstance().isActive)
         {
            this.missionResultData.fighterRight.typeMC = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(Constants_Avatarparts.TUTORIAL_MISSION_CHARACTERS[0]),Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            this.missionResultData.fighterRight.name = MafiaModel.languageData.getTextById("MafiaEnemyName_male_6");
            this.missionResultData.fighterRight.name = this.missionResultData.fighterRight.name + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_30"));
         }
         else
         {
            _loc4_ = MafiaModel.userData.profileData.city == City.Hongkong;
            _loc5_ = !!_loc4_?31:1;
            _loc6_ = !!_loc4_?45:30;
            _loc7_ = !!_loc4_?61:1;
            _loc8_ = !!_loc4_?72:60;
            _loc9_ = !!_loc4_?int(Constants_Avatarparts.STYLE_ASIAN):int(Constants_Avatarparts.STYLE_WEST);
            if(Random.boolean())
            {
               _loc3_ = new AvatarVO(CharacterGender.Male,true,_loc9_);
               this.missionResultData.fighterRight.name = MafiaModel.languageData.getTextById("MafiaEnemyName_male_" + String(Math.round(MathBase.random(_loc5_,_loc6_))));
            }
            else
            {
               _loc3_ = new AvatarVO(CharacterGender.Female,true,_loc9_);
               this.missionResultData.fighterRight.name = MafiaModel.languageData.getTextById("MafiaEnemyName_female_" + String(Math.round(MathBase.random(_loc5_,_loc6_))));
            }
            this.missionResultData.fighterRight.name = this.missionResultData.fighterRight.name + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_" + Math.round(MathBase.random(_loc7_,_loc8_))));
            this.missionResultData.fighterRight.typeMC = AvatarHelper.createAvatar(_loc3_,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         }
         this.missionResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.missionResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
      }
      
      public function parseNextEnergyUpdateTime(param1:int, param2:Number) : void
      {
         this.energyUpdateValue = param1;
         if(param2 > 0)
         {
            this.nextEnergyUpdateTime = getTimer() + param2 * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            this.nextEnergyUpdateTime = 0;
         }
      }
      
      public function checkEnergyUpdateTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.nextEnergyUpdateTime - param1));
         BasicController.getInstance().dispatchEvent(new MafiaMissionEvent(MafiaMissionEvent.CHANGE_ENERGYUPDATETIMER,_loc2_));
         if(param1 > this.nextEnergyUpdateTime)
         {
            this.nextEnergyUpdateTime = 0;
            OUDCommand.sendCommand([]);
            return;
         }
      }
      
      public function get currentMissionId() : int
      {
         return this._currentMissionId;
      }
      
      public function set currentMissionId(param1:int) : void
      {
         this._currentMissionId = param1;
      }
      
      public function get missionPosList() : Vector.<Point>
      {
         return this._missionPosList;
      }
      
      public function get missionNameList() : Vector.<String>
      {
         return this._missionNameList;
      }
   }
}
