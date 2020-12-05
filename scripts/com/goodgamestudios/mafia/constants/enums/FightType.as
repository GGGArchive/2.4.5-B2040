package com.goodgamestudios.mafia.constants.enums
{
   public class FightType extends BasicEnum
   {
      
      private static var _none:FightType;
      
      private static var _mission:FightType;
      
      private static var _duel:FightType;
      
      private static var _wanted:FightType;
      
      private static var _survival:FightType;
      
      private static var _clanwar:FightType;
      
      private static var _police:FightType;
      
      private static var _tournament:FightType;
      
      private static var _replay:FightType;
      
      private static var _gangwar:FightType;
       
      
      public function FightType(param1:String, param2:uint, param3:DoNotInstantiate#108)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : FightType
      {
         if(_none == null)
         {
            _none = new FightType("None",0,new DoNotInstantiate#108());
         }
         return _none;
      }
      
      public static function get Mission() : FightType
      {
         if(_mission == null)
         {
            _mission = new FightType("Mission",1,new DoNotInstantiate#108());
         }
         return _mission;
      }
      
      public static function get Duel() : FightType
      {
         if(_duel == null)
         {
            _duel = new FightType("Duel",2,new DoNotInstantiate#108());
         }
         return _duel;
      }
      
      public static function get Wanted() : FightType
      {
         if(_wanted == null)
         {
            _wanted = new FightType("Wanted",3,new DoNotInstantiate#108());
         }
         return _wanted;
      }
      
      public static function get Survival() : FightType
      {
         if(_survival == null)
         {
            _survival = new FightType("Survival",4,new DoNotInstantiate#108());
         }
         return _survival;
      }
      
      public static function get ClanWar() : FightType
      {
         if(_clanwar == null)
         {
            _clanwar = new FightType("ClanWar",5,new DoNotInstantiate#108());
         }
         return _clanwar;
      }
      
      public static function get Police() : FightType
      {
         if(_police == null)
         {
            _police = new FightType("Police",6,new DoNotInstantiate#108());
         }
         return _police;
      }
      
      public static function get Tournament() : FightType
      {
         if(_tournament == null)
         {
            _tournament = new FightType("Tournament",7,new DoNotInstantiate#108());
         }
         return _tournament;
      }
      
      public static function get Replay() : FightType
      {
         if(_replay == null)
         {
            _replay = new FightType("Replay",8,new DoNotInstantiate#108());
         }
         return _replay;
      }
      
      public static function get GangWar() : FightType
      {
         if(_gangwar == null)
         {
            _gangwar = new FightType("GangWar",9,new DoNotInstantiate#108());
         }
         return _gangwar;
      }
   }
}

class DoNotInstantiate#108
{
    
   
   function DoNotInstantiate#108()
   {
      super();
   }
}
