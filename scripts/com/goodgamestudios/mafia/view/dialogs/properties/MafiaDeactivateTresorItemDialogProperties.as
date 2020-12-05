package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   
   public class MafiaDeactivateTresorItemDialogProperties extends BasicStandardYesNoDialogProperties
   {
       
      
      public var location:ItemLocation;
      
      public function MafiaDeactivateTresorItemDialogProperties(param1:ItemLocation, param2:String, param3:String, param4:Function = null, param5:Function = null, param6:Function = null, param7:String = "", param8:String = "")
      {
         this.location = param1;
         super(param2,param3,param4,param5,param6,param7,param8);
      }
   }
}
