package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.DisplayObjectDuplicater;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.ConsumableType;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaWelcomeDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.getDefinitionByName;
   
   public class MafiaWelcomeDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaWelcomeDialog";
       
      
      private const GET_IT_ON_THIS_DAY:int = -1;
      
      private var _blackOutline:GlowFilter;
      
      public function MafiaWelcomeDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         var _loc1_:int = 0;
         var _loc4_:MafiaWellcomeBonusItem = null;
         var _loc5_:Cash = null;
         var _loc6_:Gold = null;
         var _loc7_:XP = null;
         var _loc8_:String = null;
         var _loc9_:Class = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         super.show();
         this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         var _loc2_:uint = 0;
         while(_loc2_ < this.standardDialogProperties.welcomeData.length)
         {
            _loc4_ = this.standardDialog["wellcomBonus" + _loc2_] as MafiaWellcomeBonusItem;
            _loc4_.gotoAndStop(1);
            _loc4_.itemContainer.gotoAndStop(1);
            if(_loc4_.itemContainer.numChildren == 2)
            {
               _loc4_.itemContainer.removeChildAt(1);
            }
            _loc5_ = new Cash();
            _loc6_ = new Gold();
            _loc7_ = new XP();
            _loc4_.txt_day.text = MafiaModel.languageData.getTextById("generic_day") + " " + int(this.standardDialogProperties.welcomeData[_loc2_].day);
            if(this.standardDialogProperties.welcomeData[_loc2_].cash > 0)
            {
               _loc1_ = this.standardDialogProperties.welcomeData[_loc2_].day;
               _loc4_.itemContainer.addChild(_loc5_);
               this.standardDialog.itemAward.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency1")),null,MafiaToolTipManager.RIGHTDISPMOUSEPOS);
               this.showAward(DisplayObjectDuplicater.duplicate(_loc5_),_loc2_,"+ " + String(this.standardDialogProperties.welcomeData[_loc2_].cash));
            }
            else if(this.standardDialogProperties.welcomeData[_loc2_].cash == this.GET_IT_ON_THIS_DAY)
            {
               _loc4_.itemContainer.addChild(_loc5_);
            }
            if(this.standardDialogProperties.welcomeData[_loc2_].gold > 0)
            {
               _loc1_ = this.standardDialogProperties.welcomeData[_loc2_].day;
               _loc4_.itemContainer.addChild(_loc6_);
               this.standardDialog.itemAward.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2")),null,MafiaToolTipManager.RIGHTDISPMOUSEPOS);
               this.showAward(DisplayObjectDuplicater.duplicate(_loc6_),_loc2_,"+ " + String(this.standardDialogProperties.welcomeData[_loc2_].gold));
            }
            else if(this.standardDialogProperties.welcomeData[_loc2_].gold < 0)
            {
               _loc4_.itemContainer.addChild(_loc6_);
            }
            if(this.standardDialogProperties.welcomeData[_loc2_].xp > 0)
            {
               _loc1_ = this.standardDialogProperties.welcomeData[_loc2_].day;
               _loc4_.itemContainer.addChild(_loc7_);
               this.standardDialog.itemAward.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_xp")),null,MafiaToolTipManager.RIGHTDISPMOUSEPOS);
               this.showAward(DisplayObjectDuplicater.duplicate(_loc7_),_loc2_,"+ " + String(this.standardDialogProperties.welcomeData[_loc2_].xp));
            }
            else if(this.standardDialogProperties.welcomeData[_loc2_].xp == this.GET_IT_ON_THIS_DAY)
            {
               _loc4_.itemContainer.addChild(_loc7_);
            }
            if(this.standardDialogProperties.welcomeData[_loc2_].item != null)
            {
               _loc1_ = this.standardDialogProperties.welcomeData[_loc2_].day;
               _loc11_ = MafiaItemData.getInstance().generateItemIcon(this.standardDialogProperties.welcomeData[_loc2_].item);
               _loc4_.itemContainer.addChild(_loc11_);
               this.standardDialog.itemAward.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc11_.properties,TooltipDispPosition.Right);
               _loc12_ = MafiaItemData.getInstance().generateItemIcon(this.standardDialogProperties.welcomeData[_loc2_].item);
               this.showAward(_loc12_,_loc2_);
            }
            else
            {
               switch(_loc2_)
               {
                  case 1:
                     _loc8_ = MafiaItemData.getInstance().generateItemPicClassname(ItemType.Consumable,ConsumableType.Action.index,13,1);
                     break;
                  case 3:
                     _loc8_ = MafiaItemData.getInstance().generateItemPicClassname(ItemType.Consumable,ConsumableType.Healing.index,15,1);
                     break;
                  case 5:
                     _loc8_ = MafiaItemData.getInstance().generateItemPicClassname(ItemType.Consumable,ConsumableType.Surprise.index,10,1);
               }
               if(_loc2_ == 1 || _loc2_ == 3 || _loc2_ == 5)
               {
                  _loc9_ = getDefinitionByName(_loc8_) as Class;
                  _loc10_ = new _loc9_();
                  _loc10_.scaleX = 1.1;
                  _loc10_.scaleY = 1.1;
                  this._blackOutline = new GlowFilter(0,1,1.5 * this.scaleFactor,1.5 * this.scaleFactor,20,3);
                  _loc10_.filters = [this._blackOutline];
                  _loc4_.itemContainer.addChild(_loc10_);
               }
            }
            _loc2_++;
         }
         var _loc3_:String = MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_copy_5",[TextFieldHelper.generateStringByValue(_loc1_,MafiaModel.languageData.getTextById("generic_day"),MafiaModel.languageData.getTextById("generic_days"))]);
         this.standardDialog.txt_copy.text = _loc3_;
         TextFieldHelper.changeSingleLineTextVerticalAlignInMultiLineTextfield(this.standardDialog.txt_copy,1.2);
      }
      
      private function showAward(param1:MovieClip, param2:int, param3:String = "") : void
      {
         updateAllTextFields();
         this.standardDialog.mc_bg.gotoAndStop(param2 + 1);
         MovieClipHelper.clearMovieClip(this.standardDialog.itemAward);
         if(param3.length == 0)
         {
            param1.scaleX = param1.scaleY = 1.3;
         }
         else
         {
            param1.scaleX = param1.scaleY = 1;
         }
         this.standardDialog.itemAward.addChild(param1);
         this.standardDialog.itemAward.mouseChildren = false;
         this.standardDialog.txt_award.text = param3;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_ok:
               hide();
         }
      }
      
      private function get scaleFactor() : Number
      {
         if(MafiaLayoutManager.getInstance())
         {
            return MafiaLayoutManager.getInstance().scaleFactor;
         }
         return 1;
      }
      
      protected function get standardDialogProperties() : MafiaWelcomeDialogProperties
      {
         return properties as MafiaWelcomeDialogProperties;
      }
      
      protected function get standardDialog() : MafiaWelcomeBonus
      {
         return disp as MafiaWelcomeBonus;
      }
   }
}
