package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailGiftReminderDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailVerificationDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailGiftReminderDialogProperties;
   
   public class MafiaMailVerificationData
   {
       
      
      public var reminderShown:Boolean;
      
      private var reminderDelayInSeconds:int;
      
      public var eMailVerificationSend:Boolean;
      
      public function MafiaMailVerificationData()
      {
         super();
         this.reminderShown = false;
         this.reminderDelayInSeconds = 30;
      }
      
      public function checkReminderTime(param1:Number) : void
      {
         if(!this.env.isBeta)
         {
            if(!this.env.loginIsKeyBased && !MafiaModel.userData.emailVerified && !MafiaTutorialController.getInstance().isActive && !this.reminderShown && !MafiaDialogHandler.getInstance().blockDialogs && MafiaModel.userData.profileData.isEmailVerificationUnlocked && (param1 - MafiaModel.userData.appRuntime) * 0.001 > this.reminderDelayInSeconds)
            {
               this.reminderShown = true;
               if(!BasicLayoutManager.getInstance().getDialog(MafiaMailVerificationDialog))
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaMailGiftReminderDialog.NAME,new MafiaMailGiftReminderDialogProperties(MafiaModel.languageData.getTextById("MafiaValidationReminderDialog_title"),MafiaModel.languageData.getTextById("MafiaValidationReminderDialog_copy_1",[MafiaModel.goldConstants.emailVerificationGold])),true,BasicDialogHandler.PRIORITY_HIGH);
               }
            }
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
