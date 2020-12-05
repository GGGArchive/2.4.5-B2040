package com.goodgamestudios.mafia.model.components.user
{
   public class MafiaPreCombatData
   {
       
      
      public var opponentId:uint;
      
      public var opponentData:MafiaProfileData;
      
      public var opponentArmament:MafiaArmamentData;
      
      public var lastUsedConsumables:Boolean;
      
      public function MafiaPreCombatData()
      {
         super();
      }
   }
}
