package com.goodgamestudios.mafia.view.screens.tournament
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.PlayerTournamentStatus;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.SearchTournamentPlayerCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ShowRemainingTournamentPlayersCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.tournament.TournamentRemainingPlayerVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class MafiaParticipantsTournamentComp
   {
      
      private static const DEFAULTPLAYERLISTLENGTH:int = 10;
      
      private static const LISTSTART:int = 0;
      
      private static const LISTEND:int = 10;
       
      
      private var tab:MovieClip;
      
      private var searchedPlayer:String = "";
      
      private var upScrollPosition:int = 0;
      
      private var downScrollPosition:int = 0;
      
      public function MafiaParticipantsTournamentComp(param1:MovieClip)
      {
         super();
         this.tab = param1;
      }
      
      public function show() : void
      {
         this.initTextfields();
         this.hideEmptyList();
         this.tab.btn_up.enableButton = false;
         this.tab.btn_down.enableButton = false;
         this.controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REMAINING_PLAYERS_UPDATED,this.onParticipantsUpdate);
         this.controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_SEARCHED_PLAYER_UPDATED,this.onSearchedPlayer);
         this.controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_PLAYER_NOTFOUND,this.onPlayerNotFound);
         this.tab.addEventListener(MouseEvent.CLICK,this.onClick);
         this.tab.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.tab.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.tab.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.upScrollPosition = LISTSTART;
         this.downScrollPosition = LISTEND;
      }
      
      public function hide() : void
      {
         this.controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REMAINING_PLAYERS_UPDATED,this.onParticipantsUpdate);
         this.controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_SEARCHED_PLAYER_UPDATED,this.onSearchedPlayer);
         this.controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_PLAYER_NOTFOUND,this.onPlayerNotFound);
         this.tab.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.tab.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.tab.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.tab.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:TournamentLine = null;
         if(param1.target is RankingMouseOverNameLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as TournamentLine;
            if(_loc3_.properties.playerID != MafiaModel.userData.playerID)
            {
               MafiaModel.otherUserData = new MafiaOtherUserData();
               this.layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
            }
            else
            {
               this.layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            }
            PlayerProfileCommand.sendCommand(_loc3_.properties.playerID,false);
         }
         if(param1.target is RankingMouseOverClanLayer)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = _loc2_.parent as TournamentLine;
            if(_loc3_.properties.clanID == 0)
            {
               return;
            }
            if(_loc3_.properties.playerID != MafiaModel.userData.playerID)
            {
               if(_loc3_.properties.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  MafiaModel.otherUserData = new MafiaOtherUserData();
                  this.layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
                  PlayerProfileCommand.sendCommand(_loc3_.properties.playerID,false);
               }
               else
               {
                  ShowClanCommand.sendCommand(_loc3_.properties.clanID);
                  this.layoutManager.state = Constants_LayoutStates.STATE_OTHERCLAN;
               }
            }
            else if(_loc3_.properties.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
            {
               this.layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            }
            else
            {
               ShowClanCommand.sendCommand();
               this.layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
            }
         }
         switch(param1.target)
         {
            case this.tab.txt_input:
               this.tab.txt_input.text = "";
               break;
            case this.tab.btn_search:
               if(this.tab.btn_search.enabled)
               {
                  this.searchPlayer(this.tab.txt_input.text);
               }
               break;
            case this.tab.btn_up:
               if(!this.tab.btn_up.enabled)
               {
                  return;
               }
               this.tab.btn_up.enableButton = false;
               this.tab.btn_down.enableButton = false;
               if(this.upScrollPosition != 0)
               {
                  this.downScrollPosition = this.downScrollPosition - DEFAULTPLAYERLISTLENGTH;
                  this.upScrollPosition = this.upScrollPosition - DEFAULTPLAYERLISTLENGTH;
                  this.getListFromServer(this.upScrollPosition);
               }
               break;
            case this.tab.btn_down:
               if(!this.tab.btn_down.enabled)
               {
                  return;
               }
               this.tab.btn_up.enableButton = false;
               this.tab.btn_down.enableButton = false;
               if(this.downScrollPosition < MafiaModel.specialEvent.tournamentEvent.numRegisteredPlayers)
               {
                  this.getListFromServer(this.downScrollPosition);
                  this.upScrollPosition = this.upScrollPosition + DEFAULTPLAYERLISTLENGTH;
                  this.downScrollPosition = this.downScrollPosition + DEFAULTPLAYERLISTLENGTH;
               }
               break;
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is RankingMouseOverNameLayer || param1.target is RankingMouseOverClanLayer)
         {
            (param1.target as MovieClip).alpha = 1;
            return;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is RankingMouseOverNameLayer || param1.target is RankingMouseOverClanLayer)
         {
            (param1.target as MovieClip).alpha = 0.05;
            return;
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(TextValide.isSmartFoxValide(this.tab.txt_input.text) && param1.keyCode == Keyboard.ENTER)
         {
            this.searchPlayer(this.tab.txt_input.text);
         }
      }
      
      private function searchPlayer(param1:String) : void
      {
         if(TextValide.isSmartFoxValide(this.tab.txt_input.text))
         {
            this.searchedPlayer = this.tab.txt_input.text;
            this.tab.txt_input.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_38");
            SearchTournamentPlayerCommand.sendCommand(this.searchedPlayer);
         }
      }
      
      private function onSearchedPlayer(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:TournamentRemainingPlayerVO = param1.params[0] as TournamentRemainingPlayerVO;
         this.tab.txt_searched_name_value.text = _loc2_.name;
         if(_loc2_.playerTournamentStatus == PlayerTournamentStatus.NotParticipating)
         {
            this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_40");
         }
         else if(_loc2_.playerTournamentStatus == PlayerTournamentStatus.Participating)
         {
            this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_41");
         }
         else if(_loc2_.playerTournamentStatus == PlayerTournamentStatus.Eliminated)
         {
            switch(_loc2_.playerReachedRound)
            {
               case TournamentRemainingPlayerVO.LAST_SIXTEEN:
                  this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_43");
                  break;
               case TournamentRemainingPlayerVO.QUARTER_FINAL:
                  this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_44");
                  break;
               case TournamentRemainingPlayerVO.SEMI_FINAL:
                  this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_45");
                  break;
               case TournamentRemainingPlayerVO.FINAL:
                  this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_46");
                  break;
               default:
                  this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_42",[_loc2_.playerReachedRound]);
            }
         }
      }
      
      private function onParticipantsUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.fillParticipantsList(MafiaModel.specialEvent.tournamentEvent.remainingTournamentPlayers);
      }
      
      private function onPlayerNotFound(param1:MafiaSpecialEventsEvent) : void
      {
         this.tab.txt_searched_name_value.text = this.searchedPlayer;
         this.tab.txt_status_value.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_3",[this.searchedPlayer]);
      }
      
      private function hideEmptyList() : void
      {
         var _loc2_:TournamentLine = null;
         var _loc1_:uint = 0;
         while(_loc1_ < DEFAULTPLAYERLISTLENGTH)
         {
            _loc2_ = this.tab["line" + _loc1_] as TournamentLine;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function fillParticipantsList(param1:Vector.<TournamentRemainingPlayerVO>) : void
      {
         var _loc3_:TournamentLine = null;
         var _loc4_:CharacterClass = null;
         var _loc5_:Sprite = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = this.tab["line" + _loc2_] as TournamentLine;
            if(param1.length < _loc2_ - 1)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.rankingLineBG.gotoAndStop(1);
               _loc3_.visible = true;
               _loc3_.properties = null;
               if(param1.length > _loc2_)
               {
                  _loc3_.txt_level.text = String(param1[_loc2_].level);
                  _loc3_.txt_name.text = param1[_loc2_].name;
                  _loc3_.txt_name.embedFonts = true;
                  _loc3_.txt_name.mouseEnabled = false;
                  if(_loc3_.txt_name.textWidth == 0)
                  {
                     _loc3_.txt_name.embedFonts = false;
                     _loc3_.txt_name.text = param1[_loc2_].name;
                  }
                  _loc3_.btn_layer_name.alpha = 0.05;
                  _loc3_.btn_layer_name.width = _loc3_.txt_name.textWidth + 20;
                  _loc3_.btn_layer_name.buttonMode = true;
                  if(param1[_loc2_].clanName)
                  {
                     _loc3_.txt_clan.text = param1[_loc2_].clanName;
                  }
                  else
                  {
                     _loc3_.txt_clan.text = "-";
                  }
                  if(_loc3_.txt_clan.textWidth == 0)
                  {
                     _loc3_.txt_clan.embedFonts = false;
                     _loc3_.txt_clan.text = param1[_loc2_].clanName;
                  }
                  _loc3_.btn_layer_clan.alpha = 0.05;
                  _loc3_.btn_layer_clan.width = _loc3_.txt_clan.textWidth + 20;
                  _loc3_.btn_layer_clan.buttonMode = true;
                  MovieClipHelper.clearMovieClip(_loc3_.mc_class);
                  if(param1[_loc2_].characterClass == null || param1[_loc2_].characterClass == CharacterClass.None)
                  {
                     _loc4_ = CharacterClass.Bully;
                  }
                  else
                  {
                     _loc4_ = param1[_loc2_].characterClass;
                  }
                  _loc5_ = AvatarHelper.createClassSymbol(_loc4_,0.5);
                  _loc3_.mc_class.addChildAt(_loc5_,0);
                  _loc3_.properties = param1[_loc2_];
                  if(this.searchedPlayer != "" && param1[_loc2_].name.toLocaleLowerCase() == this.searchedPlayer.toLocaleLowerCase())
                  {
                     _loc3_.rankingLineBG.gotoAndStop(2);
                  }
                  if(param1[_loc2_].playerID == MafiaModel.userData.playerID)
                  {
                     _loc3_.rankingLineBG.gotoAndStop(2);
                  }
               }
               else
               {
                  _loc3_.visible = false;
               }
            }
            _loc2_++;
         }
         this.searchedPlayer = "";
         if(this.downScrollPosition < MafiaModel.specialEvent.tournamentEvent.numRegisteredPlayers)
         {
            this.tab.btn_down.enableButton = true;
         }
         else
         {
            this.tab.btn_down.enableButton = false;
         }
         if(this.upScrollPosition == 0)
         {
            this.tab.btn_up.enableButton = false;
         }
         else
         {
            this.tab.btn_up.enableButton = true;
         }
      }
      
      public function getListFromServer(param1:int) : void
      {
         ShowRemainingTournamentPlayersCommand.sendCommand(param1);
      }
      
      public function initTextfields() : void
      {
         this.tab.txt_searched_name_value.text = "";
         this.tab.txt_status_value.text = "";
         this.tab.txt_input.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_38");
         this.tab.txt_title_search.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_36");
         this.tab.txt_name.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_name");
         this.tab.txt_searched_name.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_name");
         this.tab.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level");
         this.tab.txt_clan.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_family");
         this.tab.txt_copy.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_37");
         this.tab.txt_status.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_39");
         this.tab.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_8",[MafiaModel.specialEvent.tournamentEvent.numRemainingPlayers,MafiaModel.specialEvent.tournamentEvent.numRegisteredPlayers]);
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
   }
}
