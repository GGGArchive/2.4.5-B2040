package com.goodgamestudios.mafia.view.dialogs.quest
{
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.controller.commands.quest.PauseQuestCommand;
   import com.goodgamestudios.mafia.controller.commands.quest.StartQuestCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaStartQuestDialogProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaProgressQuestDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaProgressQuestDialog";
       
      
      public function MafiaProgressQuestDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         if(this.data.questVO.questStatus == QuestStatus.Paused)
         {
            this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("MafiaCityQuestResumeDialog_btn_resume");
            this.standardDialog.btn_cancle.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
         }
         else if(this.data.questVO.questStatus == QuestStatus.Active)
         {
            this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("MafiaCityQuestPauseDialog_btn_pause");
            this.standardDialog.btn_cancle.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
         }
      }
      
      override protected function applyProperties() : void
      {
         this.fillTasks(this.data.questVO.tasks);
         this.fillInfoText(this.data.questVO.questStatus);
      }
      
      private function fillTasks(param1:Vector.<QuestTaskVO>) : void
      {
         var _loc3_:QuestTaskVO = null;
         var _loc4_:QuestCityTask = null;
         var _loc5_:Number = NaN;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_] as QuestTaskVO;
            _loc4_ = this.standardDialog["task" + _loc2_];
            _loc4_.txt_description.text = MafiaModel.languageData.getTextById("MafiaQuest_task_" + _loc3_.id,[]);
            _loc4_.txt_progress.text = _loc3_.currentValue + "/" + _loc3_.requiredValue;
            _loc5_ = _loc3_.currentValue / _loc3_.requiredValue;
            _loc4_.bar_progress.bar.scaleX = _loc5_;
            _loc4_.check.visible = _loc3_.complete;
            _loc4_.holder.gotoAndStop(_loc3_.iconId);
            _loc2_++;
         }
      }
      
      private function fillInfoText(param1:QuestStatus) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         switch(param1)
         {
            case QuestStatus.Active:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaCityQuestPauseDialog_copy_1");
               _loc3_ = MafiaModel.languageData.getTextById("MafiaCityQuestPauseDialog_title",[this.data.district_id + 1]);
               break;
            case QuestStatus.Paused:
               if(MafiaModel.userData.questData.activeCityQuest)
               {
                  _loc4_ = MafiaModel.languageData.getCityName(MafiaModel.userData.questData.activeCityQuest.city);
                  _loc5_ = MafiaModel.userData.questData.activeCityQuest.districtNumber + 1;
                  _loc2_ = MafiaModel.languageData.getTextById("MafiaCityQuestStartDialog_copy_2",[_loc5_,_loc4_]);
               }
               else
               {
                  _loc2_ = MafiaModel.languageData.getTextById("MafiaCityQuestResumeDialog_copy_1");
               }
               _loc3_ = MafiaModel.languageData.getTextById("MafiaCityQuestResumeDialog_title",[this.data.district_id + 1]);
         }
         this.standardDialog.txt_title.text = _loc3_;
         this.standardDialog.txt_copy.text = _loc2_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
               if(this.data.questVO.questStatus == QuestStatus.Paused)
               {
                  StartQuestCommand.sendCommand(this.data.questVO.id);
               }
               else if(this.data.questVO.questStatus == QuestStatus.Active)
               {
                  PauseQuestCommand.sendCommand(this.data.questVO.id);
               }
               hide();
               break;
            case this.standardDialog.btn_cancle:
            case this.standardDialog.btn_close:
               hide();
         }
      }
      
      protected function get data() : MafiaStartQuestDialogProperties
      {
         return properties as MafiaStartQuestDialogProperties;
      }
      
      protected function get standardDialog() : MafiaPauseQuest
      {
         return disp as MafiaPauseQuest;
      }
   }
}
