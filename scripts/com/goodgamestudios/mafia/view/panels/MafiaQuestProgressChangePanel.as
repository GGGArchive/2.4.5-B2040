package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaQuestlogPanelProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Quadratic;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaQuestProgressChangePanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaQuestProgressChangePanel";
       
      
      private var popupActive:Boolean;
      
      private var popupQuestId:uint;
      
      private var popupQueue:Vector.<MafiaQuestEvent>;
      
      private var tweens:Vector.<GTween>;
      
      private var tweenPausedByMouseover:Boolean;
      
      public function MafiaQuestProgressChangePanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_QUEST_PROGRESS_CHANGE;
         this.popupActive = false;
         this.popupQuestId = 0;
         this.popupQueue = new Vector.<MafiaQuestEvent>();
         this.setupTweens();
         this.panel.mouseChildren = false;
         this.panel.holder.txt_title.text = MafiaModel.languageData.getTextById("MafiaUnlockProgressPanel_title");
         controller.addEventListener(MafiaQuestEvent.QUEST_STARTED,this.onQuestChange);
         controller.addEventListener(MafiaQuestEvent.TASK_PROGRESS,this.onQuestChange);
         controller.addEventListener(MafiaQuestEvent.QUEST_COMPLETED,this.onQuestChange);
         controller.addEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onPopupsUnblocked);
         controller.addEventListener(MafiaDialogEvent.DIALOGS_UNBLOCKED,this.onPopupsUnblocked);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaQuestEvent.QUEST_STARTED,this.onQuestChange);
         controller.removeEventListener(MafiaQuestEvent.TASK_PROGRESS,this.onQuestChange);
         controller.removeEventListener(MafiaQuestEvent.QUEST_COMPLETED,this.onQuestChange);
         controller.removeEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onPopupsUnblocked);
         controller.removeEventListener(MafiaDialogEvent.DIALOGS_UNBLOCKED,this.onPopupsUnblocked);
         super.destroy();
      }
      
      private function get canPopupsBeShown() : Boolean
      {
         return !MafiaLayoutManager.isFightState(MafiaLayoutManager.getInstance().currentState) && !MafiaDialogHandler.getInstance().blockDialogs;
      }
      
      private function onQuestChange(param1:MafiaQuestEvent) : void
      {
         if(this.canPopupsBeShown && !this.popupActive)
         {
            this.showPopup(param1.type,param1.params);
         }
         else
         {
            this.popupQueue.push(param1);
         }
      }
      
      private function onPopupsUnblocked(param1:MafiaDialogEvent) : void
      {
         if(this.canPopupsBeShown && !this.popupActive)
         {
            this.showNextFromQueue();
         }
      }
      
      private function showNextFromQueue() : void
      {
         var _loc1_:MafiaQuestEvent = null;
         if(this.popupQueue.length > 0)
         {
            this.removeDuplicatesFromQueue();
            this.removeUpdatesForCompletedQuestsFromQueue();
            _loc1_ = this.popupQueue.shift();
            this.showPopup(_loc1_.type,_loc1_.params);
         }
      }
      
      private function removeUpdatesForCompletedQuestsFromQueue() : void
      {
         var _loc2_:MafiaQuestEvent = null;
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         for each(_loc2_ in this.popupQueue)
         {
            if(_loc2_.type == MafiaQuestEvent.QUEST_COMPLETED)
            {
               _loc1_.push((_loc2_.params[0] as QuestVO).id);
            }
         }
         if(_loc1_.length == 0)
         {
            return;
         }
         var _loc3_:Vector.<MafiaQuestEvent> = new Vector.<MafiaQuestEvent>();
         for each(_loc2_ in this.popupQueue)
         {
            if(_loc2_.type != MafiaQuestEvent.TASK_PROGRESS || _loc1_.indexOf((_loc2_.params[0] as QuestVO).id) == -1)
            {
               _loc3_.push(_loc2_);
            }
         }
         this.popupQueue = _loc3_;
      }
      
      private function removeDuplicatesFromQueue() : void
      {
         var _loc2_:MafiaQuestEvent = null;
         var _loc3_:Boolean = false;
         var _loc4_:MafiaQuestEvent = null;
         var _loc1_:Vector.<MafiaQuestEvent> = new Vector.<MafiaQuestEvent>();
         for each(_loc2_ in this.popupQueue)
         {
            _loc3_ = false;
            for each(_loc4_ in _loc1_)
            {
               if(_loc2_.type == _loc4_.type && _loc2_.params[0] && _loc4_.params[0] && (_loc2_.params[0] as QuestVO).id == (_loc4_.params[0] as QuestVO).id)
               {
                  if(_loc2_.type == MafiaQuestEvent.TASK_PROGRESS)
                  {
                     if(_loc2_.params[1] && _loc4_.params[1] && (_loc2_.params[1] as QuestTaskVO).id == (_loc4_.params[1] as QuestTaskVO).id)
                     {
                        if(_loc2_.params[2] && _loc4_.params[2] && _loc2_.params[2] < _loc4_.params[2])
                        {
                           _loc4_.params[2] = _loc2_.params[2];
                        }
                        _loc3_ = true;
                        break;
                     }
                     continue;
                  }
                  _loc3_ = true;
                  break;
               }
            }
            if(!_loc3_)
            {
               _loc1_.push(_loc2_);
            }
         }
         this.popupQueue = _loc1_;
      }
      
      private function showPopup(param1:String, param2:Array) : void
      {
         var _loc5_:QuestTaskVO = null;
         var _loc6_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:QuestVO = param2[0];
         switch(param1)
         {
            case MafiaQuestEvent.QUEST_STARTED:
               this.panel.holder.gotoAndStop(1);
               this.panel.holder.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuestProgressPanel_copy_1");
               break;
            case MafiaQuestEvent.TASK_PROGRESS:
               _loc5_ = param2[1];
               _loc6_ = param2[2];
               this.panel.holder.gotoAndStop(!!_loc5_.complete?3:2);
               this.panel.holder.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuestProgressPanel_copy_2");
               this.panel.holder.icon_task.gotoAndStop(_loc5_.iconId);
               this.panel.holder.txt_value.text = _loc6_ + "/" + _loc5_.requiredValue;
               _loc3_.push(_loc5_.currentValue);
               _loc3_.push(_loc5_.requiredValue);
               break;
            case MafiaQuestEvent.QUEST_COMPLETED:
               this.panel.holder.gotoAndStop(4);
               this.panel.holder.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuestProgressPanel_copy_3");
         }
         updateAllTextFields();
         this.panel.holder.quest_icon.gotoAndStop(_loc4_.type.index);
         this.panel.holder.alpha = 1;
         show();
         this.popupActive = true;
         this.popupQuestId = _loc4_.id;
         this.playTweens(_loc3_);
      }
      
      private function setupTweens() : void
      {
         var _loc5_:GTween = null;
         this.tweens = new Vector.<GTween>();
         var _loc1_:GTween = new GTween(this.panel.holder,0.4,{
            "scaleX":1.2,
            "scaleY":1.2
         },{"ease":Quadratic.easeInOut});
         _loc1_.onComplete = this.onTweenGrowEnded;
         var _loc2_:GTween = new GTween(this.panel.holder,0.4,{
            "scaleX":1,
            "scaleY":1
         },{"ease":Quadratic.easeInOut});
         var _loc3_:GTween = new GTween(null,3);
         var _loc4_:GTween = new GTween(this.panel.holder,0.3,{"alpha":0});
         _loc4_.onComplete = this.onTweenFadeOutEnded;
         _loc1_.nextTween = _loc2_;
         _loc2_.nextTween = _loc3_;
         _loc3_.nextTween = _loc4_;
         this.tweens.push(_loc1_);
         this.tweens.push(_loc2_);
         this.tweens.push(_loc3_);
         this.tweens.push(_loc4_);
         for each(_loc5_ in this.tweens)
         {
            _loc5_.paused = true;
         }
      }
      
      private function playTweens(param1:Array) : void
      {
         var _loc2_:int = this.tweens.length - 1;
         while(_loc2_ >= 0)
         {
            this.tweens[_loc2_].beginning();
            _loc2_--;
         }
         this.tweens[0].data = param1;
         this.tweens[0].paused = false;
      }
      
      private function onTweenGrowEnded(param1:GTween) : void
      {
         if(param1.data.length >= 2)
         {
            this.panel.holder.txt_value.text = param1.data[0] + "/" + param1.data[1];
         }
      }
      
      private function onTweenFadeOutEnded(param1:GTween) : void
      {
         hide();
         this.popupActive = false;
         this.popupQuestId = 0;
         if(this.canPopupsBeShown)
         {
            this.showNextFromQueue();
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            disp.x = disp.stage.stageWidth * 0.5;
            disp.y = 50 * disp.scaleY;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         layoutManager.showPanel(MafiaQuestlogPanel.NAME,new MafiaQuestlogPanelProperties(this.popupQuestId));
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         if(this.tweens[2].paused == false)
         {
            this.tweens[2].beginning();
            this.tweenPausedByMouseover = true;
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         if(this.tweenPausedByMouseover)
         {
            this.tweens[2].paused = false;
         }
      }
      
      protected function get panel() : MafiaQuestProgressChange
      {
         return disp as MafiaQuestProgressChange;
      }
   }
}
