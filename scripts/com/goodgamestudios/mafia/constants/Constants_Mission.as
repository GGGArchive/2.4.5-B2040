package com.goodgamestudios.mafia.constants
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.utils.getDefinitionByName;
   
   public class Constants_Mission
   {
      
      public static const MAX_MISSIONS:Array = [25,9,9];
       
      
      private const PICLIST:Array = [PicMissiongiver_1_1,PicMissiongiver_1_2,PicMissiongiver_1_3,PicMissiongiver_1_4,PicMissiongiver_0_1,PicMissiongiver_0_2,PicMissiongiver_0_3,PicMissiongiver_0_4,PicMissiongiver_2_1,PicMissiongiver_2_2,PicMissiongiver_2_3,PicMissiongiver_2_4];
      
      public function Constants_Mission()
      {
         super();
      }
      
      public static function getMissionGiverPicClass(param1:int) : Class
      {
         var _loc2_:Class = null;
         switch(param1)
         {
            case 1:
               _loc2_ = getDefinitionByName("PicMissiongiver_" + MafiaModel.userData.profileData.city.index + "_3") as Class;
               return _loc2_;
            case 2:
               _loc2_ = getDefinitionByName("PicMissiongiver_" + MafiaModel.userData.profileData.city.index + "_1") as Class;
               return _loc2_;
            case 3:
               _loc2_ = getDefinitionByName("PicMissiongiver_" + MafiaModel.userData.profileData.city.index + "_2") as Class;
               return _loc2_;
            case 4:
               _loc2_ = getDefinitionByName("PicMissiongiver_" + MafiaModel.userData.profileData.city.index + "_4") as Class;
               return _loc2_;
            default:
               return emptyMC;
         }
      }
   }
}
