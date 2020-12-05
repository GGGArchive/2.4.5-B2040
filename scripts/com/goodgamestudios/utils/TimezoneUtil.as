package com.goodgamestudios.utils
{
   public class TimezoneUtil
   {
       
      
      public function TimezoneUtil()
      {
         super();
      }
      
      public static function getTrackingTimezone() : int
      {
         return Math.round(new Date().timezoneOffset * -1 / 60) + 13;
      }
      
      public static function getUTCTimezoneWithoutDST() : Number
      {
         return convertFlashTimezoneToUTCTimezone(getFlashTimezoneWithoutDST());
      }
      
      public static function getUTCTimezoneWithDST() : Number
      {
         return convertFlashTimezoneToUTCTimezone(getFlashTimezoneWithDST());
      }
      
      public static function getFlashTimezoneWithoutDST() : Number
      {
         var _loc1_:Number = new Date().fullYear;
         var _loc2_:Date = new Date(_loc1_,0,1);
         var _loc3_:Date = new Date(_loc1_,6,1);
         var _loc4_:Number = Math.max(_loc2_.timezoneOffset,_loc3_.timezoneOffset);
         return _loc4_;
      }
      
      public static function getFlashTimezoneWithDST() : Number
      {
         var _loc1_:Date = new Date();
         return _loc1_.timezoneOffset;
      }
      
      public static function getDST() : Number
      {
         var _loc1_:Number = getFlashTimezoneWithoutDST();
         var _loc2_:Number = new Date().timezoneOffset - _loc1_;
         return convertFlashTimezoneToUTCTimezone(_loc2_);
      }
      
      public static function hasDST() : Boolean
      {
         var _loc1_:Number = new Date().fullYear;
         var _loc2_:Date = new Date(_loc1_,0,1);
         var _loc3_:Date = new Date(_loc1_,6,1);
         return _loc2_.timezoneOffset != _loc3_.timezoneOffset;
      }
      
      public static function isDSTActive() : Boolean
      {
         var _loc1_:Number = getFlashTimezoneWithoutDST();
         var _loc2_:Number = new Date().timezoneOffset - _loc1_;
         return _loc2_ == 0?false:true;
      }
      
      public static function convertFlashTimezoneToUTCTimezone(param1:Number) : Number
      {
         return param1 / 60 * -1;
      }
      
      public static function convertUTCTimezoneToFlashTimezone(param1:int) : int
      {
         return param1 * 60 * -1;
      }
   }
}
