package com.goodgamestudios.mafia.constants.enums
{
   public class ConsumableType extends ItemSubtype
   {
      
      private static var _ammunition:ConsumableType;
      
      private static var _surprise:ConsumableType;
      
      private static var _healing:ConsumableType;
      
      private static var _action:ConsumableType;
       
      
      public function ConsumableType(param1:String, param2:uint, param3:DoNotInstantiate#75)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get Ammunition() : ConsumableType
      {
         if(_ammunition == null)
         {
            _ammunition = new ConsumableType("Ammunition",1,new DoNotInstantiate#75());
         }
         return _ammunition;
      }
      
      public static function get Surprise() : ConsumableType
      {
         if(_surprise == null)
         {
            _surprise = new ConsumableType("Surprise",2,new DoNotInstantiate#75());
         }
         return _surprise;
      }
      
      public static function get Healing() : ConsumableType
      {
         if(_healing == null)
         {
            _healing = new ConsumableType("Healing",3,new DoNotInstantiate#75());
         }
         return _healing;
      }
      
      public static function get Action() : ConsumableType
      {
         if(_action == null)
         {
            _action = new ConsumableType("Action",4,new DoNotInstantiate#75());
         }
         return _action;
      }
   }
}

class DoNotInstantiate#75
{
    
   
   function DoNotInstantiate#75()
   {
      super();
   }
}
