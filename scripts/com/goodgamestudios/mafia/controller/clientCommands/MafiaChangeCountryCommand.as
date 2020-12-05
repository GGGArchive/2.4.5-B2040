package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicChangeCountryCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   
   public class MafiaChangeCountryCommand extends BasicChangeCountryCommand
   {
       
      
      public function MafiaChangeCountryCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var currentInstanceID:int = 0;
         var instanceList:Vector.<InstanceVO> = null;
         var commandVars:Object = param1;
         var currentCountry:AbstractGGSCountry = GGSCountryController.instance.currentCountry;
         var newCountry:AbstractGGSCountry = commandVars as AbstractGGSCountry;
         if(!newCountry)
         {
            return;
         }
         if(currentCountry.ggsCountryCode != newCountry.ggsCountryCode)
         {
            if(BasicModel.instanceProxy.selectedInstanceVO)
            {
               currentInstanceID = BasicModel.instanceProxy.selectedInstanceVO.instanceId;
            }
            GGSCountryController.instance.selectedCountry = newCountry.ggsCountryCode;
            BasicModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
            if(BasicModel.instanceProxy.isInstanceIDAvalibleInCurrentCountry(currentInstanceID))
            {
               BasicModel.instanceProxy.selectedInstanceVO = BasicModel.instanceProxy.getInstanceVOByID(currentInstanceID);
            }
            else
            {
               instanceList = BasicModel.instanceProxy.getInstancesForActualCountry();
               BasicModel.instanceProxy.selectedInstanceVO = instanceList[0];
            }
            if(env.isFirstVisit)
            {
               if(MafiaDataHolder.instance.firstVisitCreationUsed)
               {
                  CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicModel.instanceProxy.selectedInstanceVO);
               }
               else
               {
                  try
                  {
                     if(BasicLayoutManager.getInstance().currentState == BasicLayoutManager.STATE_LOGIN)
                     {
                        CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicModel.instanceProxy.selectedInstanceVO);
                     }
                  }
                  catch(e:Error)
                  {
                     trace("LayoutManager is not initialized!");
                  }
               }
            }
            else
            {
               CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicModel.instanceProxy.selectedInstanceVO);
            }
            if(BasicModel.languageData)
            {
               if(currentCountry.ggsLanguageCode != newCountry.ggsLanguageCode)
               {
                  BasicModel.languageData.loadLanguage();
               }
            }
         }
      }
   }
}
