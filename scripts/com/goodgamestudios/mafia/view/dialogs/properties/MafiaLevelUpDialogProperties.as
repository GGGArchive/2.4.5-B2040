package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaLevelUpDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_ok:String = "OK";
      
      public var buttonLabel_no:String = "Close";
      
      public var level:int;
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public function MafiaLevelUpDialogProperties(param1:int, param2:String, param3:String, param4:String = "OK", param5:String = "Close", param6:Function = null, param7:Function = null)
      {
         this.buttonLabel_ok = param4;
         this.buttonLabel_no = param5;
         this.level = param1;
         this.copy = param3;
         this.title = param2;
         if(param6 != null)
         {
            this.functionYes = param6;
         }
         if(param7 != null)
         {
            this.functionNo = param7;
         }
         super();
      }
   }
}
