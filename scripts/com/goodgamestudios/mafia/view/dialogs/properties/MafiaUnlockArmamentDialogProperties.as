package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaUnlockArmamentDialogProperties extends BasicProperties
   {
       
      
      public var title:String = "";
      
      public var copy:String = "";
      
      public var buttonLabel_unlock:String = "";
      
      public var unlockCost:uint;
      
      public var functionUnlock:Function;
      
      public var functionClose:Function;
      
      public function MafiaUnlockArmamentDialogProperties(param1:String, param2:String, param3:Function = null, param4:Function = null, param5:String = "", param6:uint = 0)
      {
         this.title = param1;
         this.copy = param2;
         this.functionUnlock = param3;
         this.functionClose = param4;
         this.buttonLabel_unlock = param5;
         this.unlockCost = param6;
         super();
      }
   }
}
