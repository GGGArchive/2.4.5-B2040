package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Mission;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.mission.QuitMissionCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.city.QuitCityEventMissionCommand;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaMissionProgressPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaMissionProgressPanel";
       
      
      public function MafiaMissionProgressPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_MISSION_PROGRESS;
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         this.missionProgressPanel.btn_quit.enableButton = false;
         this.missionProgressPanel.bg.gotoAndStop(3);
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_TIMER,this.onChangeMissionWorkTimer);
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
            disp.x = Constants_Basic.GAME_WIDTH * 0.5 * disp.scaleX + layoutManager.gameNullPoint;
            disp.y = PANEL_YPOS * disp.scaleY;
         }
      }
      
      private function onChangeMissionWorkTimer(param1:MafiaMissionEvent) : void
      {
         if(param1.params[1] > 0)
         {
            this.missionProgressPanel.txt_value.text = param1.params[0];
            this.missionProgressPanel.progress_Bar.bar.scaleX = param1.params[1] * 0.01;
         }
         else
         {
            this.missionProgressPanel.txt_value.text = "0";
            this.missionProgressPanel.progress_Bar.bar.scaleX = 0;
         }
         if(param1.params[0] == "00:00")
         {
            this.missionProgressPanel.progress_Bar.bar.scaleX = 1;
         }
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaMissionEvent.CHANGE_MISSION_TIMER,this.onChangeMissionWorkTimer);
         this.missionProgressPanel.txt_value.text = "";
         this.missionProgressPanel.txt_value.visible = true;
         this.missionProgressPanel.progress_Bar.visible = true;
         this.missionProgressPanel.btn_cancel.visible = true;
         this.missionProgressPanel.clock.visible = true;
         if(MafiaModel.userData.profileData.isFastQuitMissionUnlocked)
         {
            this.missionProgressPanel.btn_quit.enableButton = true;
            this.missionProgressPanel.btn_quit.toolTipText = null;
         }
         else
         {
            this.missionProgressPanel.btn_quit.enableButton = false;
            this.missionProgressPanel.btn_quit.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_FAST_QUIT_MISSION]);
         }
         this.missionProgressPanel.btn_quit.goldInfoVisible = false;
         this.missionProgressPanel.btn_quit.label = MafiaModel.languageData.getTextById("generic_btn_endnow");
         this.showByStatus();
         this.missionProgressPanel.btn_quit.update();
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.showByStatus();
      }
      
      private function showByStatus() : void
      {
         var _loc1_:uint = 1 + (MafiaModel.userData.progressData.actionID - 1) % Constants_Mission.MAX_MISSIONS[MafiaModel.userData.profileData.city.index];
         MovieClipHelper.clearMovieClip(this.missionProgressPanel.missionGiverHolder);
         this.missionProgressPanel.missionGiverHolder.addChild(new Constants_Mission.getMissionGiverPicClass(MafiaModel.userData.progressData.missionGiverID)());
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_FREE:
               hide();
               break;
            case Constants_Status.STATUS_ON_A_MISSION:
               if(MafiaModel.specialEvent.sicilianEvent.isSicilianMission)
               {
                  this.missionProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("event_sicilianbeast_quest_title_" + int(MafiaModel.specialEvent.sicilianEvent.solvedMissions + 1));
                  this.missionProgressPanel.txt_copy.text = MafiaModel.languageData.getTextById("event_sicilianbeast_quest_copy_" + int(MafiaModel.specialEvent.sicilianEvent.solvedMissions + 1));
               }
               else
               {
                  this.missionProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuest_" + MafiaModel.userData.profileData.city.index + "_title_" + String(_loc1_));
                  this.missionProgressPanel.txt_copy.text = MafiaModel.languageData.getTextById("MafiaQuest_" + MafiaModel.userData.profileData.city.index + "_copy_" + String(_loc1_));
               }
               this.missionProgressPanel.btn_quit.enableButton = MafiaModel.userData.profileData.isFastQuitMissionUnlocked;
               this.missionProgressPanel.btn_quit.label = MafiaModel.languageData.getTextById("generic_btn_endnow");
               this.missionProgressPanel.btn_quit.goldInfoVisible = true;
               this.missionProgressPanel.btn_quit.goldInfoTimeText = MafiaModel.goldConstants.cutMissionPricePerSecond.toString();
               this.missionProgressPanel.btn_cancel.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
               break;
            case Constants_Status.STATUS_MISSION_FINISHED:
               this.missionProgressPanel.txt_copy.text = MafiaModel.languageData.getTextById("MafiaQuestDoneDialog_copy1");
               if(MafiaModel.specialEvent.sicilianEvent.isSicilianMission)
               {
                  this.missionProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("event_sicilianbeast_quest_title_" + MafiaModel.specialEvent.sicilianEvent.solvedMissions);
               }
               else
               {
                  this.missionProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuest_" + MafiaModel.userData.profileData.city.index + "_title_" + String(_loc1_));
               }
               this.missionProgressPanel.progress_Bar.visible = false;
               this.missionProgressPanel.clock.visible = false;
               this.missionProgressPanel.txt_value.visible = false;
               this.missionProgressPanel.btn_cancel.visible = false;
               this.missionProgressPanel.btn_quit.goldInfoVisible = false;
               this.missionProgressPanel.btn_quit.enableButton = true;
               this.missionProgressPanel.btn_quit.toolTipText = null;
               this.missionProgressPanel.btn_quit.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               updateAllTextFields();
               this.missionProgressPanel.btn_quit.update();
               if(MafiaTutorialController.getInstance().isActive)
               {
                  if(MafiaTutorialController.getInstance().tutorialState == MafiaTutorialController.TUT_STATE_WAITING_FOR_MISSIONBEGIN)
                  {
                     MafiaTutorialController.getInstance().nextStep();
                     this.missionProgressPanel.btn_quit.addChild(MafiaTutorialController.getInstance().tutorialArrow);
                  }
               }
         }
         updateAllTextFields();
         layoutManager.tooltipManager.hide();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_WAITING_FOR_MISSIONBEGIN:
               case MafiaTutorialController.TUT_STATE_ENDMISSION:
                  if(param1.target == this.missionProgressPanel.btn_quit && this.missionProgressPanel.btn_quit.enabled)
                  {
                     MafiaTutorialController.getInstance().nextStep();
                     break;
                  }
                  return;
            }
         }
         var _loc2_:Array = [];
         switch(param1.target)
         {
            case this.missionProgressPanel.btn_cancel:
               hide();
               MafiaModel.userData.status = Constants_Status.STATUS_FREE;
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_CANCEL_MISSION,_loc2_);
               break;
            case this.missionProgressPanel.btn_quit:
               if(!this.missionProgressPanel.btn_quit.enabled)
               {
                  return;
               }
               switch(MafiaModel.userData.status)
               {
                  case Constants_Status.STATUS_MISSION_FINISHED:
                     if(MafiaModel.specialEvent.sicilianEvent.isSicilianMission)
                     {
                        QuitCityEventMissionCommand.sendCommand();
                     }
                     else
                     {
                        QuitMissionCommand.sendCommand();
                     }
                     MafiaDialogHandler.getInstance().blockDialogs = true;
                     break;
                  case Constants_Status.STATUS_ON_A_MISSION:
                     if(MafiaModel.userData.gold >= MafiaModel.goldConstants.cutMissionPricePerSecond)
                     {
                        MafiaModel.userData.status = Constants_Status.STATUS_FREE;
                        MafiaModel.userData.progressData.duration = 0;
                     }
                     if(MafiaModel.specialEvent.sicilianEvent.isSicilianMission)
                     {
                        QuitCityEventMissionCommand.sendCommand();
                     }
                     else
                     {
                        QuitMissionCommand.sendCommand();
                     }
                     MafiaDialogHandler.getInstance().blockDialogs = true;
               }
               if(MafiaModel.userData.gold < MafiaModel.goldConstants.cutMissionPricePerSecond)
               {
                  return;
               }
               this.missionProgressPanel.progress_Bar.visible = true;
               this.missionProgressPanel.btn_cancel.visible = true;
               this.missionProgressPanel.btn_quit.enableButton = false;
               hide();
               break;
         }
      }
      
      protected function get missionProgressPanel() : MafiaMissionProgress
      {
         return disp as MafiaMissionProgress;
      }
   }
}
