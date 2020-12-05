package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaAttributeCostsData;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaPushAttributAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaPushAttributAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaPushAttributAdvancedTooltip";
       
      
      public function MafiaPushAttributAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function show() : void
      {
         super.show();
         this.fillPushAttributCost();
      }
      
      public function cost(param1:MafiaAttributeCostsData) : void
      {
         this.advancedTooltipProperties.cost = param1;
         this.fillPushAttributCost();
      }
      
      private function fillPushAttributCost() : void
      {
         if(this.advancedTooltipProperties.cost.freeAttributes > 0)
         {
            this.advancedTooltip.txt_value.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_free",[this.advancedTooltipProperties.cost.freeAttributes.toString()]);
            this.advancedTooltip.txt_value.width = this.advancedTooltip.txt_value.textWidth + 5;
            this.advancedTooltip.cash.visible = false;
            this.advancedTooltip.bg.width = this.advancedTooltip.txt_value.textWidth + 10;
            this.advancedTooltip.txt_value.x = 0 - this.advancedTooltip.txt_value.textWidth * 0.5;
         }
         else
         {
            switch(this.advancedTooltipProperties.current)
            {
               case 1:
                  this.advancedTooltip.txt_value.text = this.advancedTooltipProperties.cost.attackCost.toString();
                  break;
               case 2:
                  this.advancedTooltip.txt_value.text = this.advancedTooltipProperties.cost.enduranceCost.toString();
                  break;
               case 3:
                  this.advancedTooltip.txt_value.text = this.advancedTooltipProperties.cost.luckCost.toString();
                  break;
               case 4:
                  this.advancedTooltip.txt_value.text = this.advancedTooltipProperties.cost.resistanceCost.toString();
            }
            this.advancedTooltip.cash.visible = true;
            this.advancedTooltip.txt_value.x = 0 - this.advancedTooltip.txt_value.textWidth * 0.5 + this.advancedTooltip.cash.width * 0.5;
            this.advancedTooltip.cash.x = this.advancedTooltip.txt_value.x - 15;
            this.advancedTooltip.bg.width = this.advancedTooltip.txt_value.textWidth + 20 + this.advancedTooltip.cash.width;
         }
      }
      
      protected function get advancedTooltip() : MafiaPushAttributTooltip
      {
         return disp as MafiaPushAttributTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaPushAttributAdvancedTooltipProperties
      {
         return properties as MafiaPushAttributAdvancedTooltipProperties;
      }
   }
}
