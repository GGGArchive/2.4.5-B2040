package com.goodgamestudios.language.countryMapper
{
   public class CountryDetectionVO
   {
       
      
      public var browserLanguage:String;
      
      public var flashplayerLanguage:String;
      
      public var timezoneOffset:Number;
      
      public var countryByNetworkCookie:String;
      
      public var countryByFlashvar:String;
      
      public var countryByInstance:String;
      
      public var fakeGeoIpResponse:String = null;
      
      public function CountryDetectionVO(param1:String, param2:String, param3:Number, param4:String = "", param5:String = "", param6:String = "")
      {
         super();
         this.browserLanguage = param1;
         this.flashplayerLanguage = param2;
         if(isNaN(param3))
         {
            param3 = 0;
         }
         this.timezoneOffset = param3;
         this.countryByNetworkCookie = param4;
         this.countryByFlashvar = param5;
         this.countryByInstance = param6;
      }
      
      public function toString() : String
      {
         return !!("browserLanguage: " + this.browserLanguage + ", flashplayerLanguage: " + this.flashplayerLanguage + ", timezoneOffset: " + this.timezoneOffset + ", countryByNetworkCookie: " + this.countryByNetworkCookie + ", countryByFlashvar: " + this.countryByFlashvar + ", countryByInstance: " + this.countryByInstance + (this.fakeGeoIpResponse != null))?", geoIpResponse: " + this.fakeGeoIpResponse:"";
      }
   }
}
