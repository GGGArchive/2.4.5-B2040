package com.goodgamestudios.mafia.view.screens.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanWarData;
   
   public class MafiaMultiFightScreenProperties extends BasicProperties
   {
       
      
      public var fightResult:MafiaClanWarData;
      
      public function MafiaMultiFightScreenProperties(param1:MafiaClanWarData)
      {
         super();
         this.fightResult = param1;
      }
   }
}
