package com.goodgamestudios.mafia.constants.enums
{
   public class ExtraType extends ItemSubtype
   {
      
      private static var _container:ExtraType;
       
      
      public function ExtraType(param1:String, param2:uint, param3:DoNotInstantiate#85)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get Container() : ExtraType
      {
         if(_container == null)
         {
            _container = new ExtraType("Container",1,new DoNotInstantiate#85());
         }
         return _container;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

class DoNotInstantiate#85
{
    
   
   function DoNotInstantiate#85()
   {
      super();
   }
}
