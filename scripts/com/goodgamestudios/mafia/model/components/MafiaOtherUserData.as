package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerProfile;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.model.components.user.MafiaUserData;
   
   public class MafiaOtherUserData extends MafiaUserData
   {
       
      
      public function MafiaOtherUserData()
      {
         super();
         armament = new MafiaArmamentData();
      }
      
      override public function parseUserData(param1:Array) : void
      {
         param1.shift();
         param1.shift();
         var _loc2_:Array = String(param1).split("+");
         _loc2_.shift();
         _loc2_.shift();
         _loc2_.shift();
         super.parseUserData(_loc2_);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_DATA,[profileData]));
      }
      
      override public function parseProfileDataPB(param1:PBPlayerProfile) : void
      {
         super.parseProfileDataPB(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
      }
      
      override public function parseBoosterData(param1:Array) : void
      {
         super.parseBoosterData(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_BOOSTER_DATA));
      }
      
      public function parseAchievementData(param1:Array) : void
      {
         achievementsData.parseData(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_ACHIEVEMENT_DATA));
      }
      
      override public function parseGearDataPB(param1:PBEquipmentViewGearResponse) : void
      {
         super.parseGearDataPB(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_GEAR_DATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
      }
      
      override public function parseFoodDataPB(param1:Array) : void
      {
         super.parseFoodDataPB(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_FOOD_DATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
      }
   }
}
