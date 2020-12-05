package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_CliendCommands;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.clan.FamilyGetBulletinBoardCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.event.model.MafiaOfferEvent;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.panel.MafiaPanelEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.helper.MafiaGroupForumsHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaOwnUserData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.model.components.user.MafiaSpecialOfferData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import com.goodgamestudios.mafia.view.dialogs.MafiaAddFriendDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaChangePasswordDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailVerificationDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAddFriendDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaChangePasswordDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaActionPanelAvatarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaActionPanelAvatarAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.misc.SupportUtil;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Quadratic;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class MafiaActionPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaActionPanel";
       
      
      private const GLOWTIME:int = 300;
      
      private var allowHidePanel:Boolean = false;
      
      public function MafiaActionPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_ACTION;
         controller.addEventListener(MafiaOfferEvent.CHANGE_OFFER,this.onOfferData);
         controller.addEventListener(MafiaOfferEvent.CHANGE_GOLDSHINE,this.onShineGoldButton);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY,this.onChangeCurrency);
         controller.addEventListener(MafiaPanelEvent.CHAT_INPUT,this.onChatData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.addEventListener(MafiaNewsEvent.CHANGE_NEWNEWSDATA,this.onNewNews);
         controller.addEventListener(MafiaUserEvent.MAIL_VERIFICATION_COMPLETED,this.onVerificationComplete);
         controller.addEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         controller.addEventListener(MafiaUserEvent.CHANGE_PAYUSER_INFO,this.onUpdatePayuserInfo);
         controller.addEventListener(MafiaQuestEvent.CHANGE_QUESTLOG_DATA,this.onChangeQuestlogData);
         controller.addEventListener(MafiaSpecialEventsEvent.CAPOVITO_EVENT_DATA_UPDATED,this.onCapoVitoData);
         controller.addEventListener(MafiaSpecialEventsEvent.CAPOVITO_TIME_UPDATE,this.onCapoVitoTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_DATA_UPDATED,this.onNightOfHorrorData);
         controller.addEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_TIME_UPDATE,this.onNightOfHorrorTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onSicilianData);
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,this.onCalendarEventData);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_TIME_UPDATE,this.onCalendarEventTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.EDDYFROST_EVENT_DATA_UPDATED,this.onEddyFrostEventData);
         controller.addEventListener(MafiaSpecialEventsEvent.EDDYFROST_TIME_UPDATE,this.onEddyFrostEventTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.BREAK_THE_LAW_DATA_UPDATED,this.onBreakingTheLawData);
         controller.addEventListener(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,this.onBreakingTheLawTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_STARTED,this.onSpecialEventStarted);
         controller.addEventListener(MafiaOfferEvent.CHANGE_OFFERENDTIME,this.deactivatePaymentDoppler);
         controller.addEventListener(MafiaDialogEvent.DIALOGS_UNBLOCKED,this.onDialogsUnblocked);
         this.actionPanel.freshMessage.visible = false;
         this.actionPanel.freshMessage.mouseEnabled = false;
         this.actionPanel.btn_bonus.visible = false;
         this.actionPanel.ticker.visible = false;
         this.actionPanel.ticker.stopTicker();
         this.actionPanel.avatarPicField.levelbox.xpBar.scaleY = 0;
         this.actionPanel.avatarPicField.levelbox.txt_level.text = "1";
         this.actionPanel.txt_cash.gotoAndStop(1);
         this.actionPanel.txt_cash.value.txt_value.text = "";
         this.actionPanel.rank.gotoAndStop(1);
         this.actionPanel.cashPlusAni.gotoAndStop(1);
         this.actionPanel.cashMinusAni.gotoAndStop(1);
         this.actionPanel.cashMinusAni.mouseChildren = false;
         this.actionPanel.txt_gold.gotoAndStop(1);
         this.actionPanel.txt_gold.value.txt_value.text = "";
         this.actionPanel.goldPlusAni.gotoAndStop(1);
         this.actionPanel.goldPlusAni.mouseEnabled = false;
         this.actionPanel.goldMinusAni.gotoAndStop(1);
         this.actionPanel.btn_troup.chatani.visible = false;
         this.actionPanel.btn_troup.chatani.mouseEnabled = false;
         this.actionPanel.avatarPicField.levelbox.xpBar.properties = new Array();
         this.actionPanel.sheepBox.alpha = 0;
         this.actionPanel.sheepBox.visible = env.isTest || env.isLocal || env.isDevTest;
         if(layoutManager.actState != BasicLayoutManager.STATE_REGISTRATION)
         {
            this.fillActionPanelValues();
         }
      }
      
      override protected function init() : void
      {
         super.init();
         controller.addEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayout);
         controller.addEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.onChangeLayout);
         controller.removeEventListener(MafiaUserEvent.CHANGE_PING_DATA,this.onChangeStatus);
         controller.removeEventListener(MafiaOfferEvent.CHANGE_OFFER,this.onOfferData);
         controller.removeEventListener(MafiaOfferEvent.CHANGE_GOLDSHINE,this.onShineGoldButton);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY,this.onChangeCurrency);
         controller.removeEventListener(MafiaPanelEvent.CHAT_INPUT,this.onChatData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.removeEventListener(MafiaNewsEvent.CHANGE_NEWNEWSDATA,this.onNewNews);
         controller.removeEventListener(MafiaDialogEvent.DIALOGS_UNBLOCKED,this.onDialogsUnblocked);
         this.actionPanel.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutPanel);
         controller.removeEventListener(MafiaDialogEvent.CHANGE_LAYOUTSTATE,this.initButtons);
         controller.removeEventListener(MafiaUserEvent.MAIL_VERIFICATION_COMPLETED,this.onVerificationComplete);
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         controller.removeEventListener(MafiaSpecialEventsEvent.CAPOVITO_EVENT_DATA_UPDATED,this.onCapoVitoData);
         controller.removeEventListener(MafiaSpecialEventsEvent.CAPOVITO_TIME_UPDATE,this.onCapoVitoTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_DATA_UPDATED,this.onNightOfHorrorData);
         controller.removeEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_TIME_UPDATE,this.onNightOfHorrorTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onSicilianData);
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,this.onCalendarEventData);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_TIME_UPDATE,this.onCalendarEventTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.EDDYFROST_EVENT_DATA_UPDATED,this.onEddyFrostEventData);
         controller.removeEventListener(MafiaSpecialEventsEvent.EDDYFROST_TIME_UPDATE,this.onEddyFrostEventTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.BREAK_THE_LAW_DATA_UPDATED,this.onBreakingTheLawData);
         controller.removeEventListener(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,this.onBreakingTheLawTimer);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_STARTED,this.onSpecialEventStarted);
         controller.removeEventListener(MafiaUserEvent.CHANGE_PAYUSER_INFO,this.onUpdatePayuserInfo);
         controller.removeEventListener(MafiaOfferEvent.CHANGE_OFFERENDTIME,this.deactivatePaymentDoppler);
         this.actionPanel.ticker.stopTicker();
      }
      
      override public function show() : void
      {
         super.show();
         if(MafiaModel.userData.profileData.characterClass.index != 0)
         {
            this.fillAvatarValues(MafiaModel.userData);
            this.fillProfileData(MafiaModel.userData.profileData);
         }
         if(env.loginIsKeyBased)
         {
            this.actionPanel.mc_options.btn_changePass.enableButton = false;
         }
         else
         {
            this.actionPanel.mc_options.btn_changePass.enableButton = true;
         }
         this.highlightNews();
         this.actionPanel.btn_bonus.label = "";
         this.hideEventButton();
         this.hideAllSublayer();
         this.updateQuestlogButton();
         this.setupSpecialEvents();
      }
      
      private function setupSpecialEvents() : void
      {
         if(MafiaModel.specialEvent.capoVitoEvent.isEventActive)
         {
            this.setupCapo(true);
         }
         if(MafiaModel.specialEvent.nightOfHorrorEvent.isEventActive)
         {
            this.setupNightOfHorror(true);
         }
         if(MafiaModel.specialEvent.sicilianEvent.isEventActive)
         {
            this.setupSicilian(true,MafiaModel.specialEvent.sicilianEvent.isEventOver);
         }
         if(MafiaModel.specialEvent.calendarEvent.isEventActive)
         {
            this.setupCalendarEvent(true);
         }
         if(MafiaModel.specialEvent.tournamentEvent.isEventActive)
         {
            this.setupTournamentEvent(true);
         }
         if(MafiaModel.specialEvent.luckyDevilEvent.isEventActive)
         {
            this.setupLuckyDevilEvent(true);
         }
      }
      
      protected function onSpecialEventStarted(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupSpecialEvents();
      }
      
      private function onSpecialEventIsOver(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:int = param1.params[0];
         switch(_loc2_)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               this.hideEventButton();
               break;
            case Constants_SpecialEvents.ID_CAPO_VITO:
               this.hideEventButton();
               break;
            case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
               this.hideEventButton();
               break;
            case Constants_SpecialEvents.ID_CALENDAR:
               this.hideEventButton();
               break;
            case Constants_SpecialEvents.ID_TOURNAMENT:
               this.hideEventButton();
               if(layoutManager.currentState == Constants_LayoutStates.STATE_TOURNAMENT)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               }
               break;
            default:
               this.hideEventButton();
         }
      }
      
      private function hideEventButton() : void
      {
         this.actionPanel.btn_event.visible = this.actionPanel.layer_eventButtonOver.visible = this.actionPanel.layer_eventButtonUnder.visible = false;
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         lockPanel();
         this.updateQuestlogButton();
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case MafiaTutorialEvent.TUTORIAL_STATE_UNLOCKALL:
               this.setNaviButtonsVisibility(true);
               unLockPanel();
               this.setupSpecialEvents();
               break;
            case BasicTutorialController.TUT_STATE_CANCEL:
               this.setNaviButtonsVisibility(true);
               this.setupSpecialEvents();
               break;
            case BasicTutorialController.TUT_STATE_COMPLETED:
               this.setNaviButtonsVisibility(true);
               this.setupSpecialEvents();
               unLockPanel();
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_MISSION:
               unLockPanel();
               this.setNaviButtonsVisibility(false);
               this.activateNaviButton(this.actionPanel.btn_missions);
               this.actionPanel.btn_missions.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_INVENTAR:
               unLockPanel();
               this.setNaviButtonsVisibility(false);
               this.activateNaviButton(this.actionPanel.btn_avatar);
               this.actionPanel.btn_avatar.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               break;
            case MafiaTutorialController.TUT_STATE_TO_SHOP:
               unLockPanel();
               this.setNaviButtonsVisibility(false);
               this.activateNaviButton(this.actionPanel.btn_shop);
               this.actionPanel.btn_shop.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_PROFIL:
               unLockPanel();
               this.setNaviButtonsVisibility(false);
               this.activateNaviButton(this.actionPanel.btn_avatar);
               this.actionPanel.btn_avatar.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_GODFATHER:
               unLockPanel();
               this.setNaviButtonsVisibility(false);
               this.activateNaviButton(this.actionPanel.btn_missions);
               this.actionPanel.btn_missions.addChild(MafiaTutorialController.getInstance().tutorialArrow);
         }
         this.initButtons();
      }
      
      private function activateNaviButton(param1:MovieClip) : void
      {
         var _loc4_:GTween = null;
         var _loc2_:GlowFilter = new GlowFilter();
         var _loc3_:BlurFilter = new BlurFilter();
         _loc2_.strength = 4;
         _loc2_.alpha = 0.5;
         _loc2_.blurX = 16;
         _loc2_.blurY = 16;
         param1.alpha = 0.1;
         param1.visible = true;
         param1.getChildAt(0).filters = [_loc3_,_loc2_];
         _loc4_ = new GTween(param1,0.8,{
            "scaleY":1,
            "scaleX":1,
            "alpha":1
         },{"ease":Quadratic.easeInOut});
         _loc4_.delay = 0.3;
         var _loc5_:Object = new Object();
         _loc5_.param1 = param1;
         _loc4_.setValues(_loc5_);
         _loc4_.onComplete = this.onNaviButtonTweenComplete;
      }
      
      protected function onNaviButtonTweenComplete(param1:GTween) : void
      {
         var _loc2_:Object = param1.getValues();
         var _loc3_:MovieClip = _loc2_.param1;
         _loc3_.getChildAt(0).filters = [];
      }
      
      private function setNaviButtonsVisibility(param1:Boolean) : void
      {
         this.actionPanel.btn_avatar.visible = param1;
         this.actionPanel.btn_missions.visible = param1;
         this.actionPanel.btn_duel.visible = param1;
         this.actionPanel.btn_dungeon.visible = param1;
         this.actionPanel.btn_shop.visible = param1;
         this.actionPanel.btn_troup.visible = param1;
         this.actionPanel.btn_ranking.visible = param1;
      }
      
      private function onCapoVitoData(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupCapo(MafiaModel.specialEvent.capoVitoEvent.isEventActive);
      }
      
      private function setupCapo(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.languageData.getTextById("event_capovito_title");
         }
      }
      
      private function onNightOfHorrorData(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupNightOfHorror(MafiaModel.specialEvent.nightOfHorrorEvent.isEventActive);
      }
      
      private function setupNightOfHorror(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.languageData.getTextById("event_halloween_title");
         }
      }
      
      private function onCapoVitoTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.capoVitoEvent.runTimeInSeconds < Constants_SpecialEvents.CAPO_VITO_COUNTDOWN_TIME)
         {
            this.onEventCounter(param1.params[0]);
         }
      }
      
      private function onNightOfHorrorTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.nightOfHorrorEvent.runTimeInSeconds < Constants_SpecialEvents.CAPO_VITO_COUNTDOWN_TIME)
         {
            this.onEventCounter(param1.params[0]);
         }
      }
      
      private function onSicilianData(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupSicilian(MafiaModel.specialEvent.sicilianEvent.isEventActive,MafiaModel.specialEvent.sicilianEvent.isEventOver);
      }
      
      private function setupSicilian(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Boolean = param1 && !param2;
         this.onEventStarted(_loc3_);
         if(_loc3_)
         {
            this.actionPanel.btn_event.toolTipVO = null;
            this.actionPanel.btn_event.toolTipText = MafiaModel.languageData.getTextById("event_sicilianbeast_title");
         }
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.sicilianEvent.runTimeInSeconds < Constants_SpecialEvents.SICILIAN_COUNTDOWN_TIME)
         {
            this.actionPanel.btn_event.countDown.visible = true;
            this.actionPanel.btn_event.countDownLayer.visible = true;
            this.onEventCounter(param1.params[0]);
         }
         else
         {
            this.actionPanel.btn_event.countDown.visible = false;
            this.actionPanel.btn_event.countDownLayer.visible = false;
         }
      }
      
      private function onCalendarEventData(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupCalendarEvent(MafiaModel.specialEvent.calendarEvent.isEventActive);
      }
      
      private function setupCalendarEvent(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.specialEvent.calendarEvent.eventTitle;
         }
      }
      
      private function onEddyFrostEventData(param1:MafiaSpecialEventsEvent) : void
      {
         this.setupEddyFrostEvent(MafiaModel.specialEvent.eddyFrostEvent.isEventActive);
      }
      
      private function setupEddyFrostEvent(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.specialEvent.eddyFrostEvent.eventTitle;
         }
      }
      
      protected function onBreakingTheLawData(param1:Event) : void
      {
         this.setupBreakingTheLawEvent(MafiaModel.specialEvent.breakingTheLawEvent.isEventActive);
      }
      
      private function setupBreakingTheLawEvent(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.specialEvent.breakingTheLawEvent.eventTitle;
         }
      }
      
      private function onBreakingTheLawTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.breakingTheLawEvent.runTimeInSeconds < Constants_SpecialEvents.BREAKING_THE_LAW_TIME)
         {
            this.onEventCounter(param1.params[0]);
         }
      }
      
      private function onEddyFrostEventTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.eddyFrostEvent.runTimeInSeconds < Constants_SpecialEvents.CALENDAR_COUNTDOWN_TIME)
         {
            this.onEventCounter(param1.params[0]);
         }
      }
      
      private function onCalendarEventTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.calendarEvent.runTimeInSeconds < Constants_SpecialEvents.CALENDAR_COUNTDOWN_TIME)
         {
            this.onEventCounter(param1.params[0]);
         }
      }
      
      private function setupTournamentEvent(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.languageData.getTextById("event_lastmanstanding_title");
         }
      }
      
      private function setupLuckyDevilEvent(param1:Boolean) : void
      {
         this.onEventStarted(param1);
         if(param1)
         {
            this.actionPanel.btn_event.toolTipText = MafiaModel.languageData.getTextById("event_luckydevil_title");
         }
      }
      
      private function onEventStarted(param1:Boolean) : void
      {
         this.actionPanel.btn_event.countDownLayer.visible = this.actionPanel.btn_event.countDown.visible = false;
         if(!MafiaTutorialController.getInstance().isActive)
         {
            this.actionPanel.btn_event.visible = this.actionPanel.layer_eventButtonOver.visible = this.actionPanel.layer_eventButtonUnder.visible = param1;
         }
      }
      
      private function onEventCounter(param1:String) : void
      {
         this.actionPanel.btn_event.countDownLayer.visible = this.actionPanel.btn_event.countDown.visible = true;
         this.actionPanel.btn_event.countDown.txt_time.text = param1;
      }
      
      private function onChangeCurrency(param1:MafiaUserEvent) : void
      {
         this.fillActionPanelValues();
         this.fillAvatarValues(MafiaModel.userData);
      }
      
      private function onChatData(param1:MafiaPanelEvent) : void
      {
         this.actionPanel.btn_troup.chatani.visible = true;
         this.actionPanel.btn_troup.chatani.gotoAndPlay(2);
      }
      
      private function onNewNews(param1:MafiaNewsEvent) : void
      {
         this.highlightNews();
      }
      
      private function highlightNews() : void
      {
         if(MafiaModel.userData.messageData.newMessages > 0)
         {
            this.actionPanel.freshMessage.visible = true;
            updateAllTextFields();
            this.actionPanel.freshMessage.txt_label.text = "!";
         }
         else
         {
            this.actionPanel.freshMessage.visible = false;
            this.actionPanel.btn_messages.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_MAILING;
         }
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.fillAvatarValues(MafiaModel.userData);
      }
      
      protected function onDialogsUnblocked(param1:MafiaDialogEvent) : void
      {
         this.fillAvatarValues(MafiaModel.userData);
         this.updateQuestlogButton();
      }
      
      private function onChangeMissionData(param1:MafiaMissionEvent) : void
      {
         this.fillAvatarValues(MafiaModel.userData);
      }
      
      private function onChangeQuestlogData(param1:MafiaQuestEvent) : void
      {
         this.updateQuestlogButton();
      }
      
      private function fillAvatarValues(param1:MafiaOwnUserData) : void
      {
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return;
         }
         this.actionPanel.avatarPicField.toolTipVO = new TooltipVO(MafiaActionPanelAvatarAdvancedTooltip.NAME,new MafiaActionPanelAvatarAdvancedTooltipProperties(param1.userLevel,param1.userXP,param1.userXPForCurrentLevel,param1.userXPForNextLevel,MafiaModel.userData.userMissionEnergy / 10,param1.userAP),new Point(285,10),"",BasicCustomCursor.CURSOR_CLICK);
         this.actionPanel.avatarPicField.levelbox.xpBar.scaleY = param1.xpToNextLevelPercent / 100;
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.actionPanel.avatarPicField.levelbox.txt_level,String(param1.profileData.level));
      }
      
      private function onOfferData(param1:MafiaOfferEvent) : void
      {
         switch(param1.params[1])
         {
            case MafiaSpecialOfferData.ID_REGBONUS:
            case MafiaSpecialOfferData.ID_PRIMETIME:
               updateAllTextFields();
               this.actionPanel.btn_bonus.label = param1.params[2].toString() + "% " + MafiaModel.languageData.getTextById("MafiaActionPanel_text_bonus");
         }
      }
      
      private function onShineGoldButton(param1:MafiaOfferEvent) : void
      {
         if(!env.isBeta && param1.params[0] == true)
         {
            this.actionPanel.btn_bonus.visible = true;
            this.actionPanel.btn_bonus.label = MafiaModel.userData.offerData.offer.percentGold + "% " + MafiaModel.languageData.getTextById("MafiaActionPanel_text_bonus");
            this.actionPanel.ticker.startTicker(MafiaModel.languageData.getTextById("generic_payment_discount_copy",[MafiaModel.userData.offerData.offer.percentGold]) + "  —  ",1);
            this.actionPanel.ticker.visible = true;
         }
         else
         {
            this.actionPanel.btn_bonus.visible = false;
            this.actionPanel.ticker.visible = false;
            this.actionPanel.ticker.stopTicker();
         }
      }
      
      private function onChangeLayout(param1:MafiaDialogEvent) : void
      {
         this.showBigAvatarPicture();
         switch(param1.params[0])
         {
            case Constants_LayoutStates.STATE_DUEL_FIGHT:
            case Constants_LayoutStates.STATE_WANTED_FIGHT:
            case Constants_LayoutStates.STATE_GANGWAR_FIGHT:
            case Constants_LayoutStates.STATE_CITYQUEST_BONUS_FIGHT:
            case Constants_LayoutStates.STATE_CLAN_FIGHT:
            case Constants_LayoutStates.STATE_MISSION_FIGHT:
            case Constants_LayoutStates.STATE_REPLAY_FIGHT:
            case Constants_LayoutStates.STATE_SURVIVAL_FIGHT:
            case Constants_LayoutStates.STATE_POLICE_FIGHT:
            case Constants_LayoutStates.STATE_TOURNAMENT_FIGHT:
            case BasicLayoutManager.STATE_REGISTRATION:
               lockPanel();
               break;
            case Constants_LayoutStates.STATE_OTHERPROFILE:
            case Constants_LayoutStates.STATE_CUSTOMIZE_AVATAR:
            case Constants_LayoutStates.STATE_PLAYERRANKING:
            case Constants_LayoutStates.STATE_CLANRANKING:
            case Constants_LayoutStates.STATE_MAILING:
            case Constants_LayoutStates.STATE_GANGWARS:
            case Constants_LayoutStates.STATE_HOME:
            case Constants_LayoutStates.STATE_DUEL:
            case Constants_LayoutStates.STATE_DUEL_PREPARE:
            case Constants_LayoutStates.STATE_GANG:
               this.showSmallAvatarPicture();
               unLockPanel();
               break;
            case Constants_LayoutStates.STATE_MISSION:
               if(MafiaModel.userData.status == Constants_Status.STATUS_FLYING || MafiaModel.userData.status == Constants_Status.STATUS_FLIGHT_FINISHED)
               {
                  this.showSmallAvatarPicture();
               }
               unLockPanel();
               break;
            default:
               unLockPanel();
         }
         this.initButtons();
      }
      
      public function showBigAvatarPicture() : void
      {
         this.actionPanel.avatarPicField.levelbox.visible = true;
         this.actionPanel.avatarPicField.scaleX = this.actionPanel.avatarPicField.scaleY = 1;
         this.actionPanel.avatarPicField.bg.width = 145.5;
      }
      
      public function showSmallAvatarPicture() : void
      {
         this.actionPanel.avatarPicField.bg.width = 111.5;
         this.actionPanel.avatarPicField.levelbox.visible = false;
         this.actionPanel.avatarPicField.scaleX = this.actionPanel.avatarPicField.scaleY = 0.55;
      }
      
      private function initButtons() : void
      {
         this.actionPanel.btn_shop.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_SHOP;
         this.actionPanel.btn_shop.toolTipText = MafiaModel.languageData.getTextById("mafia_ingamehelp_category_17");
         this.actionPanel.btn_missions.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_MISSION;
         this.actionPanel.btn_missions.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_godfather");
         this.actionPanel.btn_avatar.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_avatar");
         this.actionPanel.btn_avatar.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_PROFILE;
         this.actionPanel.btn_duel.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_DUEL;
         this.actionPanel.btn_duel.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_duel");
         this.actionPanel.btn_addGold.mouseChildren = false;
         this.actionPanel.goldMinusAni.mouseChildren = false;
         this.actionPanel.goldMinusAni.mouseEnabled = false;
         this.actionPanel.cashMinusAni.mouseEnabled = false;
         this.actionPanel.cashLayer.toolTipText = MafiaModel.languageData.getTextById("MafiaPayment_cash");
         this.onUpdatePayuserInfo();
         this.actionPanel.position.mouseEnabled = false;
         this.actionPanel.positionLayer.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_rank");
         this.actionPanel.btn_ranking.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_PLAYERRANKING || layoutManager.currentState == Constants_LayoutStates.STATE_CLANRANKING;
         this.actionPanel.btn_ranking.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_ranking");
         this.actionPanel.btn_dungeon.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_GANGWARS;
         this.actionPanel.btn_dungeon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_gangwarfare");
         this.actionPanel.btn_troup.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_USERCLAN || layoutManager.currentState == Constants_LayoutStates.STATE_CLANCREATION;
         this.actionPanel.btn_troup.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_family");
         if(this.actionPanel.btn_messages.currentFrame == 1)
         {
            this.actionPanel.btn_messages.isFixed = layoutManager.currentState == Constants_LayoutStates.STATE_MAILING;
         }
         this.actionPanel.btn_messages.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_mail");
         this.actionPanel.btn_logout.toolTipText = MafiaModel.languageData.getTextById("generic_logout");
         this.actionPanel.btn_logout.enableButton = !env.loginIsKeyBased;
         this.actionPanel.btn_help.toolTipText = MafiaModel.languageData.getTextById("generic_help");
         this.actionPanel.mc_help.btn_support.toolTipText = MafiaModel.languageData.getTextById("generic_support");
         this.actionPanel.mc_help.btn_tutorial.toolTipText = MafiaModel.languageData.getTextById("mafia_ingamehelp_title");
         this.actionPanel.btn_options.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_options");
         this.actionPanel.mc_options.btn_changePass.toolTipText = MafiaModel.languageData.getTextById("generic_changePass");
         if(!env.useexternallinks)
         {
            this.actionPanel.mc_help.btn_support.enableButton = false;
         }
         this.actionPanel.mc_options.btn_sound.toolTipText = MafiaModel.languageData.getTextById("generic_sound");
         this.actionPanel.mc_options.btn_music.toolTipText = MafiaModel.languageData.getTextById("generic_music");
         this.actionPanel.mc_options.btn_music.enableButton = false;
         this.actionPanel.btn_forum.enableButton = env.networkNewsByJS || env.useexternallinks;
         if(!env.isBeta)
         {
            this.actionPanel.btn_email.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_emailverify");
            this.actionPanel.btn_email.enableButton = !env.loginIsKeyBased && !MafiaModel.userData.emailVerified && !MafiaTutorialController.getInstance().isActive && !MafiaModel.userData.mailVerification.eMailVerificationSend;
            this.actionPanel.btn_email.visible = !MafiaModel.userData.emailVerified;
            this.actionPanel.btn_addfriends.enableButton = env.loginIsKeyBased && env.invitefriends || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends;
            this.actionPanel.btn_addfriends.visible = env.loginIsKeyBased || !env.loginIsKeyBased && MafiaModel.userData.emailVerified && env.invitefriends;
            this.actionPanel.btn_addfriends.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends");
         }
         else
         {
            this.actionPanel.btn_email.enableButton = false;
            this.actionPanel.btn_addfriends.enableButton = false;
            this.actionPanel.btn_addGold.enableButton = false;
         }
         if(env.networkNewsByJS)
         {
            if(GoodgamePartners.isSpilNetwork(env.networkId))
            {
               this.actionPanel.btn_forum.toolTipText = MafiaModel.languageData.getTextById("generic_faq");
            }
            else
            {
               this.actionPanel.btn_forum.toolTipText = MafiaModel.languageData.getTextById("generic_group");
            }
         }
         else
         {
            this.actionPanel.btn_forum.toolTipText = MafiaModel.languageData.getTextById("generic_forum");
         }
         this.setSoundButtons();
         this.setGlowOnButtons();
         this.highlightNews();
      }
      
      private function onUpdatePayuserInfo(param1:Event = null) : void
      {
         if(MafiaModel.userData.hasPaymentDoppler && !MafiaModel.userData.offerData.offer)
         {
            this.actionPanel.mc_doppler.visible = true;
            this.actionPanel.mc_doppler.toolTipText = this.actionPanel.goldLayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_paymentdoubler",[MafiaModel.userData.paymentDoppler]);
         }
         else
         {
            this.deactivatePaymentDoppler();
         }
      }
      
      private function deactivatePaymentDoppler(param1:MafiaOfferEvent = null) : void
      {
         if(this.actionPanel.mc_doppler.visible == true)
         {
            this.actionPanel.mc_doppler.visible = false;
            this.actionPanel.btn_addGold.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_payment");
            this.actionPanel.goldLayer.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2");
         }
      }
      
      private function setSoundButtons() : void
      {
         if(!controller.soundController)
         {
            return;
         }
         if(controller.soundController.isEffectsMuted)
         {
            this.actionPanel.mc_options.btn_sound.cross.gotoAndStop(1);
         }
         else
         {
            this.actionPanel.mc_options.btn_sound.cross.gotoAndStop(2);
         }
         if(controller.soundController.isMusicMuted)
         {
            this.actionPanel.mc_options.btn_music.cross.gotoAndStop(1);
         }
         else
         {
            this.actionPanel.mc_options.btn_music.cross.gotoAndStop(2);
         }
      }
      
      private function fillActionPanelValues() : void
      {
         if(MafiaLayoutManager.getInstance().blockGoldCashRank && !MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         var _loc1_:Number = Number(String(this.actionPanel.txt_cash.value.txt_value.text).split(MafiaModel.languageData.getTextById("generic_decimalseparator")).join(""));
         var _loc2_:Number = Number(String(this.actionPanel.txt_gold.value.txt_value.text).split(MafiaModel.languageData.getTextById("generic_decimalseparator")).join(""));
         this.actionPanel.rank.value.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.rankInHighScoreDynamic,MafiaModel.languageData.getTextById);
         if(this.actionPanel.txt_cash.value.txt_value.text != "")
         {
            if(_loc1_ < MafiaModel.userData.cash)
            {
               this.actionPanel.txt_cash.gotoAndPlay(1);
               this.actionPanel.cashPlusAni.gotoAndPlay(1);
            }
            if(_loc1_ > MafiaModel.userData.cash)
            {
               this.actionPanel.txt_cash.gotoAndPlay(1);
               this.actionPanel.cashMinusAni.gotoAndPlay(1);
            }
         }
         this.actionPanel.txt_cash.value.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.cash,MafiaModel.languageData.getTextById);
         if(this.actionPanel.txt_gold.value.txt_value.text != "")
         {
            if(_loc2_ < MafiaModel.userData.gold)
            {
               this.actionPanel.txt_gold.gotoAndPlay(1);
               this.actionPanel.goldPlusAni.gotoAndPlay(1);
            }
            if(_loc2_ > MafiaModel.userData.gold)
            {
               this.actionPanel.txt_gold.gotoAndPlay(1);
               this.actionPanel.goldMinusAni.gotoAndPlay(1);
            }
         }
         this.actionPanel.txt_gold.value.txt_value.text = NumberStringHelper.groupString(MafiaModel.userData.gold,MafiaModel.languageData.getTextById);
      }
      
      private function onChangeUserAvatarData(param1:MafiaUserEvent) : void
      {
         this.fillProfileData(MafiaModel.userData.profileData);
      }
      
      private function fillProfileData(param1:MafiaProfileData) : void
      {
         var _loc2_:Sprite = null;
         MovieClipHelper.clearMovieClip(this.actionPanel.avatarPicField.holder);
         _loc2_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(param1.picString),0.25,true);
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         this.actionPanel.avatarPicField.holder.addChild(_loc2_);
         this.actionPanel.avatarPicField.mouseChildren = false;
         var _loc3_:Sprite = AvatarHelper.createClassSymbol(param1.characterClass,0.6);
         MovieClipHelper.clearMovieClip(this.actionPanel.avatarPicField.levelbox.mc_class);
         this.actionPanel.avatarPicField.levelbox.mc_class.addChild(_loc3_);
         this.actionPanel.rank.value.txt_value.text = NumberStringHelper.groupString(param1.rankInHighScoreDynamic,MafiaModel.languageData.getTextById);
      }
      
      private function onChangeStatus(param1:MafiaUserEvent) : void
      {
         this.initButtons();
      }
      
      private function setGlowOnButtons() : void
      {
         this.actionPanel.btn_missions.check.visible = false;
         this.actionPanel.btn_dungeon.check.visible = false;
         switch(MafiaModel.userData.status)
         {
            case Constants_Status.STATUS_MISSION_FINISHED:
            case Constants_Status.STATUS_WORK_FINISHED:
               this.actionPanel.btn_missions.check.visible = true;
               break;
            case Constants_Status.STATUS_FLIGHT_FINISHED:
               this.actionPanel.btn_dungeon.check.visible = true;
               break;
            default:
               this.actionPanel.btn_missions.check.visible = false;
               this.actionPanel.btn_dungeon.check.visible = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_GO_TO_INVENTAR:
               case MafiaTutorialController.TUT_STATE_GO_TO_PROFIL:
                  if(param1.target == this.actionPanel.btn_avatar)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
                     MafiaTutorialController.getInstance().nextStep();
                     break;
                  }
                  return;
               case MafiaTutorialController.TUT_STATE_GO_TO_MISSION:
               case MafiaTutorialController.TUT_STATE_GO_TO_GODFATHER:
                  if(param1.target == this.actionPanel.btn_missions)
                  {
                     layoutManager.state = Constants_LayoutStates.STATE_MISSION;
                     MafiaTutorialController.getInstance().nextStep();
                     break;
                  }
                  return;
               case MafiaTutorialController.TUT_STATE_TO_SHOP:
                  if(param1.target == this.actionPanel.btn_shop)
                  {
                     MafiaTutorialController.getInstance().nextStep();
                     break;
                  }
                  return;
               default:
                  return;
            }
         }
         else
         {
            layoutManager.removeTutorialPanel();
         }
         if(!env.isBeta)
         {
            if(param1.target == this.actionPanel.btn_addGold || param1.target == this.actionPanel.mc_doppler || param1.target == this.actionPanel.goldLayer || param1.target == this.actionPanel.btn_bonus)
            {
               controller.onClickMoreMoney(null);
            }
         }
         if(param1.target is MovieClip && !(param1.target as MovieClip).enabled)
         {
            return;
         }
         if(param1.target is NewBasicInterfaceButton && (param1.target as NewBasicInterfaceButton).isFixed)
         {
            return;
         }
         layoutManager.hidePanel(MafiaReviewTutorialPanel.NAME);
         super.onClick(param1);
         switch(param1.target)
         {
            case this.actionPanel.btn_avatar:
            case this.actionPanel.avatarPicField:
               if(layoutManager.actState == Constants_LayoutStates.STATE_PROFILE)
               {
                  return;
               }
               PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,false);
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case this.actionPanel.btn_questlog:
               layoutManager.showPanel(MafiaQuestlogPanel.NAME);
               break;
            case this.actionPanel.btn_shop:
               layoutManager.state = Constants_LayoutStates.STATE_SHOP;
               break;
            case this.actionPanel.btn_duel:
               layoutManager.state = Constants_LayoutStates.STATE_DUEL;
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[1]);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
               break;
            case this.actionPanel.btn_missions:
               layoutManager.state = Constants_LayoutStates.STATE_MISSION;
               break;
            case this.actionPanel.btn_ranking:
            case this.actionPanel.positionLayer:
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,"1",MafiaPlayerRankingData.TOP_RANKING_LENGTH);
               SearchRankingCommand.sendCommand(RankingListType.PlayerDynamic,MafiaModel.userData.profileData.name,MafiaPlayerRankingData.RANKING_LIST_LENGTH);
               break;
            case this.actionPanel.btn_troup:
               if(MafiaModel.userData.profileData.clanID == 0 || MafiaModel.userData.profileData.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_CLANCREATION;
               }
               else
               {
                  this.actionPanel.btn_troup.chatani.visible = false;
                  layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  ShowClanCommand.sendCommand();
                  FamilyGetBulletinBoardCommand.sendCommand();
               }
               break;
            case this.actionPanel.btn_dungeon:
               layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
               ShowGangWarsCommand.sendCommand();
               break;
            case this.actionPanel.btn_messages:
               MafiaModel.userData.messageData.readMessagesData.receiver = "";
               layoutManager.state = Constants_LayoutStates.STATE_MAILING;
               break;
            case this.actionPanel.btn_event:
               if(layoutManager.currentState == Constants_LayoutStates.STATE_HOME)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               }
               MafiaModel.specialEvent.openEventDialog();
               break;
            case this.actionPanel.mc_options.btn_sound:
               controller.soundController.toggleMuteEffects();
               controller.saveSoundSettings();
               this.setSoundButtons();
               break;
            case this.actionPanel.mc_options.btn_music:
               controller.soundController.toggleMuteMusic();
               controller.saveSoundSettings();
               this.setSoundButtons();
               break;
            case this.actionPanel.btn_options:
               this.showSubLayer(this.actionPanel.mc_options);
               break;
            case this.actionPanel.mc_options.btn_changePass:
               layoutManager.showDialog(MafiaChangePasswordDialog.NAME,new MafiaChangePasswordDialogProperties(MafiaModel.languageData.getTextById("generic_change_password_title"),MafiaModel.languageData.getTextById("generic_change_password_copy_newpass"),MafiaModel.languageData.getTextById("generic_change_password_copy_oldpass"),this.onChangePassword,null,MafiaModel.languageData.getTextById("generic_btn_okay"),MafiaModel.languageData.getTextById("generic_btn_cancel")));
               break;
            case this.actionPanel.btn_help:
               this.showSubLayer(this.actionPanel.mc_help);
               break;
            case this.actionPanel.mc_help.btn_support:
               this.mailSupport();
               break;
            case this.actionPanel.btn_forum:
               MafiaGroupForumsHelper.goNews();
               break;
            case this.actionPanel.mc_help.btn_tutorial:
               this.showTutorial();
               break;
            case this.actionPanel.btn_logout:
               layoutManager.removeTutorialPanel();
               CommandController.instance.executeCommand(BasicController.COMMAND_LOGOUT);
               break;
            case this.actionPanel.btn_email:
               layoutManager.showDialog(MafiaMailVerificationDialog.NAME,new MafiaAddFriendDialogProperties());
               break;
            case this.actionPanel.btn_addfriends:
               if(env.hasNetworkBuddies)
               {
                  MafiaModel.socialData.inviteFriends();
               }
               else if(!env.isBeta)
               {
                  layoutManager.showDialog(MafiaAddFriendDialog.NAME,new MafiaAddFriendDialogProperties());
               }
               break;
            case this.actionPanel.sheepBox.btn_sheep:
               this.onSendSheep();
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER && param1.target == this.actionPanel.sheepBox.txt_sheep)
         {
            this.onSendSheep();
         }
      }
      
      private function onSendSheep() : void
      {
         var _loc2_:GTween = null;
         var _loc1_:String = this.actionPanel.sheepBox.txt_sheep.text;
         if(_loc1_.length > 0)
         {
            CommandController.instance.executeCommand(Constants_CliendCommands.COMMAND_EXECUTE_CHEATS,[_loc1_]);
         }
         else
         {
            _loc2_ = new GTween(this.actionPanel.sheepBox,1,{"alpha":0});
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:GTween = null;
         if(isLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.actionPanel.goldLayer:
            case this.actionPanel.positionLayer:
            case this.actionPanel.avatarPicField:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               break;
            case this.actionPanel.btn_addcash:
               this.actionPanel.btn_addcash.sheep.gotoAndStop(2);
               super.onMouseOver(param1);
               break;
            case this.actionPanel.sheepBox:
               if(this.actionPanel.sheepBox.alpha == 0)
               {
                  _loc2_ = new GTween(this.actionPanel.sheepBox,1,{"alpha":1});
               }
         }
         onCursorOver(param1);
         super.onMouseOver(param1);
         if(param1.target == this.actionPanel.mc_help || this.actionPanel.mc_options == param1.target || param1.target.parent && (param1.target.parent == this.actionPanel.mc_help || param1.target.parent == this.actionPanel.mc_options))
         {
            this.allowHidePanel = false;
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(isLocked)
         {
            return;
         }
         super.onMouseOut(param1);
         switch(param1.target)
         {
            case this.actionPanel.goldLayer:
            case this.actionPanel.positionLayer:
            case this.actionPanel.avatarPicField:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               break;
            case this.actionPanel.btn_addcash:
               this.actionPanel.btn_addcash.sheep.gotoAndStop(1);
         }
      }
      
      private function onVerificationComplete(param1:MafiaUserEvent) : void
      {
         if(!(param1.params && param1.params.length > 0))
         {
            this.actionPanel.btn_email.enableButton = false;
         }
      }
      
      private function mailSupport() : void
      {
         SupportUtil.navigateToSupport(env.gameId,BasicModel.instanceProxy.selectedInstanceVO.instanceId,env.versionText,env.networkId,env.gameTitle,MafiaModel.userData.profileData.name,BasicModel.userData.playerID,BasicModel.userData.userID,GGSCountryController.instance.currentCountry.ggsLanguageCode,env.referrer);
      }
      
      private function showTutorial() : void
      {
         layoutManager.showPanel(MafiaHelpPanel.NAME);
      }
      
      private function onChangePassword(param1:Array) : void
      {
         if(param1 && param1.length == 3)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_CHANGE_PASSWORD,param1);
         }
      }
      
      private function onRollOutPanel(param1:MouseEvent) : void
      {
         this.allowHidePanel = true;
         var _loc2_:Timer = new Timer(1500,1);
         _loc2_.addEventListener(TimerEvent.TIMER,this.onhideTimer);
         _loc2_.start();
      }
      
      private function onhideTimer(param1:TimerEvent) : void
      {
         param1.target.removeEventListener(TimerEvent.TIMER,this.onhideTimer);
         if(this.allowHidePanel)
         {
            this.hideAllSublayer();
         }
      }
      
      private function hideAllSublayer() : void
      {
         this.hideSubLayer(this.actionPanel.mc_help);
         this.hideSubLayer(this.actionPanel.mc_options);
      }
      
      private function showSubLayer(param1:MovieClip) : void
      {
         this.hideAllSublayer();
         param1.visible = true;
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOutPanel);
      }
      
      private function hideSubLayer(param1:MovieClip) : void
      {
         param1.visible = false;
         param1.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOutPanel);
      }
      
      private function updateQuestlogButton() : void
      {
         var _loc1_:String = null;
         if(MafiaTutorialController.getInstance().isActive)
         {
            this.actionPanel.btn_questlog.visible = false;
            this.actionPanel.questlog_indicator.visible = false;
         }
         else
         {
            if(MafiaDialogHandler.getInstance().blockDialogs)
            {
               return;
            }
            this.actionPanel.btn_questlog.visible = true;
            this.actionPanel.btn_questlog.enableButton = MafiaModel.userData.questData.hasActiveQuests;
            this.actionPanel.btn_questlog.txt_count.text = !!MafiaModel.userData.questData.hasActiveQuests?MafiaModel.userData.questData.numActiveQuests:"";
            this.actionPanel.questlog_indicator.visible = MafiaModel.userData.questData.newQuestsAvailable;
            _loc1_ = "";
            switch(MafiaModel.userData.questData.numActiveQuests)
            {
               case 0:
                  _loc1_ = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_quests_1");
                  break;
               case 1:
                  _loc1_ = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_quests_2");
                  break;
               default:
                  _loc1_ = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_quests_3",[MafiaModel.userData.questData.numActiveQuests]);
            }
            this.actionPanel.btn_questlog.toolTipText = _loc1_;
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
         }
      }
      
      protected function get actionPanel() : ActionPanel
      {
         return disp as ActionPanel;
      }
   }
}
