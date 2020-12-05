package com.goodgamestudios.mafia.view.states
{
   public class ConnectState extends MafiaLayoutState
   {
       
      
      public function ConnectState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         layoutManager.hideAllDialogs();
         layoutManager.hideAllPanels();
         layoutManager.hideAllScreens();
         layoutManager.showBackgroundLayer();
      }
   }
}
