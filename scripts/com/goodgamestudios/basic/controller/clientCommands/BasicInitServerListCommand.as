package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.proxy.InstanceVOProxy;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class BasicInitServerListCommand extends BasicClientCommand
   {
       
      
      public function BasicInitServerListCommand()
      {
         super();
      }
      
      override public final function execute(param1:Object = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:XML = null;
         var _loc4_:InstanceVOProxy = null;
         var _loc5_:InstanceVO = null;
         var _loc6_:String = null;
         var _loc7_:Vector.<AbstractGGSCountry> = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         for each(_loc3_ in param1.serverInstances)
         {
            _loc4_ = BasicModel.instanceProxy;
            _loc5_ = new InstanceVO();
            _loc5_.ip = _loc3_.server.text();
            _loc5_.port = parseInt(_loc3_.port.text());
            _loc5_.zone = _loc3_.zone.text();
            _loc5_.maintenance = Boolean(parseInt(_loc3_.maintenance.text()));
            _loc5_.instanceId = parseInt(_loc3_["value"]);
            _loc5_.instanceCountID = parseInt(_loc3_.instanceName.text());
            _loc5_.isInternationalServer = parseInt(_loc3_.isInternational.text()) == 1;
            _loc5_.isFavorite = parseInt(_loc3_.isFavorite.text()) == 1;
            _loc5_.defaultcountry = _loc3_.defaultcountry.text();
            _loc5_.instanceLocaId = _loc3_.instanceLocaId.text();
            if(_loc5_.instanceId < 0)
            {
               _loc5_.isTestServer = true;
            }
            _loc2_ = new Object();
            _loc6_ = _loc3_.countries.text();
            if(_loc6_ && _loc6_ != "" && _loc6_.length > 2)
            {
               _loc2_ = com.adobe.serialization.json.JSON.decode(_loc6_);
            }
            _loc7_ = GGSCountryController.instance.availableCountries;
            if(_loc2_)
            {
               for each(_loc8_ in _loc2_)
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc7_.length)
                  {
                     if(_loc8_ == _loc7_[_loc9_].ggsCountryCode)
                     {
                        _loc5_.countries.push(_loc7_[_loc9_]);
                     }
                     _loc9_++;
                  }
               }
            }
            _loc4_.addInstance(_loc5_);
         }
         this.initAdditionalServer();
      }
      
      protected function initAdditionalServer() : void
      {
      }
   }
}
