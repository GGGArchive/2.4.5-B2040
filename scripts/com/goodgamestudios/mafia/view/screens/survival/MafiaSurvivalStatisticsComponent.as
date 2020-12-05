package com.goodgamestudios.mafia.view.screens.survival
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import flash.display.DisplayObject;
   
   public class MafiaSurvivalStatisticsComponent extends MafiaSurvivalComponent
   {
       
      
      public function MafiaSurvivalStatisticsComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
         this.statistics.deselectionLayer.gotoAndStop(3);
         toBackground();
      }
      
      public function fillSurvivalData(param1:MafiaSurvivalResultData) : void
      {
         this.statistics.txt_title.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_2");
         var _loc2_:* = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_8",[param1.survivalCompleted]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[6,param1.waypoint6Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[5,param1.waypoint5Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[4,param1.waypoint4Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[3,param1.waypoint3Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[2,param1.waypoint2Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_9",[1,param1.waypoint1Completed]);
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + "\n";
         _loc2_ = _loc2_ + MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_10",[param1.consecutiveEnemiesBeaten]);
         this.statistics.txt_copy.text = _loc2_;
      }
      
      protected function get statistics() : HellStatistics
      {
         return disp as HellStatistics;
      }
   }
}
