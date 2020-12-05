package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBAchievement;
   import com.goodgamestudios.mafia.controller.protobuf.misc.newachievements.PBMiscNewAchievementsResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNewAchievementDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaNewAchievementDialogProperties;
   import com.goodgamestudios.mafia.vo.NewAchievementVO;
   
   public class MafiaNewAchievementData
   {
       
      
      public function MafiaNewAchievementData()
      {
         super();
      }
      
      public function parseNewAchievements(param1:PBMiscNewAchievementsResponse) : void
      {
         var _loc4_:PBAchievement = null;
         var _loc5_:NewAchievementVO = null;
         var _loc2_:Array = param1.achievements;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as PBAchievement;
            _loc5_ = new NewAchievementVO();
            _loc5_.achievementID = _loc4_.achievementId;
            _loc5_.achievementLevel = _loc4_.level;
            _loc5_.allAttributesBonus = _loc4_.allAttributesBonus;
            _loc5_.goldBonus = _loc4_.goldBonus;
            _loc5_.item = MafiaItemData.parseItem(_loc4_.item,ItemLocation.Inventory,0);
            MafiaDialogHandler.getInstance().registerDialogs(MafiaNewAchievementDialog.NAME,new MafiaNewAchievementDialogProperties(_loc5_,MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title"),MafiaModel.languageData.getTextById("generic_btn_share"),MafiaModel.languageData.getTextById("generic_btn_okay"),this.feedAchievement),true,BasicDialogHandler.PRIORITY_MIDDLE);
            _loc3_++;
         }
      }
      
      private function feedAchievement(param1:String = null) : void
      {
         MafiaModel.socialData.postFeed(MafiaSocialData.EXTERNAL_SHARE_ACHIEVEMENT,[param1]);
      }
   }
}
