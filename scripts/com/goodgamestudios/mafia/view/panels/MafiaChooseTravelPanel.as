package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.commands.travels.StartTravelFlightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.event.model.MafiaTravelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.MafiaPrioLoader;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.travels.MafiaTravelsData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaStartQuestDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaProgressQuestDialog;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaQuestlogPanelProperties;
   import com.goodgamestudios.mafia.view.screens.energy.MafiaEnergyBarComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityQuestAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityQuestAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import com.goodgamestudios.mafia.vo.travel.TravelVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MafiaChooseTravelPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaChooseTravelPanel";
      
      private static const SEPERATOR_OFFSET:int = 5;
       
      
      private var energyBar:MafiaEnergyBarComponent;
      
      public function MafiaChooseTravelPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_TRAVEL;
         controller.addEventListener(MafiaTravelEvent.CHANGE_TRAVELDATA,this.onTravelsData);
         this.panel.txt_target.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelEnd");
         this.panel.txt_level.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelNext");
         this.panel.txt_cost.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelCost");
         this.panel.txt_time.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelTime");
         this.energyBar = new MafiaEnergyBarComponent(this.panel.energy_Bar);
      }
      
      override public function show() : void
      {
         super.show();
         this.fillTravels(MafiaModel.userData.travelsData);
         this.energyBar.show();
         this.energyBar.showDefaultEnergyBar();
         controller.addEventListener(MafiaQuestEvent.PAUSE_ACTIVE_CITY_QUEST,this.onPauseCityQuest);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.energyBar.destroy();
      }
      
      override public function hide() : void
      {
         super.hide();
         this.energyBar.hide();
         controller.removeEventListener(MafiaQuestEvent.PAUSE_ACTIVE_CITY_QUEST,this.onPauseCityQuest);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaTravelEvent.CHANGE_TRAVELDATA,this.onTravelsData);
         controller.removeEventListener(MafiaQuestEvent.PAUSE_ACTIVE_CITY_QUEST,this.onPauseCityQuest);
         super.removeEvents();
      }
      
      private function onPauseCityQuest(param1:MafiaQuestEvent) : void
      {
         this.fillTravels(MafiaModel.userData.travelsData);
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.energyBar.showDefaultEnergyBar();
         this.fillTravels(MafiaModel.userData.travelsData);
      }
      
      private function onTravelsData(param1:MafiaTravelEvent) : void
      {
         this.fillTravels(MafiaModel.userData.travelsData);
      }
      
      private function fillTravels(param1:MafiaTravelsData) : void
      {
         var _loc5_:TraveChooseDescription = null;
         var _loc6_:MafiaChooseTravelSeperator = null;
         var _loc7_:TravelActiveCityDescription = null;
         MovieClipHelper.clearMovieClip(this.panel.holder);
         var _loc2_:int = 0;
         this.energyBar.visualizeDefault();
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < param1.travels.length)
         {
            _loc5_ = new TraveChooseDescription();
            if(param1.travels[_loc4_].isUnlocked)
            {
               _loc5_.btn_travel.visible = param1.travels[_loc4_].energyUsage > 0;
               _loc5_.btn_travel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelStart");
               _loc5_.btn_unlock.visible = false;
               if(MafiaModel.userData.status > 0)
               {
                  _loc5_.btn_travel.enableButton = false;
                  switch(MafiaModel.userData.status)
                  {
                     case Constants_Status.STATUS_ON_A_MISSION:
                     case Constants_Status.STATUS_MISSION_FINISHED:
                        _loc5_.btn_travel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_blockedQuest");
                        break;
                     case Constants_Status.STATUS_WORKING:
                     case Constants_Status.STATUS_WORK_FINISHED:
                        _loc5_.btn_travel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_blockedProtectionMoney");
                  }
               }
               else if(MafiaModel.userData.userMissionEnergy < param1.travels[_loc4_].energyUsage * 10)
               {
                  _loc5_.btn_travel.enableButton = false;
                  _loc5_.btn_travel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_blockedEnergy");
               }
               else
               {
                  _loc5_.btn_travel.enableButton = true;
                  _loc5_.btn_travel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travel");
               }
            }
            else
            {
               _loc5_.btn_travel.visible = false;
               _loc5_.btn_unlock.visible = true;
               if(_loc3_)
               {
                  _loc3_ = false;
                  _loc5_.btn_unlock.enableButton = true;
                  _loc5_.btn_unlock.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_noTravel");
               }
               else
               {
                  _loc5_.btn_unlock.enableButton = false;
                  _loc5_.btn_unlock.toolTipText = _loc5_.btn_unlock.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_cityLocked",[MafiaModel.languageData.getCityName(MafiaModel.userData.questData.cityToUnlock)]);
               }
            }
            if(param1.travels[_loc4_].targetId == MafiaModel.userData.profileData.city.index && !MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
            {
               _loc5_.bg.gotoAndStop(3);
               _loc5_.btn_travel.visible = false;
               _loc5_.btn_unlock.visible = false;
            }
            else
            {
               _loc5_.properties = param1.travels[_loc4_];
               if(param1.travels[_loc4_].targetId >= City.Sicily.index)
               {
                  _loc5_.bg.gotoAndStop(2);
               }
               else
               {
                  _loc5_.bg.gotoAndStop(1);
               }
            }
            _loc5_.txt_target.text = MafiaModel.languageData.getTextById("travel_target_" + param1.travels[_loc4_].targetId.toString());
            if(param1.travels[_loc4_].nextOpponentLevel > 0)
            {
               _loc5_.txt_level.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_12") + " " + param1.travels[_loc4_].nextOpponentLevel.toString();
            }
            else
            {
               _loc5_.txt_level.text = "-";
            }
            _loc5_.txt_cost.text = param1.travels[_loc4_].energyUsage > 0?param1.travels[_loc4_].energyUsage.toString():"-";
            _loc5_.txt_time.text = param1.travels[_loc4_].energyUsage > 0?String(TimeStringHelper.getShortTimeStringBySeconds(param1.travels[_loc4_].flightTimeInSeconds)):"-";
            this.panel.holder.addChild(_loc5_);
            _loc5_.y = _loc2_;
            _loc2_ = _loc2_ + _loc5_.height;
            if(MafiaModel.userData.questData.hasActiveQuests)
            {
               if(MafiaModel.userData.questData.activeCityQuest)
               {
                  if(param1.travels[_loc4_].targetId == MafiaModel.userData.questData.activeCityQuest.city.index)
                  {
                     _loc7_ = new TravelActiveCityDescription();
                     _loc7_.btn_state.gotoAndStop(2);
                     _loc7_.btn_state.questVO = MafiaModel.userData.questData.activeCityQuest;
                     _loc7_.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_travelQuest",[MafiaModel.userData.questData.activeCityQuest.districtNumber + 1]);
                     _loc7_.btn_state.district_id = MafiaModel.userData.questData.activeCityQuest.districtNumber;
                     _loc7_.btn_state.toolTipVO = new TooltipVO(MafiaCityQuestAdvancedTooltip.NAME,new MafiaCityQuestAdvancedTooltipProperties(MafiaModel.userData.questData.activeCityQuest,MafiaModel.userData.questData.activeCityQuest.districtNumber),null,"",BasicCustomCursor.CURSOR_CLICK);
                     this.panel.holder.addChild(_loc7_);
                     _loc7_.y = _loc2_;
                     _loc2_ = _loc2_ + _loc7_.height;
                  }
               }
            }
            _loc6_ = new MafiaChooseTravelSeperator();
            this.panel.holder.addChild(_loc6_);
            _loc2_ = _loc2_ + SEPERATOR_OFFSET;
            _loc6_.y = _loc2_;
            _loc2_ = _loc2_ + _loc6_.height;
            _loc4_++;
         }
         updateAllTextFields();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Btn_TravelToCity = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:QuestVO = null;
         var _loc6_:int = 0;
         if(param1.target is Btn_TravelToCity)
         {
            _loc2_ = param1.target as Btn_TravelToCity;
            if(!_loc2_.enabled)
            {
               return;
            }
            _loc2_.enableButton = false;
            _loc3_ = _loc2_.parent as MovieClip;
            if(_loc3_.properties != null)
            {
               _loc4_ = _loc3_.properties.targetId;
               StartTravelFlightCommand.sendCommand(_loc4_);
               if(_loc4_ < City.Sicily.index)
               {
                  MafiaPrioLoader.instance.startBackgroundLoading(_loc4_);
               }
            }
         }
         if(param1.target is Btn_activ_city_quest)
         {
            _loc5_ = param1.target.parent.questVO;
            _loc6_ = param1.target.parent.district_id;
            layoutManager.showDialog(MafiaProgressQuestDialog.NAME,new MafiaStartQuestDialogProperties(_loc5_,_loc6_));
         }
         if(param1.target is Btn_UnlockTravel && (param1.target as Btn_UnlockTravel).enabled)
         {
            layoutManager.showPanel(MafiaQuestlogPanel.NAME,new MafiaQuestlogPanelProperties(MafiaModel.userData.questData.cityToUnlockQuestId));
         }
         if(param1.target == this.panel.btn_close)
         {
            this.hide();
         }
         super.onClick(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         if(param1.target is TraveChooseDescriptionBG || param1.target is Btn_TravelToCity)
         {
            this.onOverTravel((param1.target as MovieClip).parent as TraveChooseDescription);
         }
         if(param1.target is Btn_activ_city_quest)
         {
            layoutManager.tooltipManager.showAdvancedTooltip(param1.target.parent.toolTipVO,param1.target.parent as DisplayObject);
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         if(param1.target is TraveChooseDescriptionBG || param1.target is Btn_TravelToCity)
         {
            this.energyBar.showDefaultEnergyBar();
         }
         if(param1.target is Btn_activ_city_quest)
         {
            layoutManager.tooltipManager.hideAdvancedTooltip();
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function onOverTravel(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = param1 as MovieClip;
         if(!_loc2_.properties)
         {
            return;
         }
         if(MafiaModel.userData.status == Constants_Status.STATUS_FREE && _loc2_.properties is TravelVO)
         {
            if(_loc2_.properties.isUnlocked)
            {
               this.energyBar.fillEnergyBar(_loc2_.properties.energyUsage);
            }
         }
      }
      
      protected function get panel() : MafiaChooseTravel
      {
         return disp as MafiaChooseTravel;
      }
   }
}
