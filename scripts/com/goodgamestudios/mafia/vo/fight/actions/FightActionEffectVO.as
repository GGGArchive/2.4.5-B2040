package com.goodgamestudios.mafia.vo.fight.actions
{
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import flash.display.MovieClip;
   
   public class FightActionEffectVO
   {
      
      public static const DEBUFF:String = "Debuff";
      
      public static const BUFF:String = "Buff";
       
      
      public var id:uint;
      
      public var durationLeft:uint;
      
      public var target:int;
      
      public var buffType:String;
      
      public var duration:uint;
      
      public var item:FightItemVO;
      
      public var buffMC:MovieClip;
      
      public var description:String;
      
      public function FightActionEffectVO()
      {
         super();
      }
   }
}
