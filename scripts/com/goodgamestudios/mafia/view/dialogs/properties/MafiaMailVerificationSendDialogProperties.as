package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaMailVerificationSendDialogProperties extends BasicProperties
   {
       
      
      public var title:String;
      
      public var copy:String;
      
      public var copy2:String;
      
      public function MafiaMailVerificationSendDialogProperties(param1:String, param2:String, param3:String)
      {
         this.title = param1;
         this.copy = param2;
         this.copy2 = param3;
         super();
      }
   }
}
