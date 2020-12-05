package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.work.MafiaWorkAwardData;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class MafiaWorkFinishedPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaWorkFinishedPanel";
       
      
      public function MafiaWorkFinishedPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_WORKFINISHED;
         this.workFinishedPanel.bg.gotoAndStop(2);
      }
      
      override public function show() : void
      {
         super.show();
         this.workFinishedPanel.pic.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         this.fill();
      }
      
      private function fill() : void
      {
         var _loc1_:MafiaWorkAwardData = MafiaModel.userData.workData.workAwardData;
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getTimeToString(_loc1_.workDuration,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
         _loc2_.push("");
         this.workFinishedPanel.txt_copy.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_3",_loc2_);
         this.workFinishedPanel.txt_single.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_8");
         this.workFinishedPanel.txt_singleaward.text = NumberStringHelper.groupString(_loc1_.cashForWork,MafiaModel.languageData.getTextById);
         if(MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.workFinishedPanel.txt_familiybonus,MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_9"));
            this.workFinishedPanel.txt_familiybonusaward.text = "+ " + NumberStringHelper.groupString(_loc1_.cashBonusForFamily,MafiaModel.languageData.getTextById);
            this.workFinishedPanel.txt_familiybonus.visible = true;
            this.workFinishedPanel.txt_familiybonusaward.visible = true;
         }
         else
         {
            this.workFinishedPanel.txt_familiybonus.visible = false;
            this.workFinishedPanel.txt_familiybonusaward.visible = false;
         }
         if(env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.workFinishedPanel.txt_friendbonus,MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_7"));
            this.workFinishedPanel.txt_friendbonusaward.text = "+ " + NumberStringHelper.groupString(_loc1_.cashBonusForAchievement,MafiaModel.languageData.getTextById);
         }
         else
         {
            this.workFinishedPanel.txt_friendbonus.visible = false;
            this.workFinishedPanel.txt_friendbonusaward.visible = false;
         }
         this.workFinishedPanel.txt_result.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_10");
         this.workFinishedPanel.txt_resultaward.text = "+ " + NumberStringHelper.groupString(_loc1_.cashForWork + _loc1_.cashBonusForFamily + _loc1_.cashBonusForAchievement,MafiaModel.languageData.getTextById);
         this.workFinishedPanel.txt_title.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_title");
         this.workFinishedPanel.btn_cancel.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.workFinishedPanel.ap.toolTipText = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14");
         var _loc3_:int = Math.floor(_loc1_.workDuration / 60 / 60);
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.workFinishedPanel.txt_ap.text = _loc3_.toString();
         }
         else
         {
            this.workFinishedPanel.txt_ap.text = "0";
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.workFinishedPanel.btn_cancel:
               hide();
         }
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
      
      protected function get workFinishedPanel() : MafiaWorkFinished
      {
         return disp as MafiaWorkFinished;
      }
   }
}
