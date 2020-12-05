package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityQuestAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import flash.display.DisplayObject;
   
   public class MafiaCityQuestAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaCityQuestAdvancedTooltip";
      
      private static const BG_HEIGHT:int = 37;
      
      private static const MAGIC_FOUR_OFFSET:int = 4;
       
      
      public function MafiaCityQuestAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuest_type_2");
         this.advancedTooltip.txt_district.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_3") + " " + (this.advancedTooltipProperties.district_id + 1);
         this.fillTasks(this.advancedTooltipProperties.questVO.tasks);
      }
      
      private function fillTasks(param1:Vector.<QuestTaskVO>) : void
      {
         var _loc5_:QuestTaskVO = null;
         var _loc6_:MafiaCityAdvancedQuestLine = null;
         var _loc2_:int = 0;
         this.advancedTooltip.bg.height = 37;
         MovieClipHelper.clearMovieClip(this.advancedTooltip.holder);
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = param1[_loc3_] as QuestTaskVO;
            _loc6_ = new MafiaCityAdvancedQuestLine();
            _loc6_.txt_task_0.text = MafiaModel.languageData.getTextById("MafiaQuest_task_" + _loc5_.id);
            _loc6_.txt_task_value_0.text = _loc5_.currentValue + " / " + _loc5_.requiredValue;
            _loc6_.txt_task_0.textColor = !!_loc5_.complete?uint(7057715):uint(5196099);
            _loc6_.txt_task_value_0.textColor = !!_loc5_.complete?uint(7057715):uint(5196099);
            _loc6_.txt_task_0.height = _loc6_.txt_task_0.textHeight + MAGIC_FOUR_OFFSET;
            this.advancedTooltip.holder.addChild(_loc6_);
            _loc6_.y = _loc2_;
            _loc2_ = _loc2_ + _loc6_.height;
            _loc3_++;
         }
         var _loc4_:MafiaCityAdvancedQuestFooter = new MafiaCityAdvancedQuestFooter();
         switch(this.advancedTooltipProperties.questVO.questStatus)
         {
            case QuestStatus.Locked:
               _loc4_.txt_footer.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_start");
               break;
            case QuestStatus.Active:
               _loc4_.txt_footer.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_pause");
               break;
            case QuestStatus.Paused:
               _loc4_.txt_footer.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_resume");
               break;
            case QuestStatus.Finished:
               _loc4_.txt_footer.text = "";
         }
         _loc4_.y = _loc2_;
         this.advancedTooltip.holder.addChild(_loc4_);
         this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.advancedTooltip.holder.height;
         updateAllTextFields(this.advancedTooltip);
      }
      
      protected function get advancedTooltipProperties() : MafiaCityQuestAdvancedTooltipProperties
      {
         return properties as MafiaCityQuestAdvancedTooltipProperties;
      }
      
      protected function get advancedTooltip() : MafiaCityAdvancedTooltip
      {
         return disp as MafiaCityAdvancedTooltip;
      }
   }
}
