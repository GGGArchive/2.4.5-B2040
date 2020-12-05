package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaTournamentFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class TournamentFightState extends MafiaLayoutState
   {
       
      
      public function TournamentFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaTournamentFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.specialEvent.tournamentEvent.fightResultData,MafiaModel.specialEvent.tournamentEvent.reward));
      }
   }
}
