package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaMailGiftReminderDialogProperties extends BasicProperties
   {
       
      
      public var title:String;
      
      public var copy:String;
      
      public function MafiaMailGiftReminderDialogProperties(param1:String, param2:String)
      {
         this.title = param1;
         this.copy = param2;
         super();
      }
   }
}
