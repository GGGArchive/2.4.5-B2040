package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.model.components.BasicSocialData;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.controller.commands.account.CreateAvatarCommand;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaLoginPanel;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaAvatarScreen;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   
   public class LGNCommand extends MafiaCommand
   {
       
      
      public function LGNCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_LOGIN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:Date = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         if(param1 == 0)
         {
            this.onLogin(param2);
            env.isFirstVisit = false;
            return true;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return false;
         }
         MafiaDialogHandler.getInstance().blockDialogs = true;
         if(!env.loginIsKeyBased)
         {
            if(layoutManager.actState == 0)
            {
               layoutManager.state = BasicLayoutManager.STATE_LOGIN;
            }
         }
         else
         {
            MafiaModel.socialData.callJS(BasicSocialData.EXTERNAL_TRIGGER_ERROR,[param1,param2[1]]);
         }
         switch(param1)
         {
            case 1:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("generic_login_wronglogin"),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
               break;
            case 2:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_login_wronglogin"),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
               break;
            case 3:
               _loc3_ = new Date();
               _loc4_ = Math.round(_loc3_.getTime() / 1000);
               _loc5_ = TimeStringHelper.getDateToString((_loc4_ + Number(param2[3])) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_DAY_FORMAT,MafiaModel.languageData.getTextById) + " " + TimeStringHelper.getDateToString((_loc4_ + Number(param2[3])) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
               if(param2[3] >= 30758400)
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_information"),MafiaModel.languageData.getTextById("generic_login_banned_3"),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
                  _loc5_ = MafiaModel.languageData.getTextById("generic_login_banned_permanent");
               }
               else
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_information"),MafiaModel.languageData.getTextById("generic_login_banned_2",[_loc5_]),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
               }
               break;
            default:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("MafiaLogin_errorcode_1"),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
         }
         return false;
      }
      
      private function onLogin(param1:Array) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         MafiaModel.userData.userID = param1[1];
         MafiaModel.userData.playerID = param1[2];
         var _loc2_:int = param1[4];
         var _loc3_:int = param1[5];
         if(_loc2_ > 0)
         {
            if(_loc3_ == 0)
            {
               MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_title"),MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_copy_6",[_loc2_]),null),true,BasicDialogHandler.PRIORITY_HIGH);
            }
            else
            {
               MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_title"),MafiaModel.languageData.getTextById("MafiaDailyBonusDialog_copy_7",[_loc2_]),null),true,BasicDialogHandler.PRIORITY_HIGH);
            }
         }
         if(param1[3] == 1)
         {
            if(!env.loginIsKeyBased)
            {
               this.onCreateAvatar();
            }
         }
         else
         {
            if(layoutManager.getPanel(MafiaLoginPanel.NAME))
            {
               if((layoutManager.getPanel(MafiaLoginPanel.NAME) as MafiaLoginPanel).saveSelected)
               {
                  MafiaModel.localData.saveLoginData(MafiaModel.userData.loginName,MafiaModel.userData.loginPwd,true);
               }
               else
               {
                  MafiaModel.localData.saveLoginData("","",false);
               }
               layoutManager.hidePanel(MafiaLoginPanel.NAME);
            }
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_ALLPLAYERDATA,[]);
            layoutManager.backgroundComponent.showSFSProgress(MafiaModel.languageData.getTextById("progress_serverconnection"));
            MafiaDialogHandler.getInstance().blockDialogs = true;
         }
      }
      
      private function allowDialogs(param1:Object) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = false;
      }
      
      private function onCreateAvatar() : void
      {
         layoutManager.clearAllLayoutContent();
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "extraSprite";
         layoutManager.panelSprite.addChild(new MafiaAvatarScreen(new MafiaNWAvatarCreation(),layoutManager.customCursor,null,this.onCustomOK,null,_loc1_,controller,true).disp);
         layoutManager.panelSprite.addChild(_loc1_);
         layoutManager.onEndProgressbar();
      }
      
      private function onCustomOK() : void
      {
         if(layoutManager.panelSprite.getChildByName("extraSprite") && layoutManager.panelSprite.contains(layoutManager.panelSprite.getChildByName("extraSprite")))
         {
            layoutManager.panelSprite.removeChild(layoutManager.panelSprite.getChildByName("extraSprite"));
         }
         CreateAvatarCommand.sendCommand(AvatarHelper.createSFStringFromAvatarVO(MafiaDataHolder.instance.savedAvatarVO),MafiaDataHolder.instance.savedAvatarVO.characterClass,MafiaDataHolder.instance.savedAvatarVO.gender);
      }
   }
}
