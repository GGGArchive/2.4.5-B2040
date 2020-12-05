package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.WelcomeVO;
   
   public class MafiaWelcomeDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_ok:String = "OK";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var welcomeData:Vector.<WelcomeVO>;
      
      public function MafiaWelcomeDialogProperties(param1:Vector.<WelcomeVO>, param2:String, param3:String = "OK")
      {
         this.buttonLabel_ok = param3;
         this.title = param2;
         this.welcomeData = param1;
         super();
      }
   }
}
