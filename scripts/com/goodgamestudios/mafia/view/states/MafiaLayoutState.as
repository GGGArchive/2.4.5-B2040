package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaChooseTravelPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaMissionSelectionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaQuestlogPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianGoToGangwarPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaSicilianNoMissionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaStartWorkPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTravelProgressPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkFinishedPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaWorkProgressPanel;
   
   public class MafiaLayoutState
   {
       
      
      public function MafiaLayoutState()
      {
         super();
      }
      
      public function executeState() : void
      {
         this.layoutManager.hideAllScreens();
         this.layoutManager.hidePanel(MafiaQuestlogPanel.NAME);
         this.layoutManager.hidePanel(MafiaMissionProgressPanel.NAME);
         this.layoutManager.hidePanel(MafiaMissionSelectionPanel.NAME);
         this.layoutManager.hidePanel(MafiaStartWorkPanel.NAME);
         this.layoutManager.hidePanel(MafiaWorkProgressPanel.NAME);
         this.layoutManager.hidePanel(MafiaWorkFinishedPanel.NAME);
         this.layoutManager.hidePanel(MafiaChooseTravelPanel.NAME);
         this.layoutManager.hidePanel(MafiaTravelProgressPanel.NAME);
         this.layoutManager.hidePanel(MafiaSicilianNoMissionPanel.NAME);
         this.layoutManager.hidePanel(MafiaSicilianGoToGangwarPanel.NAME);
         this.layoutManager.showPanel(MafiaActionPanel.NAME);
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
