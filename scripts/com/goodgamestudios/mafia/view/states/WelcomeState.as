package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaBuddylistPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaWelcomeScreen;
   
   public class WelcomeState extends MafiaLayoutState
   {
       
      
      public function WelcomeState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.hideAllPanels();
         if(env.hasNetworkBuddies)
         {
            layoutManager.showPanel(MafiaBuddylistPanel.NAME);
         }
         layoutManager.showScreen(MafiaWelcomeScreen.NAME);
         layoutManager.showPanel(MafiaActionPanel.NAME);
      }
   }
}
