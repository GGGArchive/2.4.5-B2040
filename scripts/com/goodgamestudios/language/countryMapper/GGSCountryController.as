package com.goodgamestudios.language.countryMapper
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countries.GGSCountryCodes;
   import com.goodgamestudios.language.unicodeRanges.UnicodeScoreMap;
   import org.osflash.signals.Signal;
   
   public final class GGSCountryController
   {
      
      private static var _instance:GGSCountryController;
       
      
      public var countriesInitialized:Signal;
      
      private var _activeCountries:Vector.<String>;
      
      private var _availableCountries:Vector.<AbstractGGSCountry>;
      
      private var _currentCountry:AbstractGGSCountry;
      
      private var _selectedLanguageCode:String;
      
      private var _selectedCountryCode:String;
      
      private var _newCountrySelected:Signal;
      
      private var _languageIdentifierType:int;
      
      private var _localTimeZoneOffset:Number;
      
      private var _defaultCountry:AbstractGGSCountry;
      
      public function GGSCountryController()
      {
         this.countriesInitialized = new Signal();
         this._activeCountries = new Vector.<String>();
         this._availableCountries = new Vector.<AbstractGGSCountry>();
         this._newCountrySelected = new Signal(AbstractGGSCountry);
         super();
         this._defaultCountry = this.getDefaultCountry();
         if(_instance)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : GGSCountryController
      {
         if(!_instance)
         {
            _instance = new GGSCountryController();
         }
         return _instance;
      }
      
      public function get availableCountries() : Vector.<AbstractGGSCountry>
      {
         return this._availableCountries;
      }
      
      public function get currentCountry() : AbstractGGSCountry
      {
         return this._currentCountry;
      }
      
      public function set currentCountry(param1:AbstractGGSCountry) : void
      {
         this._currentCountry = param1;
         this._selectedCountryCode = this._currentCountry.ggsCountryCode;
      }
      
      public function set selectedCountry(param1:String) : void
      {
         var _loc2_:String = this._selectedCountryCode;
         var _loc3_:AbstractGGSCountry = this.getAvailableCountryByCountryCode(param1);
         if(_loc3_ != null)
         {
            this.currentCountry = _loc3_;
         }
         else
         {
            this.currentCountry = this.getDefaultCountry();
         }
         if(_loc2_ != param1)
         {
            this._newCountrySelected.dispatch(this.currentCountry);
         }
      }
      
      public function get newCountrySelected() : Signal
      {
         return this._newCountrySelected;
      }
      
      public function get localTimeZoneOffset() : Number
      {
         return this._localTimeZoneOffset;
      }
      
      public function setSelectedLanguage(param1:String, param2:int) : void
      {
         this._selectedLanguageCode = param1;
         this._languageIdentifierType = param2;
      }
      
      public function initAvailableCountries(param1:Vector.<Class>, param2:Number = 0) : void
      {
         var _loc4_:Class = null;
         var _loc5_:Date = null;
         this._availableCountries = new Vector.<AbstractGGSCountry>();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            this._availableCountries.push(new _loc4_());
            _loc3_++;
         }
         if(param2 != 0)
         {
            this._localTimeZoneOffset = param2;
         }
         else
         {
            _loc5_ = new Date();
            this._localTimeZoneOffset = _loc5_.timezoneOffset;
         }
         this.countriesInitialized.dispatch();
      }
      
      public function initActiveCountries(param1:Vector.<String>) : void
      {
         this._activeCountries = param1;
      }
      
      public function initAvailableCountriesLoaded(param1:Vector.<AbstractGGSCountry>, param2:Number = 0) : void
      {
         var _loc3_:Date = null;
         this._availableCountries = this.filterAvailableCountriesWithActiveGGSCountryCodeList(param1);
         if(param2 != 0)
         {
            this._localTimeZoneOffset = param2;
         }
         else
         {
            _loc3_ = new Date();
            this._localTimeZoneOffset = _loc3_.timezoneOffset;
         }
         this.countriesInitialized.dispatch();
      }
      
      private function filterAvailableCountriesWithActiveGGSCountryCodeList(param1:Vector.<AbstractGGSCountry>) : Vector.<AbstractGGSCountry>
      {
         var _loc3_:String = null;
         var _loc4_:AbstractGGSCountry = null;
         if(!this._activeCountries)
         {
            return null;
         }
         var _loc2_:Vector.<AbstractGGSCountry> = new Vector.<AbstractGGSCountry>();
         if(this._activeCountries.length == 0)
         {
            return _loc2_;
         }
         for each(_loc3_ in this._activeCountries)
         {
            _loc3_ = _loc3_.toLowerCase();
            for each(_loc4_ in param1)
            {
               if(_loc4_.ggsCountryCode.toLowerCase() == _loc3_)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         return _loc2_;
      }
      
      public function isCountryCodeAvailable(param1:String) : Boolean
      {
         var _loc2_:AbstractGGSCountry = null;
         param1 = param1.toLowerCase();
         for each(_loc2_ in this._availableCountries)
         {
            if(_loc2_.ggsCountryCode.toLowerCase() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAvailableCountryByCountryCode(param1:String) : AbstractGGSCountry
      {
         var _loc2_:AbstractGGSCountry = null;
         param1 = param1.toLowerCase();
         for each(_loc2_ in this._availableCountries)
         {
            if(_loc2_.ggsCountryCode.toLowerCase() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isBrowserLanguageAvailable(param1:String) : Boolean
      {
         var _loc2_:AbstractGGSCountry = null;
         var _loc3_:String = null;
         if(!param1 || param1 == "")
         {
            return false;
         }
         param1 = param1.toLowerCase();
         for each(_loc2_ in this._availableCountries)
         {
            for each(_loc3_ in _loc2_.browserLanguageCodes)
            {
               if(_loc3_.toLowerCase() == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      protected function getDefaultCountry() : AbstractGGSCountry
      {
         if(!this._defaultCountry)
         {
            this._defaultCountry = new AbstractGGSCountry();
            this._defaultCountry.ggsCountryCode = GGSCountryCodes.USA;
            this._defaultCountry.addBrowserLanguageCodes("[en,en-US,en-GB]");
            this._defaultCountry.flashPlayerLanguageCode = "en";
            this._defaultCountry.ggsLanguageCode = "en";
            this._defaultCountry.utcTimezoneMin = -6;
            this._defaultCountry.utcTimezoneMax = -10;
         }
         return this._defaultCountry;
      }
      
      public function set defaultCountry(param1:AbstractGGSCountry) : void
      {
         this._defaultCountry = param1;
      }
      
      public function getLangIdByUnicodeRange(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc6_:AbstractGGSCountry = null;
         var _loc2_:UnicodeScoreMap = new UnicodeScoreMap();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1.charCodeAt(_loc4_);
            for each(_loc6_ in this._availableCountries)
            {
               if(_loc6_.usesUnicodeOrd(_loc3_))
               {
                  _loc2_.addOrIncrease(_loc6_);
               }
            }
            _loc4_++;
         }
         var _loc5_:AbstractGGSCountry = _loc2_.winnerCountry;
         _loc2_.destroy();
         if(_loc5_)
         {
            return _loc5_.ggsCountryCode;
         }
         return null;
      }
   }
}
