package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaNewAchievementDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MafiaNewAchievementDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaNewAchievementDialog";
       
      
      private var achievementType:String;
      
      private const POSITIONCHANGE:Number = 30;
      
      public function MafiaNewAchievementDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.show();
         if(!env.enableFeedMessages)
         {
            this.standardDialog.btn_ok.visible = false;
         }
         BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_ACHIEVEMENT);
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_close;
         this.standardDialog.btn_close.label = this.standardDialogProperties.buttonLabel_close;
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaAchievementDialog_title");
         this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaAchievementTitle_" + this.standardDialogProperties.newAchievementData.achievementID) + " " + MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_10") + " " + this.standardDialogProperties.newAchievementData.achievementLevel.toString();
         this.achievementType = this.standardDialog.txt_copy.text;
         this.standardDialog.txt_award.text = MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_5");
         MovieClipHelper.clearMovieClip(this.standardDialog.achievementType);
         var _loc1_:String = MafiaModel.userData.achievementsData.validateItem(this.standardDialogProperties.newAchievementData.achievementID);
         var _loc2_:Class = getDefinitionByName(_loc1_) as Class;
         _loc3_ = new _loc2_();
         _loc3_.mouseEnabled = false;
         _loc3_.mouseChildren = false;
         _loc3_.scaleX = _loc3_.scaleY = 1;
         this.standardDialog.achievementType.addChild(_loc3_);
         this.standardDialog.bg.height = 280;
         this.standardDialog.bg.y = 48.35;
         this.standardDialog.btn_ok.y = this.standardDialog.btn_no.y = 167;
         this.standardDialog.gold.y = 56.5;
         this.standardDialog.item.y = 102;
         if(this.standardDialogProperties.newAchievementData.allAttributesBonus > 0)
         {
            this.standardDialog.txt_attribut.visible = true;
            this.standardDialog.txt_attribut.text = "+" + this.standardDialogProperties.newAchievementData.allAttributesBonus.toString() + " " + MafiaModel.languageData.getTextById("MafiaAchievementDialog_copy_8");
         }
         else
         {
            this.standardDialog.txt_attribut.visible = false;
            this.standardDialog.bg.height = this.standardDialog.bg.height - this.POSITIONCHANGE;
            this.standardDialog.bg.y = this.standardDialog.bg.y - this.POSITIONCHANGE * 0.5;
            this.standardDialog.btn_ok.y = this.standardDialog.btn_ok.y - this.POSITIONCHANGE;
            this.standardDialog.btn_no.y = this.standardDialog.btn_no.y - this.POSITIONCHANGE;
            this.standardDialog.gold.y = this.standardDialog.gold.y - this.POSITIONCHANGE;
            this.standardDialog.item.y = this.standardDialog.item.y - this.POSITIONCHANGE;
         }
         if(this.standardDialogProperties.newAchievementData.goldBonus > 0)
         {
            this.standardDialog.gold.visible = true;
            this.standardDialog.gold.txt_gold.text = "+" + this.standardDialogProperties.newAchievementData.goldBonus.toString();
         }
         else
         {
            this.standardDialog.gold.visible = false;
            this.standardDialog.btn_ok.y = this.standardDialog.btn_ok.y - this.POSITIONCHANGE;
            this.standardDialog.btn_no.y = this.standardDialog.btn_no.y - this.POSITIONCHANGE;
            this.standardDialog.item.y = this.standardDialog.item.y - this.POSITIONCHANGE;
            this.standardDialog.bg.height = this.standardDialog.bg.height - this.POSITIONCHANGE;
            this.standardDialog.bg.y = this.standardDialog.bg.y - this.POSITIONCHANGE * 0.5;
         }
         this.standardDialog.item.toolTipVO = null;
         this.standardDialog.item.mouseChildren = false;
         if(this.standardDialogProperties.newAchievementData.item != null)
         {
            this.standardDialog.item.visible = true;
            if(this.standardDialog.item.itemContainer.numChildren == 2)
            {
               this.standardDialog.item.itemContainer.removeChildAt(1);
            }
            _loc4_ = MafiaItemData.getInstance().generateItemIcon(this.standardDialogProperties.newAchievementData.item);
            _loc4_.scaleX = _loc4_.scaleY = 0.8;
            this.standardDialog.item.itemContainer.addChild(_loc4_);
            this.standardDialog.item.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc4_.properties,TooltipDispPosition.None);
         }
         else
         {
            this.standardDialog.item.visible = false;
            this.standardDialog.bg.height = this.standardDialog.bg.height - this.POSITIONCHANGE;
            this.standardDialog.bg.y = this.standardDialog.bg.y - this.POSITIONCHANGE * 0.5;
            this.standardDialog.btn_ok.y = this.standardDialog.btn_ok.y - this.POSITIONCHANGE;
            this.standardDialog.btn_no.y = this.standardDialog.btn_no.y - this.POSITIONCHANGE;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
               hide();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(this.achievementType);
               }
               break;
            case this.standardDialog.btn_no:
            case this.standardDialog.btn_close:
               hide();
         }
      }
      
      protected function get standardDialogProperties() : MafiaNewAchievementDialogProperties
      {
         return properties as MafiaNewAchievementDialogProperties;
      }
      
      protected function get standardDialog() : MafiaAchievement
      {
         return disp as MafiaAchievement;
      }
   }
}
