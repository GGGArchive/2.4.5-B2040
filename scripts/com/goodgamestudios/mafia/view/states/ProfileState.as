package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaBuddylistPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaUserProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaUserSubProfileScreen;
   
   public class ProfileState extends MafiaLayoutState
   {
       
      
      public function ProfileState()
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
         layoutManager.showScreen(MafiaUserSubProfileScreen.NAME);
         layoutManager.showScreen(MafiaUserProfileScreen.NAME);
         layoutManager.onTopScreen(MafiaUserProfileScreen.NAME);
         layoutManager.showPanel(MafiaActionPanel.NAME);
      }
   }
}
