package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.SlotVO;
   
   public class MafiaUnlockSlotDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var slotVO:SlotVO;
      
      public var slotType:int;
      
      public function MafiaUnlockSlotDialogProperties(param1:SlotVO, param2:int, param3:String, param4:String, param5:Function = null, param6:Function = null, param7:String = "Yes", param8:String = "No")
      {
         this.functionYes = param5;
         this.functionNo = param6;
         this.buttonLabel_yes = param7;
         this.buttonLabel_no = param8;
         this.title = param3;
         this.copy = param4;
         this.slotVO = param1;
         this.slotType = param2;
         super();
      }
   }
}
