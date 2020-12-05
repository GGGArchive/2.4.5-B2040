package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ShowTournamentFinalsCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.tournament.MafiaInfoTournamentComp;
   import com.goodgamestudios.mafia.view.screens.tournament.MafiaNextFightTournamentComp;
   import com.goodgamestudios.mafia.view.screens.tournament.MafiaParticipantsTournamentComp;
   import com.goodgamestudios.mafia.view.screens.tournament.MafiaRoundOfSixteenTournamentComp;
   import com.goodgamestudios.mafia.view.screens.tournament.MafiaStatusTournamentComp;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaTournamentScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaTournamentScreen";
      
      public static const NEXT_FIGHT:String = "next_fight";
      
      public static const PARTICIPANTS:String = "participants";
      
      public static const ROUNDOFSIXTEEN:String = "roundofsixteen";
      
      public static const TOURNAMENT_INFO:String = "tournament_info";
       
      
      private var tabs:Vector.<MovieClip>;
      
      protected var tab_participants:MafiaParticipantsTournamentComp;
      
      protected var tab_nextfight:MafiaNextFightTournamentComp;
      
      protected var tab_roundofsixteen:MafiaRoundOfSixteenTournamentComp;
      
      protected var tab_info:MafiaInfoTournamentComp;
      
      protected var status_info:MafiaStatusTournamentComp;
      
      private var tournamentState:String = "next_fight";
      
      private const SELECTSHOPBUTTONPOSITION:int = 81;
      
      private const UNSELECTSHOPBUTTONPOSITION:int = 89;
      
      public function MafiaTournamentScreen(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
         this.tab_nextfight = new MafiaNextFightTournamentComp(this.tournamentScreen.mc_nextfight);
         this.tab_participants = new MafiaParticipantsTournamentComp(this.tournamentScreen.mc_participants);
         this.tab_roundofsixteen = new MafiaRoundOfSixteenTournamentComp(this.tournamentScreen.mc_roundofsixteen);
         this.tab_info = new MafiaInfoTournamentComp(this.tournamentScreen.mc_info_tab);
         this.status_info = new MafiaStatusTournamentComp(this.tournamentScreen.mc_tournamentInfo);
         this.tabs = new Vector.<MovieClip>();
         this.tabs.push(this.tournamentScreen.mc_nextfight);
         this.tabs.push(this.tournamentScreen.mc_participants);
         this.tabs.push(this.tournamentScreen.mc_roundofsixteen);
         this.tabs.push(this.tournamentScreen.mc_info_tab);
         this.updateTabButtons();
      }
      
      private function updateTabButtons() : void
      {
         this.tournamentScreen.btn_nextfight.enableButton = this.isTabNextFightEnabled;
         this.tournamentScreen.btn_patricipants.enableButton = this.isTabParticipantsEnabled;
         this.tournamentScreen.btn_roundofsixteen.enableButton = this.isTabRoundOfSixteenEnabled;
         this.switchTournamentState(this.tournamentState);
      }
      
      private function get isTabNextFightEnabled() : Boolean
      {
         return MafiaModel.specialEvent.tournamentEvent.isPlayerInTournament && !MafiaModel.specialEvent.tournamentEvent.isTournamentOver;
      }
      
      private function get isTabParticipantsEnabled() : Boolean
      {
         return !MafiaModel.specialEvent.tournamentEvent.isTournamentApplicationOpen;
      }
      
      private function get isTabRoundOfSixteenEnabled() : Boolean
      {
         return !MafiaModel.specialEvent.tournamentEvent.isTournamentApplicationOpen;
      }
      
      override public function show() : void
      {
         super.show();
         this.tournamentScreen.btn_nextfight.toolTipText = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_31");
         this.tournamentScreen.btn_patricipants.toolTipText = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_32");
         this.tournamentScreen.btn_roundofsixteen.toolTipText = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_33");
         this.tournamentScreen.btn_tournamentinfo.toolTipText = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_34");
         this.tab_nextfight.show();
         this.status_info.show();
         this.updateTabButtons();
         basicController.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
         basicController.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_TIME_ROUND_ENDED,this.onRoundEnded);
         basicController.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_VIEW_FIGHT,this.onViewFight);
      }
      
      protected function onViewFight(param1:Event) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_TOURNAMENT_FIGHT;
         this.hide();
      }
      
      override public function hide() : void
      {
         super.hide();
         this.tournamentScreen.mc_nextfight.visible = false;
         this.tournamentScreen.mc_participants.visible = false;
         this.tournamentScreen.mc_roundofsixteen.visible = false;
         this.tournamentScreen.mc_info_tab.visible = false;
         this.status_info.hide();
         this.tab_nextfight.hide();
         this.tab_participants.hide();
         this.tab_info.hide();
         this.tab_roundofsixteen.hide();
         basicController.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
         basicController.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_TIME_ROUND_ENDED,this.onRoundEnded);
         basicController.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_VIEW_FIGHT,this.onViewFight);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         switch(param1.target)
         {
            case this.tournamentScreen.btn_nextfight:
               if(param1.target.enabled)
               {
                  this.switchTournamentState(NEXT_FIGHT);
                  super.onClick(param1);
               }
               break;
            case this.tournamentScreen.btn_patricipants:
               if(param1.target.enabled)
               {
                  this.switchTournamentState(PARTICIPANTS);
                  super.onClick(param1);
               }
               break;
            case this.tournamentScreen.btn_roundofsixteen:
               if(param1.target.enabled)
               {
                  this.switchTournamentState(ROUNDOFSIXTEEN);
                  super.onClick(param1);
               }
               break;
            case this.tournamentScreen.btn_tournamentinfo:
               this.switchTournamentState(TOURNAMENT_INFO);
               super.onClick(param1);
         }
      }
      
      protected function onDataUpdated(param1:Event) : void
      {
         this.updateTabButtons();
      }
      
      protected function onRoundEnded(param1:Event) : void
      {
      }
      
      public function switchTournamentState(param1:String) : void
      {
         this.tournamentScreen.layer_nextfight.gotoAndStop(2);
         this.tournamentScreen.btn_nextfight.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.tournamentScreen.layer_participant.gotoAndStop(2);
         this.tournamentScreen.btn_patricipants.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.tournamentScreen.layer_roundofsixteen.gotoAndStop(2);
         this.tournamentScreen.btn_roundofsixteen.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.tournamentScreen.layer_info.gotoAndStop(2);
         this.tournamentScreen.btn_tournamentinfo.y = this.UNSELECTSHOPBUTTONPOSITION;
         var _loc2_:Boolean = false;
         while(!_loc2_)
         {
            switch(param1)
            {
               case NEXT_FIGHT:
                  if(this.isTabNextFightEnabled)
                  {
                     _loc2_ = true;
                  }
                  else
                  {
                     param1 = PARTICIPANTS;
                  }
                  continue;
               case PARTICIPANTS:
                  if(this.isTabParticipantsEnabled)
                  {
                     _loc2_ = true;
                  }
                  else
                  {
                     param1 = ROUNDOFSIXTEEN;
                  }
                  continue;
               case ROUNDOFSIXTEEN:
                  if(this.isTabRoundOfSixteenEnabled)
                  {
                     _loc2_ = true;
                  }
                  else
                  {
                     param1 = TOURNAMENT_INFO;
                  }
                  continue;
               case TOURNAMENT_INFO:
                  _loc2_ = true;
                  continue;
               default:
                  continue;
            }
         }
         switch(param1)
         {
            case NEXT_FIGHT:
               this.showTournamentTabAndHideAllOthers(this.tournamentScreen.mc_nextfight);
               this.tournamentScreen.layer_nextfight.gotoAndStop(1);
               this.tournamentScreen.btn_nextfight.y = this.SELECTSHOPBUTTONPOSITION;
               break;
            case PARTICIPANTS:
               this.tab_participants.show();
               this.showTournamentTabAndHideAllOthers(this.tournamentScreen.mc_participants);
               this.tab_participants.getListFromServer(-1);
               this.tournamentScreen.layer_participant.gotoAndStop(1);
               this.tournamentScreen.btn_patricipants.y = this.SELECTSHOPBUTTONPOSITION;
               break;
            case ROUNDOFSIXTEEN:
               this.showTournamentTabAndHideAllOthers(this.tournamentScreen.mc_roundofsixteen);
               this.tab_roundofsixteen.show();
               ShowTournamentFinalsCommand.sendCommand();
               this.tournamentScreen.layer_roundofsixteen.gotoAndStop(1);
               this.tournamentScreen.btn_roundofsixteen.y = this.SELECTSHOPBUTTONPOSITION;
               break;
            case TOURNAMENT_INFO:
               this.tab_info.show();
               this.showTournamentTabAndHideAllOthers(this.tournamentScreen.mc_info_tab);
               this.tournamentScreen.layer_info.gotoAndStop(1);
               this.tournamentScreen.btn_tournamentinfo.y = this.SELECTSHOPBUTTONPOSITION;
         }
         this.tournamentState = param1;
      }
      
      private function showTournamentTabAndHideAllOthers(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         for each(_loc2_ in this.tabs)
         {
            if(_loc2_ == param1)
            {
               _loc2_.visible = true;
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      public function get tournamentScreen() : MafiaTournament
      {
         return disp as MafiaTournament;
      }
   }
}
