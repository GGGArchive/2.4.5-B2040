package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaSurvivalScreen;
   
   public class SurvivalState extends MafiaLayoutState
   {
       
      
      public function SurvivalState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaSurvivalScreen.NAME);
      }
   }
}
