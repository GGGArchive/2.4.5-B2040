package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.commands.CMTCommand;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.ColorUtils;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.commands.duel.TestFightCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.SellItemCommand;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.panels.MafiaActionPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaBuddylistPanel;
   import com.goodgamestudios.mafia.view.screens.MafiaDuelScreen;
   import com.goodgamestudios.mafia.vo.OfferVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.math.MathBase;
   import com.gskinner.motion.GTween;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   
   public class MafiaExecuteCheatCommand extends SimpleCommand
   {
       
      
      public function MafiaExecuteCheatCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Sprite = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:OfferVO = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:ItemVO = null;
         var _loc15_:int = 0;
         var _loc16_:BlurFilter = null;
         var _loc17_:TextField = null;
         var _loc18_:Timer = null;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:int = 0;
         _loc2_ = String(param1[0]).split("#");
         var _loc3_:String = _loc2_.shift();
         switch(_loc3_)
         {
            case "fight":
               TestFightCommand.sendCommand(_loc2_.shift());
            case "hidecursor":
               this.layoutManager.customCursor.hideForPerformance();
               break;
            case "ec":
               MafiaItemData.getInstance().epicColor = int(String("0x" + _loc2_.shift()));
               this.layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case "lc":
               MafiaItemData.getInstance().legendaryColor = int(String("0x" + _loc2_.shift()));
               this.layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case "home":
               this.layoutManager.state = Constants_LayoutStates.STATE_HOME;
               break;
            case "bonus":
               if(!this.env.isLocal && !this.env.isTest && !this.env.isDevTest)
               {
                  return;
               }
               _loc5_ = _loc2_.shift();
               _loc6_ = _loc2_.shift();
               _loc7_ = _loc2_.shift();
               MafiaModel.userData.offerData.initOffer = false;
               _loc8_ = MafiaModel.userData.offerData.parseData([0,_loc5_,20,_loc6_,_loc7_]);
               MafiaModel.userData.offerData.handleSpecialOffer(_loc8_);
               break;
            case "ua":
               if(!this.env.isLocal && !this.env.isTest && !this.env.isDevTest)
               {
                  return;
               }
               _loc9_ = _loc2_.shift();
               _loc20_ = 0;
               while(_loc20_ < 50)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_UPGRADE_ATTRIBUTE,[_loc9_]);
                  _loc20_++;
               }
               break;
            case "cmt":
               if(!this.env.isLocal && !this.env.isTest && !this.env.isDevTest)
               {
                  return;
               }
               _loc10_ = _loc2_.shift();
               _loc11_ = _loc2_.shift();
               _loc12_ = MafiaModel.languageData.getTextById(CMTCommand.TEASER_TYPE_TEXT_ID[_loc10_],[MafiaModel.userData.userName]);
               _loc13_ = MafiaModel.languageData.getTextById("cm_teaser" + _loc11_ + "_copy",[MafiaModel.languageData.getTextById("gametitle")]);
               CommandController.instance.executeCommand(BasicController.COMMAND_SHOW_COMA_TEASER,[_loc10_,_loc11_,_loc12_,_loc13_]);
               break;
            case "makemenaked":
               for each(_loc14_ in MafiaModel.userData.inventory.items)
               {
                  if(_loc14_)
                  {
                     SellItemCommand.sendCommand(_loc14_.slotId,_loc14_.amount);
                  }
               }
               for each(_loc14_ in MafiaModel.userData.gearData.items)
               {
                  if(_loc14_)
                  {
                     SellItemCommand.sendCommand(_loc14_.slotId,_loc14_.amount);
                  }
               }
               break;
            case "showversion":
               ((this.layoutManager.getPanel(MafiaActionPanel.NAME) as MafiaActionPanel).disp as ActionPanel).sheepBox.txt_sheep.text = this.env.versionText;
               break;
            case "iamblue":
               _loc15_ = _loc2_.shift();
               _loc16_ = new BlurFilter(_loc15_,_loc15_,3);
               _loc21_ = 0;
               while(_loc21_ < this.layoutManager.numChildren)
               {
                  _loc4_ = this.layoutManager.getChildAt(_loc21_) as Sprite;
                  _loc4_.filters = [_loc16_];
                  _loc4_.addEventListener(Event.ENTER_FRAME,this.onBeBlue);
                  _loc21_++;
               }
               this.layoutManager.tooltipManager.disp.filters = [_loc16_];
               this.layoutManager.tooltipManager.tooltipLayer.filters = [_loc16_];
               break;
            case "ihatebunnies":
               this.layoutManager.hideAllScreens();
               this.layoutManager.hideAllPanels();
               this.layoutManager.hideAllDialogs();
               this.layoutManager.backgroundComponent.hide();
               this.layoutManager.tooltipManager.tooltipLayer.mouseChildren = this.layoutManager.tooltipManager.tooltipLayer.mouseEnabled = true;
               _loc17_ = new TextField();
               _loc17_.name = "counter";
               _loc17_.x = _loc17_.y = 0;
               _loc17_.text = "0";
               this.layoutManager.tooltipManager.tooltipLayer.addChild(_loc17_);
               _loc18_ = new Timer(500);
               _loc18_.addEventListener(TimerEvent.TIMER,this.onCreateNewBunny);
               _loc18_.start();
               break;
            case "asp":
               MafiaModel.userData.unlockedAssetsData.parseUnlockedAssets(_loc2_.shift());
               this.layoutManager.state = Constants_LayoutStates.STATE_CUSTOMIZE_AVATAR;
               break;
            case "dsr":
               _loc19_ = _loc2_.shift();
               MafiaExtensionResponseCommand.cheatedResponseDelay = _loc19_;
               ((this.layoutManager.getPanel(MafiaActionPanel.NAME) as MafiaActionPanel).disp as ActionPanel).sheepBox.txt_sheep.text = "delay set to " + _loc19_ + "ms";
               break;
            case "fps":
               this.layoutManager.showFPS();
               break;
            default:
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SEND_SERVER_CHEAT,[String(param1[0])]);
         }
      }
      
      protected function onCreateNewBunny(param1:TimerEvent) : void
      {
         var _loc6_:ColorMatrix = null;
         var _loc7_:Timer = null;
         var _loc2_:Class = getDefinitionByName("C25") as Class;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = MathBase.random(0.5,5,false);
         var _loc4_:Number = MathBase.random(1,100);
         _loc3_.addEventListener(MouseEvent.CLICK,this.onClickBunny);
         _loc3_.buttonMode = _loc3_.useHandCursor = true;
         _loc3_.properties = 1;
         if(_loc4_ == 1)
         {
            _loc6_ = new ColorMatrix();
            _loc6_.colorize(ColorUtils.toColor("0xff88dd"),1);
            _loc3_.filters = [_loc6_.filter];
            _loc3_.properties = 10;
         }
         _loc3_.x = MathBase.random(0 + _loc3_.width / 2,Constants_Basic.GAME_WIDTH * this.layoutManager.scaleFactor + this.layoutManager.gameNullPoint * 2 - _loc3_.width / 2);
         _loc3_.y = MathBase.random(0 + _loc3_.height / 2,Constants_Basic.GAME_HEIGHT * this.layoutManager.scaleFactor - _loc3_.height / 2);
         this.layoutManager.tooltipManager.tooltipLayer.addChild(_loc3_);
         var _loc5_:TextField = this.layoutManager.tooltipManager.tooltipLayer.getChildByName("counter") as TextField;
         if(int(_loc5_.text) == 100)
         {
            MovieClipHelper.clearMovieClip(this.layoutManager.tooltipManager.tooltipLayer);
            this.layoutManager.tooltipManager.destroy();
            this.layoutManager.tooltipManager = new MafiaToolTipManager(this.layoutManager.tooltipManager.tooltipLayer);
            _loc7_ = param1.target as Timer;
            _loc7_.stop();
            _loc7_.removeEventListener(TimerEvent.TIMER,this.onCreateNewBunny);
            this.layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
            this.layoutManager.tooltipManager.tooltipLayer.mouseChildren = this.layoutManager.tooltipManager.tooltipLayer.mouseEnabled = false;
         }
      }
      
      protected function onClickBunny(param1:MouseEvent) : void
      {
         BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_SHOT);
         var _loc2_:TextField = this.layoutManager.tooltipManager.tooltipLayer.getChildByName("counter") as TextField;
         var _loc3_:MovieClip = param1.target as MovieClip;
         _loc2_.text = String(int(_loc2_.text) + int(_loc3_.properties));
         _loc3_.removeEventListener(MouseEvent.CLICK,this.onClickBunny);
         var _loc4_:Class = getDefinitionByName("G65") as Class;
         var _loc5_:MovieClip = new _loc4_();
         _loc5_.scaleX = _loc5_.scaleY = _loc3_.scaleX;
         _loc5_.x = _loc3_.x;
         _loc5_.y = _loc3_.y;
         _loc5_.cacheAsBitmap = true;
         var _loc6_:GTween = new GTween(_loc5_,1,{
            "alpha":0,
            "y":_loc5_.y + 20,
            "scaleY":_loc5_.scaleY + 0.5
         });
         _loc6_.delay = 2;
         _loc6_.onComplete = this.onBloodTweenComplete;
         _loc3_.parent.addChildAt(_loc5_,0);
         _loc3_.parent.removeChild(_loc3_);
         _loc3_ = null;
      }
      
      private function onBloodTweenComplete(param1:GTween) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      private function onBeBlue(param1:Event) : void
      {
         var _loc2_:Sprite = param1.target as Sprite;
         _loc2_.x = MathBase.random(-1,1);
         _loc2_.y = MathBase.random(-1,1);
         _loc2_.scaleX = _loc2_.scaleY = MathBase.random(1,1.1);
      }
      
      private function clearLayoutManager(param1:Event) : void
      {
         BasicController.getInstance().removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.clearLayoutManager);
         this.layoutManager.clearAllLayoutContent();
         this.layoutManager.clearAllScreens();
         this.showOldState();
      }
      
      private function showOldState() : void
      {
         if(this.env.hasNetworkBuddies)
         {
            this.layoutManager.showPanel(MafiaBuddylistPanel.NAME);
         }
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[0]);
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         this.layoutManager.state = Constants_LayoutStates.STATE_DUEL;
         (this.layoutManager.getScreen(MafiaDuelScreen.NAME) as MafiaDuelScreen).mafiaDuel.txt_search.text = "cc#lang#";
         BasicController.getInstance().dispatchEvent(new MafiaDialogEvent(MafiaDialogEvent.CHANGE_LAYOUTSTATE,[this.layoutManager.currentState]));
      }
      
      private function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
