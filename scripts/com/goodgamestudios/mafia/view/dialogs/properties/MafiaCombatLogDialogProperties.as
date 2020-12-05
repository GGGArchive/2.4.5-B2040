package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   
   public class MafiaCombatLogDialogProperties extends BasicProperties
   {
       
      
      public var duelResultLogData:MafiaFightResultData;
      
      public function MafiaCombatLogDialogProperties(param1:MafiaFightResultData)
      {
         this.duelResultLogData = param1;
         super();
      }
   }
}
