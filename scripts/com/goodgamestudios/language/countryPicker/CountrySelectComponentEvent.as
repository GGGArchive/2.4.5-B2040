package com.goodgamestudios.language.countryPicker
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import flash.events.Event;
   
   public class CountrySelectComponentEvent extends Event
   {
      
      public static const COUNTRY_VIEW_OPENED:String = "countryViewOpened";
      
      public static const COUNTRY_VIEW_CLOSED:String = "countryViewClosed";
      
      public static const COUNTRY_CHANGED:String = "countryChanged";
       
      
      public var selectedCountry:AbstractGGSCountry;
      
      public function CountrySelectComponentEvent(param1:String, param2:AbstractGGSCountry = null, param3:Boolean = true, param4:Boolean = false)
      {
         this.selectedCountry = param2;
         super(param1,param3,param4);
      }
   }
}
