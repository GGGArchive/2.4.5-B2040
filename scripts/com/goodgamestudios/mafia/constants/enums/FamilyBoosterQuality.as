package com.goodgamestudios.mafia.constants.enums
{
   public class FamilyBoosterQuality extends BasicEnum
   {
      
      private static var _low:FamilyBoosterQuality;
      
      private static var _high:FamilyBoosterQuality;
      
      private static var _none:FamilyBoosterQuality;
       
      
      public function FamilyBoosterQuality(param1:String, param2:uint, param3:DoNotInstantiate#72)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : FamilyBoosterQuality
      {
         if(_none == null)
         {
            _none = new FamilyBoosterQuality("None",0,new DoNotInstantiate#72());
         }
         return _none;
      }
      
      public static function get Low() : FamilyBoosterQuality
      {
         if(_low == null)
         {
            _low = new FamilyBoosterQuality("Low",1,new DoNotInstantiate#72());
         }
         return _low;
      }
      
      public static function get High() : FamilyBoosterQuality
      {
         if(_high == null)
         {
            _high = new FamilyBoosterQuality("High",2,new DoNotInstantiate#72());
         }
         return _high;
      }
   }
}

class DoNotInstantiate#72
{
    
   
   function DoNotInstantiate#72()
   {
      super();
   }
}
