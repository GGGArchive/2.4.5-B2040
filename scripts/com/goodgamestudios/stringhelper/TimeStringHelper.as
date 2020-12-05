package com.goodgamestudios.stringhelper
{
   import com.goodgamestudios.math.MathBase;
   
   public class TimeStringHelper
   {
      
      public static const TWO_TIME_FORMAT:String = "nonMiliSec";
      
      public static const DATE_DAY_FORMAT:String = "dateDay";
      
      public static const DATE_DAY_FORMAT_WITHOUT_YEAR:String = "dateDayWithoutYear";
      
      public static const DATE_SHORT_DAY_FORMAT:String = "shortDay";
      
      public static const DATE_TIMEOCLOCK_FORMAT:String = "dateTimeOclock";
      
      public static const DATE_TIMEOCLOCK_FORMAT_ADVANCED:String = "dateTimeOclockAdvanced";
      
      public static const ONE_TIME_FORMAT:String = "onetime";
      
      public static const ONE_TIME_FORMAT_ADVANCED:String = "onetimeAdvanced";
      
      public static const ONE_TIME_HOURS_FORMAT:String = "onetimehour";
      
      public static const HOURS_MINUTES_SECONDS_FORMAT:String = "hoursMinutesSeconds";
       
      
      public function TimeStringHelper()
      {
         super();
      }
      
      public static function getShortTimeStringBySeconds(param1:Number, param2:String = "") : String
      {
         return getShortTimeString(param1 * 1000,param2);
      }
      
      public static function getShortTimeStringByMinutes(param1:Number, param2:String = "") : String
      {
         return getShortTimeString(param1 * 1000 * 60,param2);
      }
      
      public static function getShortTimeString(param1:Number, param2:String = "") : String
      {
         if(param1 <= 0)
         {
            return "-";
         }
         var _loc3_:int = param1 / 1000;
         var _loc4_:int = _loc3_ / 60;
         var _loc5_:int = _loc4_ / 60;
         var _loc6_:* = "";
         _loc3_ = _loc3_ - _loc4_ * 60;
         _loc4_ = _loc4_ - _loc5_ * 60;
         _loc6_ = _loc6_ + addLeadingZero(_loc4_);
         if(param2 == TWO_TIME_FORMAT && _loc5_ == 0 || param2 != TWO_TIME_FORMAT)
         {
            _loc6_ = _loc6_ + ":";
            _loc6_ = _loc6_ + addLeadingZero(_loc3_);
         }
         if(_loc5_ > 0 || param2 == HOURS_MINUTES_SECONDS_FORMAT)
         {
            _loc6_ = addLeadingZero(_loc5_) + ":" + _loc6_;
         }
         return _loc6_;
      }
      
      public static function getHoureMinutesTimeString(param1:Number) : String
      {
         if(param1 <= 0)
         {
            return "-";
         }
         var _loc2_:int = param1 / 60;
         var _loc3_:int = _loc2_ / 60;
         var _loc4_:* = "";
         _loc2_ = _loc2_ - _loc3_ * 60;
         if(_loc2_ < 10)
         {
            _loc4_ = _loc4_ + "0";
         }
         _loc4_ = _loc4_ + _loc2_;
         _loc4_ = _loc3_ + ":" + _loc4_;
         return _loc4_;
      }
      
      public static function getHoureMinuteSecondTimeString(param1:Number) : String
      {
         if(param1 <= 0)
         {
            return "00:00:00";
         }
         var _loc2_:int = param1 % 60;
         var _loc3_:int = param1 / 60 % 60;
         var _loc4_:int = param1 / (60 * 60);
         var _loc5_:String = "";
         _loc5_ = _loc5_ + ((_loc4_ < 10?"0":"") + _loc4_);
         _loc5_ = _loc5_ + (":" + (_loc3_ < 10?"0":"") + _loc3_);
         _loc5_ = _loc5_ + (":" + (_loc2_ < 10?"0":"") + _loc2_);
         return _loc5_;
      }
      
      public static function getDateToString(param1:Number, param2:String, param3:Function) : String
      {
         if(param1 <= 0)
         {
            return "-";
         }
         var _loc4_:* = "";
         var _loc5_:Date = new Date();
         _loc5_.time = param1;
         if(param2 == DATE_DAY_FORMAT_WITHOUT_YEAR)
         {
            return _loc4_ = _loc5_.getDate() + "." + (_loc5_.getMonth() + 1);
         }
         if(param2 == DATE_DAY_FORMAT)
         {
            return _loc4_ = _loc5_.getDate() + "." + (_loc5_.getMonth() + 1) + "." + _loc5_.getFullYear();
         }
         if(param2 == DATE_SHORT_DAY_FORMAT)
         {
            return param3("generic_dayformat_short",[_loc5_.getDate() < 10?"0" + _loc5_.getDate():_loc5_.getDate().toString(),_loc5_.getMonth() + 1 < 10?"0" + (_loc5_.getMonth() + 1):(_loc5_.getMonth() + 1).toString()]);
         }
         if(param2 == DATE_TIMEOCLOCK_FORMAT)
         {
            _loc4_ = _loc4_ + (_loc5_.getHours() + ".");
            if(_loc5_.getMinutes() < 10)
            {
               _loc4_ = _loc4_ + "0";
            }
            _loc4_ = _loc4_ + _loc5_.getMinutes();
         }
         if(param2 == DATE_TIMEOCLOCK_FORMAT_ADVANCED)
         {
            if(_loc5_.getHours() < 10)
            {
               _loc4_ = _loc4_ + "0";
            }
            _loc4_ = _loc4_ + (_loc5_.getHours() + ":");
            if(_loc5_.getMinutes() < 10)
            {
               _loc4_ = _loc4_ + "0";
            }
            _loc4_ = _loc4_ + _loc5_.getMinutes();
         }
         return _loc4_ + param3("timeformat_clock");
      }
      
      private static function multiOrShortTimeString(param1:String, param2:int, param3:Boolean) : String
      {
         var _loc4_:* = param1;
         if(param3)
         {
            _loc4_ = _loc4_ + "_short";
         }
         else
         {
            _loc4_ = _loc4_ + (param2 != 1?"s":"");
         }
         return _loc4_;
      }
      
      public static function getTimeToString(param1:Number, param2:String, param3:Function, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : String
      {
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         if(param1 <= 0)
         {
            return "-";
         }
         if(param7 && !param5)
         {
            param1 = roundTimeToNextHour(param1);
         }
         var _loc8_:Number = param1 * 1000;
         var _loc9_:int = _loc8_ / 1000;
         var _loc10_:int = _loc9_ / 60;
         var _loc11_:int = _loc10_ / 60;
         var _loc12_:int = _loc11_ / 24;
         var _loc13_:int = _loc12_ / 30;
         var _loc14_:String = "";
         var _loc15_:String = "";
         _loc8_ = _loc8_ - _loc9_ * 1000;
         _loc9_ = _loc9_ - _loc10_ * 60;
         _loc10_ = _loc10_ - _loc11_ * 60;
         if(param2 != ONE_TIME_HOURS_FORMAT)
         {
            _loc11_ = _loc11_ - _loc12_ * 24;
            _loc12_ = _loc12_ - _loc13_ * 30;
         }
         if(param2 != ONE_TIME_HOURS_FORMAT && _loc13_ > 0)
         {
            _loc15_ = multiOrShortTimeString("generic_month",_loc13_,param5);
            _loc14_ = _loc13_ + " " + param3(_loc15_);
            if(param2 == ONE_TIME_FORMAT_ADVANCED)
            {
               _loc16_ = MathBase.round(_loc12_ / 30,1) + _loc13_;
               _loc15_ = multiOrShortTimeString("generic_month",_loc16_,param5);
               return _loc16_ + " " + param3(_loc15_);
            }
            if(param2 == ONE_TIME_FORMAT)
            {
               return _loc14_;
            }
         }
         if(param2 != ONE_TIME_HOURS_FORMAT && _loc12_ > 0)
         {
            _loc15_ = multiOrShortTimeString("generic_day",_loc12_,param5);
            if(_loc14_.length > 0)
            {
               _loc14_ = _loc14_ + (!!param4?"\n":" ");
            }
            _loc14_ = _loc14_ + (_loc12_ + " " + param3(_loc15_));
            if(param2 == ONE_TIME_FORMAT_ADVANCED)
            {
               _loc16_ = MathBase.round(_loc11_ / 24,1) + _loc12_;
               _loc15_ = multiOrShortTimeString("generic_day",_loc16_,param5);
               return _loc16_ + " " + param3(_loc15_);
            }
            if(param2 == ONE_TIME_FORMAT)
            {
               return _loc14_;
            }
            if(_loc13_ > 0)
            {
               return _loc14_;
            }
         }
         if(_loc11_ > 0)
         {
            if(param6 && _loc12_ > 0)
            {
               _loc17_ = MathBase.floor(_loc10_ / 60,1);
               if(_loc17_ >= 1)
               {
                  _loc11_++;
               }
               else if(_loc17_ > 0)
               {
                  return _loc14_ + " " + _loc11_ + param3("generic_comma") + _loc17_.toString().substr(_loc17_.toString().indexOf(".") + 1) + " " + param3("generic_hours");
               }
            }
            _loc15_ = multiOrShortTimeString("generic_hour",_loc11_,param5);
            if(_loc14_.length > 0)
            {
               _loc14_ = _loc14_ + (!!param4?"\n":" ");
            }
            _loc14_ = _loc14_ + (_loc11_ + " " + param3(_loc15_));
            if(param2.indexOf("onetime") >= 0 || param2 == TWO_TIME_FORMAT && _loc12_ > 0)
            {
               return _loc14_;
            }
         }
         if(_loc10_ > 0)
         {
            _loc15_ = multiOrShortTimeString("generic_minute",_loc10_,param5);
            if(_loc14_.length > 0)
            {
               _loc14_ = _loc14_ + (!!param4?"\n":" ");
            }
            _loc14_ = _loc14_ + (_loc10_ + " " + param3(_loc15_));
            if(param2.indexOf("onetime") >= 0 || param2 == TWO_TIME_FORMAT && (_loc11_ > 0 || _loc12_ > 0))
            {
               return _loc14_;
            }
         }
         else if(param2 == TWO_TIME_FORMAT && _loc14_ != "")
         {
            return _loc14_;
         }
         if(_loc9_ > 0)
         {
            _loc15_ = multiOrShortTimeString("generic_second",_loc9_,param5);
            if(_loc14_.length > 0)
            {
               _loc14_ = _loc14_ + (!!param4?"\n":" ");
            }
            _loc14_ = _loc14_ + (_loc9_ + " " + param3(_loc15_));
         }
         return _loc14_;
      }
      
      private static function roundTimeToNextHour(param1:Number) : Number
      {
         var _loc2_:Number = 60 * 60;
         if(param1 > _loc2_)
         {
            param1 = param1 + _loc2_ * 0.5;
         }
         return param1;
      }
      
      private static function addLeadingZero(param1:Number) : String
      {
         var _loc2_:String = String(param1);
         if(param1 < 10)
         {
            _loc2_ = "0" + param1;
         }
         return _loc2_;
      }
      
      public static function getDateStringFromDate(param1:Date, param2:Function) : String
      {
         return param2("generic_dayformat",[param1.getDate(),param1.getMonth() + 1,param1.getFullYear()]);
      }
      
      public static function getTimeStringFromDate(param1:Date, param2:Function) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.getHours() < 10)
         {
            _loc3_ = "0" + param1.getHours();
         }
         else
         {
            _loc3_ = String(param1.getHours());
         }
         if(param1.getMinutes() < 10)
         {
            _loc4_ = "0" + param1.getMinutes();
         }
         else
         {
            _loc4_ = String(param1.getMinutes());
         }
         return _loc3_ + ":" + _loc4_;
      }
      
      public static function getCommaTimeStringFromSeconds(param1:int, param2:Function, param3:String = "") : String
      {
         var _loc15_:Number = NaN;
         if(param1 <= 0)
         {
            return "-";
         }
         var _loc4_:Number = param1 * 1000;
         var _loc5_:int = _loc4_ / 1000;
         var _loc6_:int = _loc5_ / 60;
         var _loc7_:int = _loc6_ / 60;
         var _loc8_:int = _loc7_ / 24;
         var _loc9_:int = _loc8_ / 30;
         var _loc10_:int = _loc9_;
         var _loc11_:int = _loc8_ - _loc9_ * 30;
         var _loc12_:int = _loc7_ - _loc8_ * 24;
         var _loc13_:int = _loc6_ - _loc7_ * 60;
         var _loc14_:int = _loc5_ - _loc6_ * 60;
         if(_loc10_ > 0)
         {
            _loc15_ = MathBase.ceil(_loc11_ / 30,1);
            if(_loc15_ >= 1)
            {
               _loc10_++;
            }
            else if(_loc15_ > 0)
            {
               return _loc10_ + param2("generic_comma") + _loc15_.toString().substr(_loc15_.toString().indexOf(".") + 1) + " " + param2("generic_months");
            }
            return _loc10_ + " " + param2(multiOrShortTimeString("generic_month",_loc10_,false));
         }
         if(_loc11_ > 0)
         {
            _loc15_ = MathBase.ceil(_loc12_ / 24,1);
            if(_loc15_ >= 1)
            {
               _loc11_++;
            }
            else if(_loc15_ > 0)
            {
               return _loc11_ + param2("generic_comma") + _loc15_.toString().substr(_loc15_.toString().indexOf(".") + 1) + " " + param2("generic_days");
            }
            return _loc11_ + " " + param2(multiOrShortTimeString("generic_day",_loc11_,false));
         }
         if(param3 == HOURS_MINUTES_SECONDS_FORMAT)
         {
            return getShortTimeString(_loc4_,HOURS_MINUTES_SECONDS_FORMAT);
         }
         if(_loc12_ > 0)
         {
            _loc15_ = MathBase.ceil(_loc13_ / 60,1);
            if(_loc15_ >= 1)
            {
               _loc12_++;
            }
            else if(_loc15_ > 0)
            {
               return _loc12_ + param2("generic_comma") + _loc15_.toString().substr(_loc15_.toString().indexOf(".") + 1) + " " + param2("generic_hours");
            }
            return _loc12_ + " " + param2(multiOrShortTimeString("generic_hour",_loc12_,false));
         }
         if(_loc13_ > 0)
         {
            return _loc13_ + " " + param2(multiOrShortTimeString("generic_minute",_loc13_,false));
         }
         if(_loc14_ > 0)
         {
            return _loc14_ + " " + param2(multiOrShortTimeString("generic_second",_loc14_,false));
         }
         return "";
      }
      
      public static function getPrimeTimeToString(param1:Number, param2:Function) : String
      {
         if(param1 <= 0)
         {
            return "-";
         }
         var _loc3_:int = param1;
         var _loc4_:int = _loc3_ / 60;
         var _loc5_:String = "";
         var _loc6_:String = "";
         _loc3_ = _loc3_ - _loc4_ * 60;
         if(_loc4_ > 0)
         {
            _loc6_ = multiOrShortTimeString("generic_minute",_loc4_,false);
            _loc5_ = _loc5_ + (_loc4_ + " " + param2(_loc6_));
            return _loc5_;
         }
         _loc6_ = multiOrShortTimeString("generic_second",_loc3_,false);
         _loc5_ = _loc5_ + (_loc3_ + " " + param2(_loc6_));
         return _loc5_;
      }
      
      public static function getTextIdFormattedTimeString(param1:Number, param2:String, param3:String, param4:Function) : String
      {
         var _loc5_:int = Math.floor(param1 / (60 * 60 * 24));
         var _loc6_:int = param1 / 60 % 60;
         var _loc7_:int = param1 / (60 * 60) % 24;
         if(_loc5_ == 0)
         {
            return param4(param3,[_loc7_,_loc6_]);
         }
         return param4(param2,[_loc5_,_loc7_,_loc6_]);
      }
   }
}
