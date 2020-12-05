package com.goodgamestudios.mafia.view.screens.tournament
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_Tournament;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ViewTournamentFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaTournamentEvent;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.tournament.TournamentFightHistoryVO;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaNextFightTournamentComp
   {
       
      
      private var tab:MovieClip;
      
      private var _opponentFightHistoryOffset:int = 0;
      
      private var _playerFightHistoryOffset:int = 0;
      
      private const FIGHT_HISTORY_LIST_LENGTH:int = 4;
      
      public function MafiaNextFightTournamentComp(param1:MovieClip)
      {
         super();
         this.tab = param1;
      }
      
      public function show() : void
      {
         if(MafiaModel.specialEvent.tournamentEvent.isPlayerInTournament && !MafiaModel.specialEvent.tournamentEvent.isTournamentOver)
         {
            this.fill(MafiaModel.specialEvent.tournamentEvent);
            BasicController.getInstance().addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
            this.tab.addEventListener(MouseEvent.CLICK,this.onClick);
            this.tab.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            this.tab.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            this.tab.mouseChildren = true;
         }
      }
      
      public function hide() : void
      {
         BasicController.getInstance().removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,this.onDataUpdated);
         this.tab.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.tab.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.tab.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.playerFightHistoryOffset = 0;
         this.opponentFightHistoryOffset = 0;
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TournamentFightHistoryVO = null;
         switch(param1.target)
         {
            case this.tab.player_fight_history_line_0:
            case this.tab.player_fight_history_line_1:
            case this.tab.player_fight_history_line_2:
            case this.tab.player_fight_history_line_3:
               if(MafiaModel.specialEvent.tournamentEvent.playerFightHistory)
               {
                  _loc2_ = int(param1.target.name.charAt(param1.target.name.length - 1));
                  _loc3_ = MafiaModel.specialEvent.tournamentEvent.playerFightHistory.length - 1 - _loc2_ - this.playerFightHistoryOffset;
                  _loc4_ = MafiaModel.specialEvent.tournamentEvent.getPlayerHistoryFightVO(_loc3_);
                  if(_loc4_ && _loc4_.fightResult != FighterState.Freecard)
                  {
                     param1.target.overlay.alpha = 1;
                     MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                  }
               }
         }
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.tab.player_fight_history_line_0:
            case this.tab.player_fight_history_line_1:
            case this.tab.player_fight_history_line_2:
            case this.tab.player_fight_history_line_3:
               param1.target.overlay.alpha = 0;
               MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      protected function onDataUpdated(param1:Event) : void
      {
         this.playerFightHistoryOffset = 0;
         this.opponentFightHistoryOffset = 0;
         this.fill(MafiaModel.specialEvent.tournamentEvent);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TournamentFightHistoryVO = null;
         switch(param1.target)
         {
            case this.tab.mc_opponent.btn_gotoProfile:
               MafiaModel.otherUserData = new MafiaOtherUserData();
               MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_OTHERPROFILE;
               PlayerProfileCommand.sendCommand(MafiaModel.specialEvent.tournamentEvent.nextOpponent.ID,false);
               break;
            case this.tab.btn_fight_history_opponent_up:
               this.opponentFightHistoryOffset--;
               this.fillOpponentHistory(MafiaModel.specialEvent.tournamentEvent);
               break;
            case this.tab.btn_fight_history_opponent_down:
               this.opponentFightHistoryOffset++;
               this.fillOpponentHistory(MafiaModel.specialEvent.tournamentEvent);
               break;
            case this.tab.btn_fight_history_player_up:
               this.playerFightHistoryOffset--;
               this.fillPlayerHistory(MafiaModel.specialEvent.tournamentEvent);
               break;
            case this.tab.btn_fight_history_player_down:
               this.playerFightHistoryOffset++;
               this.fillPlayerHistory(MafiaModel.specialEvent.tournamentEvent);
               break;
            case this.tab.player_fight_history_line_0:
            case this.tab.player_fight_history_line_1:
            case this.tab.player_fight_history_line_2:
            case this.tab.player_fight_history_line_3:
               if(MafiaModel.specialEvent.tournamentEvent.playerFightHistory)
               {
                  _loc2_ = int(param1.target.name.charAt(param1.target.name.length - 1));
                  _loc3_ = MafiaModel.specialEvent.tournamentEvent.playerFightHistory.length - 1 - _loc2_ - this.playerFightHistoryOffset;
                  _loc4_ = MafiaModel.specialEvent.tournamentEvent.getPlayerHistoryFightVO(_loc3_);
                  if(_loc4_ && _loc4_.fightResult != FighterState.Freecard)
                  {
                     ViewTournamentFightCommand.sendCommand(MafiaModel.userData.playerID,_loc4_.opponentID);
                  }
               }
         }
      }
      
      public function fill(param1:MafiaTournamentEvent) : void
      {
         this.tab.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_13");
         this.tab.txt_title_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
         this.fillNextOpponent(param1);
         this.fillReward(param1);
         this.fillOpponentHistory(param1);
         this.fillPlayerHistory(param1);
      }
      
      private function fillOpponentHistory(param1:MafiaTournamentEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TournamentFightHistoryVO = null;
         this.tab.txt_fight_history_opponent_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_16");
         var _loc4_:int = 0;
         while(_loc4_ < this.FIGHT_HISTORY_LIST_LENGTH)
         {
            if(param1.nextOpponent != null && param1.opponentFightHistory != null)
            {
               _loc2_ = param1.opponentFightHistory.length - 1 - _loc4_ - this.opponentFightHistoryOffset;
               if(_loc2_ >= 0)
               {
                  _loc3_ = param1.opponentFightHistory[_loc2_];
                  this.tab["txt_fight_history_opponent_round_" + _loc4_].text = param1.getRoundname(_loc3_.round);
                  this.tab["txt_fight_history_opponent_result_" + _loc4_].text = param1.getHistoryFightDescription(_loc3_);
               }
            }
            if(param1.nextOpponent == null || param1.opponentFightHistory == null || _loc2_ < 0)
            {
               this.tab["txt_fight_history_opponent_round_" + _loc4_].text = "";
               this.tab["txt_fight_history_opponent_result_" + _loc4_].text = "";
            }
            _loc4_++;
         }
      }
      
      private function fillPlayerHistory(param1:MafiaTournamentEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TournamentFightHistoryVO = null;
         var _loc4_:TournamentFightHistoryLine = null;
         this.tab.txt_fight_history_player_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_17");
         var _loc5_:int = 0;
         while(_loc5_ < this.FIGHT_HISTORY_LIST_LENGTH)
         {
            _loc4_ = this.tab["player_fight_history_line_" + _loc5_];
            _loc4_.overlay.alpha = 0;
            _loc4_.mouseChildren = false;
            if(param1.playerFightHistory != null)
            {
               _loc2_ = param1.playerFightHistory.length - 1 - _loc5_ - this.playerFightHistoryOffset;
               if(_loc2_ >= 0)
               {
                  _loc3_ = param1.playerFightHistory[_loc2_];
                  _loc4_.txt_round.text = param1.getRoundname(_loc3_.round);
                  _loc4_.txt_result.text = param1.getHistoryFightDescription(_loc3_);
               }
            }
            if(param1.playerFightHistory == null || param1.playerFightHistory != null && _loc2_ < 0)
            {
               _loc4_.txt_round.text = "";
               _loc4_.txt_result.text = "";
            }
            _loc5_++;
         }
      }
      
      private function checkOpponentHistoryFightOffset() : void
      {
         if(MafiaModel.specialEvent.tournamentEvent.opponentFightHistory != null)
         {
            this._opponentFightHistoryOffset = Math.min(this._opponentFightHistoryOffset,MafiaModel.specialEvent.tournamentEvent.opponentFightHistory.length - this.FIGHT_HISTORY_LIST_LENGTH);
            this._opponentFightHistoryOffset = Math.max(0,this._opponentFightHistoryOffset);
         }
         else
         {
            this._opponentFightHistoryOffset = 0;
         }
      }
      
      private function checkPlayerHistoryFightOffset() : void
      {
         if(MafiaModel.specialEvent.tournamentEvent.playerFightHistory != null)
         {
            this._playerFightHistoryOffset = Math.min(this._playerFightHistoryOffset,MafiaModel.specialEvent.tournamentEvent.playerFightHistory.length - this.FIGHT_HISTORY_LIST_LENGTH);
            this._playerFightHistoryOffset = Math.max(0,this._playerFightHistoryOffset);
         }
         else
         {
            this._playerFightHistoryOffset = 0;
         }
      }
      
      private function fillReward(param1:MafiaTournamentEvent) : void
      {
         if(param1.isTournamentApplicationOpen || param1.isNextOpponentUnknown)
         {
            this.tab.mc_reward.gotoAndStop(1);
            this.tab.mc_reward.txt_reward_info.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_15");
         }
         else if(param1.currentRound == Constants_Tournament.ROUND_FINAL)
         {
            this.tab.mc_reward.gotoAndStop(3);
            this.fillRewardTexts(param1);
            if(MafiaModel.userData.profileData.gender == CharacterGender.Male)
            {
               this.tab.mc_reward.reward_man.visible = true;
               this.tab.mc_reward.reward_man.gotoAndStop(MafiaModel.specialEvent.tournamentEvent.rewardIndex + 1);
               this.tab.mc_reward.reward_woman.visible = false;
            }
            else
            {
               this.tab.mc_reward.reward_man.visible = false;
               this.tab.mc_reward.reward_woman.visible = true;
               this.tab.mc_reward.reward_woman.gotoAndStop(MafiaModel.specialEvent.tournamentEvent.rewardIndex + 1);
            }
            this.tab.mc_reward.reward_bg.gotoAndStop(MafiaModel.specialEvent.tournamentEvent.rewardIndex + 1);
         }
         else
         {
            this.tab.mc_reward.gotoAndStop(2);
            this.fillRewardTexts(param1);
         }
      }
      
      private function fillRewardTexts(param1:MafiaTournamentEvent) : void
      {
         this.tab.mc_reward.txt_glory.text = param1.nextRewardGlory;
         this.tab.mc_reward.txt_ap.text = param1.nextRewardAP;
         this.tab.mc_reward.txt_xp.text = param1.nextRewardXP;
         this.tab.mc_reward.txt_cash.text = param1.nextRewardCash;
         this.tab.mc_reward.icon_glory.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_honor");
         this.tab.mc_reward.icon_ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
         this.tab.mc_reward.icon_xp.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_xp");
         this.tab.mc_reward.icon_cash.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency1");
      }
      
      private function fillNextOpponent(param1:MafiaTournamentEvent) : void
      {
         if(param1.isTournamentApplicationOpen)
         {
            this.tab.mc_opponent.gotoAndStop(2);
            this.tab.mc_opponent.txt_body.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_14");
         }
         else if(param1.isNextOpponentFreeTicket)
         {
            this.tab.mc_opponent.gotoAndStop(3);
            this.tab.mc_opponent.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_29");
            this.tab.mc_opponent.txt_body.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_30");
         }
         else if(param1.isNextOpponentUnknown)
         {
            this.tab.mc_opponent.gotoAndStop(2);
            this.tab.mc_opponent.txt_body.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_68");
         }
         else if(param1.nextOpponent)
         {
            this.tab.mc_opponent.gotoAndStop(1);
            this.tab.mc_opponent.txt_name.text = param1.nextOpponent.name;
            this.tab.mc_opponent.txt_clan.text = param1.nextOpponent.clanName;
            this.tab.mc_opponent.txt_level.text = MafiaModel.languageData.getTextById("event_lastmanstanding_winnerLevel",[param1.nextOpponent.level]);
            this.tab.mc_opponent.btn_gotoProfile.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
            this.tab.mc_opponent.bar_health.bar.scaleX = param1.nextOpponent.HP * 0.01;
            this.tab.mc_opponent.bar_level.bar.scaleX = param1.nextOpponent.levelProgress * 0.01;
            this.tab.mc_opponent.icon_class.gotoAndStop(param1.nextOpponent.characterClass.index);
            MovieClipHelper.clearMovieClip(this.tab.mc_opponent.holder);
            this.tab.mc_opponent.holder.addChild(param1.nextOpponent.typeMC);
         }
         this.updateAllTextFields();
      }
      
      public function updateAllTextFields(param1:DisplayObjectContainer = null) : void
      {
         var _loc3_:TextField = null;
         var _loc2_:DisplayObjectContainer = !!param1?param1:this.tab as DisplayObjectContainer;
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
      
      private function get opponentFightHistoryOffset() : int
      {
         return this._opponentFightHistoryOffset;
      }
      
      private function set opponentFightHistoryOffset(param1:int) : void
      {
         this._opponentFightHistoryOffset = param1;
         this.checkOpponentHistoryFightOffset();
      }
      
      private function get playerFightHistoryOffset() : int
      {
         return this._playerFightHistoryOffset;
      }
      
      private function set playerFightHistoryOffset(param1:int) : void
      {
         this._playerFightHistoryOffset = param1;
         this.checkPlayerHistoryFightOffset();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
   }
}
