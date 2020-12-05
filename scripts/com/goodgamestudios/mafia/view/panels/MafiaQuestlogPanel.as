package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.commands.quest.ViewQuestBookCommand;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.quest.MafiaQuestData;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaQuestlogPanelProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaQuestlogAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaQuestlogAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaQuestlogPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaQuestlogPanel";
      
      private static const NUM_QUESTS_IN_VIEW:uint = 5;
      
      private static const NUM_TASKS_PER_QUEST:uint = 4;
       
      
      private var scrollPos:int = 0;
      
      private var selectedQuestIndex:uint = 0;
      
      private var scollingEnabled:Boolean = true;
      
      private var questIndexMap:Array;
      
      public function MafiaQuestlogPanel(param1:DisplayObject)
      {
         this.questIndexMap = new Array();
         super(param1);
         index = PANEL_INDEX_QUESTLOG;
      }
      
      override public function show() : void
      {
         super.show();
         if(MafiaModel.userData.questData.newQuestsAvailable)
         {
            ViewQuestBookCommand.sendCommand();
         }
         this.panel.txt_playername.text = MafiaModel.userData.profileData.name;
         if(this.panelProperties)
         {
            this.selectQuestById(this.panelProperties.questId);
            properties = null;
         }
         this.fill();
         this.updateScrollingEnabled();
         controller.addEventListener(MafiaQuestEvent.CHANGE_QUESTLOG_DATA,this.onChangeQuestlogData);
         controller.addEventListener(MafiaQuestEvent.TASK_PROGRESS,this.onChangeQuestlogData);
         this.panel.sidebar.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function selectQuestById(param1:uint) : void
      {
         var _loc2_:Vector.<QuestVO> = null;
         var _loc3_:uint = 0;
         if(param1 > 0)
         {
            _loc2_ = MafiaModel.userData.questData.activeQuests;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].id == param1)
               {
                  if(_loc3_ - this.scrollPos >= NUM_QUESTS_IN_VIEW)
                  {
                     this.scrollPos = _loc3_ - NUM_QUESTS_IN_VIEW + 1;
                  }
                  else if(_loc3_ - this.scrollPos < 0)
                  {
                     this.scrollPos = _loc3_;
                  }
                  this.selectedQuestIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function hide() : void
      {
         super.hide();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaQuestEvent.CHANGE_QUESTLOG_DATA,this.onChangeQuestlogData);
         controller.removeEventListener(MafiaQuestEvent.TASK_PROGRESS,this.onChangeQuestlogData);
         this.panel.sidebar.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      private function fill() : void
      {
         this.fillSidebar();
         this.fillQuest();
      }
      
      private function fillSidebar() : void
      {
         var _loc4_:QuestlogQuest = null;
         var _loc5_:uint = 0;
         var _loc6_:QuestVO = null;
         var _loc7_:Point = null;
         var _loc1_:MafiaQuestData = MafiaModel.userData.questData;
         var _loc2_:uint = MafiaModel.userData.questData.numActiveQuests;
         var _loc3_:uint = 0;
         while(_loc3_ < NUM_QUESTS_IN_VIEW)
         {
            _loc4_ = this.panel.sidebar["quest_" + _loc3_];
            _loc5_ = _loc3_ + this.scrollPos;
            if(_loc2_ > NUM_QUESTS_IN_VIEW)
            {
               _loc5_ = _loc5_ >= _loc2_?uint(_loc5_ - _loc2_):uint(_loc5_);
               _loc5_ = _loc5_ < 0?uint(_loc5_ + _loc2_):uint(_loc5_);
            }
            if(_loc5_ < _loc2_)
            {
               _loc4_.visible = true;
               _loc6_ = _loc1_.activeQuests[_loc5_];
               this.fillQuestInSidebar(_loc6_,_loc4_,_loc5_ == this.selectedQuestIndex);
               _loc7_ = _loc4_.localToGlobal(new Point());
               _loc7_.x = _loc7_.x - BasicLayoutManager.getInstance().gameNullPoint;
               _loc7_.x = _loc7_.x / BasicLayoutManager.getInstance().scaleFactor;
               _loc7_.y = _loc7_.y / BasicLayoutManager.getInstance().scaleFactor;
               _loc7_.x = _loc7_.x + _loc4_.width;
               _loc7_.y = _loc7_.y + _loc4_.height / 2;
               _loc4_.toolTipVO = new TooltipVO(MafiaQuestlogAdvancedTooltip.NAME,new MafiaQuestlogAdvancedTooltipProperties(_loc6_),_loc7_,"",BasicCustomCursor.CURSOR_CLICK);
               this.questIndexMap[_loc3_] = _loc5_;
            }
            else
            {
               _loc4_.visible = false;
               _loc4_.toolTipVO = null;
               this.questIndexMap[_loc3_] = null;
            }
            _loc4_.mouseChildren = false;
            _loc3_++;
         }
      }
      
      private function fillQuestInSidebar(param1:QuestVO, param2:QuestlogQuest, param3:Boolean) : void
      {
         switch(param1.type)
         {
            case QuestType.GuidingQuest:
               param2.gotoAndStop(1);
               param2.icon.gotoAndStop(param1.tasks[0].iconId);
               break;
            case QuestType.CityQuest:
               param2.gotoAndStop(2);
               param2.city.gotoAndStop(param1.city.index);
               param2.txt_number.text = "#" + (param1.districtNumber + 1);
               break;
            case QuestType.CityUnlockQuest:
               param2.gotoAndStop(3);
               param2.city.gotoAndStop(param1.reward.unlockCity.index + 1);
         }
         param2.bg.gotoAndStop(!!param3?2:1);
      }
      
      private function fillQuest() : void
      {
         if(this.selectedQuest == null)
         {
            this.selectedQuestIndex = 0;
            if(this.selectedQuest == null)
            {
               this.hide();
               return;
            }
         }
         this.fillDescription();
         this.fillReward();
         this.fillTasks();
      }
      
      private function fillDescription() : void
      {
         var _loc1_:String = "";
         var _loc2_:String = "";
         var _loc3_:String = "";
         switch(this.selectedQuest.type)
         {
            case QuestType.CityQuest:
               _loc3_ = MafiaModel.languageData.getCityName(this.selectedQuest.city);
               _loc1_ = MafiaModel.languageData.getTextById("MafiaQuest_type_2");
               _loc2_ = MafiaModel.languageData.getTextById("MafiaQuestBookDialog_copy_2",[this.selectedQuest.districtNumber + 1,_loc3_]);
               break;
            case QuestType.CityUnlockQuest:
               _loc3_ = MafiaModel.languageData.getCityName(this.selectedQuest.reward.unlockCity);
               _loc1_ = MafiaModel.languageData.getTextById("MafiaQuest_type_3");
               _loc2_ = MafiaModel.languageData.getTextById("MafiaQuestBookDialog_copy_3",[_loc3_]);
               break;
            case QuestType.GuidingQuest:
               _loc1_ = MafiaModel.languageData.getTextById("MafiaQuest_type_1");
               _loc2_ = MafiaModel.languageData.getTextById("MafiaQuestBookDialog_copy_1");
         }
         this.panel.txt_quest_title.text = _loc1_;
         this.panel.txt_quest_description.text = _loc2_;
      }
      
      private function fillReward() : void
      {
         var _loc2_:ItemVO = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Point = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TextField = null;
         var _loc10_:MovieClip = null;
         var _loc1_:Array = ["cash","gold","xp","ap"];
         if(this.selectedQuest.reward.unlockCity != City.None)
         {
            this.panel.reward.gotoAndStop(4);
            this.panel.reward.city.gotoAndStop(this.selectedQuest.reward.unlockCity.index);
         }
         else if(this.selectedQuest.type == QuestType.CityQuest)
         {
            this.panel.reward.gotoAndStop(3);
         }
         else if(this.selectedQuest.reward.item != null)
         {
            this.panel.reward.gotoAndStop(2);
            _loc2_ = this.selectedQuest.reward.item;
            MovieClipHelper.clearMovieClip(this.panel.reward.itemHolder);
            _loc3_ = MafiaItemData.getInstance().generateItemIcon(_loc2_);
            _loc3_.scaleX = _loc3_.scaleY = 0.8;
            this.panel.reward.itemHolder.addChild(_loc3_);
            _loc4_ = _loc3_.localToGlobal(new Point());
            _loc4_.x = _loc4_.x - BasicLayoutManager.getInstance().gameNullPoint;
            _loc4_.x = _loc4_.x / BasicLayoutManager.getInstance().scaleFactor;
            _loc4_.y = _loc4_.y / BasicLayoutManager.getInstance().scaleFactor;
            _loc4_.y = _loc4_.y - _loc3_.height;
            this.panel.reward.itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc2_,TooltipDispPosition.Over,_loc4_,BasicCustomCursor.CURSOR_ARROW);
            if(_loc2_.hasComponent(StackableComponent) && _loc2_.amount)
            {
               this.panel.reward.itemAmount.visible = true;
               this.panel.reward.itemAmount.txt_amount.text = _loc2_.amount.toString();
            }
            else
            {
               this.panel.reward.itemAmount.visible = false;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc6_ = _loc1_[_loc5_];
               _loc7_ = this.selectedQuest.reward[_loc6_];
               if(_loc7_ > 0)
               {
                  this.panel.reward.txt_value.text = _loc7_.toString();
                  this.panel.reward.icon.gotoAndStop(_loc5_ + 1);
               }
               _loc5_++;
            }
         }
         else
         {
            this.panel.reward.gotoAndStop(1);
            this.panel.reward.txt_value_0.visible = false;
            this.panel.reward.icon_0.visible = false;
            this.panel.reward.txt_value_1.visible = false;
            this.panel.reward.icon_1.visible = false;
            _loc8_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc6_ = _loc1_[_loc5_];
               _loc7_ = this.selectedQuest.reward[_loc6_];
               if(_loc7_ > 0)
               {
                  _loc9_ = this.panel.reward["txt_value_" + _loc8_];
                  _loc9_.visible = true;
                  _loc9_.text = _loc7_.toString();
                  _loc10_ = this.panel.reward["icon_" + _loc8_];
                  _loc10_.visible = true;
                  _loc10_.gotoAndStop(_loc5_ + 1);
                  _loc8_++;
                  if(_loc8_ > 1)
                  {
                     break;
                  }
               }
               _loc5_++;
            }
         }
         this.panel.reward.txt_title.text = MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_5");
         updateAllTextFields(this.panel.reward);
      }
      
      private function fillTasks() : void
      {
         var _loc3_:QuestlogTask = null;
         var _loc4_:QuestTaskVO = null;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         if(!(this.selectedQuest && this.selectedQuest.tasks && this.selectedQuest.tasks.length > 0))
         {
            this.panel.tasks.visible = false;
            return;
         }
         this.panel.tasks.visible = true;
         var _loc1_:uint = Math.min(NUM_TASKS_PER_QUEST,this.selectedQuest.tasks.length);
         this.panel.tasks.gotoAndStop(_loc1_);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.panel.tasks["task_" + _loc2_];
            _loc4_ = this.selectedQuest.tasks[_loc2_];
            _loc5_ = [];
            if(_loc4_.districtNumber >= 0)
            {
               _loc5_.push((_loc4_.districtNumber + 1).toString());
            }
            if(_loc4_.city != City.None)
            {
               _loc5_.push(MafiaModel.languageData.getCityName(_loc4_.city));
            }
            _loc3_.txt_description.text = MafiaModel.languageData.getTextById("MafiaQuest_task_" + _loc4_.id,_loc5_);
            _loc3_.txt_progress.text = _loc4_.currentValue + "/" + _loc4_.requiredValue;
            _loc6_ = Math.min(_loc4_.currentValue / _loc4_.requiredValue,1);
            _loc3_.bar_progress.bar.scaleX = _loc6_;
            _loc3_.check.visible = _loc4_.complete;
            _loc3_.icon.gotoAndStop(_loc4_.iconId);
            _loc2_++;
         }
         updateAllTextFields(this.panel.tasks);
      }
      
      private function onChangeQuestlogData(param1:MafiaQuestEvent) : void
      {
         if(MafiaModel.userData.questData.activeQuests.length == 0)
         {
            this.hide();
            return;
         }
         if(this.selectedQuestIndex >= MafiaModel.userData.questData.activeQuests.length)
         {
            this.selectedQuestIndex = MafiaModel.userData.questData.activeQuests.length - 1;
         }
         this.fill();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         super.onClick(param1);
         switch(param1.target)
         {
            case this.panel.btn_close:
               this.hide();
               break;
            case this.panel.sidebar.btn_up:
               this.scrollUp();
               break;
            case this.panel.sidebar.btn_down:
               this.scrollDown();
               break;
            case this.panel.sidebar.quest_0:
            case this.panel.sidebar.quest_1:
            case this.panel.sidebar.quest_2:
            case this.panel.sidebar.quest_3:
            case this.panel.sidebar.quest_4:
               _loc2_ = int(param1.target.name.substr(param1.target.name.length - 1));
               this.selectedQuestIndex = this.questIndexMap[_loc2_];
               this.fill();
         }
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(!this.scollingEnabled)
         {
            return;
         }
         if(param1.delta > 0)
         {
            this.scrollUp();
         }
         else
         {
            this.scrollDown();
         }
         layoutManager.tooltipManager.hideAdvancedTooltip();
      }
      
      private function scrollUp() : void
      {
         if(!this.scollingEnabled)
         {
            return;
         }
         var _loc1_:uint = MafiaModel.userData.questData.numActiveQuests;
         this.scrollPos--;
         if(this.scrollPos < 0)
         {
            this.scrollPos = _loc1_ - 1;
         }
         this.fillSidebar();
      }
      
      private function scrollDown() : void
      {
         if(!this.scollingEnabled)
         {
            return;
         }
         var _loc1_:uint = MafiaModel.userData.questData.numActiveQuests;
         this.scrollPos++;
         if(this.scrollPos >= _loc1_)
         {
            this.scrollPos = 0;
         }
         this.fillSidebar();
      }
      
      private function updateScrollingEnabled() : void
      {
         var _loc1_:MafiaQuestData = MafiaModel.userData.questData;
         this.scollingEnabled = _loc1_.activeQuests.length > NUM_QUESTS_IN_VIEW;
         this.panel.sidebar.btn_up.enableButton = this.scollingEnabled;
         this.panel.sidebar.btn_down.enableButton = this.scollingEnabled;
      }
      
      private function get selectedQuest() : QuestVO
      {
         return this.selectedQuestIndex < MafiaModel.userData.questData.numActiveQuests?MafiaModel.userData.questData.activeQuests[this.selectedQuestIndex]:null;
      }
      
      private function get maxScrollPos() : uint
      {
         return Math.max(0,MafiaModel.userData.questData.numActiveQuests - NUM_QUESTS_IN_VIEW);
      }
      
      protected function get panel() : MafiaQuestlog
      {
         return disp as MafiaQuestlog;
      }
      
      protected function get panelProperties() : MafiaQuestlogPanelProperties
      {
         return properties as MafiaQuestlogPanelProperties;
      }
   }
}
