package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaOtherProfileScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaOtherSubProfileScreen;
   
   public class OtherProfileState extends MafiaLayoutState
   {
       
      
      public function OtherProfileState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaOtherSubProfileScreen.NAME);
         layoutManager.showScreen(MafiaOtherProfileScreen.NAME);
         layoutManager.onTopScreen(MafiaOtherProfileScreen.NAME);
      }
   }
}
