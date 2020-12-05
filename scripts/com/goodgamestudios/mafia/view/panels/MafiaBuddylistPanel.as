package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.event.MafiaBuddyEvent;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.vo.BuddyVO;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   
   public class MafiaBuddylistPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaBuddylistPanel";
      
      public static const BUDDY_PANEL_HEIGHT:int = 160;
      
      private static const NOPIC_PATTERN:RegExp = /nopic/i;
      
      private static const BUDDYHOLDER_STD_POSX:int = 262;
      
      private static const AVATAR_SCALE_FACTOR:Number = 0.5;
      
      private static const BUDDY_ITEM_WIDTH:int = 148;
      
      private static const CITEM_WIDTH:int = 88;
      
      private static const CITEM_HEIGHT:int = 77;
       
      
      private var itemsPerPage:int;
      
      private var maxPage:int;
      
      private var currentPage:int;
      
      private var arrow_left:MovieClip;
      
      private var arrow_right:MovieClip;
      
      private var arrow_first:MovieClip;
      
      private var arrow_last:MovieClip;
      
      public function MafiaBuddylistPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_BUDDY;
      }
      
      override protected function init() : void
      {
         this.itemsPerPage = 5;
         this.maxPage = 0;
         this.currentPage = 0;
         this.arrow_left = this.buddylistPanel.btn_arrow_left;
         this.arrow_right = this.buddylistPanel.btn_arrow_right;
         this.arrow_first = this.buddylistPanel.btn_arrow_first;
         this.arrow_last = this.buddylistPanel.btn_arrow_last;
         this.buddylistPanel.btn_addbuddy.txt_title.text = MafiaModel.languageData.getTextById("generic_friends_buddy_btn_morefriends");
         this.buddylistPanel.btn_addbuddy.visible = env.invitefriends;
         this.setupBuddyItems(this.itemsPerPage);
         MafiaModel.buddyList.addEventListener(MafiaBuddyEvent.CHANGE_BUDDYDATA,this.onChangeBuddyData);
         super.init();
      }
      
      override public function destroy() : void
      {
         var _loc2_:BuddylistItem = null;
         super.destroy();
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.buddylistPanel["i" + _loc1_] as BuddylistItem;
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onClickBuddyItem);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,this.onOverBuddyItem);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,this.onOutBuddyItem);
            _loc1_++;
         }
         MafiaModel.buddyList.removeEventListener(MafiaBuddyEvent.CHANGE_BUDDYAVATARDATA,this.onChangeBuddyAvatarData);
         MafiaModel.buddyList.removeEventListener(MafiaBuddyEvent.CHANGE_BUDDYDATA,this.onChangeBuddyData);
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_COMPLETED:
            case BasicTutorialController.TUT_STATE_CANCEL:
               unLockPanel();
               break;
            default:
               lockPanel();
         }
      }
      
      private function onChangeBuddyData(param1:MafiaBuddyEvent) : void
      {
         MafiaModel.buddyList.addEventListener(MafiaBuddyEvent.CHANGE_BUDDYAVATARDATA,this.onChangeBuddyAvatarData);
         this.fillItems();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs == true)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.buddylistPanel.btn_addbuddy:
               MafiaModel.socialData.inviteFriends();
               break;
            case this.arrow_left:
               this.currentPage--;
               this.fillItems();
               break;
            case this.arrow_right:
               this.currentPage++;
               this.fillItems();
               break;
            case this.arrow_first:
               this.currentPage = 0;
               this.fillItems();
               break;
            case this.arrow_last:
               this.currentPage = this.maxPage;
               this.fillItems();
         }
      }
      
      private function onClickBuddyItem(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return;
         }
         var _loc2_:BuddylistItem = param1.target as BuddylistItem;
         if(_loc2_ && _loc2_.buddyData)
         {
            layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
            PlayerProfileCommand.sendCommand(_loc2_.buddyData.playerId,false);
         }
      }
      
      private function onOverBuddyItem(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onOutBuddyItem(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function fillItems() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BuddylistItem = null;
         var _loc5_:BuddyVO = null;
         this.initArrows(MafiaModel.buddyList.socialBuddyList.length);
         var _loc1_:int = this.currentPage * this.itemsPerPage;
         var _loc2_:int = _loc1_;
         while(_loc2_ < _loc1_ + this.itemsPerPage)
         {
            _loc3_ = _loc2_ - _loc1_;
            _loc4_ = this.buddylistPanel.getChildByName("i" + _loc3_) as BuddylistItem;
            MovieClipHelper.clearMovieClip(_loc4_.mc_holder);
            MovieClipHelper.clearMovieClip(_loc4_.classHolder);
            _loc4_.mouseChildren = false;
            _loc4_.visible = false;
            _loc4_.properties = null;
            if(_loc2_ < MafiaModel.buddyList.socialBuddyList.length)
            {
               _loc5_ = MafiaModel.buddyList.socialBuddyList[_loc2_];
               _loc4_.properties = _loc5_.playerId;
               if(_loc5_.playerName == "")
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_BUDDY_PLAYER_PROFILE,[_loc5_.playerId]);
               }
               else
               {
                  MafiaModel.buddyList.dispatchEvent(new MafiaBuddyEvent(MafiaBuddyEvent.CHANGE_BUDDYAVATARDATA,[_loc5_]));
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function onChangeBuddyAvatarData(param1:MafiaBuddyEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:BuddylistItem = null;
         var _loc7_:Sprite = null;
         var _loc8_:Loader = null;
         var _loc9_:URLRequest = null;
         var _loc10_:Sprite = null;
         var _loc2_:BuddyVO = param1.params[0] as BuddyVO;
         var _loc3_:int = this.currentPage * this.itemsPerPage;
         var _loc4_:int = _loc3_;
         while(_loc4_ < _loc3_ + this.itemsPerPage)
         {
            _loc5_ = _loc4_ - _loc3_;
            _loc6_ = this.buddylistPanel.getChildByName("i" + _loc5_) as BuddylistItem;
            if(_loc6_.properties == _loc2_.playerId)
            {
               _loc6_.visible = true;
               _loc6_.txt_name.text = _loc2_.playerName;
               _loc6_.txt_level.text = String(_loc2_.playerLevel);
               _loc6_.txt_rank.text = String(_loc2_.playerRank);
               _loc6_.buddyData = _loc2_;
               MovieClipHelper.clearMovieClip(_loc6_.mc_holder);
               MovieClipHelper.clearMovieClip(_loc6_.classHolder);
               _loc7_ = AvatarHelper.createClassSymbol(_loc2_.characterClass,0.5);
               _loc6_.classHolder.addChild(_loc7_);
               if(_loc2_.thumbUrl && _loc2_.thumbUrl != "" && _loc2_.thumbUrl.search(NOPIC_PATTERN) == -1)
               {
                  _loc8_ = new Loader();
                  _loc9_ = new URLRequest(_loc2_.thumbUrl);
                  _loc8_.load(_loc9_);
                  _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
                  _loc6_.mc_holder.addChild(_loc8_);
               }
               else
               {
                  if(_loc2_.picString.length == 1)
                  {
                     _loc10_ = AvatarHelper.createOldAvatar(_loc2_.playerGender.index + _loc2_.picString,AVATAR_SCALE_FACTOR);
                  }
                  else
                  {
                     _loc10_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(_loc2_.picString),0.2);
                  }
                  _loc10_.mouseEnabled = false;
                  _loc10_.mouseChildren = false;
                  _loc6_.mc_holder.addChild(_loc10_);
               }
            }
            _loc4_++;
         }
      }
      
      private function onPicLoadComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Rectangle = _loc2_.getBounds(null);
         var _loc4_:Number = CITEM_HEIGHT / _loc3_.height;
         _loc2_.scaleX = _loc2_.scaleY = _loc4_;
         _loc2_.y = -_loc2_.height;
         _loc2_.x = -_loc3_.width * _loc4_ * 0.5;
         param1.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicLoadComplete);
      }
      
      private function initArrows(param1:int) : void
      {
         if(param1 < 1)
         {
            this.arrow_right.visible = this.arrow_left.visible = this.arrow_first.visible = this.arrow_last.visible = false;
         }
         this.maxPage = (param1 - 1) / this.itemsPerPage;
         this.arrow_right.visible = this.maxPage > 0 && this.currentPage < this.maxPage;
         this.arrow_left.visible = this.maxPage > 0 && this.currentPage > 0;
         this.arrow_first.visible = this.currentPage > 0;
         this.arrow_last.visible = this.currentPage < this.maxPage;
      }
      
      override public function show() : void
      {
         super.show();
         this.updatePosition();
      }
      
      private function setupBuddyItems(param1:int) : void
      {
         var _loc3_:BuddylistItem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this.buddylistPanel["i" + _loc2_] as BuddylistItem;
            _loc3_.addEventListener(MouseEvent.CLICK,this.onClickBuddyItem);
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.onOverBuddyItem);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.onOutBuddyItem);
            _loc3_.visible = false;
            _loc2_++;
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
            disp.y = disp.stage.stageHeight;
         }
      }
      
      protected function get buddylistPanel() : BuddylistPanel
      {
         return disp as BuddylistPanel;
      }
   }
}
