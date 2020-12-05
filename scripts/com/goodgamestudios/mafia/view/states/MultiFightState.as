package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaClanFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class MultiFightState extends MafiaLayoutState
   {
       
      
      public function MultiFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaClanFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.gangwarData.gangwarResultData,MafiaModel.userData.gangwarData.reward));
      }
   }
}
