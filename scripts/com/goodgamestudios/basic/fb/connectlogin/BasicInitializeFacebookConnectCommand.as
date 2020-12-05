package com.goodgamestudios.basic.fb.connectlogin
{
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.utils.JSUtils;
   
   public class BasicInitializeFacebookConnectCommand extends SimpleCommand
   {
       
      
      public function BasicInitializeFacebookConnectCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(!JSUtils.isJsAvailable())
         {
            trace("Error: JaveScript not available");
            return;
         }
         if(!JSUtils.checkIfJsFunctionExists(FacebookSettings.FACEBOOK_JS_LOGIN_METHOD))
         {
            JSUtils.loadJS(FacebookSettings.FACEBOOK_JS_PATH);
         }
      }
   }
}
