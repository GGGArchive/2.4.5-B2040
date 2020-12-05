package com.goodgamestudios.mafia.model.components.user.duel
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   
   public class MafiaDuelData
   {
       
      
      public var pvpData:MafiaPvpData;
      
      public var wantedData:MafiaWantedData;
      
      public var survivalData:MafiaSurvivalResultData;
      
      public function MafiaDuelData()
      {
         super();
         this.pvpData = new MafiaPvpData();
         this.wantedData = new MafiaWantedData();
         this.survivalData = new MafiaSurvivalResultData();
      }
      
      public function update(param1:Number) : void
      {
         if(this.pvpData.nextFreeDuelFightTime > 0)
         {
            this.pvpData.checkDuelTime(param1);
         }
         if(this.wantedData.nextFreeWantedFightTime > 0)
         {
            this.wantedData.checkWantedTime(param1);
         }
         if(this.survivalData.survivalResetTime > 0)
         {
            this.survivalData.checkSurvivalResetTime(param1);
         }
         if(this.survivalData.nextFreeSurvivalFightTime > 0)
         {
            this.survivalData.checkSurvivalCoolDownTime(param1);
         }
         if(MafiaModel.userData.cityQuestFightData.nextFreeDuelFightTime > 0)
         {
            MafiaModel.userData.cityQuestFightData.checkDuelTime(param1);
         }
      }
   }
}
