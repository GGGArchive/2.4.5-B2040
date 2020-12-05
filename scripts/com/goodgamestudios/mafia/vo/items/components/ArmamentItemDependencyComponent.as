package com.goodgamestudios.mafia.vo.items.components
{
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   
   public class ArmamentItemDependencyComponent extends BasicItemComponent
   {
       
      
      public var dependencies:Vector.<WeaponType>;
      
      public function ArmamentItemDependencyComponent()
      {
         super();
      }
   }
}
