package com.goodgamestudios.mafia.view.states
{
   public class LoadItemsState extends MafiaLayoutState
   {
       
      
      public function LoadItemsState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         layoutManager.hideAllDialogs();
         layoutManager.hideAllPanels();
         layoutManager.showBackgroundLayer();
         layoutManager.backgroundComponent.showProgressBar();
      }
   }
}
