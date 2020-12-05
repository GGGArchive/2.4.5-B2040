package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaSurvivalFightScreen;
   
   public class SurvivalFightState extends MafiaLayoutState
   {
       
      
      public function SurvivalFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaSurvivalFightScreen.NAME);
      }
   }
}
