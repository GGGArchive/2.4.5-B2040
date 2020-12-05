package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.AttributeBonusItemComponent;
   
   public class GearVO extends ItemVO
   {
       
      
      public function GearVO()
      {
         super();
         addComponent(new AttributeBonusItemComponent());
      }
      
      public function get attributeBonusComponent() : AttributeBonusItemComponent
      {
         return getComponent(AttributeBonusItemComponent) as AttributeBonusItemComponent;
      }
   }
}
