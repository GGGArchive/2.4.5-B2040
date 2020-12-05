package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.SlotVO;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   
   public class MafiaFightEquipmentTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var item:ArmamentItemVO;
      
      public var itemToCompare:ArmamentItemVO;
      
      public var slot:SlotVO;
      
      public function MafiaFightEquipmentTooltipProperties(param1:ArmamentItemVO, param2:ArmamentItemVO = null, param3:SlotVO = null)
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
