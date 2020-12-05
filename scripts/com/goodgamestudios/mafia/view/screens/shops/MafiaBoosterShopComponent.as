package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.controller.commands.booster.BuyMissionBoosterCommand;
   import com.goodgamestudios.mafia.event.model.MafiaBoosterEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaBoosterAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaBoosterAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.BoosterShopItemVO;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaBoosterShopComponent extends MafiaScreen
   {
       
      
      public function MafiaBoosterShopComponent(param1:DisplayObject)
      {
         super(param1,false);
      }
      
      override public function updatePosition() : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaBoosterEvent.CHANGE_BOOSTERSHOPDATA,this.onChangeBoosterShopData);
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.shop.txt_copy,MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_copy_1"),10);
         this.shop.boosterLevelBlock.txt_lock.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_BOOSTER]);
         if(!MafiaModel.userData.profileData.isBoosterUnlocked)
         {
            this.shop.boosterLevelBlock.visible = true;
         }
         else
         {
            this.shop.boosterLevelBlock.visible = false;
         }
         this.fillBoosterShop(MafiaModel.userData.boosterShop.booster);
      }
      
      override public function destroy() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.shop["shop" + _loc1_] as MovieClip;
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onOverBooster);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onOutBooster);
            _loc1_++;
         }
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaBoosterEvent.CHANGE_BOOSTERSHOPDATA,this.onChangeBoosterShopData);
      }
      
      private function onChangeBoosterShopData(param1:MafiaBoosterEvent) : void
      {
         this.fillBoosterShop(MafiaModel.userData.boosterShop.booster);
      }
      
      private function fillBoosterShop(param1:Vector.<BoosterShopItemVO>) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:MovieClip = null;
         var _loc6_:String = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = this.shop["shop" + _loc2_] as MovieClip;
            _loc3_.txt_price.text = "";
            _loc3_.txt_price.mouseEnabled = false;
            _loc3_.txt_energy.text = "";
            _loc3_.txt_energy.mouseEnabled = false;
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onOverBooster);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onOutBooster);
            _loc4_ = getDefinitionByName("BO" + param1[_loc2_].boosterID) as Class;
            _loc5_ = new _loc4_();
            _loc5_.properties = param1[_loc2_];
            _loc5_.scaleX = _loc5_.scaleY = 0.5;
            _loc5_.mouseEnabled = false;
            MovieClipHelper.clearMovieClip(_loc3_.holder);
            _loc3_.holder.addChild(_loc5_);
            _loc3_.holder.mouseEnabled = false;
            _loc3_.toolTipVO = null;
            if(MafiaModel.userData.boosterData.boosterID == param1[_loc2_].boosterID)
            {
               _loc6_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_boosterduration");
               _loc6_ = _loc6_ + ("\n" + TimeStringHelper.getTimeToString((MafiaModel.userData.boosterData.boosterEndTime - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
               _loc3_.toolTipVO = new TooltipVO(MafiaBoosterAdvancedTooltip.NAME,new MafiaBoosterAdvancedTooltipProperties(_loc5_.properties,MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_copy_" + int(_loc5_.properties.boosterID * 2)),_loc6_),new Point(this.shop.x + _loc3_.x + _loc3_.width * 0.5,this.shop.y + _loc3_.y - 2),"",BasicCustomCursor.CURSOR_ARROW);
               _loc3_.boosterActiv.visible = true;
            }
            else
            {
               _loc3_.toolTipVO = new TooltipVO(MafiaBoosterAdvancedTooltip.NAME,new MafiaBoosterAdvancedTooltipProperties(_loc5_.properties,MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_copy_" + int(_loc5_.properties.boosterID * 2)),MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_copy_" + int(_loc5_.properties.boosterID * 2 + 1))),new Point(this.shop.x + _loc3_.x + _loc3_.width * 0.5,this.shop.y + _loc3_.y - 2),"",BasicCustomCursor.CURSOR_ARROW);
               _loc3_.boosterActiv.visible = false;
            }
            _loc3_.highlite.gotoAndStop(param1[_loc2_].boosterID);
            _loc3_.highlite.mouseEnabled = false;
            _loc3_.energy.gotoAndStop(4);
            _loc3_.energy.mouseEnabled = false;
            _loc3_.price.mouseEnabled = false;
            _loc3_.txt_energy.text = String(param1[_loc2_].power + "%");
            _loc3_.btn_buy.toolTipText = MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_btn_rent");
            _loc3_.btn_buy.enableButton = true;
            _loc3_.btn_buy.properties = param1[_loc2_].boosterID;
            if(MafiaModel.userData.cash < param1[_loc2_].cash && param1[_loc2_].gold == 0)
            {
               _loc3_.btn_buy.enableButton = false;
            }
            if(MafiaModel.userData.boosterData.boosterID > param1[_loc2_].boosterID)
            {
               _loc3_.btn_buy.enableButton = false;
               _loc3_.btn_buy.toolTipText = MafiaModel.languageData.getTextById("MafiaBoosterShopDialog_btn_downgrade");
            }
            if(MafiaModel.userData.boosterData.boosterID == param1[_loc2_].boosterID)
            {
               _loc3_.btn_buy.toolTipText = MafiaModel.languageData.getTextById("MafiaBoosterShopDialog_btn_extend");
            }
            if(param1[_loc2_].cash > 0)
            {
               _loc3_.txt_price.text = NumberStringHelper.groupString(param1[_loc2_].cash,MafiaModel.languageData.getTextById);
               _loc3_.price.gotoAndStop(1);
            }
            if(param1[_loc2_].gold > 0)
            {
               _loc3_.txt_price.text = NumberStringHelper.groupString(param1[_loc2_].gold,MafiaModel.languageData.getTextById);
               _loc3_.price.gotoAndStop(2);
            }
            _loc2_++;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         if(isLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.shop.shop0.btn_buy:
            case this.shop.shop1.btn_buy:
            case this.shop.shop2.btn_buy:
            case this.shop.shop3.btn_buy:
               _loc3_ = param1.target as MovieClip;
               if(!_loc3_.enabled)
               {
                  return;
               }
               _loc2_ = _loc3_.properties;
               _loc4_ = 0;
               while(_loc4_ < MafiaModel.userData.boosterShop.booster.length)
               {
                  if(MafiaModel.userData.boosterShop.booster[_loc4_].boosterID == _loc3_.properties)
                  {
                     if(MafiaModel.userData.boosterShop.booster[_loc4_].cash > MafiaModel.userData.cash)
                     {
                        layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoCashDialog_title"),MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy") + "\n" + MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy_2")));
                        return;
                     }
                     if(MafiaModel.userData.boosterShop.booster[_loc4_].gold > MafiaModel.userData.gold)
                     {
                        layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBooster_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
                        return;
                     }
                  }
                  _loc4_++;
               }
               _loc3_.enableButton = false;
               BuyMissionBoosterCommand.sendCommand(_loc2_);
               break;
         }
         super.onClick(param1);
      }
      
      private function onOverBooster(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(param1.target is BoosterShopItem)
         {
            _loc2_ = param1.target as MovieClip;
            layoutManager.tooltipManager.showAdvancedTooltip(_loc2_.toolTipVO,_loc2_ as DisplayObject);
         }
      }
      
      private function onOutBooster(param1:MouseEvent) : void
      {
         if(param1.target is BoosterShopItem)
         {
            layoutManager.tooltipManager.hideAdvancedTooltip();
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      public function get shop() : BoosterShop
      {
         return disp as BoosterShop;
      }
   }
}
