package com.goodgamestudios.mafia.view.screens.mailing
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.controller.commands.messages.DeleteMessageCommand;
   import com.goodgamestudios.mafia.controller.commands.messages.ReadMessageCommand;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.NewsVO;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaMailingComponent extends FlashUIComponent
   {
       
      
      private const NUMLINES:int = 13;
      
      private var _from:String;
      
      private var _readMailId:int = -1;
      
      private var _msgID:int;
      
      private var _msgType:MessageType;
      
      private var _activeMsg:String;
      
      private var _data:Vector.<NewsVO>;
      
      private var _listeType:String;
      
      private var _startPos:int = 0;
      
      public function MafiaMailingComponent(param1:DisplayObject, param2:String)
      {
         super(param1);
         this._listeType = param2;
      }
      
      public function fillNews(param1:Vector.<NewsVO>) : void
      {
         var _loc3_:MailingLine = null;
         this.destroyNews();
         this._data = param1;
         if(this._startPos < 0)
         {
            this._startPos = 0;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.NUMLINES)
         {
            _loc3_ = this.newsLines["mail" + _loc2_] as MailingLine;
            if(this._startPos != this._data.length)
            {
               if(this._data[this._startPos].secondTillSend == -1)
               {
                  _loc3_.visible = false;
               }
               else
               {
                  _loc3_.visible = true;
                  _loc3_.properties = this._data[this._startPos];
                  _loc3_.btn_delete.addEventListener(MouseEvent.CLICK,this.onDeleteMSG,false,0,true);
                  _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onOverMail,false,0,true);
                  _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onOutMail,false,0,true);
                  _loc3_.addEventListener(MouseEvent.CLICK,this.onClickMail,false,0,true);
                  _loc3_.fromPlayer_txt.mouseEnabled = false;
                  _loc3_.sendTime_txt.mouseEnabled = false;
                  _loc3_.title_txt.mouseEnabled = false;
                  _loc3_.mailingBG.mouseEnabled = false;
                  _loc3_.btn_delete.visible = false;
                  _loc3_.btn_delete.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaMailScreen_btn_delete");
                  _loc3_.fromPlayer_txt.text = this._data[this._startPos].fromPlayerName;
                  _loc3_.sendTime_txt.text = this._data[this._startPos].sendDate;
                  _loc3_.title_txt.text = MafiaModel.languageData.getTextById("tt_MafiaMail_copy_" + this._data[this._startPos].msgType.index);
                  switch(this._data[this._startPos].msgType)
                  {
                     case MessageType.FightWon:
                     case MessageType.FightLost:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_2");
                        _loc3_.duelHighlite.gotoAndStop(this._data[this._startPos].msgType.index + 1);
                        break;
                     case MessageType.ClanInvitation:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_3");
                        break;
                     case MessageType.Newsletter:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_1");
                        break;
                     case MessageType.ClanKick:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_7");
                        break;
                     case MessageType.Admin:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_1");
                        break;
                     case MessageType.PlayerMessage:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_14");
                        break;
                     case MessageType.PaymentDoppler:
                        _loc3_.title_txt.text = MafiaModel.languageData.getTextById("MafiaMailScreen_copy_1");
                        _loc3_.duelHighlite.gotoAndStop(2);
                  }
                  _loc3_.mailingBG.alpha = 0;
                  if(this._startPos == this._readMailId)
                  {
                     _loc3_.mailingBG.alpha = 1;
                     _loc3_.btn_delete.visible = true;
                  }
                  this._startPos++;
               }
            }
            _loc2_++;
         }
         this._startPos = this._startPos - this.listCount;
         this.newsLines.btn_up.visible = false;
         this.newsLines.btn_down.visible = false;
         if(this._data.length > this.NUMLINES)
         {
            if(this._startPos > 0)
            {
               this.newsLines.btn_up.visible = true;
            }
            if(this._startPos + this.NUMLINES < this._data.length)
            {
               this.newsLines.btn_down.visible = true;
            }
         }
         else
         {
            this.newsLines.btn_up.visible = false;
            this.newsLines.btn_down.visible = false;
         }
      }
      
      public function updateNews(param1:Vector.<NewsVO>) : void
      {
         if(this._startPos > 0)
         {
            if(param1.length <= this._startPos)
            {
               this._startPos = this._startPos - this.NUMLINES;
               if(this._startPos < 0)
               {
                  this._startPos = 0;
               }
            }
         }
         this.fillNews(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.newsLines.btn_up:
               this._startPos = this._startPos - this.listCount;
               this.fillNews(this._data);
               break;
            case this.newsLines.btn_down:
               this._startPos = this._startPos + this.NUMLINES;
               this.fillNews(this._data);
         }
      }
      
      private function get listCount() : int
      {
         var _loc1_:int = this._startPos;
         while(_loc1_ > 0)
         {
            _loc1_ = _loc1_ - this.NUMLINES;
         }
         return _loc1_ + this.NUMLINES;
      }
      
      private function onClickMail(param1:MouseEvent) : void
      {
         var _loc2_:MailingLine = null;
         if(param1.target is MailingLine)
         {
            _loc2_ = param1.target as MailingLine;
            this._readMailId = _loc2_.properties.listPos;
            this._activeMsg = _loc2_.name.substr(4);
            this._msgID = _loc2_.properties.msgID;
            this._msgType = _loc2_.properties.msgType;
            MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            this.deselectAllMessages();
            _loc2_.mailingBG.alpha = 1;
            _loc2_.btn_delete.visible = true;
            this._from = _loc2_.properties.fromPlayerName;
            this.setMessagesVars();
            MafiaModel.userData.messageData.readMessagesData.receiver = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_10");
            MafiaModel.userData.messageData.readMessagesData.receiver = this._from;
            MafiaModel.userData.messageData.readMessagesData.readMsgSender = this._from;
            MafiaModel.userData.messageData.readMessagesData.readMsgSenderId = _loc2_.properties.fromPlayerID;
            ReadMessageCommand.sendCommand(this._msgID,this._msgType);
         }
      }
      
      public function deleteMSG(param1:String) : void
      {
         var _loc2_:MailingLine = null;
         _loc2_ = this.newsLines["mail" + param1] as MailingLine;
         if(_loc2_ && _loc2_.properties)
         {
            this._readMailId = -1;
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onOverMail);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onOutMail);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onClickMail);
            DeleteMessageCommand.sendCommand(_loc2_.properties.msgID,_loc2_.properties.msgType);
            MafiaModel.userData.messageData.deleteMsg(_loc2_.properties.listPos,_loc2_.properties.listType);
            MafiaModel.userData.messageData.readMessagesData.receiver = "";
            this.newsLines.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.DESELECT));
            this.newsLines.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.SWITCH_WRITEMAIL,[true]));
         }
      }
      
      private function onDeleteMSG(param1:MouseEvent) : void
      {
         var _loc2_:Icon_Delete = param1.target as Icon_Delete;
         _loc2_.visible = false;
         var _loc3_:MailingLine = _loc2_.parent as MailingLine;
         this.deleteMSG(_loc3_.name.substr(4));
      }
      
      private function onOverMail(param1:MouseEvent) : void
      {
         var _loc2_:MailingLine = null;
         if(param1.target is TextField)
         {
            return;
         }
         if(param1.target is MailingLine)
         {
            _loc2_ = param1.target as MailingLine;
            MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            if(_loc2_.mailingBG.alpha > 0.9)
            {
               return;
            }
            _loc2_.mailingBG.alpha = 0.5;
            _loc2_.btn_delete.visible = true;
         }
      }
      
      private function onOutMail(param1:MouseEvent) : void
      {
         var _loc2_:MailingLine = null;
         if(param1.target is MailingLine)
         {
            _loc2_ = param1.target as MailingLine;
            MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            if(_loc2_.mailingBG.alpha > 0.9)
            {
               return;
            }
            _loc2_.mailingBG.alpha = 0;
            _loc2_.btn_delete.visible = false;
         }
      }
      
      public function deselectMessage() : void
      {
         var _loc1_:MailingLine = null;
         _loc1_ = this.newsLines["mail" + this._activeMsg] as MailingLine;
         if(_loc1_)
         {
            _loc1_.mailingBG.alpha = 0;
            _loc1_.btn_delete.visible = false;
            this._activeMsg = "-1";
            MafiaModel.userData.messageData.readMessagesData.receiver = "";
            this.newsLines.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_NEWNEWSDATA,[true]));
            this._readMailId = -1;
         }
      }
      
      public function deselectAllMessages() : void
      {
         var _loc2_:MailingLine = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.NUMLINES)
         {
            _loc2_ = this.newsLines["mail" + _loc1_] as MailingLine;
            _loc2_.mailingBG.alpha = 0;
            _loc2_.btn_delete.visible = false;
            _loc1_++;
         }
      }
      
      public function destroyNews() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MailingLine = null;
         _loc1_ = 0;
         while(_loc1_ < this.NUMLINES)
         {
            _loc2_ = this.newsLines["mail" + _loc1_] as MailingLine;
            _loc2_.properties = null;
            _loc2_.visible = false;
            _loc2_.btn_delete.removeEventListener(MouseEvent.CLICK,this.onDeleteMSG);
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onOverMail);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onOutMail);
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onClickMail);
            _loc1_++;
         }
      }
      
      private function setMessagesVars() : void
      {
         this.newsLines.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.SET_VARS,[this._from,this._readMailId,this._msgID]));
      }
      
      protected function get newsLines() : MailingLineBox
      {
         return disp as MailingLineBox;
      }
      
      public function get activeMsg() : String
      {
         return this._activeMsg;
      }
      
      public function get isMailInFocus() : Boolean
      {
         return this._readMailId > -1;
      }
   }
}
