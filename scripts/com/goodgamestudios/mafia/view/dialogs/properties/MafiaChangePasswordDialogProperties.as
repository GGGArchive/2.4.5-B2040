package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   
   public class MafiaChangePasswordDialogProperties extends BasicStandardYesNoDialogProperties
   {
       
      
      public var newpassword_text:String;
      
      public var oldpassword_text:String;
      
      public function MafiaChangePasswordDialogProperties(param1:String, param2:String, param3:String, param4:Function = null, param5:Function = null, param6:String = "Yes", param7:String = "No")
      {
         this.newpassword_text = param2;
         this.oldpassword_text = param3;
         super(param1,"",param4,param5,null,param6,param7);
      }
   }
}
