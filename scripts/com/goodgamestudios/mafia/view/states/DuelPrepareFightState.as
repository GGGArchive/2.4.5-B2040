package com.goodgamestudios.mafia.view.states
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.MafiaPreCombatScreen;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaPreCombatScreenProperties;
   
   public class DuelPrepareFightState extends MafiaLayoutState
   {
       
      
      public function DuelPrepareFightState()
      {
         super();
      }
      
      override public function executeState() : void
      {
         super.executeState();
         layoutManager.showScreen(MafiaPreCombatScreen.NAME,new MafiaPreCombatScreenProperties(MafiaModel.userData.preCombatData));
      }
   }
}
