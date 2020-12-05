package com.goodgamestudios.mafia.controller.protobuf.fight.startduel.response
{
   public final class PBFightStartDuelResult
   {
      
      public static const OK:int = 1;
      
      public static const MAX_ATTACK_COUNT_REACHED:int = 2;
      
      public static const NOT_ENOUGH_GOLD:int = 3;
      
      public static const PLAYER_NOT_EXISTS:int = 4;
      
      public static const ARMAMENT_CHANGED:int = 5;
      
      public static const ARMAMENT_LOCKED:int = 6;
       
      
      public function PBFightStartDuelResult()
      {
         super();
      }
   }
}
