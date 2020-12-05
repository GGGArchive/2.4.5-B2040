package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaMailGiftDialogProperties extends BasicProperties
   {
       
      
      public var title:String;
      
      public var copy:String;
      
      public function MafiaMailGiftDialogProperties(param1:String, param2:String)
      {
         this.title = param1;
         this.copy = param2;
         super();
      }
   }
}
