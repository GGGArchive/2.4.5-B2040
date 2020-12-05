package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.states.CityQuestBonusFight;
   import com.goodgamestudios.mafia.view.states.ClanCreationState;
   import com.goodgamestudios.mafia.view.states.ClanRankingState;
   import com.goodgamestudios.mafia.view.states.ConnectState;
   import com.goodgamestudios.mafia.view.states.CustomizeAvatarState;
   import com.goodgamestudios.mafia.view.states.DuelFightState;
   import com.goodgamestudios.mafia.view.states.DuelPrepareFightState;
   import com.goodgamestudios.mafia.view.states.DuelState;
   import com.goodgamestudios.mafia.view.states.DungeonFightState;
   import com.goodgamestudios.mafia.view.states.DungeonState;
   import com.goodgamestudios.mafia.view.states.GangState;
   import com.goodgamestudios.mafia.view.states.HomeState;
   import com.goodgamestudios.mafia.view.states.LoadItemsState;
   import com.goodgamestudios.mafia.view.states.LoginState;
   import com.goodgamestudios.mafia.view.states.MailingState;
   import com.goodgamestudios.mafia.view.states.MissionFightState;
   import com.goodgamestudios.mafia.view.states.MissionState;
   import com.goodgamestudios.mafia.view.states.MultiFightState;
   import com.goodgamestudios.mafia.view.states.OtherClanState;
   import com.goodgamestudios.mafia.view.states.OtherProfileState;
   import com.goodgamestudios.mafia.view.states.PlayerRankingState;
   import com.goodgamestudios.mafia.view.states.PoliceFightState;
   import com.goodgamestudios.mafia.view.states.ProfileState;
   import com.goodgamestudios.mafia.view.states.RegistrationState;
   import com.goodgamestudios.mafia.view.states.ReplayFightState;
   import com.goodgamestudios.mafia.view.states.ShopState;
   import com.goodgamestudios.mafia.view.states.SurvivalFightState;
   import com.goodgamestudios.mafia.view.states.SurvivalState;
   import com.goodgamestudios.mafia.view.states.TournamentFightState;
   import com.goodgamestudios.mafia.view.states.TournamentState;
   import com.goodgamestudios.mafia.view.states.UserClanState;
   import com.goodgamestudios.mafia.view.states.WantedFightState;
   import com.goodgamestudios.mafia.view.states.WelcomeState;
   import flash.utils.Dictionary;
   
   public class MafiaInitLayoutStatesCommand extends SimpleCommand
   {
       
      
      public function MafiaInitLayoutStatesCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Dictionary = MafiaLayoutManager.stateDict;
         _loc2_[BasicLayoutManager.STATE_LOAD_ITEMS] = new LoadItemsState();
         _loc2_[BasicLayoutManager.STATE_CONNECT] = new ConnectState();
         _loc2_[BasicLayoutManager.STATE_LOGIN] = new LoginState();
         _loc2_[BasicLayoutManager.STATE_REGISTRATION] = new RegistrationState();
         _loc2_[Constants_LayoutStates.STATE_SHOP] = new ShopState();
         _loc2_[Constants_LayoutStates.STATE_DUEL] = new DuelState();
         _loc2_[Constants_LayoutStates.STATE_PLAYERRANKING] = new PlayerRankingState();
         _loc2_[Constants_LayoutStates.STATE_CLANRANKING] = new ClanRankingState();
         _loc2_[Constants_LayoutStates.STATE_OTHERPROFILE] = new OtherProfileState();
         _loc2_[Constants_LayoutStates.STATE_PROFILE] = new ProfileState();
         _loc2_[Constants_LayoutStates.STATE_WELCOME] = new WelcomeState();
         _loc2_[Constants_LayoutStates.STATE_DUEL_FIGHT] = new DuelFightState();
         _loc2_[Constants_LayoutStates.STATE_MISSION_FIGHT] = new MissionFightState();
         _loc2_[Constants_LayoutStates.STATE_WANTED_FIGHT] = new WantedFightState();
         _loc2_[Constants_LayoutStates.STATE_GANGWAR_FIGHT] = new DungeonFightState();
         _loc2_[Constants_LayoutStates.STATE_CITYQUEST_BONUS_FIGHT] = new CityQuestBonusFight();
         _loc2_[Constants_LayoutStates.STATE_CLAN_FIGHT] = new MultiFightState();
         _loc2_[Constants_LayoutStates.STATE_MAILING] = new MailingState();
         _loc2_[Constants_LayoutStates.STATE_GANGWARS] = new DungeonState();
         _loc2_[Constants_LayoutStates.STATE_REPLAY_FIGHT] = new ReplayFightState();
         _loc2_[Constants_LayoutStates.STATE_CLANCREATION] = new ClanCreationState();
         _loc2_[Constants_LayoutStates.STATE_USERCLAN] = new UserClanState();
         _loc2_[Constants_LayoutStates.STATE_OTHERCLAN] = new OtherClanState();
         _loc2_[Constants_LayoutStates.STATE_CUSTOMIZE_AVATAR] = new CustomizeAvatarState();
         _loc2_[Constants_LayoutStates.STATE_MISSION] = new MissionState();
         _loc2_[Constants_LayoutStates.STATE_HOME] = new HomeState();
         _loc2_[Constants_LayoutStates.STATE_SURVIVAL] = new SurvivalState();
         _loc2_[Constants_LayoutStates.STATE_SURVIVAL_FIGHT] = new SurvivalFightState();
         _loc2_[Constants_LayoutStates.STATE_GANG] = new GangState();
         _loc2_[Constants_LayoutStates.STATE_POLICE_FIGHT] = new PoliceFightState();
         _loc2_[Constants_LayoutStates.STATE_TOURNAMENT] = new TournamentState();
         _loc2_[Constants_LayoutStates.STATE_TOURNAMENT_FIGHT] = new TournamentFightState();
         _loc2_[Constants_LayoutStates.STATE_DUEL_PREPARE] = new DuelPrepareFightState();
      }
   }
}
