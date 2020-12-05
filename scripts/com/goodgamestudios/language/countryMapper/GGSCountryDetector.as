package com.goodgamestudios.language.countryMapper
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countries.CountryUnicodeRangeMapper;
   import com.goodgamestudios.math.Random;
   import com.goodgamestudios.net.Base64;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.Timer;
   
   public class GGSCountryDetector extends EventDispatcher
   {
       
      
      private var _ggsCountryController:GGSCountryController;
      
      private var _countryXML:XML;
      
      private var lastCountryDetectionVO:CountryDetectionVO;
      
      private var countriesFilteredByLanguage:Vector.<AbstractGGSCountry>;
      
      private var countriesFilteredByLanguageAndTimezone:Vector.<AbstractGGSCountry>;
      
      private const FLASH_LANGUAGE_CODE_UNKNOWN:String = "xu";
      
      private const GEO_IP_SERVER_URL:String = "http://i2c.goodgamestudios.com";
      
      private const GEO_IP_RESPONSE_TIMEOUT:uint = 3000;
      
      private var isWaitingForGeoIpResponse:Boolean;
      
      private var geoIpUrlLoader:URLLoader;
      
      private var geoIpTimeoutTimer:Timer;
      
      public function GGSCountryDetector()
      {
         super();
         this._ggsCountryController = GGSCountryController.instance;
      }
      
      public function loadCountryXML(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(Event.COMPLETE,this.onCountryXMLLoadingComplete);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onCountryXMLIOError);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCountryXMLSecurityError);
         _loc3_.load(_loc2_);
      }
      
      private function onCountryXMLLoadingComplete(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            this._countryXML = XML(URLLoader(event.currentTarget).data);
         }
         catch(e:Error)
         {
            return;
         }
         this.parseCountryXML();
         dispatchEvent(new CountryDetectionEvent(CountryDetectionEvent.LOAD_COUNTRIES_COMPLETE));
      }
      
      private function parseCountryXML() : void
      {
         var _loc2_:XML = null;
         var _loc3_:AbstractGGSCountry = null;
         var _loc1_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         for each(_loc2_ in this._countryXML.children())
         {
            _loc3_ = new AbstractGGSCountry();
            _loc3_.ggsCountryCode = _loc2_.country;
            _loc3_.addBrowserLanguageCodes(_loc2_.browserCodes);
            _loc3_.flashPlayerLanguageCode = _loc2_.flashCode && _loc2_.flashCode != ""?_loc2_.flashCode:this.FLASH_LANGUAGE_CODE_UNKNOWN;
            _loc3_.ggsLanguageCode = _loc2_.lang;
            _loc3_.utcTimezoneMin = parseInt(_loc2_.timezoneStart);
            _loc3_.utcTimezoneMax = parseInt(_loc2_.timezoneEnd);
            CountryUnicodeRangeMapper.instance.addUnicodeRanges(_loc3_);
            _loc1_.push(_loc3_);
         }
         GGSCountryController.instance.initAvailableCountriesLoaded(_loc1_);
      }
      
      private function onCountryXMLSecurityError(param1:SecurityErrorEvent) : void
      {
      }
      
      private function onCountryXMLIOError(param1:IOErrorEvent) : void
      {
      }
      
      public function detectCountry(param1:CountryDetectionVO) : void
      {
         this.countriesFilteredByLanguage = null;
         this.countriesFilteredByLanguageAndTimezone = null;
         this.lastCountryDetectionVO = param1;
         if(param1.countryByInstance && param1.countryByInstance != "default" && param1.countryByInstance != "")
         {
            GGSCountryController.instance.selectedCountry = param1.countryByInstance;
            this.detectionComplete();
         }
         else if(param1.countryByNetworkCookie && param1.countryByNetworkCookie != "")
         {
            GGSCountryController.instance.selectedCountry = param1.countryByNetworkCookie;
            this.detectionComplete();
         }
         else if(GGSCountryController.instance.isCountryCodeAvailable(param1.countryByFlashvar))
         {
            GGSCountryController.instance.selectedCountry = param1.countryByFlashvar;
            this.detectionComplete();
         }
         else if(GGSCountryController.instance.isBrowserLanguageAvailable(param1.browserLanguage))
         {
            this.detectCountryByLanguageAndTimezone(param1.browserLanguage,LanguageIdentifierType.BROWSER_LANGUAGE,param1.timezoneOffset);
         }
         else if(param1.flashplayerLanguage != this.FLASH_LANGUAGE_CODE_UNKNOWN)
         {
            this.detectCountryByLanguageAndTimezone(param1.flashplayerLanguage,LanguageIdentifierType.FLASH_PLAYER_LANGUAGE,param1.timezoneOffset);
         }
         else
         {
            this.requestGeoIp();
         }
      }
      
      private function checkGeoIpCountry(param1:String) : void
      {
         if(GGSCountryController.instance.isCountryCodeAvailable(param1))
         {
            GGSCountryController.instance.selectedCountry = param1;
            this.detectionComplete();
         }
         else
         {
            this.detectCountryFallback(this.lastCountryDetectionVO);
         }
      }
      
      private function detectCountryFallback(param1:CountryDetectionVO) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AbstractGGSCountry = null;
         if(this.countriesFilteredByLanguageAndTimezone != null && this.countriesFilteredByLanguageAndTimezone.length > 0)
         {
            _loc2_ = Random.integer(0,this.countriesFilteredByLanguageAndTimezone.length);
            GGSCountryController.instance.selectedCountry = this.countriesFilteredByLanguageAndTimezone[_loc2_].ggsCountryCode;
         }
         else if(this.countriesFilteredByLanguage != null && this.countriesFilteredByLanguage.length > 0)
         {
            _loc3_ = this.getNearestCountryByTimezone(this.countriesFilteredByLanguage,param1.timezoneOffset);
            GGSCountryController.instance.selectedCountry = _loc3_.ggsCountryCode;
         }
         else
         {
            GGSCountryController.instance.selectedCountry = "default";
         }
         this.detectionComplete();
      }
      
      private function getNearestCountryByTimezone(param1:Vector.<AbstractGGSCountry>, param2:Number) : AbstractGGSCountry
      {
         var _loc5_:AbstractGGSCountry = null;
         var _loc6_:Number = NaN;
         var _loc3_:AbstractGGSCountry = null;
         var _loc4_:Number = Number.POSITIVE_INFINITY;
         for each(_loc5_ in param1)
         {
            if(param2 >= _loc5_.utcTimezoneMax)
            {
               _loc6_ = param2 - _loc5_.utcTimezoneMax;
               if(_loc6_ < _loc4_)
               {
                  _loc3_ = _loc5_;
                  _loc4_ = _loc6_;
               }
            }
            else if(param2 <= _loc5_.utcTimezoneMin)
            {
               _loc6_ = _loc5_.utcTimezoneMin - param2;
               if(_loc6_ < _loc4_)
               {
                  _loc3_ = _loc5_;
                  _loc4_ = _loc6_;
               }
            }
         }
         return _loc3_;
      }
      
      private function detectCountryByLanguageAndTimezone(param1:String, param2:int, param3:Number) : void
      {
         this.countriesFilteredByLanguage = this.filterCountryListByLanguage(GGSCountryController.instance.availableCountries,param1,param2);
         switch(this.countriesFilteredByLanguage.length)
         {
            case 0:
               this.requestGeoIp();
               break;
            case 1:
               GGSCountryController.instance.selectedCountry = this.countriesFilteredByLanguage[0].ggsCountryCode;
               this.detectionComplete();
               break;
            default:
               this.countriesFilteredByLanguageAndTimezone = this.filterCountryListByTimezone(this.countriesFilteredByLanguage,param3);
               if(this.countriesFilteredByLanguageAndTimezone.length == 1)
               {
                  GGSCountryController.instance.selectedCountry = this.countriesFilteredByLanguageAndTimezone[0].ggsCountryCode;
                  this.detectionComplete();
               }
               else
               {
                  this.requestGeoIp();
               }
         }
      }
      
      private function detectionComplete() : void
      {
         dispatchEvent(new CountryDetectionEvent(CountryDetectionEvent.COUNTRY_DETECTION_COMPLETE));
      }
      
      private function requestGeoIp() : void
      {
         var _loc1_:URLRequest = null;
         if(this.lastCountryDetectionVO.fakeGeoIpResponse != null)
         {
            this.checkGeoIpCountry(this.lastCountryDetectionVO.fakeGeoIpResponse);
         }
         else
         {
            if(this.geoIpUrlLoader == null)
            {
               this.geoIpUrlLoader = new URLLoader();
            }
            _loc1_ = new URLRequest(this.GEO_IP_SERVER_URL);
            _loc1_.method = URLRequestMethod.GET;
            this.geoIpUrlLoader.addEventListener(Event.COMPLETE,this.onGeoIpResponse);
            this.geoIpUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onGeoIpFailure);
            this.geoIpUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGeoIpFailure);
            this.geoIpUrlLoader.load(_loc1_);
            if(this.geoIpTimeoutTimer == null)
            {
               this.geoIpTimeoutTimer = new Timer(this.GEO_IP_RESPONSE_TIMEOUT,1);
            }
            this.geoIpTimeoutTimer.addEventListener(TimerEvent.TIMER,this.onGeoIpFailure);
            this.geoIpTimeoutTimer.start();
            this.isWaitingForGeoIpResponse = true;
         }
      }
      
      private function onGeoIpResponse(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         var _loc3_:String = _loc2_.data as String;
         var _loc4_:String = Base64.decode(this.bytesToAsciiString(this.hexStringToBytes(_loc3_)));
         this.checkGeoIpCountry(_loc4_);
         if(this.geoIpTimeoutTimer != null)
         {
            this.geoIpTimeoutTimer.removeEventListener(TimerEvent.TIMER,this.onGeoIpFailure);
         }
         this.removeLoaderListeners();
         this.isWaitingForGeoIpResponse = false;
      }
      
      private function onGeoIpFailure(param1:Event) : void
      {
         if(this.isWaitingForGeoIpResponse)
         {
            this.detectCountryFallback(this.lastCountryDetectionVO);
            if(this.geoIpTimeoutTimer != null)
            {
               this.geoIpTimeoutTimer.removeEventListener(TimerEvent.TIMER,this.onGeoIpFailure);
            }
            this.removeLoaderListeners();
            this.isWaitingForGeoIpResponse = false;
         }
      }
      
      private function removeLoaderListeners() : void
      {
         if(this.geoIpUrlLoader != null)
         {
            this.geoIpUrlLoader.removeEventListener(Event.COMPLETE,this.onGeoIpResponse);
            this.geoIpUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onGeoIpFailure);
            this.geoIpUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGeoIpFailure);
         }
      }
      
      private function filterCountryListByLanguage(param1:Vector.<AbstractGGSCountry>, param2:String, param3:int) : Vector.<AbstractGGSCountry>
      {
         var _loc4_:AbstractGGSCountry = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         switch(param3)
         {
            case LanguageIdentifierType.BROWSER_LANGUAGE:
               for each(_loc4_ in param1)
               {
                  _loc6_ = _loc4_.browserLanguageCodes.length;
                  _loc7_ = 0;
                  while(_loc7_ < _loc6_)
                  {
                     if(_loc4_.browserLanguageCodes[_loc7_].toLowerCase() == param2.toLowerCase())
                     {
                        _loc5_.push(_loc4_);
                     }
                     _loc7_++;
                  }
               }
               break;
            case LanguageIdentifierType.FLASH_PLAYER_LANGUAGE:
               for each(_loc4_ in param1)
               {
                  if(_loc4_.flashPlayerLanguageCode.toLowerCase() == param2.toLowerCase())
                  {
                     _loc5_.push(_loc4_);
                  }
               }
         }
         return _loc5_;
      }
      
      private function filterCountryListByTimezone(param1:Vector.<AbstractGGSCountry>, param2:Number) : Vector.<AbstractGGSCountry>
      {
         var _loc5_:AbstractGGSCountry = null;
         var _loc3_:int = param1.length;
         var _loc4_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         for each(_loc5_ in param1)
         {
            if(_loc5_.utcTimezoneMin <= param2 && _loc5_.utcTimezoneMax >= param2)
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
      
      private function hexStringToBytes(param1:String) : Vector.<uint>
      {
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         while(param1.length >= 2)
         {
            _loc2_.push(uint("0x" + param1.substr(0,2)));
            param1 = param1.substr(2,param1.length - 2);
         }
         return _loc2_;
      }
      
      private function bytesToAsciiString(param1:Vector.<uint>) : String
      {
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(String.fromCharCode(param1[_loc3_]));
            _loc3_++;
         }
         return _loc2_.join("");
      }
   }
}
