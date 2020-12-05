package com.goodgamestudios.mafia.constants.enums
{
   public class FeatureType extends BasicEnum
   {
      
      private static var _extrasShop:FeatureType;
      
      private static var _none:FeatureType;
       
      
      public function FeatureType(param1:String, param2:uint, param3:DoNotInstantiate#84)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : FeatureType
      {
         if(_none == null)
         {
            _none = new FeatureType("None",0,new DoNotInstantiate#84());
         }
         return _none;
      }
      
      public static function get ExtrasShop() : FeatureType
      {
         if(_extrasShop == null)
         {
            _extrasShop = new FeatureType("ExtrasShop",1,new DoNotInstantiate#84());
         }
         return _extrasShop;
      }
   }
}

class DoNotInstantiate#84
{
    
   
   function DoNotInstantiate#84()
   {
      super();
   }
}
