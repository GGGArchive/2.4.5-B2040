package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaCityDistrictTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var gangwarVO:GangwarVO;
      
      public function MafiaCityDistrictTooltipProperties(param1:GangwarVO)
      {
         super();
         this.gangwarVO = param1;
      }
   }
}
