package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaClanRankingScreen;
   
   public class ClanRankingState extends MafiaLayoutState
   {
       
      
      public function ClanRankingState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaClanRankingScreen.NAME);
      }
   }
}
