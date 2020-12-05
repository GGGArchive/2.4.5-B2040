package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.language.countries.GGSCountryCodes;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public final class BasicInitAvailableCountriesCommand extends BasicClientCommand
   {
       
      
      public function BasicInitAvailableCountriesCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         _loc2_.push(GGSCountryCodes.USA);
         _loc2_.push(GGSCountryCodes.GERMANY);
         GGSCountryController.instance.initActiveCountries(_loc2_);
      }
   }
}
