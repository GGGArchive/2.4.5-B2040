package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.event.MafiaSliderEvent;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.helper.SliderHelper;
   import com.goodgamestudios.mafia.view.panels.MafiaIngameHelpComponents.MafiaHelpSite;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   
   public class MafiaHelpPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaHelpPanel";
      
      private static const HELP_STATE_WELCOME:int = 1;
      
      private static const HELP_STATE_AVATAR:int = 2;
      
      private static const HELP_STATE_CHANGE_AVATAR:int = 3;
      
      private static const HELP_STATE_XP:int = 4;
      
      private static const HELP_STATE_CLASS:int = 5;
      
      private static const HELP_STATE_ATTRIBUTES:int = 6;
      
      private static const HELP_STATE_AP:int = 7;
      
      private static const HELP_STATE_CURRENCY:int = 8;
      
      private static const HELP_STATE_HONOR:int = 9;
      
      private static const HELP_STATE_RANK:int = 10;
      
      private static const HELP_STATE_ITEMS:int = 11;
      
      private static const HELP_STATE_GODFATHER:int = 12;
      
      private static const HELP_STATE_MISSIONS:int = 13;
      
      private static const HELP_STATE_WORK:int = 14;
      
      private static const HELP_STATE_SLOT_MACHINE:int = 15;
      
      private static const HELP_STATE_ENERGY:int = 16;
      
      private static const HELP_STATE_SHOPS:int = 17;
      
      private static const HELP_STATE_DUEL:int = 18;
      
      private static const HELP_STATE_WANTED:int = 19;
      
      private static const HELP_STATE_DUNGEON:int = 20;
      
      private static const HELP_STATE_FAMILY:int = 21;
      
      private static const HELP_STATE_ACHIEVEMENT:int = 22;
      
      private static const HELP_STATE_FRIENDS:int = 23;
      
      private static const HELP_STATE_LOGIN_BONUS:int = 24;
       
      
      private var site:MovieClip;
      
      protected var helpHeight:int = 0;
      
      protected var helpslider:SliderHelper;
      
      private const NUMBER_OF_VISIBLE_TOPICS:uint = 15;
      
      private const NUMBER_OF_TOPICS:uint = 26;
      
      private const TOPIC_HEIGHT:Number = 23.8;
      
      private var topicButtons:Vector.<MafiaBasicHelpNavigationButton>;
      
      private var _currentTopTopicInList:int = 1;
      
      private var topicHolderStartY:Number;
      
      public function MafiaHelpPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_HELP;
         this.helpPanel.filters = [new DropShadowFilter(4,45,0,0.5,15,15,1,1)];
         this.helpslider = new SliderHelper(this.helpPanel.mc_helpslider);
         this.helpPanel.mc_helpslider.addEventListener(MafiaSliderEvent.ON_SLIDING,this.onChatSliding);
         this.helpPanel.mc_helpslider.addEventListener(MafiaSliderEvent.ARROW_UP,this.onChatSliding);
         this.helpPanel.mc_helpslider.addEventListener(MafiaSliderEvent.ARROW_DOWN,this.onChatSliding);
         this.helpPanel.mc_helpslider.btn_slider.visible = false;
         this.helpslider.StepSize = 20;
         this.helpPanel.helpHolder.mask = this.helpPanel.mc_mask;
         this.topicHolderStartY = this.helpPanel.topicHolder.y;
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayout);
         this.generateTopicButtons();
         this.helpPanel.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.helpPanel.txt_help.text = MafiaModel.languageData.getTextById("mafia_ingamehelp_title");
         this.showHelpByLayoutState(layoutManager.actState);
      }
      
      override public function hide() : void
      {
         controller.removeEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayout);
         super.hide();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayout);
         super.destroy();
      }
      
      private function onChangeLayout(param1:MafiaDialogEvent) : void
      {
         this.showHelpByLayoutState(param1.params[0]);
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
            disp.y = 300 * layoutManager.scaleFactor;
            disp.x = Constants_Basic.GAME_WIDTH * 0.5 * disp.scaleX + layoutManager.gameNullPoint;
         }
      }
      
      private function generateTopicButtons() : void
      {
         var _loc3_:HelpTopic = null;
         var _loc4_:String = null;
         MovieClipHelper.clearMovieClip(this.helpPanel.topicHolder);
         this.topicButtons = new Vector.<MafiaBasicHelpNavigationButton>();
         var _loc1_:Number = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= this.NUMBER_OF_TOPICS)
         {
            _loc3_ = new HelpTopic();
            this.helpPanel.topicHolder.addChild(_loc3_);
            this.topicButtons.push(_loc3_.btn_topic);
            _loc4_ = MafiaModel.languageData.getTextById("mafia_ingamehelp_category_" + _loc2_);
            _loc3_.name = _loc2_.toString();
            _loc3_.btn_topic.label = _loc4_;
            _loc3_.y = _loc1_;
            _loc1_ = _loc1_ + this.TOPIC_HEIGHT;
            _loc2_++;
         }
      }
      
      private function updateTopicList() : void
      {
         this.helpPanel.topicHolder.y = this.topicHolderStartY - (this._currentTopTopicInList - 1) * this.TOPIC_HEIGHT;
      }
      
      public function showHelpByLayoutState(param1:int) : void
      {
         this.showHelpText(this.validateState(param1));
         this.updateTopicList();
         this.updateTopicScrollButtons();
      }
      
      private function validateState(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case Constants_LayoutStates.STATE_PROFILE:
            case Constants_LayoutStates.STATE_OTHERPROFILE:
               _loc2_ = HELP_STATE_AVATAR;
               break;
            case Constants_LayoutStates.STATE_CUSTOMIZE_AVATAR:
               _loc2_ = HELP_STATE_CHANGE_AVATAR;
               break;
            case Constants_LayoutStates.STATE_DUEL:
               _loc2_ = HELP_STATE_DUEL;
               break;
            case Constants_LayoutStates.STATE_SHOP:
               _loc2_ = HELP_STATE_SHOPS;
               break;
            case Constants_LayoutStates.STATE_PLAYERRANKING:
            case Constants_LayoutStates.STATE_CLANRANKING:
               _loc2_ = HELP_STATE_RANK;
               break;
            case Constants_LayoutStates.STATE_CLANCREATION:
            case Constants_LayoutStates.STATE_USERCLAN:
            case Constants_LayoutStates.STATE_OTHERCLAN:
               _loc2_ = HELP_STATE_FAMILY;
               break;
            case Constants_LayoutStates.STATE_GANGWARS:
               _loc2_ = HELP_STATE_DUNGEON;
               break;
            case Constants_LayoutStates.STATE_MISSION:
               _loc2_ = HELP_STATE_MISSIONS;
               break;
            case Constants_LayoutStates.STATE_CLANCREATION:
            case Constants_LayoutStates.STATE_USERCLAN:
               _loc2_ = HELP_STATE_FAMILY;
               break;
            default:
               _loc2_ = HELP_STATE_WELCOME;
         }
         return _loc2_;
      }
      
      private function showHelpText(param1:int) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Class = null;
         var _loc4_:TextField = null;
         MovieClipHelper.clearMovieClip(this.helpPanel.helpHolder);
         MovieClipHelper.clearMovieClip(this.helpPanel.iconHolder);
         switch(param1)
         {
            case HELP_STATE_WELCOME:
               _loc2_ = new Logo();
               _loc2_.y = _loc2_.y - 8;
               break;
            case HELP_STATE_AVATAR:
            case HELP_STATE_CHANGE_AVATAR:
               _loc2_ = new AvatarBtnAsset();
               break;
            case HELP_STATE_XP:
               _loc2_ = new XP();
               break;
            case HELP_STATE_CLASS:
               _loc2_ = AvatarHelper.createClassSymbol(MafiaModel.userData.profileData.characterClass) as Sprite;
               break;
            case HELP_STATE_ATTRIBUTES:
               _loc2_ = new PlusButton();
               break;
            case HELP_STATE_AP:
               _loc2_ = new AP();
               break;
            case HELP_STATE_CURRENCY:
               _loc2_ = new Cash();
               break;
            case HELP_STATE_HONOR:
               _loc2_ = new Btn_Fame();
               break;
            case HELP_STATE_RANK:
               _loc2_ = new Position();
               break;
            case HELP_STATE_ITEMS:
               _loc2_ = new ShopBtnAsset();
               break;
            case HELP_STATE_GODFATHER:
            case HELP_STATE_MISSIONS:
               _loc2_ = new MissionBtnAsset();
               break;
            case HELP_STATE_WORK:
               _loc2_ = new WorkSymbol();
               break;
            case HELP_STATE_SLOT_MACHINE:
               _loc2_ = new Automat();
               break;
            case HELP_STATE_ENERGY:
               _loc2_ = new Energy();
               break;
            case HELP_STATE_SHOPS:
               _loc2_ = new ShopBtnAsset();
               break;
            case HELP_STATE_DUEL:
            case HELP_STATE_WANTED:
               _loc2_ = new DuelBtnAsset();
               break;
            case HELP_STATE_DUNGEON:
               _loc2_ = new GangwarBtnAsset();
               break;
            case HELP_STATE_FAMILY:
               _loc2_ = new ClanBtnAsset();
               break;
            case HELP_STATE_ACHIEVEMENT:
               _loc3_ = getDefinitionByName("AC_Epic") as Class;
               _loc2_ = new _loc3_() as MovieClip;
               break;
            case HELP_STATE_FRIENDS:
               _loc2_ = new addFriendSimpleBtn();
               break;
            case HELP_STATE_LOGIN_BONUS:
               _loc3_ = getDefinitionByName("I813") as Class;
               _loc2_ = new _loc3_() as MovieClip;
         }
         if(_loc2_)
         {
            _loc2_.mouseEnabled = false;
            _loc2_.scaleX = _loc2_.scaleY = 35 / _loc2_.height;
            _loc2_.x = _loc2_.width * 0.5;
            this.helpPanel.iconHolder.addChild(_loc2_);
         }
         if(this.site)
         {
            this.site.removeEventListener(MouseEvent.ROLL_OVER,this.onOverHelp);
            this.site.removeEventListener(MouseEvent.ROLL_OUT,this.onOutHelp);
            this.site = null;
         }
         this.site = new MafiaHelpSite(new HelpSiteMC());
         this.helpPanel.helpHolder.addChild(this.site);
         this.updateButtons(param1);
         this.setupHelp();
         this.helpPanel.txt_title.x = this.helpPanel.iconHolder.x + this.helpPanel.iconHolder.width + (!!_loc2_?10:0);
         this.helpPanel.txt_title.text = MafiaModel.languageData.getTextById("mafia_ingamehelp_category_" + String(param1));
         this.helpPanel.txt_title.mouseEnabled = false;
         this.site.createText(MafiaModel.languageData.getTextById("mafia_ingamehelp_category_" + String(param1) + "_text_1"));
         this.site.y = 2;
         this.helpPanel.helpHolder.y = this.helpPanel.mc_mask.y;
         for each(_loc4_ in findTextFields(this.site))
         {
            this.updateTextField(_loc4_);
         }
         this.site.setStyle();
         this.site.addEventListener(MouseEvent.ROLL_OVER,this.onOverHelp);
         this.site.addEventListener(MouseEvent.ROLL_OUT,this.onOutHelp);
         this.helpHeight = this.site.height;
         this.helpPanel.mc_helpslider.visible = this.helpHeight > this.helpPanel.mc_mask.height;
         this.updateSlider();
      }
      
      private function setupHelp() : void
      {
         this.site.setup(this.onSwitchState);
      }
      
      private function updateButtons(param1:int) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:HelpTopic = null;
         var _loc2_:uint = 1;
         while(_loc2_ <= this.NUMBER_OF_TOPICS)
         {
            _loc4_ = this.helpPanel.topicHolder.getChildByName(_loc2_.toString()) as HelpTopic;
            _loc4_.btn_topic.enableButton = param1 != _loc2_;
            _loc2_++;
         }
         for each(_loc3_ in findTextFields(this.helpPanel.topicHolder))
         {
            this.updateTextField(_loc3_);
         }
      }
      
      private function onSwitchState(param1:int) : void
      {
         this.showHelpText(param1);
      }
      
      private function onOverHelp(param1:MouseEvent) : void
      {
         MafiaLayoutManager.getInstance().customCursor.isEnabled = false;
         MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onOutHelp(param1:MouseEvent) : void
      {
         MafiaLayoutManager.getInstance().customCursor.isEnabled = true;
         MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function scrollNaviUp() : void
      {
         this.currentTopTopicInList--;
         this.updateTopicList();
         this.updateTopicScrollButtons();
      }
      
      private function scrollNaviDown() : void
      {
         this.currentTopTopicInList++;
         this.updateTopicList();
         this.updateTopicScrollButtons();
      }
      
      private function updateTopicScrollButtons() : void
      {
         this.helpPanel.btn_naviUp.enableButton = this.currentTopTopicInList > 1;
         this.helpPanel.btn_naviDown.enableButton = this.currentTopTopicInList <= this.NUMBER_OF_TOPICS - this.NUMBER_OF_VISIBLE_TOPICS;
      }
      
      private function onChatSliding(param1:MafiaSliderEvent) : void
      {
         if(this.extraHelpHeight <= this.helpPanel.mc_mask.height)
         {
            return;
         }
         this.helpPanel.helpHolder.y = this.helpPanel.mc_mask.y - (this.extraHelpHeight - this.helpPanel.mc_mask.height) * param1.slidePos * 0.01;
      }
      
      private function updateSlider() : void
      {
         if(this.extraHelpHeight < this.helpPanel.mc_mask.height)
         {
            return;
         }
         var _loc1_:int = this.helpPanel.helpHolder.y - this.helpPanel.mc_mask.y;
         var _loc2_:int = -(this.extraHelpHeight - this.helpPanel.mc_mask.height);
         var _loc3_:int = 100 - (_loc2_ - _loc1_) / _loc2_ * 100;
         this.helpPanel.mc_helpslider.btn_slider.y = this.helpPanel.mc_helpslider.mc_sliderbar.y + this.helpPanel.mc_helpslider.mc_sliderbar.height * _loc3_ * 0.01;
      }
      
      protected function get extraHelpHeight() : int
      {
         return this.helpHeight + 5;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(param1.target is MafiaBasicHelpNavigationButton)
         {
            _loc2_ = this.getTopicButtonIndex(param1.target as MafiaBasicHelpNavigationButton);
            this.showHelpText(_loc2_);
         }
         else
         {
            switch(param1.target)
            {
               case this.helpPanel.btn_close:
                  this.hide();
                  super.onClick(param1);
                  break;
               case this.helpPanel.btn_naviUp:
                  BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
                  this.scrollNaviUp();
                  break;
               case this.helpPanel.btn_naviDown:
                  BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
                  this.scrollNaviDown();
            }
         }
      }
      
      private function getTopicButtonIndex(param1:MafiaBasicHelpNavigationButton) : uint
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.NUMBER_OF_TOPICS)
         {
            if(this.topicButtons[_loc2_] == param1)
            {
               return _loc2_ + 1;
            }
            _loc2_++;
         }
         return 0;
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         var _loc2_:TextFormat = null;
         if(!BasicLanguageFontManager.getInstance().useDefaultFont && param1.styleSheet == null)
         {
            _loc2_ = param1.defaultTextFormat;
            if(_loc2_.font != "MafiaFont1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode)
            {
               _loc2_.font = "MafiaFont1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode;
               param1.defaultTextFormat = _loc2_;
               param1.setTextFormat(_loc2_);
               if(param1.parent is MafiaBasicHelpNavigationButton)
               {
                  param1.width = 160;
               }
            }
         }
      }
      
      protected function get helpPanel() : MafiaHelp
      {
         return disp as MafiaHelp;
      }
      
      private function set currentTopTopicInList(param1:int) : void
      {
         this._currentTopTopicInList = Math.max(1,Math.min(param1,this.NUMBER_OF_TOPICS - this.NUMBER_OF_VISIBLE_TOPICS + 1));
      }
      
      private function get currentTopTopicInList() : int
      {
         return this._currentTopTopicInList;
      }
   }
}
