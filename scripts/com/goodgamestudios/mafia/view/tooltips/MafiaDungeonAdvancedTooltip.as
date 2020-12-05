package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaDungeonAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaDungeonAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaDungeonAdvancedTooltip";
       
      
      public function MafiaDungeonAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_3") + " " + Number(this.advancedTooltipProperties.dungeon.district_id + 1);
         this.advancedTooltip.txt_copy.text = this.advancedTooltipProperties.copy;
         TextFieldHelper.changeSingleLineTextVerticalAlignInMultiLineTextfield(this.advancedTooltip.txt_copy,2.1);
      }
      
      protected function get advancedTooltip() : MafiaGangwarTooltip
      {
         return disp as MafiaGangwarTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaDungeonAdvancedTooltipProperties
      {
         return properties as MafiaDungeonAdvancedTooltipProperties;
      }
   }
}
