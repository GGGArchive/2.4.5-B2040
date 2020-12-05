package com.goodgamestudios.mafia.event.model
{
   public class MafiaSurvivalEvent extends MafiaEvent
   {
      
      public static const CHANGE_SURVIVALDATA:String = "changeSurvivalData";
      
      public static const CHANGE_SURVIVALCOOLDOWNTIMER:String = "changeSurvivalCoolDownTimer";
      
      public static const CHANGE_SURVIVALRESETTIMER:String = "changeSurvivalResetTimer";
      
      public static const BEGIN_OF_SURVIVAL_ANIMATION_FINISHED:String = "beginOfSurvivalAnimationFinished";
      
      public static const REMOVE_ENEMY:String = "removeEnemy";
       
      
      public function MafiaSurvivalEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
