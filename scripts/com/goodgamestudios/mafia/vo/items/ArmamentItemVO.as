package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.EffectItemComponent;
   
   public class ArmamentItemVO extends ItemVO
   {
       
      
      public function ArmamentItemVO()
      {
         super();
         addComponent(new ArmamentItemComponent());
         addComponent(new EffectItemComponent());
      }
      
      public function get armamentComponent() : ArmamentItemComponent
      {
         return getComponent(ArmamentItemComponent) as ArmamentItemComponent;
      }
      
      public function get effectComponent() : EffectItemComponent
      {
         return getComponent(EffectItemComponent) as EffectItemComponent;
      }
   }
}
