package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   
   public class MafiaShowClanWarDialogProperties extends BasicStandardYesNoDialogProperties
   {
       
      
      public var warID:int;
      
      public var clanId:int;
      
      public var timestamp:Number;
      
      public function MafiaShowClanWarDialogProperties(param1:String, param2:String, param3:int, param4:int, param5:Number, param6:Function = null, param7:Function = null, param8:Function = null, param9:String = "", param10:String = "")
      {
         this.warID = param3;
         this.clanId = param4;
         this.timestamp = param5;
         super(param1,param2,param6,param7,param8,param9,param10);
      }
   }
}
