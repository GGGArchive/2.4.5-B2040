package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicConnectClientCommand extends SimpleCommand
   {
       
      
      public function BasicConnectClientCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:InstanceVO = BasicModel.instanceProxy.selectedInstanceVO;
         if(!_loc2_)
         {
            return;
         }
         if(BasicModel.smartfoxClient.isConnected)
         {
            BasicModel.smartfoxClient.logout();
         }
         BasicController.getInstance().connectClient(_loc2_.ip,_loc2_.port);
      }
   }
}
