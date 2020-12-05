package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class PreCombatLeftFighter extends MovieClip
   {
       
      
      public var txt_attack_label:TextField;
      
      public var armamentGrid:ArmamentGrid;
      
      public var avatarHolder:emptyMC;
      
      public var txt_toughness_value:TextField;
      
      public var txt_attack_value:TextField;
      
      public var txt_toughness_label:TextField;
      
      public var txt_luck_label:TextField;
      
      public var header:MovieClip;
      
      public var txt_health:TextField;
      
      public var txt_endurance_label:TextField;
      
      public var combatPreset:CombatPresetMC;
      
      public var healthBar:HealthBar;
      
      public var txt_deactivate_consumables:TextField;
      
      public var inventoryPanel:MovieClip;
      
      public var checkbox_dont_use_consumables:CheckBox;
      
      public var txt_luck_value:TextField;
      
      public var txt_endurance_value:TextField;
      
      public function PreCombatLeftFighter()
      {
         super();
      }
   }
}
