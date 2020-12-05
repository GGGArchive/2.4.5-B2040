package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   
   public class MissionState extends MafiaLayoutState
   {
       
      
      public function MissionState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaMissionScreen.NAME);
      }
   }
}
