package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.commands.travels.QuitTravelFlightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaTravelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.energy.MafiaEnergyBarComponent;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class MafiaTravelProgressPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaTravelProgressPanel";
       
      
      private var progressLine:MovieClip;
      
      private var start:emptyMC;
      
      private var end:emptyMC;
      
      private var energyBar:MafiaEnergyBarComponent;
      
      private const TRAVELDISTANCES:Array = [TravelDistance_0_3,TravelDistance_1_3,TravelDistance_2_3,TravelDistance_3_1,TravelDistance_3_2,TravelDistance_0_1,TravelDistance_0_2,TravelDistance_1_2,TravelDistance_2_1,TravelDistance_2_0,TravelDistance_1_0,TravelDistance_3_0];
      
      public function MafiaTravelProgressPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_TRAVELPROGRESS;
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         this.energyBar = new MafiaEnergyBarComponent(this.panel.energy_Bar);
      }
      
      override public function show() : void
      {
         super.show();
         this.panel.btn_skip.goldInfoVisible = false;
         this.panel.btn_skip.label = MafiaModel.languageData.getTextById("MafiaGangwarfare_btn_fastTravel");
         this.panel.btn_skip.enableButton = true;
         this.tweenMap();
         this.fillStartAndEnd();
         controller.addEventListener(MafiaTravelEvent.CHANGE_FLIGHTTIMER,this.onTimeUpdate);
         this.energyBar.show();
         this.energyBar.showDefaultEnergyBar();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.energyBar.destroy();
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.energyBar.hide();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaTravelEvent.CHANGE_FLIGHTTIMER,this.onTimeUpdate);
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.showByStatus();
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.energyBar.showDefaultEnergyBar();
      }
      
      private function showByStatus() : void
      {
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_FREE:
               this.hide();
               break;
            case Constants_Status.STATUS_FLYING:
               this.fillStartAndEnd();
               break;
            case Constants_Status.STATUS_FLIGHT_FINISHED:
               this.fillStartAndEnd();
               ShowGangWarsCommand.sendCommand();
         }
      }
      
      private function onTimeUpdate(param1:MafiaTravelEvent) : void
      {
         if(!this.progressLine)
         {
            this.fillStartAndEnd();
         }
         if(param1.params[1] > 0)
         {
            this.panel.timer.txt_time.text = param1.params[0];
            this.panel.timer.time_bar.scaleX = param1.params[1] * 0.01;
            this.progressLine.gotoAndStop(Math.floor(param1.params[1]));
         }
         else
         {
            this.panel.timer.txt_time.text = "0";
            this.panel.timer.time_bar.scaleX = 0;
            this.progressLine.gotoAndStop(0);
         }
         if(param1.params[0] == "00:00")
         {
            this.panel.timer.time_bar.scaleX = 1;
            this.progressLine.gotoAndStop(100);
         }
      }
      
      private function tweenMap() : void
      {
         this.panel.mapBlender.y = 140.6;
         new GTween(this.panel.mapBlender,2,{"y":-205});
      }
      
      private function fillStartAndEnd() : void
      {
         var _loc3_:Class = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TravelTarget = null;
         this.energyBar.visualizeDefault();
         var _loc1_:City = MafiaModel.userData.profileData.city;
         if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            _loc1_ = City.Sicily;
         }
         switch(_loc1_)
         {
            case City.Miami:
            case City.NewYork:
               if(MafiaModel.userData.progressData.actionID == City.Miami.index || MafiaModel.userData.progressData.actionID == City.NewYork.index)
               {
                  this.panel.worldmap.scaleX = this.panel.worldmap.scaleY = 2;
                  this.panel.worldmap.x = 115;
                  this.panel.worldmap.y = 74;
               }
               else
               {
                  this.panel.worldmap.scaleX = this.panel.worldmap.scaleY = 1;
                  this.panel.worldmap.x = 73;
                  this.panel.worldmap.y = 156;
               }
               break;
            case City.Sicily:
               this.panel.worldmap.scaleX = this.panel.worldmap.scaleY = 1.3;
               this.panel.worldmap.x = 45;
               this.panel.worldmap.y = 74;
         }
         if(this.start)
         {
            MovieClipHelper.clearMovieClip(this.start);
         }
         if(this.end)
         {
            MovieClipHelper.clearMovieClip(this.end);
         }
         if(this.progressLine)
         {
            this.panel.worldmap.removeChild(this.progressLine);
            this.progressLine = null;
         }
         if(MafiaModel.userData.status == Constants_Status.STATUS_FLYING)
         {
            _loc4_ = _loc1_.index;
            _loc5_ = MafiaModel.userData.progressData.actionID;
            if(MafiaModel.specialEvent.sicilianEvent.isFlyingFromSicilia)
            {
               _loc4_ = City.Sicily.index;
            }
            if(MafiaModel.specialEvent.sicilianEvent.isFlyingToSicilia)
            {
               _loc4_ = MafiaModel.userData.profileData.city.index;
               _loc5_ = City.Sicily.index;
            }
            this.start = this.panel.worldmap.getChildByName("target_" + _loc4_) as emptyMC;
            _loc3_ = getDefinitionByName("TravelDistance_" + _loc4_ + "_" + _loc5_) as Class;
            this.panel.txt_from.text = MafiaModel.languageData.getTextById("travel_target_" + _loc4_);
            this.progressLine = new _loc3_();
            this.progressLine.x = this.start.x;
            this.progressLine.y = this.start.y;
            this.panel.worldmap.addChild(this.progressLine);
            _loc6_ = new TravelTarget();
            this.start.addChild(_loc6_);
            this.panel.btn_skip.label = MafiaModel.languageData.getTextById("MafiaGangWarfare_btn_fastTravel");
            this.panel.btn_skip.goldInfoVisible = true;
            this.panel.btn_skip.goldInfoTimeText = MafiaModel.goldConstants.cutFlightPricePerSecond.toString();
            updateAllTextFields();
            this.panel.btn_skip.update();
            this.panel.timer.visible = true;
         }
         else
         {
            this.panel.btn_skip.enableButton = true;
            this.panel.btn_skip.goldInfoVisible = false;
            this.panel.timer.visible = false;
            this.panel.btn_skip.label = MafiaModel.languageData.getTextById("generic_btn_close");
         }
         this.panel.txt_to.text = MafiaModel.languageData.getTextById("travel_target_" + MafiaModel.userData.progressData.actionID);
         this.end = this.panel.worldmap.getChildByName("target_" + MafiaModel.userData.progressData.actionID) as emptyMC;
         var _loc2_:TravelTarget = new TravelTarget();
         this.end.addChild(_loc2_);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.panel.btn_skip:
               switch(MafiaModel.userData.status)
               {
                  case Constants_Status.STATUS_FLIGHT_FINISHED:
                     MafiaModel.userData.status = Constants_Status.STATUS_FREE;
                     QuitTravelFlightCommand.sendCommand(false);
                     if(layoutManager.currentState != Constants_LayoutStates.STATE_GANGWARS)
                     {
                        layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
                     }
                     break;
                  case Constants_Status.STATUS_FLYING:
                     if(MafiaModel.userData.gold < MafiaModel.goldConstants.cutFlightPricePerSecond)
                     {
                        return;
                     }
                     if(!this.panel.btn_skip.enabled)
                     {
                        return;
                     }
                     MafiaModel.userData.status = Constants_Status.STATUS_FREE;
                     MafiaModel.userData.progressData.duration = 0;
                     MafiaModel.userData.status = Constants_Status.STATUS_FREE;
                     QuitTravelFlightCommand.sendCommand(true);
                     this.panel.btn_skip.enableButton = false;
                     if(layoutManager.currentState != Constants_LayoutStates.STATE_GANGWARS)
                     {
                        layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
                     }
                     break;
               }
         }
      }
      
      protected function get panel() : MafiaTravel
      {
         return disp as MafiaTravel;
      }
   }
}
