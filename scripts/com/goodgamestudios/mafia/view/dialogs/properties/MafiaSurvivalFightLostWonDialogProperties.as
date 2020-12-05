package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaSurvivalFightLostWonDialogProperties extends BasicProperties
   {
       
      
      public var won:Boolean;
      
      public var timeExpired:Boolean;
      
      public function MafiaSurvivalFightLostWonDialogProperties(param1:Boolean, param2:Boolean = false)
      {
         this.won = param1;
         this.timeExpired = param2;
         super();
      }
   }
}
