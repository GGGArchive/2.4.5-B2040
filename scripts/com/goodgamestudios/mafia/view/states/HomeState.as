package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaBuddylistPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaHomeScreen;
   
   public class HomeState extends MafiaLayoutState
   {
       
      
      public function HomeState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         if(layoutManager.outGameState)
         {
            layoutManager.hideAllPanels();
            if(env.hasNetworkBuddies)
            {
               layoutManager.showPanel(MafiaBuddylistPanel.NAME);
            }
         }
         layoutManager.showPanel(MafiaActionPanel.NAME);
         layoutManager.showScreen(MafiaHomeScreen.NAME);
      }
   }
}
