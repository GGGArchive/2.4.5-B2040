package com.goodgamestudios.mafia.view.screens.survival
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class MafiaSurvivalRewardComponent extends MafiaSurvivalComponent
   {
       
      
      public function MafiaSurvivalRewardComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
         this.reward.deselectionLayer.gotoAndStop(2);
         toBackground();
      }
      
      public function fillSurvivalData(param1:MafiaSurvivalResultData) : void
      {
         var _loc2_:MovieClip = null;
         this.reward.txt_title.text = MafiaModel.languageData.getTextById("event_capovito_reward");
         this.reward.txt_copy1.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_5");
         this.reward.txt_copy2.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_6");
         this.reward.breakpoint.mouseChildren = false;
         this.reward.breakpoint.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaSurvivalScreen_checkpointEnemy");
         this.reward.boss.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaSurvivalScreen_finalBattle");
         MovieClipHelper.clearMovieClip(this.reward.mc_itemHolder);
         if(param1.item && param1.item.type != ItemType.None)
         {
            _loc2_ = MafiaItemData.getInstance().generateItemIcon(param1.item);
            _loc2_.scaleX = _loc2_.scaleY = 1.2;
            this.reward.mc_itemHolder.addChild(_loc2_);
            this.reward.mc_itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc2_.properties,TooltipDispPosition.None);
         }
         this.reward.breakpoint.txt_count.text = "25";
      }
      
      protected function get reward() : HellReward
      {
         return disp as HellReward;
      }
   }
}
