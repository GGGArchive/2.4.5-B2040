package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaGangwarFightScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaBasicFightScreenProperties;
   
   public class DungeonFightState extends MafiaLayoutState
   {
       
      
      public function DungeonFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            layoutManager.showScreen(MafiaGangwarFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.specialEvent.sicilianEvent.gangwarFightResultData,MafiaModel.specialEvent.sicilianEvent.reward));
         }
         else
         {
            layoutManager.showScreen(MafiaGangwarFightScreen.NAME,new MafiaBasicFightScreenProperties(MafiaModel.userData.gangwarData.gangwarResultData,MafiaModel.userData.gangwarData.reward));
         }
      }
   }
}
