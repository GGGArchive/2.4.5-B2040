package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.MissionVO;
   
   public class MafiaMissionAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var missionVO:MissionVO;
      
      public function MafiaMissionAdvancedTooltipProperties(param1:MissionVO)
      {
         this.missionVO = param1;
         super();
      }
   }
}
