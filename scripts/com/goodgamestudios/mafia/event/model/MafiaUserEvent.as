package com.goodgamestudios.mafia.event.model
{
   public class MafiaUserEvent extends MafiaEvent
   {
      
      public static const CHANGE_OWN_USER_DATA:String = "changeSelfUserData";
      
      public static const CHANGE_OWN_USER_CURRENCY:String = "changeSelfUserCurrency";
      
      public static const CHANGE_OWN_USER_AVATAR_DATA:String = "changeSelfUserAvatarData";
      
      public static const CHANGE_OWN_USER_BOOSTER_DATA:String = "changeSelfUserBoosterData";
      
      public static const CHANGE_OWN_USER_ACHIEVEMENT_DATA:String = "changeSelfUserAchievementData";
      
      public static const CHANGE_OWN_USER_GEAR_DATA:String = "changeSelfUserItemsInUseData";
      
      public static const CHANGE_OWN_USER_INVENTORY_DATA:String = "changeSelfUserInventorySata";
      
      public static const CHANGE_OWN_USER_ARMAMENT_DATA:String = "changeSelfUserArmamentData";
      
      public static const CHANGE_OWN_USER_ARMAMENT_PRESET_DATA:String = "changeSelfUserArmaPresetData";
      
      public static const CHANGE_OWN_USER_FOOD_DATA:String = "changeSelfUserFoodData";
      
      public static const CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA:String = "changeSelfUserAttributeCostsData";
      
      public static const CHANGE_PAYUSER_INFO:String = "change_payuser_info";
      
      public static const CHANGE_OTHER_USER_DATA:String = "changeOtherUserData";
      
      public static const CHANGE_OTHER_USER_AVATAR_DATA:String = "changeOtherUserAvatarData";
      
      public static const CHANGE_OTHER_USER_BOOSTER_DATA:String = "changeOtherUserBoosterData";
      
      public static const CHANGE_OTHER_USER_ACHIEVEMENT_DATA:String = "changeOtherUserAchievementData";
      
      public static const CHANGE_OTHER_USER_GEAR_DATA:String = "changeOtherUserItemsInUseData";
      
      public static const CHANGE_OTHER_USER_ARMAMENT_DATA:String = "changeOtherUserArmamentData";
      
      public static const CHANGE_OTHER_USER_FOOD_DATA:String = "changeOtherUserFoodData";
      
      public static const CHANGE_PING_DATA:String = "changePingData";
      
      public static const CHANGE_NAME_OFFER:String = "changeNameOffer";
      
      public static const CHANGE_WRONG_NAME:String = "changeWrongName";
      
      public static const CHANGE_WRONG_REGISTER_PARAMS:String = "changeWrongRegisterParams";
      
      public static const CHANGE_CONNECTION:String = "changeConnection";
      
      public static const CHANGE_NO_CONNECTION:String = "changeNoConnection";
      
      public static const CHANGE_AVATAR:String = "changeAvatar";
      
      public static const CREATED_AVATAR_VALID:String = "newAvatarValid";
      
      public static const CREATED_AVATAR_INVALID:String = "newAvatarInvalid";
      
      public static const INIT_USERDATA:String = "initUserdata";
      
      public static const MAIL_VERIFICATION_FAILED:String = "mailverificationFaild";
      
      public static const MAIL_VERIFICATION_COMPLETED:String = "mailverificationCompleted";
      
      public static const ITEMS_LOCKED:String = "itemsLocked";
      
      public static const ITEMS_UNLOCKED:String = "itemsUnlocked";
      
      public static const ITEM_SWAPPED:String = "itemSwapped";
      
      public static const CHANGE_EQUIP_HELP:String = "changeEquipHelp";
      
      public static const BACK_TO_PRECOMBAT:String = "backToPrecombat";
      
      public static const INVALID_NAME:String = "invalidname";
       
      
      public function MafiaUserEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
