package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaBuyEnergyDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_buy:String = "Buy";
      
      public var buttonLabel_no:String = "Close";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var rubin:int;
      
      public var refiller:int;
      
      public function MafiaBuyEnergyDialogProperties(param1:int, param2:String = "Buy", param3:String = "Close", param4:Function = null, param5:Function = null)
      {
         this.functionYes = param4;
         this.functionNo = param5;
         this.buttonLabel_buy = param2;
         this.buttonLabel_no = param3;
         this.rubin = param1;
         this.refiller = this.refiller;
         super();
      }
   }
}
