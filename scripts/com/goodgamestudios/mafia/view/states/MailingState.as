package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaMailingScreen;
   
   public class MailingState extends MafiaLayoutState
   {
       
      
      public function MailingState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaMailingScreen.NAME);
      }
   }
}
