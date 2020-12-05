package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.avatar.OUDCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSlotEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaSlotmachineComponents.SingleSlotMover;
   import com.goodgamestudios.mafia.view.panels.MafiaSlotmachineComponents.SlotmachineEndResult;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaSlotmachinePanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaSlotmachineDialog";
       
      
      private var slots:Vector.<SingleSlotMover>;
      
      private var gameIsRunning:Boolean = false;
      
      private var showResult:Boolean = true;
      
      private var endResult:SlotmachineEndResult;
      
      private var playFilter:GlowFilter;
      
      private var _playMode:String;
      
      private var _cash:int;
      
      private var _gold:int;
      
      private const PLAY_CASH:String = "play_cash";
      
      private const PLAY_GOLD:String = "play_gold";
      
      private const MAX_CASH:int = 1000;
      
      private var MAX_GOLD:int = 10;
      
      private const MIN_CASH_STAKE:int = 100;
      
      private const MIN_GOLD_STAKE:int = 50;
      
      public function MafiaSlotmachinePanel(param1:Sprite)
      {
         this.slots = new Vector.<SingleSlotMover>();
         this.playFilter = new GlowFilter(14325876,1,5,5,2,3);
         super(param1);
         index = PANEL_INDEX_SLOT;
         controller.addEventListener(MafiaSlotEvent.START_STLOTMACHINE,this.onStartSlotmachine);
         this.MAX_GOLD = MafiaModel.goldConstants.maxSlotMashineInput;
         this.initSlotmachine();
         this.cash = this.MAX_CASH;
         this.gold = this.MIN_GOLD_STAKE;
         this.playMode = this.PLAY_CASH;
      }
      
      public function get gold() : int
      {
         return this._gold;
      }
      
      public function set gold(param1:int) : void
      {
         this._gold = param1;
         if(this._gold > MafiaModel.userData.gold)
         {
            this._gold = MafiaModel.userData.gold;
         }
         if(this._gold > this.MAX_GOLD)
         {
            this._gold = this.MAX_GOLD;
         }
         if(this.gold < 0)
         {
            this._gold = 0;
         }
         if(this.playMode == this.PLAY_GOLD)
         {
            this.updateStakeInput();
            this.showMaxAward();
         }
      }
      
      public function get cash() : int
      {
         return this._cash;
      }
      
      public function set cash(param1:int) : void
      {
         this._cash = param1;
         if(this._cash > MafiaModel.userData.cash)
         {
            this._cash = MafiaModel.userData.cash;
         }
         if(this._cash > this.MAX_CASH)
         {
            this._cash = this.MAX_CASH;
         }
         if(this._cash < 0)
         {
            this._cash = 0;
         }
         if(this.playMode == this.PLAY_CASH)
         {
            this.updateStakeInput();
            this.showMaxAward();
         }
      }
      
      public function get playMode() : String
      {
         return this._playMode;
      }
      
      public function set playMode(param1:String) : void
      {
         this._playMode = param1;
         if(this.playMode == this.PLAY_CASH)
         {
            this.slotPanel.txt_input.text = this.cash.toString();
            this.slotPanel.btn_tabdollor.gotoAndStop(1);
            this.slotPanel.btn_tabgold.gotoAndStop(2);
         }
         else
         {
            this.slotPanel.txt_input.text = this.gold.toString();
            this.slotPanel.btn_tabdollor.gotoAndStop(2);
            this.slotPanel.btn_tabgold.gotoAndStop(1);
         }
         this.updateStakeInput();
         this.showMaxAward();
      }
      
      private function initSlotmachine() : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc1_:GlowFilter = new GlowFilter(0,1,1 * layoutManager.scaleFactor,1 * layoutManager.scaleFactor,20,3);
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            this.slots.push(new SingleSlotMover(this.slotPanel["slot" + _loc3_]));
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc4_ = 0;
            while(_loc4_ < 3)
            {
               MovieClipHelper.clearMovieClip(this.slotPanel["icon" + (_loc3_ + 1) + "_" + _loc4_]);
               _loc2_ = new (getDefinitionByName(Constants_Basic.ICON_PIC_CLASSNAME_LIST[_loc3_]) as Class)() as MovieClip;
               _loc2_.scaleX = _loc2_.scaleY = 0.45;
               _loc2_.filters = [_loc1_];
               if(_loc3_ == 6)
               {
                  _loc2_.scaleX = _loc2_.scaleY = 0.7;
               }
               this.slotPanel["icon" + (_loc3_ + 1) + "_" + _loc4_].addChild(_loc2_);
               _loc4_++;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc4_ = 0;
            while(_loc4_ < 2)
            {
               MovieClipHelper.clearMovieClip(this.slotPanel["iconsmall" + (_loc3_ + 1) + "_" + _loc4_]);
               _loc2_ = new (getDefinitionByName(Constants_Basic.ICON_PIC_CLASSNAME_LIST[_loc3_]) as Class)() as MovieClip;
               _loc2_.scaleX = _loc2_.scaleY = 0.25;
               _loc2_.filters = [_loc1_];
               this.slotPanel["iconsmall" + (_loc3_ + 1) + "_" + _loc4_].addChild(_loc2_);
               _loc4_++;
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            MovieClipHelper.clearMovieClip(this.slotPanel["iconmax1_" + _loc4_]);
            _loc2_ = new (getDefinitionByName("J91") as Class)() as MovieClip;
            _loc2_.scaleX = _loc2_.scaleY = 0.5;
            _loc2_.rotation = 20;
            _loc2_.filters = [_loc1_];
            this.slotPanel["iconmax1_" + _loc4_].addChild(_loc2_);
            _loc4_++;
         }
         this.slotPanel.btn_go.filters = [this.playFilter];
         this.slotPanel.btn_go.gotoAndStop(1);
         this.slotPanel.btn_tabdollor.gotoAndStop(1);
         this.slotPanel.btn_tabgold.gotoAndStop(2);
         this.slotPanel.awardMC.cacheAsBitmap = true;
         this.slotPanel.awardMC.gotoAndPlay("normal");
         this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "GOOD LUCK!";
         this.slotPanel.advertisment.mouseChildren = false;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc4_:Timer = null;
         if(this.gameIsRunning && this.showResult)
         {
            if(this.slots[0].isReadyToHear && this.slots[1].isReadyToHear && this.slots[2].isReadyToHear)
            {
               _loc4_ = new Timer(1000,1);
               _loc4_.addEventListener(TimerEvent.TIMER,this.onShowResult);
               _loc4_.start();
               this.showResult = false;
            }
         }
         var _loc2_:int = getTimer();
         var _loc3_:int = 0;
         while(_loc3_ < this.slots.length)
         {
            this.slots[_loc3_].updateDisp(_loc2_);
            _loc3_++;
         }
         if(this.slots[0].isFinished && this.slots[1].isFinished && this.slots[2].isFinished && this.gameIsRunning)
         {
            this.endGame();
         }
      }
      
      private function onShowResult(param1:Event) : void
      {
         (param1.target as Timer).removeEventListener(TimerEvent.TIMER,this.onShowResult);
         this.gotEndresult();
      }
      
      private function endGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SingleSlotMover = null;
         MafiaDialogHandler.getInstance().blockDialogs = false;
         this.slotPanel.btn_go.filters = [this.playFilter];
         this.slotPanel.btn_go.gotoAndStop(1);
         this.showResult = true;
         this.gameIsRunning = false;
         this.slotPanel.btn_go.enableButton = true;
         OUDCommand.sendCommand([]);
         this.slotPanel.awardMC.gotoAndPlay("winlose");
         if(this.playMode == this.PLAY_CASH)
         {
            if(this.endResult.cash > 0)
            {
               this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "YOU WIN\n" + this.endResult.cash.toString() + " $!";
            }
            else
            {
               this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "YOU LOST!\nTRY AGAIN!";
            }
         }
         else if(this.endResult.gold > 0)
         {
            this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "YOU WIN\n" + this.endResult.gold.toString() + " GOLD!";
         }
         else
         {
            this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "YOU LOST!\nTRY AGAIN!";
         }
         if(this.endResult.cash > 0 || this.endResult.gold > 0)
         {
            if(this.endResult.slot1Icon == this.endResult.slot2Icon && this.endResult.slot1Icon == this.endResult.slot3Icon && this.endResult.slot2Icon == this.endResult.slot3Icon)
            {
               switch(this.endResult.slot1Icon)
               {
                  case 1:
                     this.slotPanel.winblink100.gotoAndPlay(2);
                     break;
                  case 2:
                     this.slotPanel.winblink75.gotoAndPlay(2);
                     break;
                  case 3:
                     this.slotPanel.winblink50.gotoAndPlay(2);
                     break;
                  case 4:
                     this.slotPanel.winblink30.gotoAndPlay(2);
                     break;
                  case 5:
                     this.slotPanel.winblink20.gotoAndPlay(2);
                     break;
                  case 6:
                     this.slotPanel.winblink10.gotoAndPlay(2);
                     break;
                  case -1:
                     this.slotPanel.winblink2.gotoAndPlay(2);
               }
               _loc1_ = 0;
               while(_loc1_ < 3)
               {
                  _loc2_ = this.slots[_loc1_] as SingleSlotMover;
                  _loc2_.highlightWinIcon();
                  _loc1_++;
               }
            }
            else
            {
               this.slotPanel.winblink2of2.gotoAndPlay(2);
               if(this.endResult.slot1Icon == this.endResult.slot2Icon)
               {
                  (this.slots[0] as SingleSlotMover).highlightWinIcon();
                  (this.slots[1] as SingleSlotMover).highlightWinIcon();
                  return;
               }
               if(this.endResult.slot2Icon == this.endResult.slot3Icon)
               {
                  (this.slots[1] as SingleSlotMover).highlightWinIcon();
                  (this.slots[2] as SingleSlotMover).highlightWinIcon();
                  return;
               }
               if(this.endResult.slot3Icon == this.endResult.slot1Icon)
               {
                  (this.slots[2] as SingleSlotMover).highlightWinIcon();
                  (this.slots[0] as SingleSlotMover).highlightWinIcon();
                  return;
               }
            }
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var url:String = null;
         var urlRequest:URLRequest = null;
         var event:MouseEvent = param1;
         if(!event.target)
         {
            return;
         }
         if(this.gameIsRunning && event.target != this.slotPanel.btn_close)
         {
            return;
         }
         switch(event.target)
         {
            case this.slotPanel.btn_go:
               if(!this.gameIsRunning)
               {
                  if(this.playMode == this.PLAY_CASH)
                  {
                     if(this.cash == 0 || this.cash > MafiaModel.userData.cash)
                     {
                        layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_slotmachine_1"),MafiaModel.languageData.getTextById("MafiaNoCashForSlotmachine_copy"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
                        return;
                     }
                  }
                  else if(this.gold == 0 || this.gold > MafiaModel.userData.gold)
                  {
                     layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_slotmachine_1"),MafiaModel.languageData.getTextById("MafiaNoGoldForSlotmachine_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
                     return;
                  }
                  this.slotPanel.btn_go.gotoAndStop(3);
                  this.slotPanel.btn_go.filters = [];
                  this.slotPanel.awardMC.awardtxt.txt_awardmessage.text = "GOOD LUCK!";
                  if(this.playMode == this.PLAY_CASH)
                  {
                     MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_START_SLOTMACHINE,[this.cash,0]);
                  }
                  else
                  {
                     MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_START_SLOTMACHINE,[0,this.gold]);
                  }
               }
               break;
            case this.slotPanel.advertisment:
               if(!env.loginIsKeyBased && env.useexternallinks)
               {
                  try
                  {
                     url = "http://empire.goodgamestudios.com/";
                     urlRequest = new URLRequest(url);
                     navigateToURL(urlRequest,"_blank");
                  }
                  catch(e:Error)
                  {
                  }
               }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.target)
         {
            return;
         }
         if(this.gameIsRunning && param1.target != this.slotPanel.btn_close)
         {
            return;
         }
         switch(param1.target)
         {
            case this.slotPanel.btn_go:
               if(this.gameIsRunning)
               {
                  this.slotPanel.btn_go.gotoAndStop(1);
               }
               break;
            case this.slotPanel.btn_tabdollor:
               this.playMode = this.PLAY_CASH;
               break;
            case this.slotPanel.btn_tabgold:
               this.playMode = this.PLAY_GOLD;
               break;
            case this.slotPanel.btn_close:
               this.hide();
               break;
            case this.slotPanel.btn_down:
               if(this.playMode == this.PLAY_CASH)
               {
                  _loc2_ = int(this.cash % this.MIN_CASH_STAKE) || int(this.MIN_CASH_STAKE);
                  this.cash = Math.max(this.cash - _loc2_,this.MIN_CASH_STAKE);
               }
               else
               {
                  _loc2_ = int(this._gold % this.MIN_GOLD_STAKE) || int(this.MIN_GOLD_STAKE);
                  this.gold = Math.max(this._gold - _loc2_,this.MIN_GOLD_STAKE);
               }
               break;
            case this.slotPanel.btn_up:
               if(this.playMode == this.PLAY_CASH)
               {
                  this.cash = this.cash + this.MIN_CASH_STAKE;
               }
               else
               {
                  this.gold = this.gold + this.MIN_GOLD_STAKE;
               }
               break;
            case this.slotPanel.btn_double:
               if(this.playMode == this.PLAY_CASH)
               {
                  this.cash = this.cash * 2;
               }
               else
               {
                  this.gold = this.gold * 2;
               }
               break;
            case this.slotPanel.btn_max:
               if(this.playMode == this.PLAY_CASH)
               {
                  this.cash = this.MAX_CASH;
               }
               else
               {
                  this.gold = this.MAX_GOLD;
               }
         }
         super.onClick(param1);
      }
      
      private function showMaxAward() : void
      {
         if(this.playMode == this.PLAY_CASH)
         {
            this.slotPanel.maxCash.visible = true;
            this.slotPanel.maxGold.visible = false;
            this.slotPanel.txt_maxwin.text = String(this.cash * 100);
         }
         else
         {
            this.slotPanel.maxCash.visible = false;
            this.slotPanel.maxGold.visible = true;
            this.slotPanel.txt_maxwin.text = String(this.gold * 100);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(!param1.target)
         {
            return;
         }
         if(this.gameIsRunning)
         {
            return;
         }
         switch(param1.target)
         {
            case this.slotPanel.btn_go:
            case this.slotPanel.btn_tabdollor:
            case this.slotPanel.btn_tabgold:
            case this.slotPanel.btn_double:
            case this.slotPanel.btn_max:
            case this.slotPanel.btn_down:
            case this.slotPanel.btn_up:
               (param1.target as MovieClip).buttonMode = true;
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               break;
            case this.slotPanel.advertisment:
               if(!env.loginIsKeyBased && env.useexternallinks)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               }
               break;
            default:
               super.onMouseOver(param1);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(!param1.target)
         {
            return;
         }
         switch(param1.target)
         {
            case this.slotPanel.btn_go:
            case this.slotPanel.btn_tabdollor:
            case this.slotPanel.btn_tabgold:
            case this.slotPanel.btn_double:
            case this.slotPanel.btn_max:
            case this.slotPanel.btn_down:
            case this.slotPanel.btn_up:
               (param1.target as MovieClip).buttonMode = false;
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               break;
            case this.slotPanel.advertisment:
               if(!env.loginIsKeyBased && env.useexternallinks)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               }
               break;
            default:
               super.onMouseOut(param1);
         }
      }
      
      private function onStartSlotmachine(param1:MafiaSlotEvent) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         this.endResult = new SlotmachineEndResult();
         this.endResult.cash = param1.params.shift();
         this.endResult.gold = param1.params.shift();
         this.endResult.slot1Icon = param1.params.shift();
         this.endResult.slot2Icon = param1.params.shift();
         this.endResult.slot3Icon = param1.params.shift();
         this.startSlotmachine();
      }
      
      private function gotEndresult() : void
      {
         var _loc1_:Timer = new Timer(500,3);
         _loc1_.addEventListener(TimerEvent.TIMER,this.endNext);
         _loc1_.start();
      }
      
      private function endNext(param1:TimerEvent) : void
      {
         var _loc2_:int = (param1.target as Timer).currentCount;
         var _loc3_:int = _loc2_ == 1?int(this.endResult.slot1Icon):_loc2_ == 2?int(this.endResult.slot2Icon):int(this.endResult.slot3Icon);
         this.slots[_loc2_ - 1].stopAtIconNr(_loc3_);
         if(_loc2_ - 1 == this.slots.length - 1)
         {
            param1.target.removeEventListener(TimerEvent.TIMER,this.startNext);
         }
      }
      
      override public function destroy() : void
      {
         this.slotPanel.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         controller.removeEventListener(MafiaSlotEvent.START_STLOTMACHINE,this.onStartSlotmachine);
         super.destroy();
      }
      
      private function startSlotmachine() : void
      {
         this.slots[0].reset();
         this.slots[1].reset();
         this.slots[2].reset();
         this.gameIsRunning = true;
         this.slots[0].animate = true;
         this.slotPanel.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         var _loc1_:Timer = new Timer(250,2);
         _loc1_.addEventListener(TimerEvent.TIMER,this.startNext);
         _loc1_.start();
      }
      
      private function startNext(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.slots.length)
         {
            if(!this.slots[_loc2_].animate)
            {
               this.slots[_loc2_].animate = true;
               if(_loc2_ == this.slots.length - 1)
               {
                  param1.target.removeEventListener(TimerEvent.TIMER,this.startNext);
               }
               return;
            }
            _loc2_++;
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.slotPanel.maxAwardMC.play();
         this.slotPanel.awardMC.play();
         this.slotPanel.awardMC.awardtxt.txt_awardmessage.embedFonts = true;
         var _loc1_:TextFormat = this.slotPanel.awardMC.awardtxt.txt_awardmessage.defaultTextFormat;
         _loc1_.font = "High Speed";
         this.slotPanel.awardMC.awardtxt.txt_awardmessage.defaultTextFormat = _loc1_;
         this.slotPanel.awardMC.awardtxt.txt_awardmessage.setTextFormat(_loc1_);
         basicController.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY,this.onCurrencyUpdate);
      }
      
      protected function onCurrencyUpdate(param1:Event) : void
      {
         if(this.gameIsRunning)
         {
         }
      }
      
      private function updateStakeInput() : void
      {
         if(this.playMode == this.PLAY_CASH)
         {
            this.slotPanel.txt_input.text = this.cash.toString();
         }
         else
         {
            this.slotPanel.txt_input.text = this.gold.toString();
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         this.slotPanel.awardMC.stop();
         this.slotPanel.maxAwardMC.stop();
      }
      
      private function get slotPanel() : MafiaSlotmachine
      {
         return disp as MafiaSlotmachine;
      }
   }
}
