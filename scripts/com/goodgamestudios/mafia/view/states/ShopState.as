package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.view.screens.MafiaShopScreen;
   import com.goodgamestudios.mafia.view.screens.MafiaUserProfileScreen;
   
   public class ShopState extends MafiaLayoutState
   {
       
      
      public function ShopState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaShopScreen.NAME);
         layoutManager.showScreen(MafiaUserProfileScreen.NAME);
         layoutManager.onTopScreen(MafiaUserProfileScreen.NAME);
      }
   }
}
