package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaGangwarScreen;
   
   public class DungeonState extends MafiaLayoutState
   {
       
      
      public function DungeonState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaGangwarScreen.NAME);
      }
   }
}
