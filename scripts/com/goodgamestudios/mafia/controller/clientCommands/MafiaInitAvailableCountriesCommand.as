package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.clientCommands.BasicClientCommand;
   import com.goodgamestudios.language.countries.GGSCountryCodes;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class MafiaInitAvailableCountriesCommand extends BasicClientCommand
   {
       
      
      public function MafiaInitAvailableCountriesCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         _loc2_.push(GGSCountryCodes.JAPAN);
         _loc2_.push(GGSCountryCodes.UK);
         _loc2_.push(GGSCountryCodes.USA);
         _loc2_.push(GGSCountryCodes.TURKEY);
         _loc2_.push(GGSCountryCodes.NORWAY);
         _loc2_.push(GGSCountryCodes.GREECE);
         _loc2_.push(GGSCountryCodes.NETHERLANDS);
         _loc2_.push(GGSCountryCodes.CZECH_REPUBLIC);
         _loc2_.push(GGSCountryCodes.ITALY);
         _loc2_.push(GGSCountryCodes.FRANCE);
         _loc2_.push(GGSCountryCodes.RUSSIA);
         _loc2_.push(GGSCountryCodes.FINLAND);
         _loc2_.push(GGSCountryCodes.SWEDEN);
         _loc2_.push(GGSCountryCodes.PORTUGAL);
         _loc2_.push(GGSCountryCodes.POLAND);
         _loc2_.push(GGSCountryCodes.GERMANY);
         _loc2_.push(GGSCountryCodes.HUNGARY);
         _loc2_.push(GGSCountryCodes.SPAIN);
         _loc2_.push(GGSCountryCodes.DENMARK);
         _loc2_.push(GGSCountryCodes.SOUTH_KOREA);
         GGSCountryController.instance.initActiveCountries(_loc2_);
      }
   }
}
