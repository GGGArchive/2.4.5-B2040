package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.SlotVO;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   
   public class MafiaFoodAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var food:FoodVO;
      
      public var slot:SlotVO;
      
      public function MafiaFoodAdvancedTooltipProperties(param1:FoodVO, param2:SlotVO = null)
      {
         this.food = param1;
         if(param2)
         {
            this.slot = param2;
         }
         super();
      }
   }
}
