package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.basic.vo.BasicTooltipVO;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaAdvancedTooltipProperties;
   import flash.geom.Point;
   
   public class TooltipVO extends BasicTooltipVO
   {
       
      
      public function TooltipVO(param1:String = null, param2:MafiaAdvancedTooltipProperties = null, param3:Point = null, param4:String = "", param5:int = 1)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
