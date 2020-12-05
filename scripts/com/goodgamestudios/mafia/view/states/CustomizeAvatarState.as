package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaCustomizeAvatarScreen;
   
   public class CustomizeAvatarState extends MafiaLayoutState
   {
       
      
      public function CustomizeAvatarState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaCustomizeAvatarScreen.NAME);
      }
   }
}
