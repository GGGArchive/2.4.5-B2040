package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicOnClickMoreCurrencyCommand extends SimpleCommand
   {
       
      
      public function BasicOnClickMoreCurrencyCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(BasicModel.userData.isGuest())
         {
            this.layoutManager.showDialog(CommonDialogNames.StandardYesNoDialog_NAME,new BasicStandardYesNoDialogProperties(BasicModel.languageData.getTextById("alert_addgold_title"),BasicModel.languageData.getTextById("alert_addgold_copy"),this.onStartRegisterDialog,null,null,BasicModel.languageData.getTextById("panelwin_login_register"),BasicModel.languageData.getTextById("btn_text_cancle")));
         }
         else
         {
            this.addExtraGold();
         }
      }
      
      private function addExtraGold() : void
      {
         BasicController.getInstance().addExtraGold();
      }
      
      private function onStartRegisterDialog(param1:Array) : void
      {
         BasicController.getInstance().onStartRegisterDialog();
      }
      
      protected function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
