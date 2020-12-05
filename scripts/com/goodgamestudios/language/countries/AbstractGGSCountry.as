package com.goodgamestudios.language.countries
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.language.unicodeRanges.UnicodeRange;
   import com.goodgamestudios.language.unicodeRanges.UnicodeRegistry;
   
   public class AbstractGGSCountry
   {
       
      
      private var _ggsCountryCode:String = "";
      
      private var _browserLanguageCodes:Vector.<String>;
      
      private var _flashPlayerLanguageCode:String = "";
      
      private var _ggsLanguageCode:String = "";
      
      private var _utcTimezoneMin:Number = 0;
      
      private var _utcTimezoneMax:Number = 0;
      
      private var _useUnicodeRanges:Vector.<UnicodeRange>;
      
      private var _useNonLatinCharset:Boolean;
      
      public function AbstractGGSCountry()
      {
         this._browserLanguageCodes = new Vector.<String>();
         this._useUnicodeRanges = new Vector.<UnicodeRange>();
         super();
         this._useUnicodeRanges.push(UnicodeRegistry.BASIC_LATIN);
         this._useUnicodeRanges.push(UnicodeRegistry.LATIN_SUPPLEMENT);
      }
      
      public function usesUnicodeOrd(param1:int) : Boolean
      {
         var _loc3_:UnicodeRange = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in this._useUnicodeRanges)
         {
            if(param1 >= _loc3_.rangeOffset && param1 <= _loc3_.rangeEnd)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function addBrowserLanguageCodes(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = param1.substring(1,param1.length - 1);
         var _loc3_:Array = _loc2_.split(",");
         for each(_loc4_ in _loc3_)
         {
            this._browserLanguageCodes.push(StringUtil.trim(_loc4_));
         }
      }
      
      public function get useUnicodeRanges() : Vector.<UnicodeRange>
      {
         this._useNonLatinCharset = true;
         return this._useUnicodeRanges;
      }
      
      public function get useNonLatinCharset() : Boolean
      {
         return this._useNonLatinCharset;
      }
      
      public function set useNonLatinCharset(param1:Boolean) : void
      {
         this._useNonLatinCharset = param1;
      }
      
      public function get browserLanguageCodes() : Vector.<String>
      {
         return this._browserLanguageCodes;
      }
      
      public function get flashPlayerLanguageCode() : String
      {
         return this._flashPlayerLanguageCode;
      }
      
      public function set flashPlayerLanguageCode(param1:String) : void
      {
         this._flashPlayerLanguageCode = param1;
      }
      
      public function get ggsLanguageCode() : String
      {
         return this._ggsLanguageCode;
      }
      
      public function set ggsLanguageCode(param1:String) : void
      {
         this._ggsLanguageCode = param1;
      }
      
      public function get ggsCountryCode() : String
      {
         return this._ggsCountryCode;
      }
      
      public function set ggsCountryCode(param1:String) : void
      {
         this._ggsCountryCode = param1;
      }
      
      public function get utcTimezoneMin() : Number
      {
         return this._utcTimezoneMin;
      }
      
      public function set utcTimezoneMin(param1:Number) : void
      {
         this._utcTimezoneMin = param1;
      }
      
      public function get utcTimezoneMax() : Number
      {
         return this._utcTimezoneMax;
      }
      
      public function set utcTimezoneMax(param1:Number) : void
      {
         this._utcTimezoneMax = param1;
      }
      
      public function toString() : String
      {
         return "ggsCountryCode: " + this.ggsCountryCode + ", ggsLanguageCode: " + this._ggsLanguageCode + ", flashPlayerLanguageCode: " + this._flashPlayerLanguageCode + ", browserLanguageCodes: " + this._browserLanguageCodes + ", unicodeRanges: " + this._useUnicodeRanges + ", timeZoneOffset: from: " + this._utcTimezoneMin + " to: " + this._utcTimezoneMax;
      }
   }
}
