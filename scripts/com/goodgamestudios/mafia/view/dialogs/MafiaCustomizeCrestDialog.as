package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.controller.commands.clan.ChangeCrestCommand;
   import com.goodgamestudios.mafia.helper.FamilyCrestHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.NewBasicStandartButton;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCustomizeCrestDialogProperties;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestPartVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   
   public class MafiaCustomizeCrestDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaCustomizeCrestDialog";
       
      
      private var crestVO:FamilyCrestVO;
      
      public function MafiaCustomizeCrestDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.customizeCrestDialog.btn_save.label = MafiaModel.languageData.getTextById("generic_register_btn_save",[]);
         this.customizeCrestDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaFamilyCrestDialog_title",[]);
         this.customizeCrestDialog.icon_primary.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyCrestDialog_copy_1",[]);
         this.customizeCrestDialog.icon_variation.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyCrestDialog_copy_2",[]);
         this.customizeCrestDialog.icon_secondary.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyCrestDialog_copy_3",[]);
         this.customizeCrestDialog.icon_banderole.toolTipText = MafiaModel.languageData.getTextById("MafiaFamilyCrestDialog_copy_4",[]);
         this.customizeCrestDialog.btn_random.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_random",[]);
         this.hideColorPickers();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
      }
      
      override protected function applyProperties() : void
      {
         this.crestVO = this.customizeCrestDialogProperties.crestVO;
         this.updateCrest();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         super.onClick(param1);
         this.hideColorPickers();
         var _loc2_:NewBasicStandartButton = param1.target as NewBasicStandartButton;
         if(_loc2_ != null && !_loc2_.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.customizeCrestDialog.btn_save:
               ChangeCrestCommand.sendCommand(this.crestVO);
            case this.customizeCrestDialog.btn_close:
               hide();
               break;
            case this.customizeCrestDialog.btn_primary_next:
               this.crestVO.primary = FamilyCrestHelper.getNextAvailablePart(this.crestVO.primary,MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_primary_prev:
               this.crestVO.primary = FamilyCrestHelper.getPrevAvailablePart(this.crestVO.primary,MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_variation_next:
               this.crestVO.primary = FamilyCrestHelper.getNextAvailableVariationForPart(this.crestVO.primary,MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_variation_prev:
               this.crestVO.primary = FamilyCrestHelper.getPrevAvailableVariationForPart(this.crestVO.primary,MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_secondary_next:
               this.crestVO.secondary = FamilyCrestHelper.getNextAvailablePart(this.crestVO.secondary,MafiaModel.userData.userClan.availableFamilyCrestSecondaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_secondary_prev:
               this.crestVO.secondary = FamilyCrestHelper.getPrevAvailablePart(this.crestVO.secondary,MafiaModel.userData.userClan.availableFamilyCrestSecondaryParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_banderole_next:
               this.crestVO.banderole = FamilyCrestHelper.getNextAvailablePart(this.crestVO.banderole,MafiaModel.userData.userClan.availableFamilyCrestBanderoleParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_banderole_prev:
               this.crestVO.banderole = FamilyCrestHelper.getPrevAvailablePart(this.crestVO.banderole,MafiaModel.userData.userClan.availableFamilyCrestBanderoleParts);
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_primary_color:
               this.fillColorPicker(this.customizeCrestDialog.colorpicker_primary,FamilyCrestHelper.getAvailableColorsOfPart(this.crestVO.primary));
               this.customizeCrestDialog.colorpicker_primary.visible = true;
               break;
            case this.customizeCrestDialog.btn_secondary_color:
               this.fillColorPicker(this.customizeCrestDialog.colorpicker_secondary,FamilyCrestHelper.getAvailableColorsOfPart(this.crestVO.secondary));
               this.customizeCrestDialog.colorpicker_secondary.visible = true;
               break;
            case this.customizeCrestDialog.btn_banderole_color:
               this.fillColorPicker(this.customizeCrestDialog.colorpicker_banderole,FamilyCrestHelper.getAvailableColorsOfPart(this.crestVO.banderole));
               this.customizeCrestDialog.colorpicker_banderole.visible = true;
               break;
            case this.customizeCrestDialog.colorpicker_primary.color_0:
            case this.customizeCrestDialog.colorpicker_primary.color_1:
            case this.customizeCrestDialog.colorpicker_primary.color_2:
            case this.customizeCrestDialog.colorpicker_primary.color_3:
            case this.customizeCrestDialog.colorpicker_primary.color_4:
            case this.customizeCrestDialog.colorpicker_primary.color_5:
            case this.customizeCrestDialog.colorpicker_primary.color_6:
            case this.customizeCrestDialog.colorpicker_primary.color_7:
            case this.customizeCrestDialog.colorpicker_primary.color_8:
               _loc3_ = (param1.target as MovieClip).name;
               this.crestVO.primary.color = int(_loc3_.charAt(_loc3_.length - 1));
               this.updateCrest();
               break;
            case this.customizeCrestDialog.colorpicker_secondary.color_0:
            case this.customizeCrestDialog.colorpicker_secondary.color_1:
            case this.customizeCrestDialog.colorpicker_secondary.color_2:
            case this.customizeCrestDialog.colorpicker_secondary.color_3:
            case this.customizeCrestDialog.colorpicker_secondary.color_4:
            case this.customizeCrestDialog.colorpicker_secondary.color_5:
            case this.customizeCrestDialog.colorpicker_secondary.color_6:
            case this.customizeCrestDialog.colorpicker_secondary.color_7:
            case this.customizeCrestDialog.colorpicker_secondary.color_8:
               _loc4_ = (param1.target as MovieClip).name;
               this.crestVO.secondary.color = int(_loc4_.charAt(_loc4_.length - 1));
               this.updateCrest();
               break;
            case this.customizeCrestDialog.colorpicker_banderole.color_0:
            case this.customizeCrestDialog.colorpicker_banderole.color_1:
            case this.customizeCrestDialog.colorpicker_banderole.color_2:
            case this.customizeCrestDialog.colorpicker_banderole.color_3:
            case this.customizeCrestDialog.colorpicker_banderole.color_4:
            case this.customizeCrestDialog.colorpicker_banderole.color_5:
            case this.customizeCrestDialog.colorpicker_banderole.color_6:
            case this.customizeCrestDialog.colorpicker_banderole.color_7:
            case this.customizeCrestDialog.colorpicker_banderole.color_8:
               _loc5_ = (param1.target as MovieClip).name;
               this.crestVO.banderole.color = int(_loc5_.charAt(_loc5_.length - 1));
               this.updateCrest();
               break;
            case this.customizeCrestDialog.btn_random:
               this.crestVO = FamilyCrestHelper.getRandomCrest();
               this.updateCrest();
         }
      }
      
      private function updateCrest() : void
      {
         this.updatePrimaryVariationButtons();
         this.updatePrimaryColorButton();
         this.updateSecondaryColorButton();
         this.updateBanderoleColorButton();
         this.updateCostLabels();
         MovieClipHelper.clearMovieClip(this.customizeCrestDialog.container);
         this.customizeCrestDialog.container.addChild(FamilyCrestHelper.createFamilyCrest(this.crestVO,MafiaModel.userData.userClan.clanName));
      }
      
      private function updatePrimaryVariationButtons() : void
      {
         var _loc1_:Boolean = FamilyCrestHelper.doesPartHaveVariations(this.crestVO.primary,MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts);
         this.customizeCrestDialog.btn_variation_next.enableButton = this.customizeCrestDialog.btn_variation_prev.enableButton = _loc1_;
         this.customizeCrestDialog.icon_variation.gotoAndStop(!!_loc1_?1:2);
      }
      
      private function updatePrimaryColorButton() : void
      {
         this.updateColorButton(this.customizeCrestDialog.btn_primary_color,this.crestVO.primary);
      }
      
      private function updateSecondaryColorButton() : void
      {
         this.updateColorButton(this.customizeCrestDialog.btn_secondary_color,this.crestVO.secondary);
      }
      
      private function updateBanderoleColorButton() : void
      {
         this.customizeCrestDialog.btn_banderole_color.enableButton = this.crestVO.banderole.type != 6;
         if(this.customizeCrestDialog.btn_banderole_color.enabled)
         {
            this.updateColorButton(this.customizeCrestDialog.btn_banderole_color,this.crestVO.banderole);
         }
      }
      
      private function updateColorButton(param1:MovieClip, param2:FamilyCrestPartVO) : void
      {
         var _loc3_:Object = FamilyCrestHelper.getSelectedColorsOfPart(param2);
         if(_loc3_ is Array)
         {
            this.colorizeDisp(param1.color_0,(_loc3_ as Array)[0]);
            this.colorizeDisp(param1.color_1,(_loc3_ as Array)[1]);
            param1.color_1.visible = true;
         }
         else
         {
            this.colorizeDisp(param1.color_0,_loc3_ as int);
            param1.color_1.visible = false;
         }
      }
      
      private function updateCostLabels() : void
      {
         var _loc1_:uint = !!FamilyCrestHelper.arePartsIdentical(this.crestVO.primary,MafiaModel.userData.userClan.familyCrest.primary)?uint(0):uint(this.crestVO.primary.costGold);
         var _loc2_:uint = !!FamilyCrestHelper.arePartsIdentical(this.crestVO.secondary,MafiaModel.userData.userClan.familyCrest.secondary)?uint(0):uint(this.crestVO.secondary.costGold);
         var _loc3_:uint = !!FamilyCrestHelper.arePartsIdentical(this.crestVO.banderole,MafiaModel.userData.userClan.familyCrest.banderole)?uint(0):uint(this.crestVO.banderole.costGold);
         this.customizeCrestDialog.cost_primary.visible = _loc1_ > 0;
         this.customizeCrestDialog.cost_secondary.visible = _loc2_ > 0;
         this.customizeCrestDialog.cost_banderole.visible = _loc3_ > 0;
         this.customizeCrestDialog.cost_primary.txt.text = _loc1_;
         this.customizeCrestDialog.cost_secondary.txt.text = _loc2_;
         this.customizeCrestDialog.cost_banderole.txt.text = _loc3_;
         var _loc4_:uint = _loc1_ + _loc2_ + _loc3_;
         this.customizeCrestDialog.btn_save.goldInfoVisible = _loc4_ > 0;
         this.customizeCrestDialog.btn_save.goldInfoTimeText = _loc4_.toString();
      }
      
      private function hideColorPickers() : void
      {
         this.customizeCrestDialog.colorpicker_primary.visible = false;
         this.customizeCrestDialog.colorpicker_secondary.visible = false;
         this.customizeCrestDialog.colorpicker_banderole.visible = false;
      }
      
      private function fillColorPicker(param1:MovieClip, param2:Array) : void
      {
         var _loc4_:NewBasicStandartButton = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc3_:int = 0;
         while(_loc3_ <= 8)
         {
            _loc4_ = param1["color_" + _loc3_];
            _loc5_ = param2[_loc3_];
            if(_loc5_ == null)
            {
               _loc4_.enableButton = false;
            }
            else if(_loc5_ is Array)
            {
               _loc4_.enableButton = true;
               _loc6_ = _loc5_ as Array;
               if(_loc6_.length == 2)
               {
                  _loc4_.colors.gotoAndStop(2);
                  this.colorizeDisp(_loc4_.colors.color_0,_loc6_[0]);
                  this.colorizeDisp(_loc4_.colors.color_1,_loc6_[1]);
               }
               else if(_loc6_.length == 3)
               {
                  _loc4_.colors.gotoAndStop(3);
                  this.colorizeDisp(_loc4_.colors.color_0,_loc6_[0]);
                  this.colorizeDisp(_loc4_.colors.color_1,_loc6_[1]);
                  this.colorizeDisp(_loc4_.colors.color_2,_loc6_[2]);
               }
               else
               {
                  trace("wrong number of colors");
               }
            }
            else
            {
               _loc4_.enableButton = true;
               _loc4_.colors.gotoAndStop(1);
               this.colorizeDisp(_loc4_.colors.color_0,_loc5_ as int);
            }
            _loc3_++;
         }
      }
      
      private function colorizeDisp(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:ColorTransform = new ColorTransform();
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      protected function get customizeCrestDialogProperties() : MafiaCustomizeCrestDialogProperties
      {
         return properties as MafiaCustomizeCrestDialogProperties;
      }
      
      private function get customizeCrestDialog() : MafiaCustomizeCrest
      {
         return disp as MafiaCustomizeCrest;
      }
   }
}
