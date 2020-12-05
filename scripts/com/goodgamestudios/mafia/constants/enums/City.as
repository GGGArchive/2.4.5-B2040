package com.goodgamestudios.mafia.constants.enums
{
   public class City extends BasicEnum
   {
      
      private static var _none:City;
      
      private static var _newYork:City;
      
      private static var _miami:City;
      
      private static var _hongkong:City;
      
      private static var _sicily:City;
       
      
      public function City(param1:String, param2:int, param3:DoNotInstantiate#54)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : City
      {
         if(_none == null)
         {
            _none = new City("None",-1,new DoNotInstantiate#54());
         }
         return _none;
      }
      
      public static function get NewYork() : City
      {
         if(_newYork == null)
         {
            _newYork = new City("NewYork",0,new DoNotInstantiate#54());
         }
         return _newYork;
      }
      
      public static function get Miami() : City
      {
         if(_miami == null)
         {
            _miami = new City("Miami",1,new DoNotInstantiate#54());
         }
         return _miami;
      }
      
      public static function get Hongkong() : City
      {
         if(_hongkong == null)
         {
            _hongkong = new City("Hongkong",2,new DoNotInstantiate#54());
         }
         return _hongkong;
      }
      
      public static function get Sicily() : City
      {
         if(_sicily == null)
         {
            _sicily = new City("Sicily",3,new DoNotInstantiate#54());
         }
         return _sicily;
      }
   }
}

class DoNotInstantiate#54
{
    
   
   function DoNotInstantiate#54()
   {
      super();
   }
}
