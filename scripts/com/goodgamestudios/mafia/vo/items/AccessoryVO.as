package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemDependencyComponent;
   
   public class AccessoryVO extends ArmamentItemVO
   {
       
      
      public function AccessoryVO()
      {
         super();
         addComponent(new ArmamentItemDependencyComponent());
      }
      
      public function get dependencyComponent() : ArmamentItemDependencyComponent
      {
         return getComponent(ArmamentItemDependencyComponent) as ArmamentItemDependencyComponent;
      }
   }
}
