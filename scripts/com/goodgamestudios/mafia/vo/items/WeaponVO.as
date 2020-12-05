package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.vo.items.components.WeaponDamageItemComponent;
   
   public class WeaponVO extends ArmamentItemVO
   {
       
      
      public function WeaponVO()
      {
         super();
         addComponent(new WeaponDamageItemComponent());
      }
      
      public function get weaponDamage() : WeaponDamageItemComponent
      {
         return getComponent(WeaponDamageItemComponent) as WeaponDamageItemComponent;
      }
   }
}
