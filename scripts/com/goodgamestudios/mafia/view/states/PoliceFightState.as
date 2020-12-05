package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaPoliceFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class PoliceFightState extends MafiaLayoutState
   {
       
      
      public function PoliceFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaPoliceFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.policeData.resultData));
      }
   }
}
