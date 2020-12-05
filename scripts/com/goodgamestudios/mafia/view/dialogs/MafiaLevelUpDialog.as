package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewGearCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewInventoryCommand;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaLevelUpDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MafiaLevelUpDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaLevelUpDialog";
       
      
      private var standardTxtWidth:Number;
      
      public function MafiaLevelUpDialog(param1:Sprite)
      {
         super(param1);
         this.standardTxtWidth = this.standardDialog.txt_attribut.width;
      }
      
      override public function show() : void
      {
         super.show();
         BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_LEVEL_UP);
         MafiaLayoutManager.getInstance().hidePanel(MafiaReviewTutorialPanel.NAME);
         if(!MafiaTutorialController.getInstance().isActive)
         {
            MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_PROFILE;
         }
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_no;
         this.standardDialog.bg.gotoAndStop(2);
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         TextFieldHelper.changeTextFromatSizeByTextWidth(48,this.standardDialog.txt_level,this.standardDialogProperties.level.toString(),1);
         this.standardDialog.txt_award.text = MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_5");
         this.standardDialog.txt_attribut.text = "+3 " + MafiaModel.languageData.getTextById("MafiaLevelUpDialog_copy_2");
         this.standardDialog.gold.visible = true;
         this.standardDialog.txt_gold.text = "+" + MafiaModel.goldConstants.levelUpGold.toString();
         if(!env.enableFeedMessages)
         {
            this.standardDialog.btn_ok.visible = false;
         }
         MovieClipHelper.clearMovieClip(this.standardDialog.mc_unlock);
         switch(this.standardDialogProperties.level)
         {
            case Constants_UnlockLevel.UNLOCK_DUEL:
               _loc1_ = new DuelBtnAsset();
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
               if(!MafiaTutorialController.getInstance().isActive)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_DUEL;
               }
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Duel")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_FAST_QUIT_MISSION:
               _loc1_ = new UnlockFastQuitMissionIcon();
               _loc1_.scaleX = _loc1_.scaleY = 1.6;
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_FastQuitQuest")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_BOOSTER:
               _loc2_ = getDefinitionByName("BO2") as Class;
               _loc1_ = new _loc2_();
               _loc1_.scaleX = _loc1_.scaleY = 0.6;
               _loc1_.x = _loc1_.x - _loc1_.width / 1.5;
               _loc1_.y = _loc1_.y - _loc1_.height;
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Booster")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_BARKEEPER:
               _loc1_ = new Drink();
               _loc1_.scaleX = _loc1_.scaleY = 1;
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Barkeeper")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_WORK:
               _loc1_ = new WorkSymbol();
               _loc1_.scaleX = _loc1_.scaleY = 0.6;
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_ProtectionMoney")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_WANTED:
               _loc1_ = new UnlockWantedIcon();
               _loc1_.scaleX = _loc1_.scaleY = 1.7;
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Wanted")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_CLAN_CREATION:
               _loc1_ = new ClanBtnAsset();
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Family")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_DUNGEON1:
               _loc1_ = new GangwarBtnAsset();
               ShowGangWarsCommand.sendCommand();
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_Gangwarfare")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            case Constants_UnlockLevel.UNLOCK_DUNGEON2:
            case Constants_UnlockLevel.UNLOCK_DUNGEON3:
            case Constants_UnlockLevel.UNLOCK_DUNGEON4:
            case Constants_UnlockLevel.UNLOCK_DUNGEON5:
            case Constants_UnlockLevel.UNLOCK_DUNGEON6:
            case Constants_UnlockLevel.UNLOCK_DUNGEON7:
            case Constants_UnlockLevel.UNLOCK_DUNGEON8:
            case Constants_UnlockLevel.UNLOCK_DUNGEON9:
            case Constants_UnlockLevel.UNLOCK_DUNGEON10:
            case Constants_UnlockLevel.UNLOCK_DUNGEON11:
            case Constants_UnlockLevel.UNLOCK_DUNGEON12:
            case Constants_UnlockLevel.UNLOCK_DUNGEON13:
            case Constants_UnlockLevel.UNLOCK_DUNGEON14:
            case Constants_UnlockLevel.UNLOCK_DUNGEON15:
            case Constants_UnlockLevel.UNLOCK_DUNGEON16:
            case Constants_UnlockLevel.UNLOCK_DUNGEON17:
            case Constants_UnlockLevel.UNLOCK_DUNGEON18:
               _loc1_ = new GangwarBtnAsset();
               this.standardDialog.mc_unlock.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaLevelUpDialog_GangwarfareNew")),null,MafiaToolTipManager.TOPDISPMOUSEPOS,BasicCustomCursor.CURSOR_ARROW);
               break;
            default:
               this.standardDialog.mc_unlock.toolTipVO = null;
               _loc1_ = new emptyMC();
         }
         this.standardDialog.mc_unlock.mouseChildren = false;
         this.standardDialog.mc_unlock.addChild(_loc1_);
         this.standardDialog.txt_attribut.width = this.standardTxtWidth - _loc1_.width;
         _loc1_.x = _loc1_.x - _loc1_.width / 2;
         _loc1_.y = _loc1_.y - _loc1_.height / 2;
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_LEVEL_UP:
                  MafiaTutorialController.getInstance().flipArrow();
                  this.standardDialog.btn_no.addChild(MafiaTutorialController.getInstance().tutorialArrow);
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_ok:
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_LEVEL_UP:
                        MafiaTutorialController.getInstance().nextStep();
                  }
               }
               hide();
               this.updateUserData();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(null);
               }
               break;
            case this.standardDialog.btn_no:
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_LEVEL_UP:
                        MafiaTutorialController.getInstance().nextStep();
                  }
               }
               this.updateUserData();
               hide();
         }
      }
      
      private function updateUserData() : void
      {
         ViewGearCommand.sendCommand(MafiaModel.userData.playerID);
         ViewInventoryCommand.sendCommand();
         ViewArmamentCommand.sendCommand(MafiaModel.userData.playerID);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_DATA));
      }
      
      protected function get standardDialogProperties() : MafiaLevelUpDialogProperties
      {
         return properties as MafiaLevelUpDialogProperties;
      }
      
      protected function get standardDialog() : MafiaLevelUp
      {
         return disp as MafiaLevelUp;
      }
   }
}
