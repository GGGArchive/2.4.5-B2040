package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class MafiaTournamentRegisterDialogProperties extends BasicProperties
   {
       
      
      public var functionYes:Function;
      
      public var registeredPlayers:int;
      
      public function MafiaTournamentRegisterDialogProperties(param1:Function = null)
      {
         this.functionYes = param1;
         super();
      }
   }
}
