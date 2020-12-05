package com.goodgamestudios.mafia.constants.enums
{
   public class CharacterGender extends BasicEnum
   {
      
      private static var _none:CharacterGender;
      
      private static var _female:CharacterGender;
      
      private static var _male:CharacterGender;
       
      
      public function CharacterGender(param1:String, param2:uint, param3:DoNotInstantiate#58)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : CharacterGender
      {
         if(_none == null)
         {
            _none = new CharacterGender("None",0,new DoNotInstantiate#58());
         }
         return _none;
      }
      
      public static function get Female() : CharacterGender
      {
         if(_female == null)
         {
            _female = new CharacterGender("Female",1,new DoNotInstantiate#58());
         }
         return _female;
      }
      
      public static function get Male() : CharacterGender
      {
         if(_male == null)
         {
            _male = new CharacterGender("Male",2,new DoNotInstantiate#58());
         }
         return _male;
      }
      
      public static function getById(param1:int) : CharacterGender
      {
         if(param1 == 1)
         {
            return Female;
         }
         if(param1 == 2)
         {
            return Male;
         }
         return None;
      }
   }
}

class DoNotInstantiate#58
{
    
   
   function DoNotInstantiate#58()
   {
      super();
   }
}
