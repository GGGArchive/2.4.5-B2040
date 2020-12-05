package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class BasicReplaceAvailableCountriesByInstanceCountriesCommand extends SimpleCommand
   {
       
      
      public function BasicReplaceAvailableCountriesByInstanceCountriesCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc3_:AbstractGGSCountry = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(_loc3_ in BasicModel.instanceProxy.selectedInstanceVO.countries)
         {
            _loc2_.push(_loc3_.ggsCountryCode);
         }
         GGSCountryController.instance.initActiveCountries(_loc2_);
         GGSCountryController.instance.initAvailableCountriesLoaded(BasicModel.instanceProxy.selectedInstanceVO.countries);
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
