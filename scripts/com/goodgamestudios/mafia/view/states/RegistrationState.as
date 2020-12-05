package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.panels.MafiaRegisterPanel;
   
   public class RegistrationState extends MafiaLayoutState
   {
       
      
      public function RegistrationState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         layoutManager.showPanel(MafiaRegisterPanel.NAME);
      }
   }
}
