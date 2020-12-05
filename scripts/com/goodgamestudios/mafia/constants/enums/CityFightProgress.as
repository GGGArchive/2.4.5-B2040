package com.goodgamestudios.mafia.constants.enums
{
   public class CityFightProgress extends BasicEnum
   {
      
      private static var _fight_unavailable:CityFightProgress;
      
      private static var _fight_available:CityFightProgress;
      
      private static var _fight_won:CityFightProgress;
      
      private static var _reward_taken:CityFightProgress;
       
      
      public function CityFightProgress(param1:String, param2:uint, param3:DoNotInstantiate#74)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get FightUnavailable() : CityFightProgress
      {
         if(_fight_unavailable == null)
         {
            _fight_unavailable = new CityFightProgress("FightUnavailable",1,new DoNotInstantiate#74());
         }
         return _fight_unavailable;
      }
      
      public static function get FightAvailable() : CityFightProgress
      {
         if(_fight_available == null)
         {
            _fight_available = new CityFightProgress("FightAvailable",2,new DoNotInstantiate#74());
         }
         return _fight_available;
      }
      
      public static function get FightWon() : CityFightProgress
      {
         if(_fight_won == null)
         {
            _fight_won = new CityFightProgress("FightWon",3,new DoNotInstantiate#74());
         }
         return _fight_won;
      }
      
      public static function get Reward_taken() : CityFightProgress
      {
         if(_reward_taken == null)
         {
            _reward_taken = new CityFightProgress("Reward_taken",4,new DoNotInstantiate#74());
         }
         return _reward_taken;
      }
   }
}

class DoNotInstantiate#74
{
    
   
   function DoNotInstantiate#74()
   {
      super();
   }
}
