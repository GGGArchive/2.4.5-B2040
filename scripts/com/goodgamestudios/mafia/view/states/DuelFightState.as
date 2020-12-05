package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaDuelFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class DuelFightState extends MafiaLayoutState
   {
       
      
      public function DuelFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaDuelFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.duelData.pvpData.duelResultData,MafiaModel.userData.duelData.pvpData.reward));
      }
   }
}
