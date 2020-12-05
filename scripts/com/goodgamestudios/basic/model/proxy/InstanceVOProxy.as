package com.goodgamestudios.basic.model.proxy
{
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countries.GGSCountryCodes;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public final class InstanceVOProxy extends AbstractProxy
   {
       
      
      private var _instanceMap:Vector.<InstanceVO>;
      
      private var _selectedInstanceVO:InstanceVO;
      
      private var _langData:BasicLanguageData;
      
      public function InstanceVOProxy()
      {
         this._instanceMap = new Vector.<InstanceVO>();
         super();
      }
      
      public function get instanceMap() : Vector.<InstanceVO>
      {
         return this._instanceMap;
      }
      
      public function get selectedInstanceVO() : InstanceVO
      {
         return this._selectedInstanceVO;
      }
      
      public function set selectedInstanceVO(param1:InstanceVO) : void
      {
         if(param1)
         {
            this._selectedInstanceVO = param1;
         }
      }
      
      public function set langData(param1:BasicLanguageData) : void
      {
         this._langData = param1;
      }
      
      public function addInstance(param1:InstanceVO) : void
      {
         this._instanceMap.push(param1);
      }
      
      public function getInstanceVOByID(param1:int) : InstanceVO
      {
         var _loc2_:InstanceVO = null;
         for each(_loc2_ in this._instanceMap)
         {
            if(_loc2_.instanceId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getInstancesForActualCountry() : Vector.<InstanceVO>
      {
         var _loc4_:InstanceVO = null;
         var _loc5_:int = 0;
         var _loc1_:Vector.<InstanceVO> = new Vector.<InstanceVO>();
         var _loc2_:AbstractGGSCountry = GGSCountryController.instance.currentCountry;
         var _loc3_:int = 0;
         while(_loc3_ < this._instanceMap.length)
         {
            _loc4_ = this._instanceMap[_loc3_];
            if(_loc4_.isTestServer)
            {
               this.setServerName(_loc4_);
               _loc1_.push(_loc4_);
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_.countries.length)
               {
                  if(_loc4_.countries[_loc5_].ggsCountryCode == _loc2_.ggsCountryCode)
                  {
                     this.setServerName(_loc4_);
                     _loc1_.push(_loc4_);
                     break;
                  }
                  _loc5_++;
               }
            }
            _loc3_++;
         }
         return this.sortInstancesVO(_loc1_);
      }
      
      public function get hasOnlyOneInstanceInWorld() : Boolean
      {
         var _loc1_:Vector.<InstanceVO> = this.getInstancesForActualCountry();
         return _loc1_.length == 1;
      }
      
      public function isInstanceIDAvalibleInCurrentCountry(param1:int) : Boolean
      {
         var _loc3_:InstanceVO = null;
         var _loc2_:Vector.<InstanceVO> = this.getInstancesForActualCountry();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.instanceId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function setServerName(param1:InstanceVO) : void
      {
         if(this._langData != null)
         {
            if(param1.isTestServer)
            {
               return;
            }
            if(param1.instanceLocaId && param1.instanceLocaId != "")
            {
               param1.serverName = this._langData.getTextById(param1.instanceLocaId) + ": " + param1.instanceCountID;
            }
            else if(param1.countries.length > 1)
            {
               param1.serverName = this._langData.getTextById("generic_world",[param1.instanceCountID]);
            }
            else if(param1.countries.length == 1)
            {
               param1.serverName = this._langData.getTextById("generic_language_" + param1.countries[0].ggsLanguageCode) + ": " + param1.instanceCountID;
            }
         }
      }
      
      private function checkSpecialServerName(param1:InstanceVO) : String
      {
         var _loc3_:AbstractGGSCountry = null;
         var _loc2_:int = 0;
         if(param1.countries.length == 4)
         {
            for each(_loc3_ in param1.countries)
            {
               if(_loc3_.ggsCountryCode == GGSCountryCodes.FINLAND || _loc3_.ggsCountryCode == GGSCountryCodes.SWEDEN || _loc3_.ggsCountryCode == GGSCountryCodes.DENMARK || _loc3_.ggsCountryCode == GGSCountryCodes.NORWAY)
               {
                  _loc2_++;
               }
            }
            if(_loc2_ == 4)
            {
               return this._langData.getTextById("generic_language_skn") + ": " + param1.instanceCountID;
            }
         }
         else if(param1.countries.length == 2)
         {
            for each(_loc3_ in param1.countries)
            {
               if(_loc3_.ggsCountryCode == GGSCountryCodes.PORTUGAL || _loc3_.ggsCountryCode == GGSCountryCodes.BRAZIL)
               {
                  _loc2_++;
               }
            }
            if(_loc2_ == 2)
            {
               return this._langData.getTextById("generic_language_pt") + ": " + param1.instanceCountID;
            }
         }
         return "";
      }
      
      private function sortInstancesVO(param1:Vector.<InstanceVO>) : Vector.<InstanceVO>
      {
         var _loc7_:InstanceVO = null;
         var _loc2_:Vector.<InstanceVO> = new Vector.<InstanceVO>();
         var _loc3_:Vector.<InstanceVO> = new Vector.<InstanceVO>();
         var _loc4_:Vector.<InstanceVO> = new Vector.<InstanceVO>();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc7_ = param1[_loc5_];
            if(_loc7_.isTestServer)
            {
               _loc4_.push(_loc7_);
            }
            else if(_loc7_.isInternationalInstance)
            {
               _loc3_.push(_loc7_);
            }
            else
            {
               _loc2_.push(_loc7_);
               _loc2_.reverse();
            }
            _loc5_++;
         }
         var _loc6_:Vector.<InstanceVO> = _loc2_.concat(_loc3_);
         _loc6_ = _loc6_.concat(_loc4_);
         return _loc6_;
      }
   }
}
