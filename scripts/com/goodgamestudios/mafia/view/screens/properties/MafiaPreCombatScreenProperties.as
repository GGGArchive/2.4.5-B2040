package com.goodgamestudios.mafia.view.screens.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.model.components.user.MafiaPreCombatData;
   
   public class MafiaPreCombatScreenProperties extends BasicProperties
   {
       
      
      public var preCombatData:MafiaPreCombatData;
      
      public function MafiaPreCombatScreenProperties(param1:MafiaPreCombatData)
      {
         super();
         this.preCombatData = param1;
      }
   }
}
