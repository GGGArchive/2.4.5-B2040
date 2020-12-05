package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaWantedFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class WantedFightState extends MafiaLayoutState
   {
       
      
      public function WantedFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaWantedFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.duelData.wantedData.wantedResultData,MafiaModel.userData.duelData.wantedData.reward));
      }
   }
}
