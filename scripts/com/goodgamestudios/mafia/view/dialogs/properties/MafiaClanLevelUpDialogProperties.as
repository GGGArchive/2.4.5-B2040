package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaClanLevelUpDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_ok:String = "OK";
      
      public var buttonLabel_no:String = "Close";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public function MafiaClanLevelUpDialogProperties(param1:String, param2:String, param3:String = "OK", param4:String = "Close", param5:Function = null, param6:Function = null)
      {
         this.buttonLabel_ok = param3;
         this.buttonLabel_no = param4;
         this.copy = param2;
         this.title = param1;
         if(param5 != null)
         {
            this.functionYes = param5;
         }
         if(param6 != null)
         {
            this.functionNo = param6;
         }
         super();
      }
   }
}
