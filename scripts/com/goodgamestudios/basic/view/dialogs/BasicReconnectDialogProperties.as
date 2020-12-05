package com.goodgamestudios.basic.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class BasicReconnectDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_reconnect:String = "Try again";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionReconnect:Function;
      
      public function BasicReconnectDialogProperties(param1:String, param2:String, param3:Function = null, param4:String = "Try again")
      {
         this.functionReconnect = param3;
         this.buttonLabel_reconnect = param4;
         this.title = param1;
         this.copy = param2;
         super();
      }
   }
}
