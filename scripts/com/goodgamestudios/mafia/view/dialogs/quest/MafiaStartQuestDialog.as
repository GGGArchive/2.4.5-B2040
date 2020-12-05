package com.goodgamestudios.mafia.view.dialogs.quest
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.controller.commands.quest.StartQuestCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaStartQuestDialogProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaStartQuestDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaStartQuestDialog";
       
      
      public function MafiaStartQuestDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_start");
         this.standardDialog.btn_cancle.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
      }
      
      override protected function applyProperties() : void
      {
         this.fillTasks(this.data.questVO.tasks);
         this.fillInfoText(this.data.questVO.questStatus);
      }
      
      private function fillTasks(param1:Vector.<QuestTaskVO>) : void
      {
         var _loc3_:QuestTaskVO = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_] as QuestTaskVO;
            this.standardDialog["txt_quest_" + _loc2_].text = MafiaModel.languageData.getTextById("MafiaQuest_task_" + _loc3_.id);
            this.standardDialog["txt_quest_value_" + _loc2_].text = _loc3_.currentValue + " / " + _loc3_.requiredValue;
            this.standardDialog["icon" + _loc2_].gotoAndStop(_loc3_.iconId);
            _loc2_++;
         }
      }
      
      private function fillInfoText(param1:QuestStatus) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         switch(param1)
         {
            case QuestStatus.Locked:
               _loc2_ = MafiaModel.languageData.getTextById("MafiaCityQuestStartDialog_copy_1");
               _loc3_ = MafiaModel.languageData.getTextById("MafiaCityQuestStartDialog_title",[this.data.district_id + 1]);
         }
         this.standardDialog.txt_title.text = _loc3_;
         this.standardDialog.txt_copy.text = _loc2_;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
               if(!MafiaModel.userData.questData.activeCityQuest)
               {
                  StartQuestCommand.sendCommand(this.data.questVO.id);
               }
               else
               {
                  _loc2_ = MafiaModel.languageData.getCityName(MafiaModel.userData.questData.activeCityQuest.city);
                  _loc3_ = MafiaModel.userData.questData.activeCityQuest.districtNumber + 1;
                  layoutManager.showDialog(MafiaInterruptQuestDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaCityQuestStartDialog_title",[this.data.district_id]),MafiaModel.languageData.getTextById("MafiaCityQuestStartDialog_copy_2",[_loc3_,_loc2_]),this.startQuest,null,null,MafiaModel.languageData.getTextById("generic_btn_okay"),MafiaModel.languageData.getTextById("generic_btn_no")));
               }
               hide();
               break;
            case this.standardDialog.btn_cancle:
            case this.standardDialog.btn_close:
               hide();
         }
      }
      
      private function startQuest() : void
      {
         StartQuestCommand.sendCommand(this.data.questVO.id);
      }
      
      protected function get data() : MafiaStartQuestDialogProperties
      {
         return properties as MafiaStartQuestDialogProperties;
      }
      
      protected function get standardDialog() : MafiaStartQuest
      {
         return disp as MafiaStartQuest;
      }
   }
}
