package com.goodgamestudios.mafia.view.screens.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaGangwarTreeScreenProperties extends BasicProperties
   {
       
      
      public var dungeon:GangwarVO;
      
      public function MafiaGangwarTreeScreenProperties(param1:GangwarVO)
      {
         this.dungeon = param1;
         super();
      }
   }
}
