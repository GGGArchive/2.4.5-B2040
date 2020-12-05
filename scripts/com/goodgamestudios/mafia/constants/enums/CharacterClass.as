package com.goodgamestudios.mafia.constants.enums
{
   import com.goodgamestudios.math.Random;
   
   public class CharacterClass extends BasicEnum
   {
      
      private static var _none:CharacterClass;
      
      private static var _bully:CharacterClass;
      
      private static var _rogue:CharacterClass;
      
      private static var _tactician:CharacterClass;
       
      
      public function CharacterClass(param1:String, param2:uint, param3:DoNotInstantiate#57)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : CharacterClass
      {
         if(_none == null)
         {
            _none = new CharacterClass("None",0,new DoNotInstantiate#57());
         }
         return _none;
      }
      
      public static function get Bully() : CharacterClass
      {
         if(_bully == null)
         {
            _bully = new CharacterClass("Bully",1,new DoNotInstantiate#57());
         }
         return _bully;
      }
      
      public static function get Rogue() : CharacterClass
      {
         if(_rogue == null)
         {
            _rogue = new CharacterClass("Rogue",2,new DoNotInstantiate#57());
         }
         return _rogue;
      }
      
      public static function get Tactician() : CharacterClass
      {
         if(_tactician == null)
         {
            _tactician = new CharacterClass("Tactician",3,new DoNotInstantiate#57());
         }
         return _tactician;
      }
      
      public static function getById(param1:int) : CharacterClass
      {
         var _loc2_:CharacterClass = null;
         switch(param1)
         {
            case 1:
               _loc2_ = Bully;
               break;
            case 2:
               _loc2_ = Rogue;
               break;
            case 3:
               _loc2_ = Tactician;
               break;
            default:
               _loc2_ = None;
         }
         return _loc2_;
      }
      
      public static function getRandom() : CharacterClass
      {
         return getById(Random.integer(1,4));
      }
   }
}

class DoNotInstantiate#57
{
    
   
   function DoNotInstantiate#57()
   {
      super();
   }
}
