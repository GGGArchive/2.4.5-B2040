package com.goodgamestudios.mafia.view.screens.survival
{
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class MafiaSurvivalOverviewComponent extends MafiaSurvivalComponent
   {
       
      
      private const MAX_SURVIVAL_LENGTH:int = 31;
      
      public function MafiaSurvivalOverviewComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
         this.overview.deselectionLayer.gotoAndStop(1);
         toForeground();
      }
      
      public function fillSurvivalData(param1:MafiaSurvivalResultData) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:HellBreakpointPosition = null;
         var _loc5_:int = 0;
         var _loc6_:ColorMatrix = null;
         this.overview.txt_title.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_1");
         if(param1.survivalProgress == 0)
         {
            this.overview.txt_copy.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_4");
         }
         else if(param1.survivalProgress < param1.absoluteKilledEnemies)
         {
            this.overview.txt_copy.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_11");
         }
         else if(param1.survivalProgress == MafiaSurvivalResultData.MAX_ENEMIES)
         {
            this.overview.txt_copy.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_12");
         }
         else
         {
            this.overview.txt_copy.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_7");
         }
         this.overview.progress.bar.scaleX = 1;
         if(param1.absoluteKilledEnemies > param1.survivalProgress && param1.survivalProgress < MafiaSurvivalResultData.MAX_ENEMIES)
         {
            this.overview.progress.maxKilled.visible = true;
            _loc3_ = this.overview.progress.bar.width / MafiaSurvivalResultData.MAX_ENEMIES * param1.absoluteKilledEnemies;
            this.overview.progress.maxKilled.x = _loc3_ - 0.5;
            this.overview.progress.maxKilled.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaSurvivalScreen_failed");
         }
         else
         {
            this.overview.progress.maxKilled.visible = false;
         }
         this.overview.progress.bar.scaleX = param1.survivalProgress / MafiaSurvivalResultData.MAX_ENEMIES;
         this.overview.hellBoss.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaSurvivalScreen_finalBattle");
         var _loc2_:uint = 1;
         while(_loc2_ < 7)
         {
            _loc4_ = this.overview.progress["break" + _loc2_] as HellBreakpointPosition;
            _loc4_.mouseChildren = false;
            _loc5_ = _loc2_ * 5;
            _loc4_.toolTipText = null;
            _loc4_.txt_count.text = _loc5_.toString();
            _loc6_ = new ColorMatrix();
            if(_loc5_ > param1.survivalProgress)
            {
               _loc6_.desaturate();
            }
            else
            {
               _loc6_.reset();
            }
            _loc4_.filters = [_loc6_.filter];
            _loc4_.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaSurvivalScreen_checkpoint",[_loc2_.toString()]);
            _loc2_++;
         }
      }
      
      public function fillNextOpponentClass(param1:MafiaSurvivalResultData) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:CharacterClass = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.MAX_SURVIVAL_LENGTH)
         {
            _loc4_ = this.overview.progress["a" + _loc2_] as MovieClip;
            MovieClipHelper.clearMovieClip(_loc4_);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.opponentCharacterClass.length)
         {
            if(_loc3_ + param1.survivalProgress < this.MAX_SURVIVAL_LENGTH)
            {
               _loc5_ = this.overview.progress["a" + (_loc3_ + param1.survivalProgress)] as MovieClip;
               _loc6_ = param1.opponentCharacterClass[_loc3_] as CharacterClass;
               switch(_loc6_)
               {
                  case CharacterClass.Bully:
                     _loc5_.addChild(new IconClass1());
                     _loc5_.getChildAt(0).scaleX = _loc5_.getChildAt(0).scaleY = 0.4;
                     break;
                  case CharacterClass.Rogue:
                     _loc5_.addChild(new IconClass2());
                     _loc5_.getChildAt(0).scaleX = _loc5_.getChildAt(0).scaleY = 0.4;
                     break;
                  case CharacterClass.Tactician:
                     _loc5_.addChild(new IconClass3());
                     _loc5_.getChildAt(0).scaleX = _loc5_.getChildAt(0).scaleY = 0.4;
               }
            }
            _loc3_++;
         }
      }
      
      protected function get overview() : HellOverview
      {
         return disp as HellOverview;
      }
   }
}
