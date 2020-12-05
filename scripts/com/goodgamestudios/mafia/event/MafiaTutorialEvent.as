package com.goodgamestudios.mafia.event
{
   import flash.events.Event;
   
   public class MafiaTutorialEvent extends Event
   {
      
      public static const TUTORIAL_STATE_CHANGE:String = "tutorialstatechange";
      
      public static const TUTORIAL_RESET_CURRENT_STEP:String = "tutorialresetstep";
      
      public static const TUTORIAL_STATE_SELL_WEAPON:String = "tutorialsellweapon";
      
      public static const TUTORIAL_STATE_UNLOCKALL:String = "tutorialunlockall";
       
      
      public function MafiaTutorialEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
