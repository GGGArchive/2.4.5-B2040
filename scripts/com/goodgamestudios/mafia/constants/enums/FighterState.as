package com.goodgamestudios.mafia.constants.enums
{
   public class FighterState extends BasicEnum
   {
      
      private static var _none:FighterState;
      
      private static var _ready:FighterState;
      
      private static var _lost:FighterState;
      
      private static var _left:FighterState;
      
      private static var _won:FighterState;
      
      private static var _freecard:FighterState;
       
      
      public function FighterState(param1:String, param2:uint, param3:DoNotInstantiate#73)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : FighterState
      {
         if(_none == null)
         {
            _none = new FighterState("None",0,new DoNotInstantiate#73());
         }
         return _none;
      }
      
      public static function get Ready() : FighterState
      {
         if(_ready == null)
         {
            _ready = new FighterState("Ready",1,new DoNotInstantiate#73());
         }
         return _ready;
      }
      
      public static function get Lost() : FighterState
      {
         if(_lost == null)
         {
            _lost = new FighterState("Lost",2,new DoNotInstantiate#73());
         }
         return _lost;
      }
      
      public static function get Left() : FighterState
      {
         if(_left == null)
         {
            _left = new FighterState("Left",3,new DoNotInstantiate#73());
         }
         return _left;
      }
      
      public static function get Won() : FighterState
      {
         if(_won == null)
         {
            _won = new FighterState("Won",4,new DoNotInstantiate#73());
         }
         return _won;
      }
      
      public static function get Freecard() : FighterState
      {
         if(_freecard == null)
         {
            _freecard = new FighterState("Freecard",5,new DoNotInstantiate#73());
         }
         return _freecard;
      }
   }
}

class DoNotInstantiate#73
{
    
   
   function DoNotInstantiate#73()
   {
      super();
   }
}
