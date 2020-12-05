package com.goodgamestudios.mafia.view.screens.tournament
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.HealTournamentPlayerCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaTournamentEvent;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaStatusTournamentComp
   {
       
      
      private var disp:MovieClip;
      
      public function MafiaStatusTournamentComp(param1:MovieClip)
      {
         super();
         this.disp = param1;
      }
      
      public function show() : void
      {
         this.updateStatus(MafiaModel.specialEvent.tournamentEvent);
         BasicController.getInstance().addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_TIME_UPDATE,this.onTimeUpdate);
         BasicController.getInstance().addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
         this.disp.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function hide() : void
      {
         BasicController.getInstance().removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_TIME_UPDATE,this.onTimeUpdate);
         BasicController.getInstance().removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
         this.disp.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onDataUpdated(param1:Event) : void
      {
         this.updateStatus(MafiaModel.specialEvent.tournamentEvent);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this.disp.mc_info_player)
         {
            switch(param1.target)
            {
               case this.disp.mc_info_player.btn_heal:
                  if(this.disp.mc_info_player.btn_heal.enabled)
                  {
                     HealTournamentPlayerCommand.sendCommand();
                  }
            }
         }
         else if(this.disp.mc_winner)
         {
            switch(param1.target)
            {
               case this.disp.mc_winner.btn_gotoPlayer:
                  if(this.disp.mc_winner.btn_gotoPlayer.enabled)
                  {
                     if(MafiaModel.specialEvent.tournamentEvent.winner.ID != MafiaModel.userData.playerID)
                     {
                        MafiaModel.otherUserData = new MafiaOtherUserData();
                        MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_OTHERPROFILE;
                     }
                     else
                     {
                        MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_PROFILE;
                     }
                     PlayerProfileCommand.sendCommand(MafiaModel.specialEvent.tournamentEvent.winner.ID,false);
                  }
            }
         }
      }
      
      protected function onTimeUpdate(param1:Event) : void
      {
         this.updateTimeUntilNextRound();
      }
      
      public function updateStatus(param1:MafiaTournamentEvent) : void
      {
         if(param1 && param1.isEventActive)
         {
            if(param1.isTournamentApplicationOpen || param1.isTournamentRunning)
            {
               this.fillRoundInfo(param1);
               if(param1.isPlayerInTournament)
               {
                  this.fillPlayerHealth(param1);
               }
               else if(param1.isPlayerEliminated)
               {
                  this.fillPlayerEliminated();
               }
               else if(!param1.hasPlayerEntered && param1.isTournamentRunning)
               {
                  this.fillPlayerDidntEnter();
               }
            }
            else
            {
               this.fillTournamentWinner(param1);
            }
         }
         else
         {
            trace("no tournament running!");
         }
      }
      
      private function fillRoundInfo(param1:MafiaTournamentEvent) : void
      {
         this.disp.gotoAndStop(1);
         if(param1.isPlayerInTournament)
         {
            this.disp.mc_info_round.txt_round_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_7");
         }
         else
         {
            this.disp.mc_info_round.txt_round_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_70");
         }
         this.disp.mc_info_round.txt_round_value.text = param1.getCurrentRoundname();
         this.disp.mc_info_round.txt_participants_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_8");
         this.updateTimeUntilNextRound();
         if(param1.isTournamentApplicationOpen)
         {
            this.disp.mc_info_round.txt_time_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_26");
            this.disp.mc_info_round.txt_participants_value.text = param1.numRegisteredPlayers;
         }
         else
         {
            if(param1.isPlayerInTournament)
            {
               this.disp.mc_info_round.txt_time_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_9");
            }
            else
            {
               this.disp.mc_info_round.txt_time_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_69");
            }
            this.disp.mc_info_round.txt_participants_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_27",[param1.numRemainingPlayers,param1.numRegisteredPlayers]);
         }
      }
      
      private function updateTimeUntilNextRound() : void
      {
         if(this.disp.mc_info_round)
         {
            this.disp.mc_info_round.txt_time_value.text = TimeStringHelper.getTimeToString(MafiaModel.specialEvent.tournamentEvent.secondsUntilNextFight,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById,false,true);
         }
      }
      
      private function fillPlayerHealth(param1:MafiaTournamentEvent) : void
      {
         this.disp.gotoAndStop(1);
         this.disp.mc_info_player.gotoAndStop(1);
         this.disp.mc_info_player.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_10");
         this.disp.mc_info_player.txt_health_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_healthPercentage",[param1.currentHealth]);
         this.disp.mc_info_player.mc_healthBar.bar.scaleX = param1.currentHealth * 0.01;
         var _loc2_:Point = this.disp.mc_info_player.btn_info.localToGlobal(new Point(this.disp.mc_info_player.btn_info.x,this.disp.mc_info_player.btn_info.y));
         _loc2_.x = (_loc2_.x - MafiaLayoutManager.getInstance().gameNullPoint) / MafiaLayoutManager.getInstance().scaleFactor;
         _loc2_.y = _loc2_.y / MafiaLayoutManager.getInstance().scaleFactor;
         this.disp.mc_info_player.btn_info.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("event_lastmanstanding_copy_12")),_loc2_);
         this.disp.mc_info_player.txt_heal_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_11");
         this.disp.mc_info_player.btn_heal.label = MafiaModel.languageData.getTextById("event_lastmanstanding_btn_heal");
         if(param1.currentHealth < 100)
         {
            this.disp.mc_info_player.txt_heal_cost.text = param1.cashCostToHeal;
            this.disp.mc_info_player.btn_heal.enableButton = true;
         }
         else
         {
            this.disp.mc_info_player.txt_heal_cost.text = "-";
            this.disp.mc_info_player.btn_heal.enableButton = false;
         }
         this.updateAllTextFields();
         this.disp.mc_info_player.btn_heal.update();
      }
      
      private function fillPlayerEliminated() : void
      {
         this.disp.gotoAndStop(1);
         this.disp.mc_info_player.gotoAndStop(2);
         this.disp.mc_info_player.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_50");
         this.disp.mc_info_player.txt_copy.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_51");
         this.updateAllTextFields();
      }
      
      private function fillPlayerDidntEnter() : void
      {
         this.disp.gotoAndStop(1);
         this.disp.mc_info_player.gotoAndStop(2);
         this.disp.mc_info_player.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_48");
         this.disp.mc_info_player.txt_copy.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_49");
      }
      
      private function fillTournamentWinner(param1:MafiaTournamentEvent) : void
      {
         this.disp.gotoAndStop(2);
         this.disp.mc_winner.mc_winner.txt_winner.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_52");
         this.disp.mc_winner.btn_gotoPlayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
         if(param1 && param1.winner)
         {
            this.disp.mc_winner.white_flag.visible = false;
            this.disp.mc_winner.txt_winner_name.text = param1.winner.name;
            this.disp.mc_winner.txt_clan_name.text = param1.winner.clanName;
            this.disp.mc_winner.icon_class.visible = true;
            this.disp.mc_winner.icon_class.gotoAndStop(param1.winner.characterClass.index);
            this.disp.mc_winner.txt_winner_lvl.text = MafiaModel.languageData.getTextById("event_lastmanstanding_winnerLevel",[param1.winner.level]);
            MovieClipHelper.clearMovieClip(this.disp.mc_winner.holder);
            this.disp.mc_winner.holder.addChild(param1.winner.typeMC);
            this.disp.mc_winner.btn_gotoPlayer.enableButton = true;
         }
         else
         {
            this.disp.mc_winner.white_flag.visible = true;
            this.disp.mc_winner.txt_winner_name.text = "";
            this.disp.mc_winner.txt_clan_name.text = "";
            this.disp.mc_winner.icon_class.visible = false;
            this.disp.mc_winner.txt_winner_lvl.text = "";
            MovieClipHelper.clearMovieClip(this.disp.mc_winner.holder);
            this.disp.mc_winner.btn_gotoPlayer.enableButton = false;
            trace("no winner data");
         }
         this.updateAllTextFields();
      }
      
      public function updateAllTextFields(param1:DisplayObjectContainer = null) : void
      {
         var _loc3_:TextField = null;
         var _loc2_:DisplayObjectContainer = !!param1?param1:this.disp as DisplayObjectContainer;
         for each(_loc3_ in this.findTextFields(_loc2_))
         {
            this.updateTextField(_loc3_);
         }
      }
      
      protected function findTextFields(param1:DisplayObjectContainer) : Array
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc4_ is TextField)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_ is DisplayObjectContainer)
            {
               _loc5_ = this.findTextFields(_loc4_ as DisplayObjectContainer);
               _loc2_ = _loc2_.concat(_loc5_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function updateTextField(param1:TextField) : void
      {
         BasicLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
      
      public function initTextfields() : void
      {
         this.disp.mc_info_bottom.txt_event_lastmanstanding_copy_10.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_10");
         this.disp.mc_info_bottom.txt_event_lastmanstanding_copy_11.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_11");
         this.disp.mc_info_bottom.btn_heal.label = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_11");
      }
   }
}
