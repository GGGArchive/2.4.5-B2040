package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class MissionFightState extends MafiaLayoutState
   {
       
      
      public function MissionFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.hidePanel(MafiaReviewTutorialPanel.NAME);
         layoutManager.showScreen(MafiaMissionFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.missionData.missionResultData,MafiaModel.userData.missionData.reward));
      }
   }
}
