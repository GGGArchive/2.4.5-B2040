package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.model.components.BasicUserData;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerProfile;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearResponse;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.components.user.booster.MafiaBoosterData;
   import com.goodgamestudios.mafia.model.components.user.gang.MafiaGangData;
   import com.goodgamestudios.mafia.vo.ArmamentPresetVO;
   import com.goodgamestudios.mafia.vo.FighterVO;
   
   public class MafiaUserData extends BasicUserData
   {
       
      
      public var userLevel:int = 0;
      
      public var userXP:Number;
      
      public var userXPForCurrentLevel:Number;
      
      public var userXPForNextLevel:Number;
      
      public var xpToNextLevelPercent:Number;
      
      public var userMissionEnergy:int;
      
      public var afterLogin:Boolean = false;
      
      public var achievementsData:MafiaAchievementData;
      
      public var profileData:MafiaProfileData;
      
      public var boosterData:MafiaBoosterData;
      
      public var gearData:MafiaGearData;
      
      public var armament:MafiaArmamentData;
      
      public var armamentPresetData:ArmamentPresetVO;
      
      public var gangData:MafiaGangData;
      
      public var foodData:MafiaFoodData;
      
      public function MafiaUserData()
      {
         super();
         this.profileData = new MafiaProfileData();
         this.boosterData = new MafiaBoosterData();
         this.achievementsData = new MafiaAchievementData();
         this.gearData = new MafiaGearData();
         this.foodData = new MafiaFoodData();
         this.gangData = new MafiaGangData();
         this.armamentPresetData = new ArmamentPresetVO();
      }
      
      public function parseUserData(param1:Array) : void
      {
         this.userLevel = param1.shift();
         this.profileData.level = this.userLevel;
         this.userXP = param1.shift();
         this.userXPForCurrentLevel = param1.shift();
         this.userXPForNextLevel = param1.shift();
         this.userMissionEnergy = param1.shift();
         param1.shift();
         param1.shift();
         param1.shift();
         this.profileData.defense = param1.shift();
         this.xpToNextLevelPercent = 100 * (this.userXP - this.userXPForCurrentLevel) / (this.userXPForNextLevel - this.userXPForCurrentLevel);
      }
      
      public function parseProfileDataPB(param1:PBPlayerProfile) : void
      {
         this.profileData = this.profileData.parseDataPB(param1);
         userName = this.profileData.name;
      }
      
      public function parseBoosterData(param1:Array) : void
      {
         this.boosterData = this.boosterData.parseData(param1);
      }
      
      public function parseGearDataPB(param1:PBEquipmentViewGearResponse) : void
      {
         this.gearData.parseDataPB(param1,this.profileData);
      }
      
      public function parseFoodDataPB(param1:Array) : void
      {
         this.foodData.parseDataPB(param1,this.profileData);
      }
      
      public function get fighterVO() : FighterVO
      {
         var _loc1_:FighterVO = new FighterVO();
         _loc1_.id = playerID;
         _loc1_.currentHitpoints = _loc1_.totalHitpoints = this.profileData.health;
         _loc1_.attack = int(this.profileData.attack);
         _loc1_.endurance = this.profileData.endurance;
         _loc1_.luck = int(this.profileData.luck);
         _loc1_.toughness = int(this.profileData.toughness);
         _loc1_.characterClassMC = AvatarHelper.createClassSymbol(this.profileData.characterClass);
         _loc1_.typeMC = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(this.profileData.picString),Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         _loc1_.name = userName;
         _loc1_.level = this.profileData.level;
         return _loc1_;
      }
   }
}
