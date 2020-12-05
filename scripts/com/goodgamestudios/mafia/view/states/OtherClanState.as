package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaOtherClanScreen;
   
   public class OtherClanState extends MafiaLayoutState
   {
       
      
      public function OtherClanState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaOtherClanScreen.NAME);
      }
   }
}
