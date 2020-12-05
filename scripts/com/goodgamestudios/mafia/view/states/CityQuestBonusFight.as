package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaCityBonusFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class CityQuestBonusFight extends MafiaLayoutState
   {
       
      
      public function CityQuestBonusFight()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaCityBonusFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.cityQuestFightData.cityBonusFightResultData,MafiaModel.userData.cityQuestFightData.reward));
      }
   }
}
