package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaUserClanScreen;
   
   public class UserClanState extends MafiaLayoutState
   {
       
      
      public function UserClanState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaUserClanScreen.NAME);
      }
   }
}
