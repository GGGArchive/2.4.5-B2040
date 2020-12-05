package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.SlotVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class MafiaItemAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var item:ItemVO;
      
      public var itemToCompare:ItemVO;
      
      public var slot:SlotVO;
      
      public function MafiaItemAdvancedTooltipProperties(param1:ItemVO, param2:ItemVO = null, param3:SlotVO = null)
      {
         this.item = param1;
         if(param2)
         {
            this.itemToCompare = param2;
         }
         if(param3)
         {
            this.slot = param3;
         }
         super();
      }
   }
}
