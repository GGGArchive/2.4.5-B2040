package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.FeatureType;
   
   public class FeatureStatusVO
   {
       
      
      public var feature:FeatureType;
      
      public var isActive:Boolean;
      
      public var runtime_period:Number;
      
      public var remaining_until_end:Number;
      
      public var remaining_until_start:Number;
      
      public function FeatureStatusVO()
      {
         super();
      }
   }
}
