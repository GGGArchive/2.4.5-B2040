package com.goodgamestudios.language.countryMapper
{
   import flash.events.Event;
   
   public class CountryDetectionEvent extends Event
   {
      
      public static var LOAD_COUNTRIES_COMPLETE:String = "loadCountriesComplete";
      
      public static var COUNTRY_DETECTION_COMPLETE:String = "countryDetectionComplete";
       
      
      public function CountryDetectionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
