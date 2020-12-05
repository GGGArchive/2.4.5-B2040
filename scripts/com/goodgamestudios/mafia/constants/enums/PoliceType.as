package com.goodgamestudios.mafia.constants.enums
{
   public class PoliceType extends BasicEnum
   {
      
      private static var _none:PoliceType;
      
      private static var _police:PoliceType;
      
      private static var _swat:PoliceType;
       
      
      public function PoliceType(param1:String, param2:uint, param3:DoNotInstantiate#102)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : PoliceType
      {
         if(_none == null)
         {
            _none = new PoliceType("None",0,new DoNotInstantiate#102());
         }
         return _none;
      }
      
      public static function get Police() : PoliceType
      {
         if(_police == null)
         {
            _police = new PoliceType("Police",1,new DoNotInstantiate#102());
         }
         return _police;
      }
      
      public static function get SWAT() : PoliceType
      {
         if(_swat == null)
         {
            _swat = new PoliceType("SWAT",2,new DoNotInstantiate#102());
         }
         return _swat;
      }
   }
}

class DoNotInstantiate#102
{
    
   
   function DoNotInstantiate#102()
   {
      super();
   }
}
