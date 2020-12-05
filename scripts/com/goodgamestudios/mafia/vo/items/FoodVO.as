package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.AttributeBonusItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.ExpiringComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   
   public class FoodVO extends ItemVO
   {
       
      
      public function FoodVO()
      {
         super();
         addComponent(new AttributeBonusItemComponent());
         addComponent(new StackableComponent());
         addComponent(new ExpiringComponent());
      }
      
      public function get attributeBonusComponent() : AttributeBonusItemComponent
      {
         return getComponent(AttributeBonusItemComponent) as AttributeBonusItemComponent;
      }
      
      public function get stackableComponent() : StackableComponent
      {
         return getComponent(StackableComponent) as StackableComponent;
      }
      
      public function get expiringComponent() : ExpiringComponent
      {
         return getComponent(ExpiringComponent) as ExpiringComponent;
      }
   }
}
