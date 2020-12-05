package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.event.model.MafiaGangEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.booster.MafiaBoosterData;
   import com.goodgamestudios.mafia.vo.AchievementVO;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaOtherSubProfileScreen extends MafiaSubProfileScreen
   {
      
      public static const NAME:String = "MafiaOtherSubProfileScreen";
       
      
      public function MafiaOtherSubProfileScreen(param1:DisplayObject)
      {
         super(param1);
         if(MafiaModel.otherUserData.achievementsData.achievements.length > 0)
         {
            this.fillAchievements(MafiaModel.otherUserData.achievementsData.achievements);
         }
         if(MafiaModel.otherUserData.gearData.items.length > 0)
         {
            fillGear(MafiaModel.otherUserData.gearData.items);
         }
         if(MafiaModel.otherUserData.foodData.food.length > 0)
         {
            fillFood(MafiaModel.otherUserData.foodData.food);
         }
         if(MafiaModel.otherUserData.armament != null)
         {
            fillArmament(MafiaModel.otherUserData.armament);
         }
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onChangeOtherAvatarData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ARMAMENT_DATA,this.onChangeOtherArmamentData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ACHIEVEMENT_DATA,this.onChangeOtherAchievementsData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_BOOSTER_DATA,this.onChangeOtherBoosterData);
         controller.addEventListener(MafiaGangEvent.CHANGE_OTHER_USER_GANG_DATA,this.onChangeOtherGangData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_GEAR_DATA,this.onChangeOtherItemsInUseData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_FOOD_DATA,this.onChangeOtherFoodData);
         tabEquipment.combatPreset.visible = false;
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onChangeOtherAvatarData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ARMAMENT_DATA,this.onChangeOtherArmamentData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ACHIEVEMENT_DATA,this.onChangeOtherAchievementsData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_BOOSTER_DATA,this.onChangeOtherBoosterData);
         controller.removeEventListener(MafiaGangEvent.CHANGE_OTHER_USER_GANG_DATA,this.onChangeOtherGangData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_GEAR_DATA,this.onChangeOtherItemsInUseData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_FOOD_DATA,this.onChangeOtherFoodData);
         super.removeEvents();
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
      }
      
      private function onChangeOtherArmamentData(param1:MafiaUserEvent) : void
      {
         fillArmament(MafiaModel.otherUserData.armament);
      }
      
      private function onChangeOtherAvatarData(param1:MafiaUserEvent) : void
      {
         fillAvatarStats(MafiaModel.otherUserData.profileData);
      }
      
      private function onChangeOtherItemsInUseData(param1:MafiaUserEvent) : void
      {
         fillGear(MafiaModel.otherUserData.gearData.items);
      }
      
      private function onChangeOtherFoodData(param1:MafiaUserEvent) : void
      {
         fillFood(MafiaModel.otherUserData.foodData.food);
      }
      
      private function onChangeOtherAchievementsData(param1:MafiaUserEvent) : void
      {
         this.fillAchievements(MafiaModel.otherUserData.achievementsData.achievements);
      }
      
      override public function fillAchievements(param1:Vector.<AchievementVO>) : void
      {
         super.fillAchievements(param1);
      }
      
      private function onChangeOtherBoosterData(param1:MafiaUserEvent) : void
      {
         this.fillBooster(MafiaModel.otherUserData.boosterData);
      }
      
      override public function fillBooster(param1:MafiaBoosterData) : void
      {
         super.fillBooster(param1);
         if(param1.boosterID == 0)
         {
            tabAdditional.boosterPicField.visible = false;
            tabAdditional.noBooster.visible = false;
         }
         else
         {
            tabAdditional.boosterPicField.visible = true;
            tabAdditional.boosterPicField.txt_traveltime.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_questduration");
            tabAdditional.boosterPicField.txt_traveltime.appendText("\n" + String("-" + param1.boosterPower + "%"));
            tabAdditional.boosterPicField.txt_boostduration.text = "";
            tabAdditional.noBooster.visible = false;
         }
      }
      
      private function onChangeOtherGangData(param1:MafiaGangEvent) : void
      {
         super.fillGang(MafiaModel.otherUserData.gangData);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
      }
   }
}
