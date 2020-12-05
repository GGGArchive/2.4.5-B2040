package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaPlayerRankingScreen;
   
   public class PlayerRankingState extends MafiaLayoutState
   {
       
      
      public function PlayerRankingState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaPlayerRankingScreen.NAME);
      }
   }
}
