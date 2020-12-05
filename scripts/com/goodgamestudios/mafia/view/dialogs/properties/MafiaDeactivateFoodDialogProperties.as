package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaDeactivateFoodDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var slotID:int;
      
      public function MafiaDeactivateFoodDialogProperties(param1:int, param2:String, param3:String, param4:Function = null, param5:Function = null, param6:String = "Yes", param7:String = "No")
      {
         this.functionYes = param4;
         this.functionNo = param5;
         this.buttonLabel_yes = param6;
         this.buttonLabel_no = param7;
         this.title = param2;
         this.copy = param3;
         this.slotID = param1;
         super();
      }
   }
}
