package com.goodgamestudios.basic.fb.connectlogin
{
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.utils.JSUtils;
   import flash.external.ExternalInterface;
   
   public class BasicFacebookConnectCommand extends SimpleCommand
   {
      
      public static var gameID:int;
       
      
      public function BasicFacebookConnectCommand()
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
         JSUtils.addJsCallback(FacebookSettings.FACEBOOK_CALLBACK_NAME,this.jsFacebookLoginCallback);
         ExternalInterface.call(FacebookSettings.FACEBOOK_JS_LOGIN_METHOD,gameID);
      }
      
      protected function jsFacebookLoginCallback(param1:String, param2:String, param3:String, param4:String) : void
      {
      }
   }
}
