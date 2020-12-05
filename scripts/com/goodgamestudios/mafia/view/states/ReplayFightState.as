package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaReplayFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class ReplayFightState extends MafiaLayoutState
   {
       
      
      public function ReplayFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaReplayFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.messageData.replayFightData,MafiaModel.userData.messageData.reward));
      }
   }
}
