package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaUnlockGangwarDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaUnlockGangwarDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaUnlockGangwarDialog";
       
      
      public function MafiaUnlockGangwarDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_unlock.label = MafiaModel.languageData.getTextById("MafiaGangWarfare_btn_hire");
         this.standardDialog.btn_unlock.goldInfoVisible = true;
         this.standardDialog.btn_unlock.goldInfoTimeText = this.unlockDialogProperties.dungeon.unlockPriceC2.toString();
         this.standardDialog.btn_unlock.enableButton = true;
         if(env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends)
         {
            this.standardDialog.btn_friends.label = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_invite");
            this.standardDialog.btn_friends.goldInfoVisible = false;
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_buyDungeon_friends",[this.unlockDialogProperties.dungeon.minRecruitedFriends - MafiaModel.userData.gangwarData.recruitedFriends,this.unlockDialogProperties.dungeon.unlockPriceC2]) + " " + MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2");
         }
         else
         {
            this.standardDialog.btn_friends.visible = false;
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_buyDungeon_gold",[this.unlockDialogProperties.dungeon.unlockPriceC2 + " " + MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2")]);
         }
         this.standardDialog.btn_no.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangWarfare_title");
         updateAllTextFields();
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_unlock:
               if(!this.standardDialog.btn_unlock.enabled)
               {
                  return;
               }
               if(this.unlockDialogProperties.functionYes != null)
               {
                  this.unlockDialogProperties.functionYes();
               }
               this.standardDialog.btn_unlock.enableButton = false;
               hide();
               break;
            case this.standardDialog.btn_friends:
               hide();
               if(env.loginIsKeyBased)
               {
                  MafiaModel.socialData.inviteFriends();
               }
               else if(!env.isBeta)
               {
                  layoutManager.showDialog(MafiaAddFriendDialog.NAME,new MafiaAddFriendDialogProperties());
               }
               break;
            case this.standardDialog.btn_no:
               hide();
         }
      }
      
      protected function get standardDialog() : MafiaUnlockGangwar
      {
         return disp as MafiaUnlockGangwar;
      }
      
      protected function get unlockDialogProperties() : MafiaUnlockGangwarDialogProperties
      {
         return properties as MafiaUnlockGangwarDialogProperties;
      }
   }
}
