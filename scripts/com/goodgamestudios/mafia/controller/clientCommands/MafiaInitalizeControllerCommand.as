package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitalizeControllerCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaWorldSelectionDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaWorldSelectionDialogProperties;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   
   public class MafiaInitalizeControllerCommand extends BasicInitalizeControllerCommand
   {
       
      
      public function MafiaInitalizeControllerCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:InstanceVO = null;
         super.execute();
         BasicController.getInstance().soundController = new MafiaSoundController();
         BasicController.getInstance().soundController.initialize();
         if(!MafiaModel.smartfoxClient.userForcedDisconnect && (this.env.isTest || this.env.isLocal || this.env.isDevTest))
         {
            if(MafiaDataHolder.instance.firstVisitCreationUsed)
            {
               if(!this.env.loginIsKeyBased)
               {
                  this.layoutManager.state = BasicLayoutManager.STATE_REGISTRATION;
               }
               else
               {
                  this.doAnythingAfterSocialConnect();
               }
            }
            else
            {
               this.layoutManager.showDialog(MafiaWorldSelectionDialog.NAME,new MafiaWorldSelectionDialogProperties());
            }
         }
         else if(this.env.loginIsKeyBased)
         {
            this.doAnythingAfterSocialConnect();
         }
         else if(BasicModel.instanceProxy.hasOnlyOneInstanceInWorld || this.env.forceInstanceConnect)
         {
            this.connectToInstance(BasicModel.instanceProxy.selectedInstanceVO);
         }
         else if(MafiaModel.smartfoxClient.userForcedDisconnect)
         {
            this.initLoginState();
         }
         else if(this.env.useAutoLogin && BasicModel.localData.hasInstanceId)
         {
            _loc2_ = BasicModel.localData.readInstanceId();
            _loc3_ = BasicModel.instanceProxy.getInstanceVOByID(_loc2_);
            this.connectToInstance(_loc3_);
         }
         else if(MafiaDataHolder.instance.firstVisitCreationUsed)
         {
            this.connectToInstance(BasicModel.instanceProxy.selectedInstanceVO);
            this.layoutManager.state = BasicLayoutManager.STATE_REGISTRATION;
         }
         else
         {
            this.initLoginState();
         }
      }
      
      private function initLoginState() : void
      {
         this.layoutManager.state = BasicLayoutManager.STATE_LOGIN;
         this.connectToInstance(BasicModel.instanceProxy.selectedInstanceVO);
      }
      
      private function doAnythingAfterSocialConnect() : void
      {
         BasicController.getInstance().refreshSocketListener();
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_VERSION_CHECK,[this.env.buildNumberGame]);
      }
      
      private function connectToInstance(param1:InstanceVO) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,param1);
         this.layoutManager.backgroundComponent.showSFSProgress(MafiaModel.languageData.getTextById("progress_serverconnection"));
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      private function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
