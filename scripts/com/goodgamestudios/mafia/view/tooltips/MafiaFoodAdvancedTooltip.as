package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaFoodAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   
   public class MafiaFoodAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaFoodAdvancedTooltip";
       
      
      private const XPOS:int = -101;
      
      private const PROPERTIEHEIGHT:int = 19;
      
      private const COMPARE:int = 5;
      
      private var yPos:Number;
      
      public function MafiaFoodAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:ItemProperties = null;
         var _loc2_:ItemProperties = null;
         var _loc3_:ItemProperties = null;
         var _loc4_:ItemProperties = null;
         this.advancedTooltip.bg.height = 100;
         this.advancedTooltip.compareItemLine.y = 73;
         this.advancedTooltip.txt_category.text = this.advancedTooltipProperties.food.categoryName;
         this.advancedTooltip.txt_name.text = this.advancedTooltipProperties.food.name;
         this.advancedTooltip.txt_category.textColor = MafiaItemData.getColorForItemQuality(this.advancedTooltipProperties.food);
         this.yPos = 55;
         if(this.advancedTooltipProperties.food.attributeBonusComponent.attack > 0)
         {
            _loc1_ = this.itemProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack"),NumberStringHelper.groupString(this.advancedTooltipProperties.food.attributeBonusComponent.attack,MafiaModel.languageData.getTextById),this.advancedTooltipProperties.food.attributeBonusComponent.attackPerc);
            _loc1_.y = this.yPos;
            _loc1_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc1_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         if(this.advancedTooltipProperties.food.attributeBonusComponent.endurance > 0)
         {
            _loc2_ = this.itemProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance"),NumberStringHelper.groupString(this.advancedTooltipProperties.food.attributeBonusComponent.endurance,MafiaModel.languageData.getTextById),this.advancedTooltipProperties.food.attributeBonusComponent.endurancePerc);
            _loc2_.y = this.yPos;
            _loc2_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc2_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         if(this.advancedTooltipProperties.food.attributeBonusComponent.luck > 0)
         {
            _loc3_ = this.itemProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck"),NumberStringHelper.groupString(this.advancedTooltipProperties.food.attributeBonusComponent.luck,MafiaModel.languageData.getTextById),this.advancedTooltipProperties.food.attributeBonusComponent.luckPerc);
            _loc3_.y = this.yPos;
            _loc3_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc3_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         if(this.advancedTooltipProperties.food.attributeBonusComponent.toughness > 0)
         {
            _loc4_ = this.itemProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough"),NumberStringHelper.groupString(this.advancedTooltipProperties.food.attributeBonusComponent.toughness,MafiaModel.languageData.getTextById),this.advancedTooltipProperties.food.attributeBonusComponent.toughnessPerc);
            _loc4_.y = this.yPos;
            _loc4_.x = this.XPOS;
            this.advancedTooltip.addChildAt(_loc4_,this.advancedTooltip.numChildren);
            this.yPos = this.yPos + this.PROPERTIEHEIGHT;
         }
         this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + (this.yPos - 80);
         this.advancedTooltip.compareItemLine.y = this.yPos;
         this.advancedTooltip.txt_duration.y = this.advancedTooltip.compareItemLine.y + 2;
         if(layoutManager.actState != Constants_LayoutStates.STATE_OTHERPROFILE)
         {
            this.advancedTooltip.txt_duration.text = this.advancedTooltipProperties.food.expiringComponent.remainingTime;
         }
         else
         {
            this.advancedTooltip.compareItemLine.visible = false;
            this.advancedTooltip.bg.height = this.advancedTooltip.bg.height - 20;
            this.advancedTooltip.txt_duration.text = "";
         }
      }
      
      private function itemProperties(param1:String, param2:String, param3:Boolean = false) : ItemProperties
      {
         var _loc4_:ItemProperties = new ItemProperties();
         if(param3)
         {
            param2 = "+ " + param2 + "%";
         }
         _loc4_.txt_description.text = param1;
         _loc4_.txt_value.text = param2;
         updateTextField(_loc4_.txt_description);
         updateTextField(_loc4_.txt_value);
         _loc4_.shop.visible = false;
         return _loc4_;
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
         while(this.advancedTooltip.numChildren > 6)
         {
            this.advancedTooltip.removeChildAt(6);
         }
      }
      
      protected function get advancedTooltip() : MafiaFoodTooltip
      {
         return disp as MafiaFoodTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaFoodAdvancedTooltipProperties
      {
         return properties as MafiaFoodAdvancedTooltipProperties;
      }
   }
}
