package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemDependencyComponent;
   
   public class SkillVO extends ArmamentItemVO
   {
       
      
      public function SkillVO()
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
