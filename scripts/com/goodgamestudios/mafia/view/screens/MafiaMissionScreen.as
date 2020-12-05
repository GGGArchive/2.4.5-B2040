package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.commands.mission.StartMissionCommand;
   import com.goodgamestudios.mafia.controller.commands.mission.ViewMissionCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.city.StartCityEventMissionCommand;
   import com.goodgamestudios.mafia.controller.commands.work.StopWorkingCommand;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaSicilianEvent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBuyEnergyDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaFullInventoryDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBuyEnergyDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaFullInventoryDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionSelectionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianGoToGangwarPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianNoMissionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSlotmachinePanel;
   import com.goodgamestudios.mafia.view.panels.MafiaStartWorkPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTravelProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkFinishedPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkProgressPanel;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaMissionSelectionProperties;
   import com.goodgamestudios.mafia.view.screens.energy.MafiaEnergyBarComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaBarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMissionAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSicilianDungeonAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSicilianMissionAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSlotMachineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaWorkAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaBarAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMissionAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaWorkAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.MissionVO;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaMissionScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaMissionWorkScreen";
       
      
      protected var missionGlow:GlowFilter;
      
      private var _showMissionSelection:Boolean = false;
      
      private var _showWorkSelection:Boolean = false;
      
      private var drinkHelpShown:Boolean = false;
      
      public var energyBar:MafiaEnergyBarComponent;
      
      public function MafiaMissionScreen(param1:DisplayObject)
      {
         this.missionGlow = new GlowFilter(16777215,1,10,10,2);
         super(param1);
         this.energyBar = new MafiaEnergyBarComponent(this.mission.energy_Bar);
         this.fillMission();
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_MISSION;
      }
      
      override public function show() : void
      {
         if(this.mission.currentFrame != MafiaModel.userData.profileData.city.index + 1)
         {
            this.mission.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         }
         super.show();
         this.showMissionSelection = false;
         this.showWorkSelection = false;
         if(MafiaModel.userData.profileData.isBarkeeperUnlocked && !this.drinkHelpShown && !MafiaTutorialController.getInstance().isActive && MafiaModel.userData.missionData.missionEnergy <= 50 && MafiaModel.userData.profileData.level < 11)
         {
            this.drinkHelpShown = true;
            layoutManager.showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_godfather")));
         }
         this.energyBar.show();
         this.mission.sicilian.visible = false;
         this.mission.slot.off.visible = false;
         this.fillMission();
         this.fillWork(MafiaModel.userData.workData.workC1PerHour);
         if(MafiaModel.specialEvent.sicilianEvent.isEventActive)
         {
            this.fillSicilian(MafiaModel.specialEvent.sicilianEvent);
         }
         if(this.mission.currentFrame - 1 == City.Miami.index)
         {
            this.mission.slot.ani.gotoAndPlay(2);
         }
         controller.addEventListener(MafiaWorkEvent.CHANGE_WORK_AWARD_DATA,this.onWorkAwardData);
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onSicilianData);
         controller.addEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_DATA,this.onChangeDungeondata);
         controller.addEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         controller.addEventListener(MafiaMissionEvent.CHANGE_MISSION_RESULT,this.onChangeMissionResult);
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         controller.addEventListener(MafiaWorkEvent.CHANGE_WORK_DATA,this.onChangeWorkdata);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         ViewMissionCommand.sendCommand();
      }
      
      override public function hide() : void
      {
         super.hide();
         layoutManager.hidePanel(MafiaMissionSelectionPanel.NAME);
         layoutManager.hidePanel(MafiaSlotmachinePanel.NAME);
         layoutManager.hidePanel(MafiaTravelProgressPanel.NAME);
      }
      
      override public function destroy() : void
      {
         this.energyBar.destroy();
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         this.energyBar.hide();
         controller.removeEventListener(MafiaWorkEvent.CHANGE_WORK_AWARD_DATA,this.onWorkAwardData);
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onSicilianData);
         controller.removeEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_DATA,this.onChangeDungeondata);
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_RESULT,this.onChangeMissionResult);
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         controller.removeEventListener(MafiaWorkEvent.CHANGE_WORK_DATA,this.onChangeWorkdata);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         super.removeEvents();
      }
      
      private function onChangeDungeondata(param1:MafiaGangwarEvent) : void
      {
         this.fillByStatus();
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case MafiaTutorialController.TUT_STATE_SELECTMISSION:
               MafiaTutorialController.getInstance().addTutorialArrow(this.mission.tutpoint1,false);
               MafiaTutorialController.getInstance().addTutorialArrow(this.mission.tutpoint2,false);
               MafiaTutorialController.getInstance().addTutorialArrow(this.mission.tutpoint3,true);
         }
      }
      
      private function onSicilianData(param1:MafiaSpecialEventsEvent) : void
      {
         this.fillSicilian(param1.params[0]);
      }
      
      private function onSpecialEventIsOver(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:int = param1.params[0];
         switch(_loc2_)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               this.mission.sicilian.visible = false;
               this.mission.sicilian.toolTipVO = null;
               layoutManager.hidePanel(MafiaSicilianNoMissionPanel.NAME);
               layoutManager.hidePanel(MafiaSicilianGoToGangwarPanel.NAME);
               layoutManager.hidePanel(MafiaMissionSelectionPanel.NAME);
               ViewMissionCommand.sendCommand();
               this.showMissionSelection = false;
         }
      }
      
      private function fillSicilian(param1:MafiaSicilianEvent) : void
      {
         this.showMissionSelection = false;
         if(param1.isEventActive && param1.isMissionGiverActive)
         {
            layoutManager.tooltipManager.hideAdvancedTooltip();
            layoutManager.hidePanel(MafiaMissionSelectionPanel.NAME);
            layoutManager.hideDialog(MafiaFullInventoryDialog);
            this.mission.sicilian.visible = true;
            this.mission.slot.off.visible = true;
            if(!param1.isMissionPhaseFinished)
            {
               if(param1.missionGiverActive)
               {
                  if(layoutManager.getPanel(MafiaSicilianNoMissionPanel.NAME) && (layoutManager.getPanel(MafiaSicilianNoMissionPanel.NAME) as MafiaSicilianNoMissionPanel).isVisible())
                  {
                     layoutManager.showSpecificPanel(MafiaMissionSelectionPanel.NAME,new MafiaMissionSelectionProperties(MafiaModel.userData.missionData.missions[3],MafiaModel.languageData.getTextById("generic_btn_start"),MafiaModel.languageData.getTextById("generic_btn_goback"),this.clickStartMission,this.clickNoMission));
                     this.energyBar.fillEnergyBar(MafiaModel.userData.missionData.missions[3].time / 60);
                     this.showMissionSelection = true;
                  }
                  layoutManager.hidePanel(MafiaSicilianNoMissionPanel.NAME);
               }
               this.mission.sicilian.hit.toolTipVO = new TooltipVO(MafiaSicilianMissionAdvancedTooltip.NAME,null,new Point(this.mission.sicilian.x + 230,this.mission.sicilian.y - 200),"",BasicCustomCursor.CURSOR_CLICK);
            }
            else
            {
               layoutManager.hidePanel(MafiaSicilianGoToGangwarPanel.NAME);
               this.mission.sicilian.hit.toolTipVO = new TooltipVO(MafiaSicilianDungeonAdvancedTooltip.NAME,null,new Point(this.mission.sicilian.x + 230,this.mission.sicilian.y - 200),"",BasicCustomCursor.CURSOR_CLICK);
            }
         }
         else
         {
            layoutManager.hidePanel(MafiaMissionSelectionPanel.NAME);
            layoutManager.hideDialog(MafiaFullInventoryDialog);
            this.mission.sicilian.visible = false;
            this.mission.sicilian.toolTipVO = null;
         }
      }
      
      private function onChangeWorkdata(param1:MafiaWorkEvent) : void
      {
         this.fillWork(MafiaModel.userData.workData.workC1PerHour);
      }
      
      private function onWorkAwardData(param1:MafiaWorkEvent) : void
      {
         layoutManager.showPanel(MafiaWorkFinishedPanel.NAME);
      }
      
      private function fillMission() : void
      {
         if(MafiaModel.userData.missionData.missions && MafiaModel.userData.missionData.missions.length > 0)
         {
            this.fillMissions(MafiaModel.userData.missionData.missions);
         }
         this.fillByStatus();
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.energyBar.showDefaultEnergyBar();
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.fillByStatus();
      }
      
      private function fillByStatus() : void
      {
         if(layoutManager.actState == Constants_LayoutStates.STATE_MISSION_FIGHT)
         {
            return;
         }
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_FREE:
               break;
            case Constants_Status.STATUS_ON_A_MISSION:
               if(layoutManager.actState == Constants_LayoutStates.STATE_MISSION)
               {
                  layoutManager.showPanel(MafiaMissionProgressPanel.NAME);
               }
               break;
            case Constants_Status.STATUS_MISSION_FINISHED:
               if(layoutManager.actState == Constants_LayoutStates.STATE_MISSION || layoutManager.actState == Constants_LayoutStates.STATE_PROFILE || layoutManager.actState == Constants_LayoutStates.STATE_PLAYERRANKING)
               {
                  layoutManager.showPanel(MafiaMissionProgressPanel.NAME);
               }
               break;
            case Constants_Status.STATUS_WORKING:
               if(layoutManager.actState == Constants_LayoutStates.STATE_MISSION)
               {
                  layoutManager.showPanel(MafiaWorkProgressPanel.NAME);
               }
               break;
            case Constants_Status.STATUS_WORK_FINISHED:
               if(layoutManager.actState == Constants_LayoutStates.STATE_MISSION || layoutManager.actState == Constants_LayoutStates.STATE_PROFILE || layoutManager.actState == Constants_LayoutStates.STATE_PLAYERRANKING)
               {
                  MafiaModel.userData.status = Constants_Status.STATUS_FREE;
                  StopWorkingCommand.sendCommand();
               }
               break;
            case Constants_Status.STATUS_FLYING:
            case Constants_Status.STATUS_FLIGHT_FINISHED:
               if(MafiaModel.userData.gangwarData.wasInitialized)
               {
                  layoutManager.showPanel(MafiaTravelProgressPanel.NAME);
               }
               else
               {
                  ShowGangWarsCommand.sendCommand();
               }
         }
      }
      
      private function onChangeMissionData(param1:MafiaMissionEvent) : void
      {
         this.fillMissions(MafiaModel.userData.missionData.missions);
      }
      
      private function fillMissions(param1:Vector.<MissionVO>) : void
      {
         var _loc3_:MovieClip = null;
         this.energyBar.visualizeDefault();
         this.mission.bar.properties = [MafiaModel.userData.missionData.energyRefill,MafiaModel.userData.missionData.maxEnergyRefill];
         if(MafiaModel.userData.profileData.isBarkeeperUnlocked)
         {
            this.mission.bar.hit.toolTipVO = new TooltipVO(MafiaBarAdvancedTooltip.NAME,new MafiaBarAdvancedTooltipProperties(this.mission.bar.properties[0],this.mission.bar.properties[1]),MafiaModel.userData.missionData.missionPosList[4],"",BasicCustomCursor.CURSOR_CLICK);
         }
         else
         {
            this.mission.bar.hit.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_barkeeper") + "\n" + MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_BARKEEPER])),MafiaModel.userData.missionData.missionPosList[4],"",BasicCustomCursor.CURSOR_ARROW);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = this.mission["mission" + _loc2_] as MovieClip;
            _loc3_.properties = param1[_loc2_];
            _loc3_.hit.toolTipVO = new TooltipVO(MafiaMissionAdvancedTooltip.NAME,new MafiaMissionAdvancedTooltipProperties(_loc3_.properties),param1[_loc2_].staticPosition,"",BasicCustomCursor.CURSOR_CLICK);
            _loc2_++;
         }
         if(MafiaModel.userData.profileData.isSlotmachineUnlocked)
         {
            this.mission.slot.hit.toolTipVO = new TooltipVO(MafiaSlotMachineAdvancedTooltip.NAME,null,new Point(this.mission.slot.x + 180,this.mission.slot.y - 100),"",BasicCustomCursor.CURSOR_CLICK);
         }
         else
         {
            this.mission.slot.hit.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties("\n\"" + MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_slotmachine_1") + "\"\n\n" + MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_SLOTMACHINE]) + "\n"),new Point(this.mission.slot.x + 180,this.mission.slot.y - 100),"",BasicCustomCursor.CURSOR_ARROW);
         }
         if(param1.length == 4)
         {
            this.mission.sicilian.properties = param1[3];
         }
         this.energyBar.showDefaultEnergyBar();
      }
      
      private function fillWork(param1:int) : void
      {
         var _loc2_:int = 0;
         if(MafiaModel.userData.profileData.isWorkUnlocked)
         {
            _loc2_ = param1;
            this.mission.work.hit.toolTipVO = new TooltipVO(MafiaWorkAdvancedTooltip.NAME,new MafiaWorkAdvancedTooltipProperties(NumberStringHelper.groupString(_loc2_,MafiaModel.languageData.getTextById)),MafiaModel.userData.missionData.missionPosList[5],"",BasicCustomCursor.CURSOR_CLICK);
         }
         else
         {
            this.mission.work.hit.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_protectionmoney_2") + "\n" + MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_WORK])),MafiaModel.userData.missionData.missionPosList[5],"",BasicCustomCursor.CURSOR_ARROW);
         }
         this.fillByStatus();
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MissionVO = null;
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_SELECTMISSION:
                  if(param1.target == this.mission.mission0.hit || param1.target == this.mission.mission1.hit || param1.target == this.mission.mission2.hit)
                  {
                     MafiaTutorialController.getInstance().nextStep();
                     MovieClipHelper.clearMovieClip(this.mission.tutpoint1);
                     MovieClipHelper.clearMovieClip(this.mission.tutpoint2);
                     MovieClipHelper.clearMovieClip(this.mission.tutpoint3);
                  }
                  else
                  {
                     return;
                  }
               case MafiaTutorialController.TUT_STATE_TO_SHOP:
                  return;
               case MafiaTutorialController.TUT_STATE_TUTREWARD:
                  return;
               default:
                  return;
            }
         }
         if(this.showMissionSelection)
         {
            return;
         }
         if(!param1.target.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.mission.mission0.hit:
            case this.mission.mission1.hit:
            case this.mission.mission2.hit:
               if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && !this._showWorkSelection)
               {
                  this.showMissionSelection = true;
                  _loc2_ = param1.target as MovieClip;
                  _loc3_ = _loc2_.parent as MovieClip;
                  layoutManager.showSpecificPanel(MafiaMissionSelectionPanel.NAME,new MafiaMissionSelectionProperties(_loc3_.properties,MafiaModel.languageData.getTextById("generic_btn_start"),MafiaModel.languageData.getTextById("generic_btn_goback"),this.clickStartMission,this.clickNoMission));
                  this.energyBar.fillEnergyBar(_loc3_.properties.time / 60);
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
                  this.onOutMission(_loc2_);
               }
               break;
            case this.mission.bar.hit:
            case this.mission.energy_Bar:
               this.showBuyEnergyDialog();
               break;
            case this.mission.work.hit:
               if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && MafiaModel.userData.profileData.isWorkUnlocked)
               {
                  this.showWorkSelection = true;
                  this.mission.work.gotoAndStop(1);
                  layoutManager.showPanel(MafiaStartWorkPanel.NAME);
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               }
               break;
            case this.mission.slot.hit:
               if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && !this._showWorkSelection && MafiaModel.userData.profileData.isSlotmachineUnlocked)
               {
                  layoutManager.showPanel(MafiaSlotmachinePanel.NAME);
               }
               break;
            case this.mission.sicilian.hit:
               _loc2_ = param1.target as MovieClip;
               _loc4_ = null;
               if(MafiaModel.userData.missionData.missions.length > 3)
               {
                  _loc4_ = MafiaModel.userData.missionData.missions[3];
               }
               this.openSicilianMissionPanel(_loc4_,_loc2_);
         }
      }
      
      public function openSicilianMissionPanel(param1:MissionVO = null, param2:MovieClip = null) : void
      {
         if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && !this._showWorkSelection)
         {
            this.showMissionSelection = true;
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            this.mission.sicilian.gotoAndStop(1);
            if(!MafiaModel.specialEvent.sicilianEvent.isMissionPhaseFinished)
            {
               if(MafiaModel.specialEvent.sicilianEvent.missionCooldown > 0)
               {
                  layoutManager.showPanel(MafiaSicilianNoMissionPanel.NAME,new MafiaMissionSelectionProperties(null,"",MafiaModel.languageData.getTextById("generic_btn_goback"),null,this.clickNoMission));
               }
               else if(this.mission.sicilian.properties && this.mission.sicilian.properties is MissionVO)
               {
                  layoutManager.showSpecificPanel(MafiaMissionSelectionPanel.NAME,new MafiaMissionSelectionProperties(param1,MafiaModel.languageData.getTextById("generic_btn_start"),MafiaModel.languageData.getTextById("generic_btn_goback"),this.clickStartMission,this.clickNoMission));
                  this.energyBar.fillEnergyBar(param1.time / 60);
                  if(param2)
                  {
                     this.onOutMission(param2);
                  }
               }
               else
               {
                  this.showMissionSelection = false;
               }
            }
            else
            {
               layoutManager.showPanel(MafiaSicilianGoToGangwarPanel.NAME,new MafiaMissionSelectionProperties(null,MafiaModel.languageData.getTextById("event_sicilianbeast_btn_toGangwarfare"),MafiaModel.languageData.getTextById("generic_btn_goback"),null,this.clickNoMission));
            }
         }
      }
      
      private function onChangeMissionResult(param1:MafiaMissionEvent) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_MISSION_FIGHT;
      }
      
      private function clickStartMission(param1:int) : void
      {
         this.showMissionSelection = false;
         if(MafiaModel.userData.inventory.isInventoryFull && MafiaModel.userData.missionData.missions[param1].item)
         {
            layoutManager.showDialog(MafiaFullInventoryDialog.NAME,new MafiaFullInventoryDialogProperties(param1,MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_title"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_1"),this.onStartMission,this.gotoShop));
         }
         else
         {
            this.onStartMission(param1);
         }
      }
      
      public function clickNoMission(param1:Object) : void
      {
         this.showMissionSelection = false;
      }
      
      private function onStartMission(param1:int) : void
      {
         this.showMissionSelection = false;
         if(param1 == 3 && MafiaModel.specialEvent.sicilianEvent.isEventActive)
         {
            StartCityEventMissionCommand.sendCommand();
         }
         else
         {
            StartMissionCommand.sendCommand(param1);
         }
      }
      
      private function gotoShop(param1:Object = null) : void
      {
         this.showMissionSelection = false;
         layoutManager.state = Constants_LayoutStates.STATE_SHOP;
      }
      
      public function showBuyEnergyDialog() : void
      {
         if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && !this._showWorkSelection && MafiaModel.userData.profileData.isBarkeeperUnlocked)
         {
            this.mission.bar.gotoAndStop(1);
            layoutManager.showDialog(MafiaBuyEnergyDialog.NAME,new MafiaBuyEnergyDialogProperties(MafiaModel.userData.gold,MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_btn_drink"),MafiaModel.languageData.getTextById("generic_btn_close"),this.buyEnergy));
            this.energyBar.fillPreDrinkEnergyBar();
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function buyEnergy() : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_BUY_ENERGY,[]);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_SELECTMISSION:
                  switch(param1.target)
                  {
                     case this.mission.mission0.hit:
                     case this.mission.mission1.hit:
                     case this.mission.mission2.hit:
                        addr73:
                        if(this.showMissionSelection || this._showWorkSelection)
                        {
                           return;
                        }
                        if(MafiaModel.userData.status == Constants_Status.STATUS_FREE)
                        {
                           super.onMouseOver(param1);
                        }
                        switch(param1.target)
                        {
                           case this.mission.mission1.hit:
                           case this.mission.mission0.hit:
                           case this.mission.mission2.hit:
                              this.onOverMission(param1.target as MovieClip);
                              break;
                           case this.mission.bar.hit:
                           case this.mission.energy_Bar:
                              if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && MafiaModel.userData.profileData.isBarkeeperUnlocked)
                              {
                                 layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                                 this.energyBar.fillPreDrinkEnergyBar();
                              }
                              if(MafiaModel.userData.status == Constants_Status.STATUS_FREE)
                              {
                                 this.mission.bar.gotoAndStop(2);
                              }
                              break;
                           case this.mission.work.hit:
                              if(MafiaModel.userData.status == Constants_Status.STATUS_FREE)
                              {
                                 this.mission.work.gotoAndStop(2);
                              }
                              break;
                           case this.mission.sicilian.hit:
                              if(MafiaModel.userData.status == Constants_Status.STATUS_FREE)
                              {
                                 this.mission.sicilian.gotoAndStop(2);
                              }
                        }
                        return;
                     default:
                        return;
                  }
               default:
                  return;
            }
         }
         §§goto(addr73);
      }
      
      private function onOverMission(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = param1.parent as MovieClip;
         if(!_loc2_.properties)
         {
            return;
         }
         if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && _loc2_.properties is MissionVO)
         {
            _loc2_.gotoAndStop(2);
            this.energyBar.fillEnergyBar(_loc2_.properties.time / 60);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(this.showMissionSelection)
         {
            return;
         }
         super.onMouseOut(param1);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         switch(param1.target)
         {
            case this.mission.mission0.hit:
            case this.mission.mission1.hit:
            case this.mission.mission2.hit:
               if(!this.showMissionSelection)
               {
                  this.onOutMission(param1.target as MovieClip);
                  this.energyBar.onOutEnergyBar();
               }
               break;
            case this.mission.bar.hit:
            case this.mission.energy_Bar:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               this.energyBar.showDefaultEnergyBar();
               this.mission.bar.gotoAndStop(1);
               break;
            case this.mission.work.hit:
               this.mission.work.gotoAndStop(1);
               break;
            case this.mission.sicilian.hit:
               this.mission.sicilian.gotoAndStop(1);
         }
      }
      
      private function onOutMission(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = param1.parent as MovieClip;
         if(!_loc2_.properties)
         {
            return;
         }
         _loc2_.gotoAndStop(1);
      }
      
      protected function get mission() : MafiaMission
      {
         return disp as MafiaMission;
      }
      
      public function set showMissionSelection(param1:Boolean) : void
      {
         this._showMissionSelection = param1;
      }
      
      public function get showMissionSelection() : Boolean
      {
         return this._showMissionSelection;
      }
      
      public function set showWorkSelection(param1:Boolean) : void
      {
         this._showWorkSelection = param1;
      }
   }
}
