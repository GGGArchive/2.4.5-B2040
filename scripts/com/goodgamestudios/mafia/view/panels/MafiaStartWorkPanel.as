package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.work.GoWorkingCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAddFriendDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class MafiaStartWorkPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaStartWorkPanel";
       
      
      public function MafiaStartWorkPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_WORKSTART;
         controller.addEventListener(MafiaWorkEvent.CHANGE_WORK_DATA,this.onChangeWorkdata);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ACHIEVEMENT_DATA,this.onChangeAchievementdata);
         this.startWork.bg.gotoAndStop(1);
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         if(disp && disp.stage)
         {
            super.updatePosition();
            _loc1_ = disp.getBounds(null);
            disp.x = Constants_Basic.GAME_WIDTH * 0.5 * disp.scaleX + layoutManager.gameNullPoint;
            disp.y = PANEL_YPOS * disp.scaleY;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.startWork.pic.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         this.fillWork();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaWorkEvent.CHANGE_WORK_DATA,this.onChangeWorkdata);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ACHIEVEMENT_DATA,this.onChangeAchievementdata);
      }
      
      private function onChangeWorkdata(param1:MafiaWorkEvent) : void
      {
         this.fillWork();
      }
      
      private function onChangeAchievementdata(param1:MafiaUserEvent) : void
      {
         this.fillWork();
      }
      
      private function fillWork() : void
      {
         this.startWork.btn_start.label = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_btn_work");
         this.startWork.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_close");
         this.startWork.txt_title.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_title");
         this.startWork.txt_copy.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_1");
         this.startWork.ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
         this.startWork.cash.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency1");
         this.startWork.txt_reward_title.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_11");
         var _loc1_:int = MafiaModel.userData.workData.workC1PerHour;
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.startWork.txt_reward,NumberStringHelper.groupString(_loc1_,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_9"));
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.startWork.txt_ap.text = "1/" + MafiaModel.languageData.getTextById("generic_hour");
         }
         else
         {
            this.startWork.txt_ap.text = "0";
         }
         if(!env.isBeta)
         {
            this.startWork.btn_addFriend.visible = env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends;
            this.startWork.btn_addFriend.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaProtectionMoneyScreen_inviteFriends",[Number(Constants_Basic.FRIENDS_WORK_BONUS * MafiaModel.userData.achievementsData.achievements[7].achievementLevel) + "%",MafiaModel.userData.achievementsData.achievements[7].achievementNextValue,Number(Constants_Basic.FRIENDS_WORK_BONUS * (MafiaModel.userData.achievementsData.achievements[7].achievementLevel + 1)) + "%"])),new Point(this.startWork.btn_addFriend.x + 400,this.startWork.btn_addFriend.y + 250),"",BasicCustomCursor.CURSOR_CLICK);
         }
         else
         {
            this.startWork.btn_addFriend.enableButton = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField || MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(!param1.target.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.startWork.btn_start:
               if(MafiaModel.userData.status == Constants_Status.STATUS_FREE)
               {
                  this.onStartWork();
                  hide();
                  (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showWorkSelection = false;
               }
               break;
            case this.startWork.btn_close:
               hide();
               (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showWorkSelection = false;
               break;
            case this.startWork.btn_addFriend:
               if(env.loginIsKeyBased)
               {
                  MafiaModel.socialData.inviteFriends();
               }
               else if(!env.isBeta)
               {
                  layoutManager.showDialog(MafiaAddFriendDialog.NAME,new MafiaAddFriendDialogProperties());
               }
         }
         super.onClick(param1);
      }
      
      private function onStartWork() : void
      {
         GoWorkingCommand.sendCommand();
      }
      
      protected function get startWork() : MafiaStartWork
      {
         return disp as MafiaStartWork;
      }
   }
}
