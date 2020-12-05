package com.goodgamestudios.mafia.view.dialogs.quest
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCompleteQuestDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.quest.QuestRewardVO;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaCompleteQuestDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaCompleteQuestDialog";
       
      
      public function MafiaCompleteQuestDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         var _loc2_:String = null;
         super.show();
         var _loc1_:QuestVO = this.data.quest;
         switch(_loc1_.type)
         {
            case QuestType.CityUnlockQuest:
               _loc2_ = BasicModel.languageData.getTextById("MafiaQuestDoneDialog_title_1",[MafiaModel.languageData.getCityName(_loc1_.reward.unlockCity)]);
               break;
            case QuestType.CityQuest:
               _loc2_ = BasicModel.languageData.getTextById("MafiaQuestDoneDialog_title_2");
               break;
            case QuestType.GuidingQuest:
               _loc2_ = BasicModel.languageData.getTextById("MafiaQuestDoneDialog_title_3");
         }
         this.standardDialog.txt_title.text = _loc2_;
         this.standardDialog.txt_copy.text = BasicModel.languageData.getTextById("MafiaQuestDoneDialog_copy_1");
         this.standardDialog.txt_reward.text = BasicModel.languageData.getTextById("MafiaLevelUpDialog_copy_5");
         this.standardDialog.btn_ok.label = BasicModel.languageData.getTextById("generic_btn_okay");
         updateAllTextFields();
      }
      
      override protected function applyProperties() : void
      {
         this.fillTasks(this.data.quest.tasks);
         this.fillReward(this.data.quest.reward,this.data.quest.type);
      }
      
      private function fillTasks(param1:Vector.<QuestTaskVO>) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:QuestTaskVO = null;
         var _loc5_:Array = null;
         this.standardDialog.tasks.gotoAndStop(param1.length);
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = this.standardDialog.tasks["task" + _loc2_];
            _loc4_ = param1[_loc2_] as QuestTaskVO;
            _loc5_ = [];
            if(_loc4_.districtNumber >= 0)
            {
               _loc5_.push((_loc4_.districtNumber + 1).toString());
            }
            if(_loc4_.city != City.None)
            {
               _loc5_.push(MafiaModel.languageData.getCityName(_loc4_.city));
            }
            _loc3_.txt_info.text = MafiaModel.languageData.getTextById("MafiaQuest_task_" + _loc4_.id,_loc5_);
            _loc3_.txt_value.text = _loc4_.requiredValue + "/" + _loc4_.requiredValue;
            _loc2_++;
         }
      }
      
      private function fillReward(param1:QuestRewardVO, param2:QuestType) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc8_:ItemVO = null;
         var _loc9_:MovieClip = null;
         var _loc10_:uint = 0;
         var _loc6_:MafiaQuestReward = new MafiaQuestReward();
         var _loc7_:Array = ["cash","gold","xp","ap"];
         if(param2 == QuestType.CityQuest)
         {
            _loc6_.gotoAndStop("cityquest");
         }
         else if(param1.item)
         {
            _loc6_.gotoAndStop("item");
            _loc3_ = 0;
            while(_loc3_ < _loc7_.length)
            {
               _loc4_ = _loc7_[_loc3_];
               _loc5_ = param1[_loc4_];
               if(_loc5_ > 0)
               {
                  _loc6_.txt_value_0.text = _loc5_.toString();
                  _loc6_.icon_0.gotoAndStop(_loc3_ + 1);
               }
               MovieClipHelper.clearMovieClip(_loc6_.itemHolder);
               _loc8_ = param1.item;
               _loc9_ = MafiaItemData.getInstance().generateItemIcon(_loc8_);
               _loc6_.itemHolder.addChild(_loc9_);
               _loc6_.itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc8_,TooltipDispPosition.Over,null,BasicCustomCursor.CURSOR_ARROW);
               _loc3_++;
            }
         }
         else if(param1.unlockCity != City.None)
         {
            if(param1.unlockCity == City.Miami)
            {
               _loc6_.gotoAndStop("miami");
            }
            else
            {
               _loc6_.gotoAndStop("hongkong");
            }
         }
         else
         {
            _loc6_.gotoAndStop("cash");
            _loc10_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc7_.length)
            {
               _loc4_ = _loc7_[_loc3_];
               _loc5_ = param1[_loc4_];
               if(_loc5_ > 0 && _loc10_ < 2)
               {
                  _loc6_["txt_value_" + _loc10_].text = _loc5_.toString();
                  _loc6_["icon_" + _loc10_].gotoAndStop(_loc3_ + 1);
                  _loc10_++;
               }
               _loc3_++;
            }
         }
         MovieClipHelper.clearMovieClip(this.standardDialog.reward);
         this.standardDialog.reward.addChild(_loc6_);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
            case this.standardDialog.btn_close:
               hide();
         }
      }
      
      protected function get data() : MafiaCompleteQuestDialogProperties
      {
         return properties as MafiaCompleteQuestDialogProperties;
      }
      
      protected function get standardDialog() : MafiaCompleteQuest
      {
         return disp as MafiaCompleteQuest;
      }
   }
}
