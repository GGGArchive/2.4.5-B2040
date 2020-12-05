package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.genericLO.InstanceMappingErrorLO;
   
   public class BasicConnectToInstanceVOCommand extends SimpleCommand
   {
      
      public static const NAME:String = "BasicConnectToInstanceVOCommand";
       
      
      public function BasicConnectToInstanceVOCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:InstanceVO = param1 as InstanceVO;
         if(_loc2_)
         {
            BasicModel.instanceProxy.selectedInstanceVO = _loc2_;
            if(BasicModel.localData)
            {
               BasicModel.localData.saveInstanceId(_loc2_.instanceId);
            }
            CommandController.instance.executeCommand(BasicController.COMMAND_CHECK_MAINTENANCE,BasicCheckMaintenanceCommand.VIA_NETWORK_XML);
         }
         else
         {
            ExternalLog.logger.log(new InstanceMappingErrorLO("",InstanceMappingErrorLO.CONNECT_TO_INSTANCE_NULL),NAME);
         }
      }
   }
}
