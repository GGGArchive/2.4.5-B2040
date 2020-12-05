package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaDuelScreen;
   
   public class DuelState extends MafiaLayoutState
   {
       
      
      public function DuelState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaDuelScreen.NAME);
      }
   }
}
