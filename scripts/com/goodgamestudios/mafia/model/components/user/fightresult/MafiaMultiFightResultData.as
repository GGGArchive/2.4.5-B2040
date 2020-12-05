package com.goodgamestudios.mafia.model.components.user.fightresult
{
   import com.goodgamestudios.mafia.vo.FighterVO;
   
   public class MafiaMultiFightResultData
   {
       
      
      public var fights:Vector.<MafiaFightResultData>;
      
      public var fightersLeft:Vector.<FighterVO>;
      
      public var fightersRight:Vector.<FighterVO>;
      
      public var currentFight:MafiaFightResultData;
      
      public var skip:Boolean;
      
      public function MafiaMultiFightResultData()
      {
         super();
      }
   }
}
