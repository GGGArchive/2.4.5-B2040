package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.input.KeyCode;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.controller.commands.clan.CreateFamilyCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.LookingForFamilyCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.MafiaGroupForumsHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaClanCreationScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaClanCreationScreen";
       
      
      private var isWaitingForServerMessage:Boolean;
      
      public function MafiaClanCreationScreen(param1:Sprite)
      {
         super(param1);
         layoutManager.showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_nofamily")));
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_CLAN;
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         this.clanCreation.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.isWaitingForServerMessage = false;
         this.fillClanCreation();
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == KeyCode.ENTER && this.clanCreation.btn_yes.enabled)
         {
            this.onCreation();
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         layoutManager.hidePanel(MafiaReviewTutorialPanel.NAME);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         super.removeEvents();
      }
      
      private function onChangeUserAvatarData(param1:MafiaUserEvent) : void
      {
         this.checkLookingStatus();
      }
      
      private function checkLookingStatus() : void
      {
         if(MafiaModel.userData.profileData.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
         {
            this.clanCreation.btn_check_yes.selected();
            this.clanCreation.btn_check_no.deselected();
         }
         else
         {
            this.clanCreation.btn_check_yes.deselected();
            this.clanCreation.btn_check_no.selected();
         }
      }
      
      private function fillClanCreation() : void
      {
         this.clanCreation.txt_troopName.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_1");
         this.clanCreation.txt_troopName.maxChars = 15;
         this.clanCreation.txt_title.text = MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_foundfamily");
         this.clanCreation.txt_copy.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_1");
         this.clanCreation.txt_title2.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_11");
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.clanCreation.txt_copy2,MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_13"),6);
         this.clanCreation.txt_copy3.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_14");
         this.clanCreation.txt_yes.text = MafiaModel.languageData.getTextById("generic_btn_yes");
         this.clanCreation.txt_no.text = MafiaModel.languageData.getTextById("generic_btn_no");
         this.checkLookingStatus();
         this.clanCreation.btn_no.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         if(MafiaModel.userData.profileData.isClanCreationUnlocked)
         {
            this.clanCreation.familyCreationLevelBlock.visible = false;
            this.clanCreation.btn_yes.enableButton = true;
            this.clanCreation.btn_yes.label = MafiaModel.languageData.getTextById("MafiaFamilyScreen_btn_found");
            this.clanCreation.btn_yes.goldInfoVisible = true;
            this.clanCreation.btn_yes.goldInfoTimeText = MafiaModel.goldConstants.createClanPrice.toString();
         }
         else
         {
            this.clanCreation.txt_copy.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_12",[Constants_UnlockLevel.UNLOCK_CLAN_CREATION]);
            this.clanCreation.familyCreationLevelBlock.visible = true;
            this.clanCreation.familyCreationLevelBlock.txt_lock.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[Constants_UnlockLevel.UNLOCK_CLAN_CREATION]);
            this.clanCreation.btn_yes.enableButton = false;
            this.clanCreation.btn_yes.label = MafiaModel.languageData.getTextById("MafiaFamilyScreen_btn_found");
         }
         this.clanCreation.btn_forum.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_familyForumFind");
         this.clanCreation.btn_forum.visible = env.useexternallinks || env.networkNewsByJS;
         this.clanCreation.btn_forum.visible = !GoodgamePartners.isSpilNetwork(env.networkId);
         updateTextField(this.clanCreation.btn_yes.txt_label);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == Constants_SFS.PROTOBUF_CREATE_FAMILY)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.clanCreation.btn_yes:
               if(this.clanCreation.btn_yes.enabled)
               {
                  this.onCreation();
               }
               break;
            case this.clanCreation.btn_check_yes:
               this.onLooking(true);
               break;
            case this.clanCreation.btn_check_no:
               this.onLooking(false);
               break;
            case this.clanCreation.btn_no:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case this.clanCreation.txt_troopName:
               (param1.target as TextField).setSelection(0,(param1.target as TextField).text.length);
               break;
            case this.clanCreation.btn_forum:
               MafiaGroupForumsHelper.goSearchClan();
         }
      }
      
      private function onCreation() : void
      {
         var _loc1_:String = this.clanCreation.txt_troopName.text;
         if(_loc1_ == MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_1") || _loc1_ == "")
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_21")));
            return;
         }
         if(!isNaN(Number(_loc1_)))
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_22")));
            return;
         }
         if(!TextValide.isSmartFoxValide(_loc1_))
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_5")));
            return;
         }
         this.isWaitingForServerMessage = true;
         BasicController.getInstance().waitForMessage(Constants_SFS.PROTOBUF_CREATE_FAMILY);
         CreateFamilyCommand.sendCommand(_loc1_);
      }
      
      private function onLooking(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.clanCreation.btn_check_yes.isSelected)
            {
               return;
            }
            LookingForFamilyCommand.sendCommand(1);
         }
         else
         {
            if(this.clanCreation.btn_check_no.isSelected)
            {
               return;
            }
            LookingForFamilyCommand.sendCommand(0);
         }
      }
      
      private function get clanCreation() : MafiaClanCreation
      {
         return disp as MafiaClanCreation;
      }
   }
}
