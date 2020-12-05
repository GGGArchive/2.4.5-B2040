package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemDependencyComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   
   public class ConsumableVO extends ArmamentItemVO
   {
       
      
      public function ConsumableVO()
      {
         super();
         addComponent(new StackableComponent());
         addComponent(new ArmamentItemDependencyComponent());
      }
      
      public function get stackableComponent() : StackableComponent
      {
         return getComponent(StackableComponent) as StackableComponent;
      }
      
      public function get dependencyComponent() : ArmamentItemDependencyComponent
      {
         return getComponent(ArmamentItemDependencyComponent) as ArmamentItemDependencyComponent;
      }
   }
}
