package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.shop.ViewItemsCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.SpecialWantedCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.RegisterForTournamentCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ShowTournamentInfoCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.MafiaTutorialData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaBreakingTheLawEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCapoVitoEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaLuckyDevilEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaNightOfHorrorEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaSicilianEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaSpecialEvent;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaTournamentEvent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBreakingTheLawDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCalendarEventDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCapoVitoDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaEddyFrostEventDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNightOfHorrorDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianDungeonDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianMissionDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSicilianThankYouDialog;
   import com.goodgamestudios.mafia.view.dialogs.luckyDevil.MafiaLuckyDevilDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaTournamentRegisterDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.tournament.MafiaTournamentRegisterDialog;
   
   public class MafiaSpecialEventData
   {
       
      
      private var eventList:Vector.<MafiaSpecialEvent>;
      
      public function MafiaSpecialEventData()
      {
         super();
         this.eventList = new Vector.<MafiaSpecialEvent>();
      }
      
      public function parseSAE(param1:Array) : void
      {
         var _loc2_:int = param1.shift();
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:MafiaSpecialEvent = null;
         switch(_loc2_)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               _loc3_ = this.sicilianEvent;
               break;
            case Constants_SpecialEvents.ID_CAPO_VITO:
               _loc3_ = this.capoVitoEvent;
               break;
            case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
               _loc3_ = this.nightOfHorrorEvent;
               break;
            case Constants_SpecialEvents.ID_CALENDAR:
               _loc3_ = this.calendarEvent;
               break;
            case Constants_SpecialEvents.ID_TOURNAMENT:
               _loc3_ = this.tournamentEvent;
               break;
            case Constants_SpecialEvents.ID_BREAKING_THE_LAW:
               _loc3_ = this.breakingTheLawEvent;
               break;
            case Constants_SpecialEvents.ID_LUCKY_DEVIL:
               _loc3_ = this.luckyDevilEvent;
               break;
            case Constants_SpecialEvents.ID_EDDY_FROST:
               _loc3_ = this.eddyFrostEvent;
               break;
            default:
               trace("parseSAE - unknown event id: " + _loc2_);
         }
         _loc3_.parseEvent(param1);
         this.initializeSpecialEvent(_loc3_);
      }
      
      public function initializeSpecialEvent(param1:MafiaSpecialEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:BasicProperties = null;
         if(!param1.wasTeaserReceived && !MafiaTutorialController.getInstance().isActive && MafiaTutorialData.getInstance().tutorialShown)
         {
            param1.teaserReceived = true;
            _loc2_ = "";
            _loc3_ = null;
            switch(param1.eventId)
            {
               case Constants_SpecialEvents.ID_SICILIAN:
                  _loc2_ = MafiaSicilianMissionDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_CAPO_VITO:
                  _loc2_ = MafiaCapoVitoDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_CALENDAR:
                  _loc2_ = MafiaCalendarEventDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_BREAKING_THE_LAW:
                  _loc2_ = MafiaBreakingTheLawDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
                  _loc2_ = MafiaNightOfHorrorDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_TOURNAMENT:
                  if(BasicLayoutManager.getInstance().currentState != Constants_LayoutStates.STATE_TOURNAMENT)
                  {
                     MafiaModel.specialEvent.tournamentEvent.playerRequestedTournamentInfo = true;
                     ShowTournamentInfoCommand.sendCommand();
                  }
                  _loc2_ = MafiaTournamentRegisterDialog.NAME;
                  _loc3_ = new MafiaTournamentRegisterDialogProperties(this.registerForTournament);
                  break;
               case Constants_SpecialEvents.ID_LUCKY_DEVIL:
                  _loc2_ = MafiaLuckyDevilDialog.NAME;
                  break;
               case Constants_SpecialEvents.ID_EDDY_FROST:
                  _loc2_ = MafiaEddyFrostEventDialog.NAME;
                  break;
               default:
                  trace("MafiaSpecialEventData.initializeSpecialEvent: event " + param1.eventId + " unknown");
            }
            MafiaDialogHandler.getInstance().registerDialogs(_loc2_,_loc3_,true,BasicDialogHandler.PRIORITY_TOP);
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SPECIAL_EVENT_STARTED,[param1.eventId]));
         }
         switch(param1.eventId)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,[param1 as MafiaSicilianEvent]));
               break;
            case Constants_SpecialEvents.ID_CAPO_VITO:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CAPOVITO_EVENT_DATA_UPDATED,[param1 as MafiaCapoVitoEvent]));
               break;
            case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.NIGHTOFHORROR_DATA_UPDATED,[param1 as MafiaNightOfHorrorEvent]));
               break;
            case Constants_SpecialEvents.ID_CALENDAR:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,[param1 as MafiaCalendarEvent]));
               break;
            case Constants_SpecialEvents.ID_EDDY_FROST:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.EDDYFROST_EVENT_DATA_UPDATED,[param1 as MafiaEddyFrostEvent]));
               break;
            case Constants_SpecialEvents.ID_TOURNAMENT:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,[param1 as MafiaTournamentEvent]));
               break;
            case Constants_SpecialEvents.ID_BREAKING_THE_LAW:
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.BREAK_THE_LAW_DATA_UPDATED,[param1 as MafiaBreakingTheLawEvent]));
         }
      }
      
      public function initializeSpecialEvents() : void
      {
         var _loc1_:MafiaSpecialEvent = null;
         for each(_loc1_ in this.eventList)
         {
            if(_loc1_.isEventActive)
            {
               this.initializeSpecialEvent(_loc1_);
            }
         }
      }
      
      public function openEventDialog() : void
      {
         var _loc2_:MafiaSpecialEvent = null;
         var _loc1_:MafiaSpecialEvent = null;
         for each(_loc2_ in this.eventList)
         {
            if(_loc2_.isEventActive)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         if(!_loc1_)
         {
            return;
         }
         switch(_loc1_.eventId)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               if(this.sicilianEvent.finishedSicilianSuccess)
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaSicilianThankYouDialog.NAME,null,true,BasicDialogHandler.PRIORITY_MIDDLE);
               }
               else if(!this.sicilianEvent.isMissionPhaseFinished)
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaSicilianMissionDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               }
               else
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaSicilianDungeonDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               }
               break;
            case Constants_SpecialEvents.ID_CAPO_VITO:
               SpecialWantedCommand.sendCommand();
               MafiaDialogHandler.getInstance().registerDialogs(MafiaCapoVitoDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               break;
            case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
               SpecialWantedCommand.sendCommand();
               MafiaDialogHandler.getInstance().registerDialogs(MafiaNightOfHorrorDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               break;
            case Constants_SpecialEvents.ID_CALENDAR:
               MafiaDialogHandler.getInstance().registerDialogs(MafiaCalendarEventDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               break;
            case Constants_SpecialEvents.ID_EDDY_FROST:
               MafiaDialogHandler.getInstance().registerDialogs(MafiaEddyFrostEventDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               break;
            case Constants_SpecialEvents.ID_TOURNAMENT:
               if(MafiaModel.specialEvent.tournamentEvent.isTournamentApplicationOpen && !MafiaModel.specialEvent.tournamentEvent.hasPlayerEntered)
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaTournamentRegisterDialog.NAME,new MafiaTournamentRegisterDialogProperties(this.registerForTournament),true,BasicDialogHandler.PRIORITY_TOP);
               }
               else if(BasicLayoutManager.getInstance().currentState != Constants_LayoutStates.STATE_TOURNAMENT)
               {
                  MafiaModel.specialEvent.tournamentEvent.playerRequestedTournamentInfo = true;
                  ShowTournamentInfoCommand.sendCommand();
               }
               break;
            case Constants_SpecialEvents.ID_BREAKING_THE_LAW:
               ViewItemsCommand.sendCommand(ItemLocation.ShopBreakingTheLaw);
               MafiaDialogHandler.getInstance().registerDialogs(MafiaBreakingTheLawDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
               break;
            case Constants_SpecialEvents.ID_LUCKY_DEVIL:
               MafiaDialogHandler.getInstance().registerDialogs(MafiaLuckyDevilDialog.NAME,null,true,BasicDialogHandler.PRIORITY_TOP);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:MafiaSpecialEvent = null;
         for each(_loc2_ in this.eventList)
         {
            if(_loc2_.isEventActive)
            {
               _loc2_.update(param1);
            }
         }
      }
      
      public function get sicilianEvent() : MafiaSicilianEvent
      {
         return this.getEvent(MafiaSicilianEvent) as MafiaSicilianEvent;
      }
      
      public function get capoVitoEvent() : MafiaCapoVitoEvent
      {
         return this.getEvent(MafiaCapoVitoEvent) as MafiaCapoVitoEvent;
      }
      
      public function get nightOfHorrorEvent() : MafiaNightOfHorrorEvent
      {
         return this.getEvent(MafiaNightOfHorrorEvent) as MafiaNightOfHorrorEvent;
      }
      
      public function get calendarEvent() : MafiaCalendarEvent
      {
         return this.getEvent(MafiaCalendarEvent) as MafiaCalendarEvent;
      }
      
      public function get tournamentEvent() : MafiaTournamentEvent
      {
         return this.getEvent(MafiaTournamentEvent) as MafiaTournamentEvent;
      }
      
      public function get breakingTheLawEvent() : MafiaBreakingTheLawEvent
      {
         return this.getEvent(MafiaBreakingTheLawEvent) as MafiaBreakingTheLawEvent;
      }
      
      public function get luckyDevilEvent() : MafiaLuckyDevilEvent
      {
         return this.getEvent(MafiaLuckyDevilEvent) as MafiaLuckyDevilEvent;
      }
      
      public function get eddyFrostEvent() : MafiaEddyFrostEvent
      {
         return this.getEvent(MafiaEddyFrostEvent) as MafiaEddyFrostEvent;
      }
      
      private function getEvent(param1:Class) : *
      {
         var _loc2_:MafiaSpecialEvent = null;
         var _loc3_:MafiaSpecialEvent = null;
         for each(_loc2_ in this.eventList)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
         }
         _loc3_ = new param1();
         this.eventList.push(_loc3_);
         return _loc3_;
      }
      
      private function registerForTournament() : void
      {
         RegisterForTournamentCommand.sendCommand();
      }
   }
}
