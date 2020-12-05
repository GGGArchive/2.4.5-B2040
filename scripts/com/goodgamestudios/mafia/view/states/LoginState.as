package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.panels.MafiaLoginPanel;
   
   public class LoginState extends MafiaLayoutState
   {
       
      
      public function LoginState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         layoutManager.hidePanel(MafiaLoginPanel.NAME);
         layoutManager.onEndProgressbar();
         layoutManager.hideAllPanels();
         layoutManager.hideAllScreens();
         layoutManager.showBackgroundLayer();
         layoutManager.showPanel(MafiaLoginPanel.NAME);
         layoutManager.showServerAndClientVersion();
      }
   }
}
