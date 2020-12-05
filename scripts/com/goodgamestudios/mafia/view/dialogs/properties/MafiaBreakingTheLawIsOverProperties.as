package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   
   public class MafiaBreakingTheLawIsOverProperties extends BasicStandardOkDialogProperties
   {
       
      
      public var xp:int;
      
      public var cash:int;
      
      public function MafiaBreakingTheLawIsOverProperties(param1:String, param2:String, param3:Function = null, param4:String = "", param5:int = 0, param6:int = 0)
      {
         super(param1,param2,param3,param4);
         this.xp = param5;
         this.cash = param6;
      }
   }
}
