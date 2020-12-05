package com.goodgamestudios.mafia.constants
{
   public class Constants_SpecialEvents
   {
      
      public static const ID_NIGHT_OF_HORROR:int = 10;
      
      public static const ID_SICILIAN:int = 20;
      
      public static const ID_CALENDAR:int = 30;
      
      public static const ID_TOURNAMENT:int = 40;
      
      public static const ID_BREAKING_THE_LAW:int = 50;
      
      public static const ID_LUCKY_DEVIL:int = 60;
      
      public static const ID_EDDY_FROST:int = 70;
      
      public static const ID_CAPO_VITO:int = 80;
      
      public static const SICILIAN_DUNGEONENEMIES:int = 5;
      
      public static const CAPO_VITO_COUNTDOWN_TIME:int = 3600;
      
      public static const SICILIAN_COUNTDOWN_TIME:int = 3600;
      
      public static const CALENDAR_COUNTDOWN_TIME:int = 3600;
      
      public static const BREAKING_THE_LAW_TIME:int = 3600;
      
      public static const CAPO_VITO_PIC_ID:int = 99;
      
      public static const NIGHT_OF_HORROR_PIC_ID:int = 19;
      
      private static var _sicilian_formular:int = 0;
      
      private static var _sicilian_factor:Number = 0;
       
      
      public function Constants_SpecialEvents()
      {
         super();
      }
      
      public static function getFakeAvailableMissionAmount(param1:Number, param2:Array, param3:Number) : Number
      {
         var _loc6_:Number = NaN;
         param2.sort(sortOnSeconds);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            if(_loc5_ == param2.length - 1)
            {
               setScicilian_formular(param2[_loc5_][1],param3,param1);
               _loc4_ = param2[_loc5_][1];
            }
            else if(param1 < param2[_loc5_][0] && param1 > param2[_loc5_ + 1][0])
            {
               setScicilian_formular(param2[_loc5_][1],param3,param1);
               _loc4_ = param2[_loc5_][1];
               break;
            }
            _loc5_++;
         }
         switch(_loc4_)
         {
            case 1:
               _loc6_ = formular1FakeAvailableMissions(param1,param3);
               break;
            case 2:
               _loc6_ = formular2FakeAvailableMissions(param1,param3);
               break;
            default:
               _loc6_ = 0;
         }
         return _loc6_;
      }
      
      private static function sortOnSeconds(param1:Array, param2:Array) : Number
      {
         if(param1[0] < param2[0])
         {
            return 1;
         }
         if(param1[0] > param2[0])
         {
            return -1;
         }
         return 0;
      }
      
      private static function formular1FakeAvailableMissions(param1:Number, param2:Number) : Number
      {
         return Math.max(param1 * _sicilian_factor * (param1 * _sicilian_factor),1);
      }
      
      private static function formular2FakeAvailableMissions(param1:Number, param2:Number) : Number
      {
         return Math.max(Math.sqrt(param1 * _sicilian_factor),1);
      }
      
      private static function setScicilian_formular(param1:int, param2:Number, param3:Number) : void
      {
         if(_sicilian_formular != param1)
         {
            updateFaktor(param1,param2,param3);
         }
         _sicilian_formular = param1;
      }
      
      private static function updateFaktor(param1:int, param2:Number, param3:Number) : void
      {
         switch(param1)
         {
            case 1:
               _sicilian_factor = Math.sqrt(param2) / param3;
               break;
            case 2:
               _sicilian_factor = param2 * param2 / param3;
         }
      }
   }
}
