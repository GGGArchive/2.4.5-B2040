package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaTournamentScreen;
   
   public class TournamentState extends MafiaLayoutState
   {
       
      
      public function TournamentState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaTournamentScreen.NAME);
      }
   }
}
