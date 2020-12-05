package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_CliendCommands;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   
   public class MafiaAddFriendDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaAddFriendDialog";
       
      
      private var _defaultMailString:String;
      
      private var _defaultNameString:String;
      
      private var _defaultFriendNameString:String;
      
      public function MafiaAddFriendDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         disp.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         disp.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         this.addFriendDialog.btn_yes.label = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_invite");
         this.addFriendDialog.btn_no.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
      }
      
      override protected function removeEvents() : void
      {
         disp.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         disp.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         super.removeEvents();
      }
      
      override protected function applyProperties() : void
      {
         this.addFriendDialog.txt_name.text = this._defaultNameString = MafiaModel.userData.profileData.name;
         this.addFriendDialog.txt_nameFriend.text = this._defaultFriendNameString = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_9");
         this.addFriendDialog.txt_email.text = this._defaultMailString = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_3");
         this.addFriendDialog.txt_name.tabIndex = 1;
         this.addFriendDialog.txt_nameFriend.tabIndex = 2;
         this.addFriendDialog.txt_email.tabIndex = 3;
         this.addFriendDialog.txt_title.text = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends");
         this.addFriendDialog.stepone.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends");
         this.addFriendDialog.stepone.txt_step.text = "1";
         this.addFriendDialog.stepone.gotoAndStop(1);
         this.addFriendDialog.steptwo.txt_copy.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_6");
         this.addFriendDialog.steptwo.txt_step.text = "2";
         this.addFriendDialog.steptwo.gotoAndStop(1);
         this.addFriendDialog.stepthree.txt_copy.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_7");
         this.addFriendDialog.stepthree.txt_step.text = "3";
         this.addFriendDialog.stepthree.gotoAndStop(2);
         this.addFriendDialog.txt_friendsbonustitle.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_1");
         this.addFriendDialog.txt_friendsbonus.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_5");
         this.addFriendDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_4");
         var _loc1_:Array = [MafiaModel.userData.achievementsData.achievements[7].achievementNextValue - MafiaModel.userData.achievementsData.achievements[7].achievementValue];
         this.addFriendDialog.txt_friendsbonuscount.text = MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_2",[TextFieldHelper.generateStringByValue(parseInt(_loc1_[0]),MafiaModel.languageData.getTextById("generic_friend"),MafiaModel.languageData.getTextById("generic_friends"))]);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.addFriendDialog.btn_no:
            case this.addFriendDialog.btn_close:
               hide();
               break;
            case this.addFriendDialog.btn_yes:
               if(!TextValide.isSmartFoxValide(this.addFriendDialog.txt_name.text) || !TextValide.isSmartFoxValide(this.addFriendDialog.txt_nameFriend.text))
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_namenotvalid")));
                  return;
               }
               if(this.addFriendDialog.txt_email.text.length < 7 || this.addFriendDialog.txt_email.text == this._defaultMailString)
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_emailwrong_copy")));
                  return;
               }
               if(TextValide.isSmartFoxValide(this.addFriendDialog.txt_email.text))
               {
                  this.onAddFriend([this.addFriendDialog.txt_name.text,this.addFriendDialog.txt_email.text,this.addFriendDialog.txt_nameFriend.text == this._defaultFriendNameString?"":this.addFriendDialog.txt_nameFriend.text]);
               }
               else
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_error_invalidemail")));
               }
               break;
         }
      }
      
      protected function onFocusIn(param1:FocusEvent) : void
      {
         if(!param1.target)
         {
            return;
         }
         switch(param1.target)
         {
            case this.addFriendDialog.txt_nameFriend:
               if(this.addFriendDialog.txt_nameFriend.text == this._defaultFriendNameString)
               {
                  this.addFriendDialog.txt_nameFriend.text = "";
               }
               break;
            case this.addFriendDialog.txt_email:
               if(this.addFriendDialog.txt_email.text == this._defaultMailString)
               {
                  this.addFriendDialog.txt_email.text = "";
               }
         }
      }
      
      protected function onFocusOut(param1:FocusEvent) : void
      {
         if(!param1.target)
         {
            return;
         }
         switch(param1.target)
         {
            case this.addFriendDialog.txt_name:
               if(this.addFriendDialog.txt_name.text == "")
               {
                  this.addFriendDialog.txt_name.text = this._defaultNameString;
               }
               break;
            case this.addFriendDialog.txt_nameFriend:
               if(this.addFriendDialog.txt_nameFriend.text == "")
               {
                  this.addFriendDialog.txt_nameFriend.text = this._defaultFriendNameString;
               }
               break;
            case this.addFriendDialog.txt_email:
               if(this.addFriendDialog.txt_email.text == "")
               {
                  this.addFriendDialog.txt_email.text = this._defaultMailString;
               }
         }
      }
      
      private function onAddFriend(param1:Array) : void
      {
         CommandController.instance.executeCommand(Constants_CliendCommands.COMMAND_SENDFRIENDLINK,param1);
      }
      
      protected function get addFriendDialogProperties() : MafiaAddFriendDialogProperties
      {
         return properties as MafiaAddFriendDialogProperties;
      }
      
      protected function get addFriendDialog() : AddFriends
      {
         return disp as AddFriends;
      }
   }
}
