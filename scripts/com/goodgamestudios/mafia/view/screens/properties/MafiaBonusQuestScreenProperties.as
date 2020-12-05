package com.goodgamestudios.mafia.view.screens.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaBonusQuestScreenProperties extends BasicProperties
   {
       
      
      public var gangwar:GangwarVO;
      
      public function MafiaBonusQuestScreenProperties(param1:GangwarVO)
      {
         this.gangwar = param1;
         super();
      }
   }
}
