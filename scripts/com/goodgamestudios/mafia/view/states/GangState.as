package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaGangScreen;
   
   public class GangState extends MafiaLayoutState
   {
       
      
      public function GangState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaGangScreen.NAME);
      }
   }
}
