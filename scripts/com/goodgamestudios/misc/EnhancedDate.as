package com.goodgamestudios.misc
{
   public class EnhancedDate
   {
       
      
      private var _date:Date;
      
      public function EnhancedDate()
      {
         this._date = new Date();
         super();
      }
      
      public function get date() : Date
      {
         return this._date;
      }
      
      public function getIntervalUTCTimestamp(param1:int) : int
      {
         var _loc2_:Number = Date.UTC(this._date.fullYearUTC,this._date.monthUTC,this._date.dateUTC,this._date.hoursUTC,this._date.minutesUTC,this._date.secondsUTC,this._date.millisecondsUTC);
         return int(_loc2_ / param1);
      }
      
      public function getUTCTimestamp() : Number
      {
         return Date.UTC(this._date.fullYearUTC,this._date.monthUTC,this._date.dateUTC,this._date.hoursUTC,this._date.minutesUTC,this._date.secondsUTC,this._date.millisecondsUTC);
      }
   }
}
