package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.MafiaLoginFeatureData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAddFriendDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.mafia.vo.FeatureVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   
   public class MafiaHomeScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaHomeScreen";
       
      
      private var _currentFeature:int;
      
      private var _currentFeatureListPosition:int = 0;
      
      private const MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW:int = 11;
      
      private var tickerSingleTextWidth:Number = 0;
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private const TITLE_TEXT_HEIGHT:int = 31;
      
      public function MafiaHomeScreen(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
         this.homeScreen.featureList.visible = true;
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_HOME;
      }
      
      override public function show() : void
      {
         super.show();
         MafiaDialogHandler.getInstance().blockDialogs = true;
         this.homeScreen.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.homeScreen.btn_show.label = MafiaModel.languageData.getTextById("homescreenFeature_btn_showAll");
         this.homeScreen.comingSoon.addFriend.txt_title.text = MafiaModel.languageData.getTextById("MafiaAchievementTitle_8");
         this.homeScreen.comingSoon.addFriend.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends");
         this.homeScreen.comingSoon.addFriend.btn_addFriend.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends");
         this.homeScreen.featureList.txt_title.text = MafiaModel.languageData.getTextById("homescreenFeature_text_archive");
         this.homeScreen.logo.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         this.homeScreen.news_ticker.startTicker("+++NEWS",1);
         this.fillFeatures(this.featureData,this._currentFeatureListPosition);
         this.updateScrollButtons();
         this.homeScreen.btn_show.visible = false;
         this.homeScreen.comingSoon.addFriend.visible = !env.isBeta && (env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends);
      }
      
      override public function hide() : void
      {
         super.hide();
         MafiaDialogHandler.getInstance().blockDialogs = false;
         this.homeScreen.news_ticker.stopTicker();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         MafiaDialogHandler.getInstance().blockDialogs = false;
      }
      
      private function fillFeatures(param1:MafiaLoginFeatureData, param2:int) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:FeatureListItem = null;
         var _loc6_:* = false;
         var _loc3_:int = param2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > param1.featureList.length)
         {
            _loc3_ = param1.featureList.length;
         }
         if(param1.featureList.length > 0)
         {
            this._currentFeature = 0;
            _loc4_ = 0;
            while(_loc4_ < this.MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW)
            {
               _loc5_ = this.homeScreen.featureList["feature" + _loc4_] as FeatureListItem;
               _loc5_.mouseChildren = false;
               if(_loc3_ < param1.featureList.length)
               {
                  _loc5_.visible = true;
                  _loc5_.txt_feature.text = MafiaModel.languageData.getTextById("homescreenFeature_" + param1.featureList[_loc3_].id + "_" + param1.featureList[_loc3_].subId + "_title");
                  TextFieldHelper.sliceTextAnAddPoints(_loc5_.txt_feature);
                  _loc6_ = param1.featureList[_loc3_].featureTime == param1.featureList[0].featureTime;
                  _loc5_.properties = param1.featureList[_loc3_];
               }
               else
               {
                  _loc5_.visible = false;
               }
               _loc3_++;
               _loc4_++;
            }
            this.fillCurrentFeature(param1.featureList[0]);
            this.fillComingSoon(param1.comingSoonId);
         }
      }
      
      private function fillCurrentFeature(param1:FeatureVO) : void
      {
         MovieClipHelper.clearMovieClip(this.homeScreen.mc_featureholder);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.leading = 0;
         var _loc3_:Class = getDefinitionByName("FeatureDialog_" + param1.id + "_" + param1.subId) as Class;
         var _loc4_:MovieClip = new _loc3_();
         _loc4_.txt_title.defaultTextFormat = _loc2_;
         _loc4_.txt_title.text = MafiaModel.languageData.getTextById("homescreenFeature_" + param1.id + "_" + param1.subId + "_title");
         _loc4_.txt_title.height = _loc4_.txt_title.textHeight + this.MAGIC_FOUR_OFFSET;
         _loc4_.txt_copy.y = _loc4_.txt_copy.y + _loc4_.txt_title.height - this.TITLE_TEXT_HEIGHT;
         _loc4_.txt_copy.text = MafiaModel.languageData.getTextById("homescreenFeature_" + param1.id + "_" + param1.subId + "_copy");
         if(param1.id == 21 && param1.subId == 1)
         {
            _loc4_.txt_old_strength.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_strenght");
            _loc4_.txt_old_aptitude.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_aptitude");
            _loc4_.txt_old_intelligence.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_intelligence");
            _loc4_.txt_old_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
            _loc4_.txt_old_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
            _loc4_.txt_new_attack.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
            _loc4_.txt_new_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
            _loc4_.txt_new_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
            _loc4_.txt_new_tough.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         }
         this.homeScreen.mc_featureholder.addChild(_loc4_);
         this.highlightFeatureItem(param1);
         updateAllTextFields();
      }
      
      private function fillComingSoon(param1:int) : void
      {
         MovieClipHelper.clearMovieClip(this.homeScreen.comingSoon.mc_commingholder);
         var _loc2_:ComingSoon = new ComingSoon();
         this.homeScreen.comingSoon.txt_copy.text = MafiaModel.languageData.getTextById("homescreen_text_comingSoon");
         _loc2_.txt_copy.text = MafiaModel.languageData.getTextById("homescreenComingSoon_" + param1 + "_copy");
         this.homeScreen.comingSoon.mc_commingholder.addChild(_loc2_);
         updateAllTextFields();
      }
      
      private function updateScrollButtons() : void
      {
         var _loc1_:* = this.featureData.featureList.length > this.MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW;
         this.homeScreen.featureList.btn_up.visible = _loc1_;
         this.homeScreen.featureList.btn_down.visible = _loc1_;
         if(_loc1_)
         {
            this.homeScreen.featureList.btn_up.enableButton = this._currentFeatureListPosition > 0;
            this.homeScreen.featureList.btn_down.enableButton = this._currentFeatureListPosition + this.MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW < this.featureData.featureList.length;
         }
      }
      
      private function highlightFeatureItem(param1:FeatureVO) : void
      {
         var _loc3_:FeatureListItem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW)
         {
            _loc3_ = this.homeScreen.featureList["feature" + _loc2_] as FeatureListItem;
            _loc3_.bg.gotoAndStop(1);
            if(_loc3_.properties && param1.id == _loc3_.properties.id && param1.subId == _loc3_.properties.subId)
            {
               _loc3_.bg.gotoAndStop(2);
            }
            _loc2_++;
         }
      }
      
      private function getFeatureIndex(param1:FeatureVO) : int
      {
         var _loc2_:Vector.<FeatureVO> = MafiaModel.userData.featureData.featureList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:FeatureListItem = null;
         if(param1.target is FeatureListItem)
         {
            _loc2_ = param1.target as FeatureListItem;
            if(_loc2_.properties is FeatureVO)
            {
               this.fillCurrentFeature(_loc2_.properties);
               this._currentFeature = this.getFeatureIndex(_loc2_.properties);
            }
         }
         switch(param1.target)
         {
            case this.homeScreen.btn_show:
               this.toggleFeatureList();
               break;
            case this.homeScreen.btn_featureLeft:
               if(this._currentFeature == 0)
               {
                  this._currentFeature = MafiaModel.userData.featureData.featureList.length - 1;
               }
               else
               {
                  this._currentFeature--;
               }
               this.fillCurrentFeature(MafiaModel.userData.featureData.featureList[this._currentFeature]);
               break;
            case this.homeScreen.btn_featureRight:
               if(this._currentFeature >= MafiaModel.userData.featureData.featureList.length - 1)
               {
                  this._currentFeature = 0;
               }
               else
               {
                  this._currentFeature++;
               }
               this.fillCurrentFeature(MafiaModel.userData.featureData.featureList[this._currentFeature]);
               break;
            case this.homeScreen.comingSoon.addFriend.btn_addFriend:
               if(env.loginIsKeyBased)
               {
                  MafiaModel.socialData.inviteFriends();
               }
               else if(!env.isBeta)
               {
                  layoutManager.showDialog(MafiaAddFriendDialog.NAME,new MafiaAddFriendDialogProperties());
               }
               break;
            case this.homeScreen.featureList.btn_up:
               this.scrollUp();
               break;
            case this.homeScreen.featureList.btn_down:
               this.scrollDown();
               break;
            case this.homeScreen.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            default:
               super.onClick(param1);
         }
      }
      
      private function toggleFeatureList() : void
      {
         if(this.homeScreen.featureList.visible == false)
         {
            this.homeScreen.comingSoon.visible = false;
            this.homeScreen.featureList.visible = true;
            this.homeScreen.btn_show.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         }
         else
         {
            this.homeScreen.comingSoon.visible = false;
            this.homeScreen.featureList.visible = true;
            this.homeScreen.btn_show.label = MafiaModel.languageData.getTextById("homescreenFeature_btn_showAll");
         }
      }
      
      private function scrollUp() : void
      {
         if(this._currentFeatureListPosition > 0)
         {
            this._currentFeatureListPosition--;
         }
         this.updateScrollButtons();
         this.fillFeatures(MafiaModel.userData.featureData,this._currentFeatureListPosition);
      }
      
      private function scrollDown() : void
      {
         if(this._currentFeatureListPosition + this.MAX_NUMBER_OF_FEATURE_ITEMS_IN_VIEW < MafiaModel.userData.featureData.featureList.length)
         {
            this._currentFeatureListPosition++;
         }
         this.updateScrollButtons();
         this.fillFeatures(MafiaModel.userData.featureData,this._currentFeatureListPosition);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:FeatureListItem = null;
         if(param1.target is FeatureListItem)
         {
            _loc2_ = param1.target as FeatureListItem;
            if(_loc2_.properties is FeatureVO)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is FeatureListItem)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         super.onMouseOut(param1);
      }
      
      private function get featureData() : MafiaLoginFeatureData
      {
         return MafiaModel.userData.featureData;
      }
      
      protected function get homeScreen() : MafiaHome
      {
         return disp as MafiaHome;
      }
   }
}
