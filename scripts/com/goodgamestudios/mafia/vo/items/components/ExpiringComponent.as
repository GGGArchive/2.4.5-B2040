package com.goodgamestudios.mafia.vo.items.components
{
   public class ExpiringComponent extends BasicItemComponent
   {
       
      
      public var endTime:Number = 0;
      
      public var duration:Number = 0;
      
      public var remainingTime:String;
      
      public function ExpiringComponent()
      {
         super();
      }
   }
}
