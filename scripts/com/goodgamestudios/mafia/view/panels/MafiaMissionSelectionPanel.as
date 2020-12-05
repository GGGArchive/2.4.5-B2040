package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Mission;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaSicilianEvent;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBuyEnergyDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBuyEnergyDialogProperties;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaMissionSelectionProperties;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaMissionSelectionPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaMissionSelectionPanel";
       
      
      public function MafiaMissionSelectionPanel(param1:Sprite)
      {
         super(param1);
         index = PANEL_INDEX_MISSION_SELECTION;
         this.missionSelection.bg.gotoAndStop(1);
      }
      
      override public function show() : void
      {
         super.show();
         this.missionSelection.availableMissions.txt_sicilian_missions.text = "";
         this.fillMissions();
         if(MafiaTutorialController.getInstance().isActive)
         {
            if(MafiaTutorialController.getInstance().tutorialState == MafiaTutorialController.TUT_STATE_STARTMISSION)
            {
               this.missionSelection.btn_ok.addChild(MafiaTutorialController.getInstance().tutorialArrow);
            }
         }
      }
      
      override public function hide() : void
      {
         if(isVisible() && MafiaModel.smartfoxClient.isConnected && MafiaModel.specialEvent.sicilianEvent.isEventActive && !MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished && this.panelProperties.missionVO.missionNr + 1 == MafiaSicilianEvent.MISSION_GIVER_ID && !MafiaModel.specialEvent.sicilianEvent.missionGiverActive)
         {
            layoutManager.showPanel(MafiaSicilianNoMissionPanel.NAME,new MafiaMissionSelectionProperties(null,"",MafiaModel.languageData.getTextById("generic_btn_goback"),null,(layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).clickNoMission));
            (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showMissionSelection = true;
         }
         super.hide();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      private function fillMissions() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:ItemVO = null;
         this.missionSelection.availableMissions.txt_sicilian_missions.text = "";
         this.missionSelection.btn_no.label = this.panelProperties.buttonLabel_no;
         if(MafiaModel.specialEvent.sicilianEvent.isEventActive && !MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished && this.panelProperties.missionVO.missionNr + 1 == MafiaSicilianEvent.MISSION_GIVER_ID)
         {
            this.missionSelection.txt_title.text = MafiaModel.languageData.getTextById("event_sicilianbeast_quest_title_" + int(MafiaModel.specialEvent.sicilianEvent.solvedMissions + 1));
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.missionSelection.txt_copy,"\n" + MafiaModel.languageData.getTextById("event_sicilianbeast_quest_copy_" + int(MafiaModel.specialEvent.sicilianEvent.solvedMissions + 1)),11);
            this.missionSelection.availableMissions.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_11",[MafiaModel.specialEvent.sicilianEvent.solvedMissions,MafiaModel.specialEvent.sicilianEvent.totalMissions]);
            controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
            this.missionSelection.availableMissions.visible = true;
            this.updateSicilianTimerText();
         }
         else
         {
            _loc1_ = 1 + (this.panelProperties.missionVO.missionID - 1) % Constants_Mission.MAX_MISSIONS[MafiaModel.userData.profileData.city.index];
            this.missionSelection.txt_title.text = MafiaModel.languageData.getTextById("MafiaQuest_" + MafiaModel.userData.profileData.city.index + "_title_" + String(_loc1_));
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.missionSelection.txt_copy,MafiaModel.languageData.getTextById("MafiaQuest_" + MafiaModel.userData.profileData.city.index + "_copy_" + String(_loc1_)),11);
            this.missionSelection.availableMissions.visible = false;
         }
         this.missionSelection.txt_time.text = String(TimeStringHelper.getShortTimeStringBySeconds(this.panelProperties.missionVO.time));
         this.missionSelection.clock.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_time");
         this.missionSelection.txt_energy.text = String(Math.round(this.panelProperties.missionVO.time / 60 * 10) / 10);
         this.missionSelection.energy.gotoAndStop(3);
         this.missionSelection.energy.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_energy");
         this.missionSelection.txt_xp.text = NumberStringHelper.groupString(this.panelProperties.missionVO.xp,MafiaModel.languageData.getTextById);
         this.missionSelection.xp.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_xp");
         this.missionSelection.txt_cash.text = NumberStringHelper.groupString(this.panelProperties.missionVO.c1,MafiaModel.languageData.getTextById);
         this.missionSelection.cash.toolTipText = MafiaModel.languageData.getTextById("MafiaPayment_cash");
         if(this.panelProperties.missionVO.cIcon == CharacterClass.Bully)
         {
            this.missionSelection.ClassIcon.gotoAndStop(1);
            this.missionSelection.ttHelper.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon1");
         }
         else if(this.panelProperties.missionVO.cIcon == CharacterClass.Rogue)
         {
            this.missionSelection.ClassIcon.gotoAndStop(2);
            this.missionSelection.ttHelper.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon2");
         }
         else if(this.panelProperties.missionVO.cIcon == CharacterClass.Tactician)
         {
            this.missionSelection.ClassIcon.gotoAndStop(3);
            this.missionSelection.ttHelper.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon3");
         }
         if(MafiaModel.userData.userMissionEnergy >= this.panelProperties.missionVO.time / 60 * 10)
         {
            this.missionSelection.btn_ok.label = this.panelProperties.buttonLabel_yes;
            this.missionSelection.btn_ok.toolTipVO = null;
         }
         else
         {
            this.missionSelection.btn_ok.label = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_btn_drink");
            this.missionSelection.btn_ok.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaGodfatherScreen_copy_3")),null,MafiaToolTipManager.TOPDISPMOUSEPOS);
         }
         MovieClipHelper.clearMovieClip(this.missionSelection.missionItemHolder);
         this.missionSelection.missionItemHolder.toolTipVO = null;
         if(this.panelProperties.missionVO.item != null)
         {
            this.missionSelection.strip.visible = true;
            this.missionSelection.missionItemHolder.visible = true;
            _loc2_ = MafiaItemData.getInstance().generateItemIcon(this.panelProperties.missionVO.item);
            this.missionSelection.missionItemHolder.addChild(_loc2_);
            _loc3_ = _loc2_.properties as ItemVO;
            this.missionSelection.missionItemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc3_,TooltipDispPosition.Right);
         }
         else
         {
            this.missionSelection.strip.visible = false;
            this.missionSelection.missionItemHolder.visible = false;
         }
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.missionSelection.txt_ap.text = String(this.panelProperties.missionVO.ap);
            this.missionSelection.ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
            this.missionSelection.ap.visible = true;
         }
         else
         {
            this.missionSelection.ap.visible = false;
            this.missionSelection.txt_ap.text = "";
         }
         MovieClipHelper.clearMovieClip(this.missionSelection.missionGiverHolder);
         this.missionSelection.missionGiverHolder.addChild(new Constants_Mission.getMissionGiverPicClass(this.panelProperties.missionVO.missionNr + 1)());
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         this.updateSicilianTimerText();
      }
      
      private function updateSicilianTimerText() : void
      {
         var _loc1_:String = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_4") + "\n" + MafiaModel.specialEvent.sicilianEvent.runTimeString;
         this.missionSelection.availableMissions.txt_sicilian_missions.text = _loc1_;
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
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_STARTMISSION:
                  if(param1.target == this.missionSelection.btn_ok)
                  {
                     MafiaTutorialController.getInstance().nextStep();
                     break;
                  }
                  return;
            }
         }
         switch(param1.target)
         {
            case this.missionSelection.btn_close:
               this.hide();
               break;
            case this.missionSelection.btn_ok:
               if(MafiaModel.userData.userMissionEnergy >= this.panelProperties.missionVO.time / 60 * 10)
               {
                  this.hide();
                  if(this.panelProperties.functionYes != null)
                  {
                     this.panelProperties.functionYes(this.panelProperties.missionVO.missionNr);
                  }
               }
               else
               {
                  this.hide();
                  layoutManager.showDialog(MafiaBuyEnergyDialog.NAME,new MafiaBuyEnergyDialogProperties(MafiaModel.userData.gold,MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_btn_drink"),MafiaModel.languageData.getTextById("generic_btn_close"),this.buyEnergy));
               }
               break;
            case this.missionSelection.btn_no:
               this.hide();
               if(this.panelProperties.functionNo != null)
               {
                  this.panelProperties.functionNo(null);
               }
         }
      }
      
      private function buyEnergy() : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_BUY_ENERGY,[]);
      }
      
      protected function get panelProperties() : MafiaMissionSelectionProperties
      {
         return properties as MafiaMissionSelectionProperties;
      }
      
      protected function get missionSelection() : MafiaMissionSelection
      {
         return disp as MafiaMissionSelection;
      }
   }
}
