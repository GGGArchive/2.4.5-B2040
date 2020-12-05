package com.goodgamestudios.mafia.view.screens.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.RewardVO;
   
   public class MafiaBasicFightScreenProperties extends BasicProperties
   {
       
      
      public var fightResult:MafiaFightResultData;
      
      public var reward:RewardVO;
      
      public function MafiaBasicFightScreenProperties(param1:MafiaFightResultData, param2:RewardVO = null)
      {
         super();
         this.fightResult = param1;
         if(param2)
         {
            this.reward = param2;
         }
         else
         {
            this.reward = new RewardVO();
         }
      }
   }
}
