package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.view.components.MafiaAccessoryTooltipHelper;
   import com.goodgamestudios.mafia.view.components.MafiaConsumableTooltipHelper;
   import com.goodgamestudios.mafia.view.components.MafiaSkillTooltipHelper;
   import com.goodgamestudios.mafia.view.components.MafiaWeaponTooltipHelper;
   import com.goodgamestudios.mafia.view.helper.MiniGridHelper;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaFightEquipmentTooltipProperties;
   import com.goodgamestudios.mafia.vo.items.AccessoryVO;
   import com.goodgamestudios.mafia.vo.items.ConsumableVO;
   import com.goodgamestudios.mafia.vo.items.SkillVO;
   import com.goodgamestudios.mafia.vo.items.WeaponVO;
   import flash.display.DisplayObject;
   
   public class MafiaAdvancedFightEquipmentTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaFightEquipmentTooltip";
       
      
      private var minigrid:MiniGridHelper;
      
      private const DESCRIPTION_HEADER_HEIGHT:int = 33;
      
      private const TOOLTIP_BG_HEIGHT:int = 34;
      
      private const ARMAMENTNAMEITEMLINE:int = 28;
      
      private const ARMAMENTITEMPROPERTIES:int = 19;
      
      public function MafiaAdvancedFightEquipmentTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      override protected function applyProperties() : void
      {
         this.resetTooltip();
         MovieClipHelper.clearMovieClip(this.advancedTooltip.minigrid);
         this.minigrid = new MiniGridHelper(this.advancedTooltip.minigrid,this.advancedTooltipProperties.item.armamentComponent.widthInGrid,this.advancedTooltipProperties.item.armamentComponent.heightInGrid);
         this.advancedTooltip.txt_category.text = this.advancedTooltipProperties.item.categoryNameWithoutQuality;
         this.advancedTooltip.txt_size.text = this.advancedTooltipProperties.item.armamentComponent.widthInGrid + "X" + this.advancedTooltipProperties.item.armamentComponent.heightInGrid;
         if(this.advancedTooltipProperties.item.qualityName)
         {
            this.advancedTooltip.txt_quality.text = this.advancedTooltipProperties.item.qualityName;
         }
         switch(this.advancedTooltipProperties.item.type)
         {
            case ItemType.Weapon:
               this.advancedTooltip.header.gotoAndStop(1);
               MafiaWeaponTooltipHelper.instance.createTooltipBody(this.advancedTooltipProperties.item as WeaponVO,this.advancedTooltip.body);
               break;
            case ItemType.Consumable:
               this.advancedTooltip.header.gotoAndStop(2);
               MafiaConsumableTooltipHelper.instance.createTooltipBody(this.advancedTooltipProperties.item as ConsumableVO,this.advancedTooltip.body);
               break;
            case ItemType.Skill:
               this.advancedTooltip.header.gotoAndStop(3);
               MafiaSkillTooltipHelper.instance.createTooltipBody(this.advancedTooltipProperties.item as SkillVO,this.advancedTooltip.body);
               break;
            case ItemType.Accessory:
               this.advancedTooltip.header.gotoAndStop(4);
               MafiaAccessoryTooltipHelper.instance.createTooltipBody(this.advancedTooltipProperties.item as AccessoryVO,this.advancedTooltip.body);
         }
         this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + this.advancedTooltip.body.height;
         updateAllTextFields();
      }
      
      override public function destroy() : void
      {
         this.resetTooltip();
         super.destroy();
      }
      
      override public function hide() : void
      {
         this.resetTooltip();
         super.hide();
      }
      
      private function resetTooltip() : void
      {
         this.advancedTooltip.bg.height = this.TOOLTIP_BG_HEIGHT;
         MovieClipHelper.clearMovieClip(this.advancedTooltip.body);
         this.advancedTooltip.txt_quality.text = "";
         this.advancedTooltip.txt_category.text = "";
         this.advancedTooltip.txt_size.text = "";
      }
      
      protected function get advancedTooltipProperties() : MafiaFightEquipmentTooltipProperties
      {
         return properties as MafiaFightEquipmentTooltipProperties;
      }
      
      protected function get advancedTooltip() : MafiaFightEquipmentTooltip
      {
         return disp as MafiaFightEquipmentTooltip;
      }
   }
}
