package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class BasicChangeCountryCommand extends BasicClientCommand
   {
       
      
      public function BasicChangeCountryCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:InstanceVO = null;
         var _loc6_:Vector.<InstanceVO> = null;
         var _loc2_:AbstractGGSCountry = GGSCountryController.instance.currentCountry;
         var _loc3_:AbstractGGSCountry = param1 as AbstractGGSCountry;
         if(!_loc3_)
         {
            return;
         }
         if(_loc2_.ggsCountryCode != _loc3_.ggsCountryCode)
         {
            if(BasicModel.instanceProxy.selectedInstanceVO)
            {
               _loc4_ = BasicModel.instanceProxy.selectedInstanceVO.instanceId;
            }
            GGSCountryController.instance.selectedCountry = _loc3_.ggsCountryCode;
            BasicModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
            if(BasicModel.instanceProxy.isInstanceIDAvalibleInCurrentCountry(_loc4_))
            {
               _loc5_ = BasicModel.instanceProxy.getInstanceVOByID(_loc4_);
            }
            else
            {
               _loc6_ = BasicModel.instanceProxy.getInstancesForActualCountry();
               _loc5_ = _loc6_[0];
            }
            CommandController.instance.executeCommand(BasicController.COMMAND_SERVER_INFO,env.minUsernameLength);
            if(BasicModel.instanceProxy.selectedInstanceVO != _loc5_)
            {
               BasicModel.instanceProxy.selectedInstanceVO = _loc5_;
               CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicModel.instanceProxy.selectedInstanceVO);
            }
            if(BasicModel.languageData)
            {
               if(_loc2_.ggsLanguageCode != _loc3_.ggsLanguageCode)
               {
                  CommandController.instance.executeCommand(BasicController.COMMAND_CHANGE_LANGUAGE);
               }
            }
         }
      }
   }
}
