package com.goodgamestudios.mafia.event.model
{
   public class MafiaFightEvent extends MafiaEvent
   {
      
      public static const START_COMBAT:String = "startCombat";
      
      public static const SKIP_COMBAT:String = "skipCombat";
      
      public static const END_COMBAT:String = "endCombat";
      
      public static const END_MULTIFIGHT:String = "multifightEnd";
      
      public static const START_MULTIFIGHT:String = "multifightStart";
      
      public static const PLAY_WEAPON_ANIMATION:String = "playWeaponAnimation";
      
      public static const PLAY_CONSUMABLE_ANIMATION:String = "playConsumableAnimation";
      
      public static const UPDATE_EFFECTS:String = "updateEffects";
      
      public static const HEALTH_BAR_ANIMATION_FINISHED:String = "combatAnimationFinished";
      
      public static const RESULT_ANIMATION_FINISHED:String = "resultAnimationFinished";
      
      public static const END_OF_COMBAT_ANIMATION_FINISHED:String = "endOfCombatAnimationFinished";
      
      public static const EFFECT_ANIMATION_FINISHED:String = "effectAnimationFinished";
       
      
      public function MafiaFightEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
