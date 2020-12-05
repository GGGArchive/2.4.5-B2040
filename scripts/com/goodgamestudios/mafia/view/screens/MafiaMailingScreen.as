package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.commands.clan.JoinFamilyCommand;
   import com.goodgamestudios.mafia.controller.commands.messages.ShowNewsCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaMessageData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.screens.mailing.MafiaMailingComponent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class MafiaMailingScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaMailingScreen";
       
      
      private var from:String;
      
      private var readMailId:int = -1;
      
      private var msgID:int;
      
      private var msgType:MessageType;
      
      private var fightMessages:MafiaMailingComponent;
      
      private var normalMessages:MafiaMailingComponent;
      
      private const LISTTYPENORMAL:String = "normal";
      
      private const LISTTYPEFIGHTS:String = "fights";
      
      private const WRITEMODE:int = 3;
      
      public function MafiaMailingScreen(param1:DisplayObject)
      {
         super(param1);
         controller.addEventListener(MafiaNewsEvent.CHANGE_NEWSDATA,this.onChangeNewsData);
         controller.addEventListener(MafiaNewsEvent.CHANGE_READMSGDATA,this.onChangeReadMsgData);
         controller.addEventListener(MafiaNewsEvent.CHANGE_SENDMSG,this.onSendMsg);
         controller.addEventListener(MafiaNewsEvent.CHANGE_MAILREFRESHTIME,this.onChangeMailRefreshTimer);
         this.fightMessages = new MafiaMailingComponent(this.newsScreen.fight,this.LISTTYPEFIGHTS);
         this.fightMessages.disp.addEventListener(MafiaNewsEvent.SWITCH_WRITEMAIL,this.onWriteMail);
         this.fightMessages.disp.addEventListener(MafiaNewsEvent.SET_VARS,this.onSetVars);
         this.fightMessages.disp.addEventListener(MafiaNewsEvent.DESELECT,this.onDeselectMessage);
         this.normalMessages = new MafiaMailingComponent(this.newsScreen.normal,this.LISTTYPENORMAL);
         this.normalMessages.disp.addEventListener(MafiaNewsEvent.SWITCH_WRITEMAIL,this.onWriteMail);
         this.normalMessages.disp.addEventListener(MafiaNewsEvent.SET_VARS,this.onSetVars);
         this.normalMessages.disp.addEventListener(MafiaNewsEvent.DESELECT,this.onDeselectMessage);
         this.createWriting(true);
         this.setupButton(MafiaMessageData.LISTTYPE_TEXT);
         this.newsScreen.readLayer.gotoAndStop(3);
         this.newsScreen.btn_ok.visible = false;
         this.init();
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_MAIL.toString();
      }
      
      override public function show() : void
      {
         super.show();
         ShowNewsCommand.sendCommand();
         this.newsScreen.btn_addGold.visible = false;
         this.newsScreen.mc_doppler_icon.visible = false;
         if(MafiaModel.userData.messageData.readMessagesData.receiver != "")
         {
            this.switchToWriteMode();
         }
         this.newsScreen.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.newsScreen.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         if(this.readMailId > -1)
         {
            this.newsScreen.btn_view.visible = true;
         }
         if(this.from != null && this.readMailId > -1)
         {
            this.newsScreen.btn_view.visible = false;
            this.newsScreen.btn_ok.visible = true;
            this.newsScreen.btn_ok.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_answer");
            MafiaModel.userData.messageData.readMessagesData.receiver = this.from;
         }
      }
      
      override protected function removeEvents() : void
      {
         this.newsScreen.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.newsScreen.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         super.removeEvents();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaNewsEvent.CHANGE_NEWSDATA,this.onChangeNewsData);
         controller.removeEventListener(MafiaNewsEvent.CHANGE_READMSGDATA,this.onChangeReadMsgData);
         controller.removeEventListener(MafiaNewsEvent.CHANGE_SENDMSG,this.onSendMsg);
         controller.removeEventListener(MafiaNewsEvent.CHANGE_MAILREFRESHTIME,this.onChangeMailRefreshTimer);
         this.fightMessages.disp.removeEventListener(MafiaNewsEvent.SWITCH_WRITEMAIL,this.onWriteMail);
         this.normalMessages.disp.removeEventListener(MafiaNewsEvent.SWITCH_WRITEMAIL,this.onWriteMail);
         this.fightMessages.disp.removeEventListener(MafiaNewsEvent.SET_VARS,this.onSetVars);
         this.normalMessages.disp.removeEventListener(MafiaNewsEvent.SET_VARS,this.onSetVars);
         super.destroy();
      }
      
      override protected function init() : void
      {
         if(BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.newsScreen.txt_mail_to);
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.newsScreen.txt_mail_copy);
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.newsScreen.writeMail.txt_mail_to);
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.newsScreen.writeMail.txt_mail_copy);
         }
         else
         {
            this.newsScreen.txt_mail_to.embedFonts = false;
            this.newsScreen.txt_mail_copy.embedFonts = false;
            this.newsScreen.writeMail.txt_mail_to.embedFonts = false;
            this.newsScreen.writeMail.txt_mail_copy.embedFonts = false;
         }
         var _loc1_:String = MafiaModel.languageData.getTextById("MafiaMailScreen_title");
         var _loc2_:String = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_22");
         var _loc3_:String = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
         this.newsScreen.normal.txt_title.text = _loc1_;
         this.newsScreen.fight.txt_title.text = _loc2_;
         this.newsScreen.btn_player.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_avatar");
         this.newsScreen.normal.btn_refresh.toolTipText = MafiaModel.languageData.getTextById("generic_btn_refresh");
         this.newsScreen.fight.btn_refresh.toolTipText = MafiaModel.languageData.getTextById("generic_btn_refresh");
         this.newsScreen.btn_delete.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaMailScreen_btn_delete");
         this.newsScreen.layer_normal.btn_normal.toolTipText = _loc1_;
         this.newsScreen.layer_fight.btn_toFights.toolTipText = _loc2_;
         this.newsScreen.writeMail.layer.btn_write.toolTipText = _loc3_;
         this.clearReadMessage();
      }
      
      private function onChangeNewsData(param1:MafiaNewsEvent) : void
      {
         this.normalMessages.updateNews(MafiaModel.userData.messageData.normalMessages);
         this.fightMessages.updateNews(MafiaModel.userData.messageData.fightMessages);
      }
      
      private function onWriteMail(param1:MafiaNewsEvent) : void
      {
         this.createWriting(param1.params[0]);
      }
      
      private function onSetVars(param1:MafiaNewsEvent) : void
      {
         this.from = param1.params[0];
         this.readMailId = param1.params[1];
         this.msgID = param1.params[2];
         this.msgType = param1.params[3];
      }
      
      private function onDeselectMessage(param1:MafiaNewsEvent) : void
      {
         this.clearReadMessage();
      }
      
      private function onSendMsg(param1:MafiaNewsEvent) : void
      {
         MafiaModel.userData.messageData.readMessagesData.receiver = "";
         this.createWriting(true);
      }
      
      private function onChangeReadMsgData(param1:MafiaNewsEvent) : void
      {
         if(!this.from)
         {
            return;
         }
         var _loc2_:Array = new Array();
         this.createReading();
         this.newsScreen.btn_player.visible = false;
         this.newsScreen.txt_mail_copy.selectable = false;
         this.newsScreen.txt_mail_copy.mouseEnabled = false;
         this.newsScreen.txt_mail_to_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_21");
         this.newsScreen.readLayer.gotoAndStop(3);
         this.newsScreen.btn_ok.visible = false;
         this.newsScreen.btn_view.visible = false;
         this.newsScreen.btn_join.visible = false;
         this.newsScreen.btn_delete.visible = true;
         this.newsScreen.btn_addGold.visible = false;
         this.newsScreen.mc_doppler_icon.visible = false;
         switch(MafiaModel.userData.messageData.readMessagesData.readMsgType)
         {
            case MessageType.FightWon:
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_2");
               _loc2_[0] = this.from;
               this.newsScreen.txt_mail_to.text = this.from;
               this.newsScreen.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_4",_loc2_);
               this.newsScreen.btn_view.visible = true;
               this.newsScreen.btn_view.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view");
               this.newsScreen.btn_player.visible = true;
               this.newsScreen.readLayer.gotoAndStop(2);
               break;
            case MessageType.FightLost:
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_2");
               _loc2_[0] = this.from;
               this.newsScreen.txt_mail_to.text = this.from;
               this.newsScreen.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_5",_loc2_);
               this.newsScreen.btn_view.visible = true;
               this.newsScreen.btn_view.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view");
               this.newsScreen.btn_player.visible = true;
               this.newsScreen.readLayer.gotoAndStop(1);
               break;
            case MessageType.ClanInvitation:
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_3");
               _loc2_[0] = this.from;
               this.newsScreen.txt_mail_to.text = this.from;
               _loc2_[1] = MafiaModel.userData.messageData.clanInvitiationVO.clanName;
               this.newsScreen.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_6",_loc2_);
               this.newsScreen.btn_join.visible = true;
               this.newsScreen.btn_join.toolTipText = MafiaModel.languageData.getTextById("generic_btn_accept");
               this.newsScreen.btn_player.visible = true;
               break;
            case MessageType.Newsletter:
               this.newsScreen.txt_mail_to.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_1");
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
               this.newsScreen.txt_mail_copy.text = MafiaModel.userData.messageData.readMessagesData.readMsgText;
               break;
            case MessageType.ClanKick:
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_7");
               _loc2_[0] = this.from;
               this.newsScreen.txt_mail_to.text = this.from;
               this.newsScreen.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_8",_loc2_);
               this.newsScreen.btn_ok.visible = true;
               this.newsScreen.btn_ok.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_answer");
               break;
            case MessageType.Admin:
               this.newsScreen.txt_mail_to.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_1");
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
               this.newsScreen.txt_mail_copy.text = MafiaModel.userData.messageData.readMessagesData.readMsgText;
               break;
            case MessageType.PlayerMessage:
               this.newsScreen.txt_mail_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
               this.newsScreen.txt_mail_to.text = MafiaModel.userData.messageData.readMessagesData.readMsgSender;
               this.newsScreen.txt_mail_copy.text = MafiaModel.userData.messageData.readMessagesData.readMsgText;
               this.newsScreen.txt_mail_copy.selectable = true;
               this.newsScreen.txt_mail_copy.mouseEnabled = true;
               this.newsScreen.btn_ok.visible = true;
               this.newsScreen.btn_ok.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_answer");
               this.newsScreen.btn_player.visible = true;
               break;
            case MessageType.PaymentDoppler:
               this.newsScreen.txt_mail_to.text = MafiaModel.userData.messageData.readMessagesData.readMsgSender;
               this.newsScreen.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_23");
               this.newsScreen.btn_addGold.visible = true;
               this.newsScreen.mc_doppler_icon.visible = true;
               this.newsScreen.btn_addGold.label = MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold");
         }
      }
      
      private function fillNews(param1:int, param2:int = 0) : void
      {
         this.normalMessages.fillNews(MafiaModel.userData.messageData.normalMessages);
         this.fightMessages.fillNews(MafiaModel.userData.messageData.fightMessages);
      }
      
      private function createWriting(param1:Boolean) : void
      {
         MafiaModel.userData.messageData.readMessagesData.readMsgType = MessageType.PlayerMessage;
         this.newsScreen.writeMail.txt_title.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
         this.newsScreen.writeMail.txt_mail_to.tabIndex = 500;
         this.newsScreen.writeMail.txt_mail_to.maxChars = 20;
         this.newsScreen.writeMail.txt_mail_to.selectable = true;
         this.newsScreen.writeMail.txt_mail_to.mouseEnabled = true;
         this.newsScreen.writeMail.txt_mail_copy.tabIndex = 500;
         this.newsScreen.writeMail.txt_mail_copy.selectable = true;
         this.newsScreen.writeMail.txt_mail_copy.mouseEnabled = true;
         this.newsScreen.writeMail.txt_mail_copy.maxChars = 450;
         if(MafiaModel.userData.messageData.readMessagesData.receiver != "")
         {
            this.newsScreen.writeMail.txt_mail_to.text = MafiaModel.userData.messageData.readMessagesData.receiver;
         }
         else if(this.newsScreen.writeMail.txt_mail_to.text.length > 0 && this.newsScreen.writeMail.txt_mail_to.text != MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10") && !param1)
         {
            MafiaModel.userData.messageData.readMessagesData.receiver = this.newsScreen.writeMail.txt_mail_to.text;
         }
         else
         {
            this.newsScreen.writeMail.txt_mail_to.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
         }
         if(!param1 && MafiaModel.userData.messageData.readMessagesData.receiver != "")
         {
            this.newsScreen.writeMail.txt_mail_to.text = MafiaModel.userData.messageData.readMessagesData.receiver;
         }
         if(layoutManager.currentState == Constants_LayoutStates.STATE_OTHERPROFILE || param1 || this.newsScreen.writeMail.txt_mail_to.text == MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10"))
         {
            this.newsScreen.writeMail.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_13");
         }
         this.newsScreen.writeMail.btn_send.toolTipText = MafiaModel.languageData.getTextById("MafiaMailScreen_btn_send");
         this.newsScreen.writeMail.btn_send.enableButton = false;
      }
      
      private function clearReadMessage() : void
      {
         this.newsScreen.btn_delete.visible = false;
         this.newsScreen.btn_ok.visible = false;
         this.newsScreen.btn_view.visible = false;
         this.newsScreen.btn_join.visible = false;
         this.newsScreen.btn_player.visible = false;
         this.newsScreen.btn_addGold.visible = false;
         this.newsScreen.mc_doppler_icon.visible = false;
         this.newsScreen.readLayer.gotoAndStop(3);
         this.newsScreen.txt_mail_title.text = "";
         this.newsScreen.txt_mail_to_copy.text = "";
         this.newsScreen.txt_mail_to.text = "";
         this.newsScreen.txt_mail_copy.text = "";
         this.from = null;
         this.readMailId = -1;
         this.msgID = 0;
         this.msgType = null;
      }
      
      private function createReading() : void
      {
         this.newsScreen.txt_mail_to_copy.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_21");
         this.newsScreen.txt_mail_to.selectable = false;
         this.newsScreen.txt_mail_to.mouseEnabled = false;
         this.newsScreen.btn_delete.visible = true;
         this.newsScreen.btn_ok.enableButton = true;
      }
      
      private function onChangeMailRefreshTimer(param1:MafiaNewsEvent) : void
      {
         var _loc2_:Number = param1.params[0];
         if(_loc2_ != -1)
         {
            this.newsScreen.normal.btn_refresh.enableButton = false;
            this.newsScreen.fight.btn_refresh.enableButton = false;
         }
         else
         {
            this.newsScreen.normal.btn_refresh.enableButton = true;
            this.newsScreen.fight.btn_refresh.enableButton = true;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.newsScreen.btn_addGold:
            case this.newsScreen.mc_doppler_icon:
               controller.onClickMoreMoney(null);
               break;
            case this.newsScreen.btn_ok:
               this.switchToWriteMode(true);
               break;
            case this.newsScreen.btn_join:
               MafiaModel.userData.messageData.deleteMsg(this.readMailId,1);
               this.createWriting(true);
               this.readMailId = -1;
               JoinFamilyCommand.sendCommand(MafiaModel.userData.messageData.clanInvitiationVO.clanID,MafiaModel.userData.messageData.clanInvitiationVO.invitiationHashCode,this.msgID);
               this.clearReadMessage();
               break;
            case this.newsScreen.btn_view:
               MafiaModel.userData.messageData.readMessagesData.receiver = "";
               MafiaModel.userData.duelData.pvpData.lastDuelEnemy = this.from;
               layoutManager.state = Constants_LayoutStates.STATE_REPLAY_FIGHT;
               this.fightMessages.deselectAllMessages();
               this.clearReadMessage();
               MafiaFightController.getInstance().startFight(MafiaModel.userData.messageData.replayFightData,FightType.Replay);
               break;
            case this.newsScreen.btn_player:
               MafiaModel.userData.messageData.readMessagesData.receiver = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
               if(MafiaModel.userData.messageData.readMessagesData.readMsgSenderId != MafiaModel.userData.playerID)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
               }
               else
               {
                  layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               }
               PlayerProfileCommand.sendCommand(MafiaModel.userData.messageData.readMessagesData.readMsgSenderId,false);
               this.normalMessages.deselectAllMessages();
               this.fightMessages.deselectAllMessages();
               this.clearReadMessage();
               break;
            case this.newsScreen.normal.btn_refresh:
            case this.newsScreen.fight.btn_refresh:
               if(!(param1.target as MovieClip).enabled)
               {
                  return;
               }
               ShowNewsCommand.sendCommand();
               break;
            case this.newsScreen.layer_fight.btn_toFights:
               if(this.newsScreen.layer_fight.currentFrame == 1)
               {
                  return;
               }
               if(this.newsScreen.writeMail.layer.currentFrame == 1)
               {
                  this.newsScreen.setChildIndex(this.newsScreen.layer_fight,this.newsScreen.numChildren - 1);
                  this.newsScreen.setChildIndex(this.newsScreen.fight,this.newsScreen.numChildren - 1);
                  this.setupButton(MafiaMessageData.LISTTYPE_FIGHT);
               }
               else if(this.newsScreen.getChildIndex(this.newsScreen.normal) > this.newsScreen.getChildIndex(this.newsScreen.fight))
               {
                  this.newsScreen.swapChildren(this.newsScreen.normal,this.newsScreen.fight);
                  this.newsScreen.swapChildren(this.newsScreen.layer_normal,this.newsScreen.layer_fight);
                  this.setupButton(MafiaMessageData.LISTTYPE_FIGHT);
                  if(this.normalMessages.isMailInFocus)
                  {
                     this.clearReadMessage();
                     this.normalMessages.deselectAllMessages();
                  }
               }
               this.newsScreen.setChildIndex(this.newsScreen.writeMail,0);
               this.newsScreen.writeMail.layer.gotoAndStop(2);
               this.newsScreen.writeMail.layer.btn_write.y = -16.5;
               this.newsScreen.setChildIndex(this.newsScreen.backgroundHolder,0);
               break;
            case this.newsScreen.layer_normal.btn_normal:
               if(this.newsScreen.layer_normal.currentFrame == 1)
               {
                  return;
               }
               if(this.newsScreen.writeMail.layer.currentFrame == 1)
               {
                  this.newsScreen.setChildIndex(this.newsScreen.layer_normal,this.newsScreen.numChildren - 1);
                  this.newsScreen.setChildIndex(this.newsScreen.normal,this.newsScreen.numChildren - 1);
                  this.setupButton(MafiaMessageData.LISTTYPE_TEXT);
               }
               else if(this.newsScreen.getChildIndex(this.newsScreen.normal) < this.newsScreen.getChildIndex(this.newsScreen.fight))
               {
                  this.newsScreen.swapChildren(this.newsScreen.fight,this.newsScreen.normal);
                  this.newsScreen.swapChildren(this.newsScreen.layer_fight,this.newsScreen.layer_normal);
                  this.setupButton(MafiaMessageData.LISTTYPE_TEXT);
                  if(this.fightMessages.isMailInFocus)
                  {
                     this.clearReadMessage();
                     this.fightMessages.deselectAllMessages();
                  }
               }
               this.newsScreen.setChildIndex(this.newsScreen.writeMail,0);
               this.newsScreen.writeMail.layer.gotoAndStop(2);
               this.newsScreen.writeMail.layer.btn_write.y = -16.5;
               this.newsScreen.setChildIndex(this.newsScreen.backgroundHolder,0);
               break;
            case this.newsScreen.writeMail.layer.btn_write:
               if(this.newsScreen.writeMail.layer.currentFrame == 1)
               {
                  return;
               }
               this.clearReadMessage();
               this.switchToWriteMode();
               this.newsScreen.setChildIndex(this.newsScreen.backgroundHolder,0);
               break;
            case this.newsScreen.writeMail.btn_send:
               if(!this.newsScreen.writeMail.btn_send.enabled)
               {
                  return;
               }
               this.onSendMessage();
               break;
            case this.newsScreen.btn_delete:
               if(this.newsScreen.layer_normal.currentFrame == 1)
               {
                  this.normalMessages.deleteMSG(this.normalMessages.activeMsg);
                  this.clearReadMessage();
                  return;
               }
               if(this.newsScreen.layer_fight.currentFrame == 1)
               {
                  this.fightMessages.deleteMSG(this.fightMessages.activeMsg);
                  this.clearReadMessage();
                  return;
               }
               break;
         }
      }
      
      private function switchToWriteMode(param1:Boolean = false) : void
      {
         this.newsScreen.setChildIndex(this.newsScreen.writeMail,this.newsScreen.numChildren - 1);
         this.setupButton(this.WRITEMODE);
         this.createWriting(false);
         this.readMailId = -1;
      }
      
      private function setupButton(param1:int) : void
      {
         switch(param1)
         {
            case MafiaMessageData.LISTTYPE_FIGHT:
               this.newsScreen.layer_fight.gotoAndStop(1);
               this.newsScreen.layer_fight.btn_toFights.y = -19.75;
               this.newsScreen.layer_normal.gotoAndStop(2);
               this.newsScreen.layer_normal.btn_normal.y = -16.5;
               this.newsScreen.writeMail.layer.gotoAndStop(2);
               this.newsScreen.writeMail.layer.btn_write.y = -16.5;
               break;
            case MafiaMessageData.LISTTYPE_TEXT:
               this.newsScreen.layer_fight.gotoAndStop(2);
               this.newsScreen.layer_fight.btn_toFights.y = -16.5;
               this.newsScreen.layer_normal.gotoAndStop(1);
               this.newsScreen.layer_normal.btn_normal.y = -19.75;
               this.newsScreen.writeMail.layer.gotoAndStop(2);
               this.newsScreen.writeMail.layer.btn_write.y = -16.5;
               break;
            case this.WRITEMODE:
               this.newsScreen.writeMail.layer.gotoAndStop(1);
               this.newsScreen.writeMail.layer.btn_write.y = -19.75;
               this.newsScreen.layer_fight.gotoAndStop(2);
               this.newsScreen.layer_fight.btn_toFights.y = -16.5;
               this.newsScreen.layer_normal.gotoAndStop(2);
               this.newsScreen.layer_normal.btn_normal.y = -16.5;
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.newsScreen.txt_mail_to:
               this.checkMailToTxt();
               break;
            case this.newsScreen.txt_mail_copy:
               this.checkMailCopyTxt();
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(this.newsScreen.writeMail.txt_mail_copy.text.length < 2 || this.newsScreen.writeMail.txt_mail_copy.text == MafiaModel.languageData.getTextById("MafiaMailScreen_copy_13") || this.newsScreen.writeMail.txt_mail_to.text == MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10"))
         {
            this.newsScreen.writeMail.btn_send.enableButton = false;
         }
         else
         {
            this.newsScreen.writeMail.btn_send.enableButton = true;
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
            case this.newsScreen.writeMail.txt_mail_to:
               this.checkMailToTxt();
               break;
            case this.newsScreen.writeMail.txt_mail_copy:
               this.checkMailCopyTxt();
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
            case this.newsScreen.writeMail.txt_mail_to:
               break;
            case this.newsScreen.writeMail.txt_mail_copy:
         }
      }
      
      private function checkMailToTxt() : void
      {
         if(this.newsScreen.writeMail.txt_mail_to.text == MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10"))
         {
            this.newsScreen.writeMail.btn_send.enableButton = false;
            this.newsScreen.writeMail.txt_mail_to.text = "";
         }
         if(this.newsScreen.writeMail.txt_mail_copy.text == "")
         {
            this.newsScreen.writeMail.txt_mail_copy.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_13");
         }
      }
      
      private function checkMailCopyTxt() : void
      {
         if(this.newsScreen.writeMail.txt_mail_copy.text == MafiaModel.languageData.getTextById("MafiaMailScreen_copy_13"))
         {
            this.newsScreen.writeMail.btn_send.enableButton = false;
            this.newsScreen.writeMail.txt_mail_copy.text = "";
         }
         if(this.newsScreen.writeMail.txt_mail_to.text == "")
         {
            this.newsScreen.writeMail.txt_mail_to.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
         }
      }
      
      private function onSendMessage() : void
      {
         this.from = String(this.newsScreen.writeMail.txt_mail_to.text);
         if(this.from.length == 0)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_16")));
            return;
         }
         var _loc1_:Array = new Array();
         _loc1_.push(this.from);
         _loc1_.push(this.newsScreen.writeMail.txt_mail_copy.text);
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SEND_MSG,_loc1_);
         MafiaModel.userData.messageData.readMessagesData.receiver = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
      }
      
      protected function get newsScreen() : MafiaMailing
      {
         return disp as MafiaMailing;
      }
   }
}
