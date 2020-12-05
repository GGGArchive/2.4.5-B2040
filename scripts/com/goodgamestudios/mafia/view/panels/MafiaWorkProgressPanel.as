package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.controller.commands.work.StopWorkingCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAddFriendDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MafiaWorkProgressPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaWorkProgressPanel";
       
      
      public function MafiaWorkProgressPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_WORKPROGRESS;
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         this.workProgressPanel.bg.gotoAndStop(2);
      }
      
      override public function show() : void
      {
         super.show();
         this.workProgressPanel.pic.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         this.showByStatus();
         controller.addEventListener(MafiaWorkEvent.CHANGE_WORK_TIMER,this.onChangeMissionWorkTimer);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaWorkEvent.CHANGE_WORK_TIMER,this.onChangeMissionWorkTimer);
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
      
      private function onChangeMissionWorkTimer(param1:MafiaWorkEvent) : void
      {
         this.workProgressPanel.txt_time.text = param1.params[0];
         this.workProgressPanel.txt_award.text = NumberStringHelper.groupString(param1.params[1],MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("silver");
         this.workProgressPanel.txt_ap.text = param1.params[2];
         this.workProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_title");
         this.workProgressPanel.txt_copy.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_2");
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.showByStatus();
      }
      
      private function showByStatus() : void
      {
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_WORKING:
               this.workProgressPanel.time.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_time");
               this.workProgressPanel.cash.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency1");
               this.workProgressPanel.ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
               this.workProgressPanel.txt_copy.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_2");
               this.workProgressPanel.txt_title.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_title");
               this.workProgressPanel.btn_cancel.label = MafiaModel.languageData.getTextById("generic_btn_end");
               if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
               {
                  this.workProgressPanel.ap.visible = true;
                  this.workProgressPanel.txt_ap.visible = true;
               }
               else
               {
                  this.workProgressPanel.ap.visible = false;
                  this.workProgressPanel.txt_ap.visible = false;
               }
               if(!env.isBeta)
               {
                  this.workProgressPanel.btn_addFriend.visible = env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends;
                  this.workProgressPanel.btn_addFriend.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaProtectionMoneyScreen_inviteFriends",[Number(Constants_Basic.FRIENDS_WORK_BONUS * MafiaModel.userData.achievementsData.achievements[7].achievementLevel) + "%",MafiaModel.userData.achievementsData.achievements[7].achievementNextValue,Number(Constants_Basic.FRIENDS_WORK_BONUS * (MafiaModel.userData.achievementsData.achievements[7].achievementLevel + 1)) + "%"])),new Point(this.workProgressPanel.btn_addFriend.x + 400,this.workProgressPanel.btn_addFriend.y + 250),"",BasicCustomCursor.CURSOR_CLICK);
               }
               else
               {
                  this.workProgressPanel.btn_addFriend.enableButton = false;
               }
               break;
            default:
               hide();
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.workProgressPanel.btn_cancel:
               MafiaModel.userData.status = Constants_Status.STATUS_WORK_FINISHED;
               StopWorkingCommand.sendCommand();
               hide();
               break;
            case this.workProgressPanel.btn_addFriend:
               if(env.loginIsKeyBased)
               {
                  MafiaModel.socialData.inviteFriends();
               }
               else if(!env.isBeta)
               {
                  layoutManager.showDialog(MafiaAddFriendDialog.NAME,new MafiaAddFriendDialogProperties());
               }
         }
      }
      
      protected function get workProgressPanel() : MafiaWorkProgress
      {
         return disp as MafiaWorkProgress;
      }
   }
}
