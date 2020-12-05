package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaClanCreationScreen;
   
   public class ClanCreationState extends MafiaLayoutState
   {
       
      
      public function ClanCreationState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaClanCreationScreen.NAME);
      }
   }
}
