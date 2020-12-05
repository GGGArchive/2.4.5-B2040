package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponent;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponentEvent;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.controller.commands.account.CreateAvatarCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.panel.MafiaPanelEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.helper.MafiaTextFieldWatcher;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaAvatarNameSelectionPanel;
   import com.goodgamestudios.mafia.view.MafiaComboboxComponent;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaAvatarScreen;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   import com.goodgamestudios.misc.SystemAnalyzer;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class MafiaRegisterPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaRegisterDialog";
       
      
      private var SCALE:Number = 0.5;
      
      private var choiceLanguageComponent:CountrySelectComponent;
      
      private var worldSelection:MafiaComboboxComponent;
      
      private var isWaitingForServerMessage:Boolean;
      
      private var avatarSend:Boolean;
      
      private var _changeWorld:Boolean;
      
      private var _init:Boolean;
      
      private var _defaultMailString:String;
      
      private var _defaultPasswordString:String;
      
      private var _defaultNameString:String;
      
      private var errorMessage:String;
      
      public function MafiaRegisterPanel(param1:Sprite)
      {
         this.errorMessage = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_10");
         super(param1);
         index = PANEL_INDEX_REGISTER;
         this.choiceLanguageComponent = new CountrySelectComponent(this.regiScreen.mc_languageChoice,new CountrySelectionTooltip(),GGSCountryController.instance.availableCountries,2,BasicModel.languageData.getTextById);
         this.regiScreen.mc_languageChoice.addEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
         this.regiScreen.mc_languageChoice.addEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         this.worldSelection = new MafiaComboboxComponent(this.regiScreen.worldSelection);
         this.regiScreen.worldSelection.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeWorld);
         this.regiScreen.txt_password.tabIndex = 5;
         this.regiScreen.txt_charaktername.tabIndex = 3;
         this.regiScreen.txt_mail.tabIndex = 4;
         this.regiScreen.txt_charaktername.maxChars = Constants_Basic.MAX_NAMELENGTH;
         this.regiScreen.txt_password.maxChars = Constants_Basic.MAX_NAMELENGTH;
         this.regiScreen.sticker.mouseEnabled = this.regiScreen.sticker.mouseChildren = false;
         this.retrieveInvitationData();
         this.fillWorldSelection();
         this.updateTexts();
      }
      
      private function retrieveInvitationData() : void
      {
         var referrer:String = "";
         try
         {
            referrer = ExternalInterface.call("function getLocation() {return document.referrer;}");
            if(referrer == null || referrer.indexOf("http") == -1)
            {
               referrer = ExternalInterface.call("document.location.toString");
            }
         }
         catch(e:Error)
         {
            trace("Script access denied! retrieveInvitationData");
         }
         trace(referrer);
         var firstIndex:int = String(referrer).indexOf("iti=");
         if(firstIndex != -1)
         {
            MafiaModel.userData.addFriendData.invitationToInstance = parseInt(String(referrer).substr(firstIndex + 4));
            var secondIndex:int = firstIndex + 4 + String(MafiaModel.userData.addFriendData.invitationToInstance).length + 1;
            if(secondIndex != -1)
            {
               MafiaModel.userData.addFriendData.invitationHashCode = String(referrer).substr(secondIndex + 4);
            }
            else
            {
               MafiaModel.userData.addFriendData.invitationHashCode = "";
            }
            trace(MafiaModel.userData.addFriendData.invitationToInstance);
            trace(MafiaModel.userData.addFriendData.invitationHashCode);
            return;
         }
         MafiaModel.userData.addFriendData.invitationToInstance = 0;
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT < disp.stage.stageWidth / Constants_Basic.GAME_WIDTH)
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            disp.x = (disp.stage.stageWidth - Constants_Basic.GAME_WIDTH * disp.scaleX) * 0.5;
         }
      }
      
      override protected function applyProperties() : void
      {
         MovieClipHelper.clearMovieClip(this.regiScreen.mc_avatar_holder);
         this.regiScreen.mc_avatar_holder.addChild(AvatarHelper.createAvatar(MafiaDataHolder.instance.savedAvatarVO,this.SCALE));
         switch(MafiaDataHolder.instance.savedAvatarVO.characterClass)
         {
            case CharacterClass.Bully:
               this.regiScreen.mc_dmg.gotoAndStop(1);
               this.regiScreen.mc_hp.gotoAndStop(3);
               break;
            case CharacterClass.Rogue:
               this.regiScreen.mc_dmg.gotoAndStop(2);
               this.regiScreen.mc_hp.gotoAndStop(2);
               break;
            case CharacterClass.Tactician:
               this.regiScreen.mc_dmg.gotoAndStop(3);
               this.regiScreen.mc_hp.gotoAndStop(1);
         }
         this.fillWorldSelection();
      }
      
      override public function show() : void
      {
         this._changeWorld = false;
         this.choiceLanguageComponent.setDefaultCountry(GGSCountryController.instance.currentCountry);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
         disp.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         disp.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         controller.addEventListener(MafiaUserEvent.CREATED_AVATAR_VALID,this.onCreateAvatarValid);
         controller.addEventListener(MafiaUserEvent.CHANGE_CONNECTION,this.onConnection);
         controller.addEventListener(MafiaUserEvent.CHANGE_NO_CONNECTION,this.onNoConnection);
         controller.addEventListener(MafiaUserEvent.CHANGE_NAME_OFFER,this.onOfferName);
         controller.addEventListener(MafiaUserEvent.CHANGE_WRONG_NAME,this.onWrongName);
         controller.addEventListener(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,this.onWrongRegisterParams);
         controller.addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.updateFonts);
         MafiaModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.reloadLanguage);
         this.regiScreen.errorMessageLayer.visible = false;
         this.regiScreen.txt_error.text = "";
         this.regiScreen.btn_agbs.txt_label.text = MafiaModel.languageData.getTextById("generic_register_btn_agb");
         TextFieldHelper.changeSingleLineTextVerticalAlignInMultiLineTextfield(this.regiScreen.btn_agbs.txt_label);
         this.regiScreen.btn_play.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
         this.regiScreen.btn_registered_already.txt_label.text = MafiaModel.languageData.getTextById("MafiaCustomizeAvatarScreen_text_alreadyregistered");
         this.regiScreen.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_createavatar");
         this.regiScreen.btn_customize.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaRegisterScreen_btn_back");
         this.regiScreen.eMailValidationMc.visible = false;
         this.regiScreen.eMailValidationMc.mouseChildren = false;
         this.regiScreen.nameValidationMc.visible = false;
         this.regiScreen.nameValidationMc.mouseChildren = false;
         MafiaTextFieldWatcher.watchTextField(this.regiScreen.txt_mail,MafiaTextFieldWatcher.RULE_EMAIL,this.onWatchMailTextfield,7);
         MafiaTextFieldWatcher.watchTextField(this.regiScreen.txt_charaktername,MafiaTextFieldWatcher.RULE_USERNAME,this.onUserNameInput,BasicModel.basicLocalization.getUsernameMinLength);
         this.updateTexts();
         super.show();
      }
      
      protected function onOpenCountryList(param1:CountrySelectComponentEvent) : void
      {
      }
      
      protected function onCountrySelected(param1:CountrySelectComponentEvent) : void
      {
         var _loc2_:AbstractGGSCountry = param1.selectedCountry as AbstractGGSCountry;
         CommandController.instance.executeCommand(BasicController.COMMAND_CHANGE_COUNTRY,_loc2_);
         this.onUserNameInput(0);
         this.onWatchMailTextfield(0);
      }
      
      private function onUserNameInput(param1:int) : void
      {
         updateAllTextFields(this.regiScreen.nameValidationMc);
         switch(param1)
         {
            case MafiaTextFieldWatcher.ERRORCODE_ALL_OK:
               this.regiScreen.nameValidationMc.visible = false;
               this.errorMessage = "";
               break;
            case MafiaTextFieldWatcher.ERRORCODE_INVALID_CHARS:
               this.regiScreen.nameValidationMc.toolTipText = MafiaModel.languageData.getTextById("generic_register_namenotvalid");
               this.regiScreen.nameValidationMc.visible = true;
               this.regiScreen.nameValidationMc.gotoAndStop(1);
               this.errorMessage = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_10");
               break;
            case MafiaTextFieldWatcher.ERRORCODE_TOO_SHORT:
               this.regiScreen.nameValidationMc.toolTipText = MafiaModel.languageData.getTextById("generic_register_nametooshort");
               this.regiScreen.nameValidationMc.visible = true;
               this.regiScreen.nameValidationMc.gotoAndStop(1);
               this.errorMessage = MafiaModel.languageData.getTextById("generic_register_nametooshort");
         }
      }
      
      private function onWatchMailTextfield(param1:int) : void
      {
         switch(param1)
         {
            case MafiaTextFieldWatcher.ERRORCODE_ALL_OK:
               this.regiScreen.eMailValidationMc.visible = false;
               break;
            case MafiaTextFieldWatcher.ERRORCODE_NO_EMAIL:
            case MafiaTextFieldWatcher.ERRORCODE_TOO_SHORT:
               this.regiScreen.eMailValidationMc.toolTipText = MafiaModel.languageData.getTextById("generic_register_emailwrong_copy");
               this.regiScreen.eMailValidationMc.visible = true;
               this.regiScreen.eMailValidationMc.gotoAndStop(1);
               break;
            case MafiaTextFieldWatcher.ERRORCODE_INVALID_CHARS:
               this.regiScreen.eMailValidationMc.toolTipText = MafiaModel.languageData.getTextById("generic_register_email_copy");
               this.regiScreen.eMailValidationMc.visible = true;
               this.regiScreen.eMailValidationMc.gotoAndStop(1);
               break;
            default:
               this.regiScreen.eMailValidationMc.visible = false;
         }
      }
      
      override public function destroy() : void
      {
         this.regiScreen.mc_languageChoice.removeEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
         this.regiScreen.mc_languageChoice.removeEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         this.regiScreen.worldSelection.removeEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeWorld);
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         MafiaTextFieldWatcher.stopWatchingTextField(this.regiScreen.txt_mail);
         MafiaTextFieldWatcher.stopWatchingTextField(this.regiScreen.txt_charaktername);
         MafiaModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.reloadLanguage);
         disp.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         disp.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         controller.removeEventListener(MafiaUserEvent.CREATED_AVATAR_VALID,this.onCreateAvatarValid);
         controller.removeEventListener(MafiaUserEvent.CHANGE_CONNECTION,this.onConnection);
         controller.removeEventListener(MafiaUserEvent.CHANGE_NO_CONNECTION,this.onNoConnection);
         controller.removeEventListener(MafiaUserEvent.CHANGE_NAME_OFFER,this.onOfferName);
         controller.removeEventListener(MafiaUserEvent.CHANGE_WRONG_NAME,this.onWrongName);
         controller.removeEventListener(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,this.onWrongRegisterParams);
         controller.removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.updateFonts);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
      }
      
      private function onMouseOverLanguage(param1:MafiaPanelEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onMouseOutLanguage(param1:MafiaPanelEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function onNoConnection(param1:MafiaUserEvent) : void
      {
         this.regiScreen.btn_play.enableButton = false;
         this.regiScreen.errorMessageLayer.visible = true;
         this.regiScreen.txt_error.text = MafiaModel.languageData.getTextById("MafiaSystemDialog_copy_1");
      }
      
      private function onConnection(param1:MafiaUserEvent) : void
      {
         layoutManager.onEndProgressbar();
         this.regiScreen.btn_play.enableButton = true;
         this.avatarSend = false;
         this.regiScreen.errorMessageLayer.visible = false;
         this.regiScreen.txt_error.text = "";
         this._changeWorld = false;
         this._init = false;
      }
      
      private function onOfferName(param1:MafiaUserEvent) : void
      {
         this.regiScreen.errorMessageLayer.visible = false;
         this.regiScreen.txt_error.text = "";
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.params[0].length)
         {
            _loc2_.push(param1.params[0][_loc3_]);
            _loc3_++;
         }
         _loc2_.pop();
         layoutManager.showPanel(MafiaAvatarNameSelectionPanel.NAME);
         (layoutManager.getPanel(MafiaAvatarNameSelectionPanel.NAME) as MafiaAvatarNameSelectionPanel).setDisplayTarget(this.regiScreen.txt_charaktername);
         (layoutManager.getPanel(MafiaAvatarNameSelectionPanel.NAME) as MafiaAvatarNameSelectionPanel).onNameSelectedFunction = this.onSelectedName;
         (layoutManager.getPanel(MafiaAvatarNameSelectionPanel.NAME) as MafiaAvatarNameSelectionPanel).showNames(_loc2_,param1.params[1]);
      }
      
      private function onSelectedName(param1:String) : void
      {
         this.regiScreen.txt_charaktername.text = param1;
      }
      
      private function onWrongName(param1:MafiaUserEvent) : void
      {
         TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,this.errorMessage,3);
         this.regiScreen.errorMessageLayer.visible = true;
      }
      
      private function onWrongRegisterParams(param1:MafiaUserEvent) : void
      {
         TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,param1.params[0].toString(),3);
         this.regiScreen.errorMessageLayer.visible = true;
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOver(param1);
         switch(param1.target)
         {
            case this.regiScreen.btn_agbs:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               this.regiScreen.btn_agbs.txt_label.textColor = this.regiScreen.txt_title.textColor;
               break;
            case this.regiScreen.btn_registered_already:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               this.regiScreen.btn_registered_already.txt_label.textColor = this.regiScreen.txt_title.textColor;
               break;
            default:
               if(param1.target is MovieClip)
               {
                  _loc2_ = param1.target as MovieClip;
                  if(_loc2_.name.substr(0,7) == "country" || _loc2_ == this.regiScreen.mc_languageChoice.btn_arrow)
                  {
                     layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
                  }
               }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOut(param1);
         switch(param1.target)
         {
            case this.regiScreen.btn_agbs:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               this.regiScreen.btn_agbs.txt_label.textColor = 5196099;
               break;
            case this.regiScreen.btn_registered_already:
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               this.regiScreen.btn_registered_already.txt_label.textColor = this.regiScreen.txt_title.textColor;
               this.regiScreen.btn_registered_already.txt_label.textColor = 16777215;
               break;
            default:
               if(param1.target is MovieClip)
               {
                  _loc2_ = param1.target as MovieClip;
                  if(_loc2_.name.substr(0,7) == "country" || _loc2_ == this.regiScreen.mc_languageChoice.btn_arrow)
                  {
                     layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
                  }
               }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var spr:Sprite = null;
         var urlRequest:URLRequest = null;
         var event:MouseEvent = param1;
         switch(event.target)
         {
            case this.regiScreen.btn_customize:
               layoutManager.clearAllLayoutContent();
               spr = new Sprite();
               spr.name = "extraSprite";
               layoutManager.panelSprite.addChild(new MafiaAvatarScreen(new MafiaNWAvatarCreation(),layoutManager.customCursor,MafiaDataHolder.instance.savedAvatarVO,this.onCustomOK,this.onRegisteredAlready,spr,controller).disp);
               layoutManager.panelSprite.addChild(spr);
               layoutManager.onEndProgressbar();
               hide();
               break;
            case this.regiScreen.btn_agb:
               if(this.regiScreen.btn_agb.isSelected)
               {
                  this.regiScreen.btn_agb.deselected();
               }
               else
               {
                  this.regiScreen.btn_agb.selected();
               }
               break;
            case this.regiScreen.btn_agbs:
               try
               {
                  urlRequest = new URLRequest(env.urlAGB);
                  navigateToURL(urlRequest,"goodgamestudios");
               }
               catch(e:Error)
               {
               }
               break;
            case this.regiScreen.btn_play:
               if(!(event.target as MovieClip).enabled)
               {
                  return;
               }
               this.onLogin();
               break;
            case this.regiScreen.btn_registered_already:
               this.onRegisteredAlready();
         }
      }
      
      private function onRegisteredAlready() : void
      {
         if(layoutManager.panelSprite.getChildByName("extraSprite") && layoutManager.panelSprite.contains(layoutManager.panelSprite.getChildByName("extraSprite")))
         {
            layoutManager.panelSprite.removeChild(layoutManager.panelSprite.getChildByName("extraSprite"));
         }
         if(!MafiaModel.smartfoxClient.isConnected)
         {
            this.onChangeWorld(null);
         }
         layoutManager.clearAllLayoutContent();
         layoutManager.state = BasicLayoutManager.STATE_LOGIN;
      }
      
      private function onLogin() : void
      {
         trace("isConected " + MafiaModel.smartfoxClient.isConnected);
         if(!MafiaModel.smartfoxClient.isConnected)
         {
            this.onChangeWorld(null);
            return;
         }
         if(this.regiScreen.txt_charaktername.text == this._defaultNameString || this.regiScreen.txt_charaktername.text.length == 0 || !TextValide.isSmartFoxValide(this.regiScreen.txt_charaktername.text) || MafiaTextFieldWatcher.validateString(this.regiScreen.txt_charaktername.text,MafiaTextFieldWatcher.RULE_USERNAME,BasicModel.basicLocalization.getUsernameMinLength) != MafiaTextFieldWatcher.ERRORCODE_ALL_OK)
         {
            this.errorMessage = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_10");
            updateAllTextFields();
            TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,this.errorMessage,3);
            this.regiScreen.errorMessageLayer.visible = true;
            return;
         }
         if(this.regiScreen.txt_mail.text == this._defaultMailString || !TextValide.isEmailString(this.regiScreen.txt_mail.text) || TextValide.trimPassword(this.regiScreen.txt_mail.text).length < 7)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,MafiaModel.languageData.getTextById("generic_register_emailwrong_copy"),3);
            this.regiScreen.errorMessageLayer.visible = true;
            return;
         }
         if(TextValide.trimPassword(this.regiScreen.txt_password.text).length == 0 || TextValide.trimPassword(this.regiScreen.txt_password.text) == this._defaultPasswordString || !TextValide.isSmartFoxValide(TextValide.trimPassword(this.regiScreen.txt_password.text)))
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,MafiaModel.languageData.getTextById("generic_register_password_copy"),3);
            this.regiScreen.errorMessageLayer.visible = true;
            return;
         }
         if(TextValide.trimPassword(this.regiScreen.txt_password.text).length < 4)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,MafiaModel.languageData.getTextById("generic_register_passwordshort_copy"),3);
            this.regiScreen.errorMessageLayer.visible = true;
            return;
         }
         if(!this.regiScreen.btn_agb.isSelected)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,MafiaModel.languageData.getTextById("generic_register_agb_copy"),3);
            this.regiScreen.errorMessageLayer.visible = true;
            return;
         }
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         this.isWaitingForServerMessage = true;
         if(!this.avatarSend)
         {
            CreateAvatarCommand.sendCommand(AvatarHelper.createSFStringFromAvatarVO(MafiaDataHolder.instance.savedAvatarVO),MafiaDataHolder.instance.savedAvatarVO.characterClass,MafiaDataHolder.instance.savedAvatarVO.gender);
         }
         else
         {
            this.sendRegisterData();
         }
      }
      
      private function onCreateAvatarValid(param1:MafiaUserEvent) : void
      {
         this.avatarSend = true;
         this.sendRegisterData();
      }
      
      private function sendRegisterData() : void
      {
         var _loc3_:String = null;
         var _loc1_:String = this.regiScreen.txt_charaktername.text;
         var _loc2_:String = this.regiScreen.txt_mail.text;
         MafiaModel.userData.loginName = _loc1_;
         MafiaModel.userData.loginPwd = _loc3_;
         _loc3_ = TextValide.trimPassword(this.regiScreen.txt_password.text);
         var _loc4_:Array = new Array();
         _loc4_.push(_loc1_);
         _loc4_.push(_loc2_);
         _loc4_.push(_loc3_);
         _loc4_.push(MafiaModel.userData.addFriendData.invitationHashCode);
         _loc4_.push(1);
         CommandController.instance.executeCommand(BasicController.COMMAND_REGISTER_USER,_loc4_);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == BasicSmartfoxConstants.S2C_REGISTER)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onCustomOK() : void
      {
         if(layoutManager.panelSprite.getChildByName("extraSprite") && layoutManager.panelSprite.contains(layoutManager.panelSprite.getChildByName("extraSprite")))
         {
            layoutManager.panelSprite.removeChild(layoutManager.panelSprite.getChildByName("extraSprite"));
         }
         MafiaModel.languageData.loadLanguage();
         layoutManager.state = BasicLayoutManager.STATE_REGISTRATION;
      }
      
      private function reloadLanguage(param1:LanguageDataEvent) : void
      {
         this.regiScreen.errorMessageLayer.visible = false;
         this.regiScreen.txt_error.text = "";
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         super.onFontsLoaded(param1);
         if(isVisible())
         {
            this.updateTexts();
         }
      }
      
      private function updateFonts(param1:LanguageDataEvent) : void
      {
         this.updateTexts();
      }
      
      private function updateTexts() : void
      {
         this._defaultMailString = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_11");
         this._defaultPasswordString = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_12");
         this._defaultNameString = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_13");
         TextFieldHelper.changeTextFromatSizeByTextWidth(10,this.regiScreen.sticker.txt_sticker,MafiaModel.languageData.getTextById("MafiaLoginScreen_text_forfree"),3);
         updateAllTextFields();
         this.regiScreen.txt_charaktername.text = this._defaultNameString;
         this.regiScreen.txt_mail.text = this._defaultMailString;
         if(!this.regiScreen.txt_password.displayAsPassword)
         {
            this.regiScreen.txt_password.text = this._defaultPasswordString;
         }
         this.regiScreen.btn_agbs.txt_label.text = MafiaModel.languageData.getTextById("generic_register_btn_agb");
         TextFieldHelper.changeSingleLineTextVerticalAlignInMultiLineTextfield(this.regiScreen.btn_agbs.txt_label);
         this.regiScreen.btn_play.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
         this.regiScreen.btn_registered_already.txt_label.text = MafiaModel.languageData.getTextById("MafiaCustomizeAvatarScreen_text_alreadyregistered");
         this.regiScreen.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_createavatar");
         this.regiScreen.btn_customize.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaRegisterScreen_btn_back");
         this.fillWorldSelection();
         updateAllTextFields();
         BasicLanguageFontManager.getInstance().changeFontByLanguage(this.regiScreen.btn_play.txt_label);
         BasicLanguageFontManager.getInstance().changeFontByLanguage(this.regiScreen.btn_registered_already.txt_label);
      }
      
      private function fillWorldSelection() : void
      {
         var _loc3_:InstanceVO = null;
         var _loc4_:Object = null;
         this.worldSelection.clearItems();
         var _loc1_:Vector.<InstanceVO> = BasicModel.instanceProxy.getInstancesForActualCountry();
         _loc1_ = _loc1_.reverse();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as InstanceVO;
            if(!env.isBeta)
            {
               _loc4_ = {
                  "label":_loc3_.serverName,
                  "data":_loc3_
               };
               this.worldSelection.addItem(_loc4_);
            }
            _loc2_++;
         }
         if(env.invitefriends && MafiaModel.userData.addFriendData.isValid && env.isFirstVisit)
         {
            this.selectInstance(MafiaModel.userData.addFriendData.invitationToInstance);
            if(MafiaModel.userData.addFriendData.invitationToInstance > 0)
            {
               this.regiScreen.worldSelection.visible = false;
            }
            return;
         }
         if(BasicModel.instanceProxy.selectedInstanceVO)
         {
            this.selectInstance(BasicModel.instanceProxy.selectedInstanceVO.instanceId);
         }
         else
         {
            this.selectInstance(BasicModel.instanceProxy.instanceMap[0].instanceId);
         }
         updateAllTextFields();
      }
      
      private function selectInstance(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.worldSelection.itemData.length)
         {
            if((this.worldSelection.itemData[_loc2_].data as InstanceVO).instanceId == param1)
            {
               this.worldSelection.selectItemIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         this.worldSelection.selectItemIndex(1);
      }
      
      protected function onFocusIn(param1:FocusEvent) : void
      {
         if(!param1.target)
         {
            return;
         }
         switch(param1.target)
         {
            case this.regiScreen.txt_password:
               if(TextValide.trimPassword(this.regiScreen.txt_password.text) == this._defaultPasswordString)
               {
                  this.regiScreen.txt_password.text = "";
               }
               this.regiScreen.txt_password.displayAsPassword = true;
               break;
            case this.regiScreen.txt_mail:
               if(this.regiScreen.txt_mail.text == this._defaultMailString)
               {
                  this.regiScreen.txt_mail.text = "";
                  if(SystemAnalyzer.instance.hasALTGRBug())
                  {
                     TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.regiScreen.txt_error,MafiaModel.languageData.getTextById("generic_alert_win7chromebug"),3);
                     this.regiScreen.errorMessageLayer.visible = true;
                  }
               }
               break;
            case this.regiScreen.txt_charaktername:
               if(this.regiScreen.txt_charaktername.text == this._defaultNameString)
               {
                  this.regiScreen.txt_charaktername.text = "";
               }
               layoutManager.hidePanel(MafiaAvatarNameSelectionPanel.NAME);
               this.regiScreen.errorMessageLayer.visible = false;
               this.regiScreen.txt_error.text = "";
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
            case this.regiScreen.txt_password:
               if(TextValide.trimPassword(this.regiScreen.txt_password.text) == "")
               {
                  this.regiScreen.txt_password.text = this._defaultPasswordString;
                  this.regiScreen.txt_password.displayAsPassword = false;
               }
               break;
            case this.regiScreen.txt_mail:
               if(this.regiScreen.txt_mail.text == "")
               {
                  this.regiScreen.txt_mail.text = this._defaultMailString;
               }
               break;
            case this.regiScreen.txt_charaktername:
               if(this.regiScreen.txt_charaktername.text == "")
               {
                  this.regiScreen.txt_charaktername.text = this._defaultNameString;
               }
         }
      }
      
      protected function onChangeWorld(param1:Event) : void
      {
         this._changeWorld = true;
         var _loc2_:InstanceVO = this.worldSelection.selectedData as InstanceVO;
         if(_loc2_.instanceId != BasicModel.instanceProxy.selectedInstanceVO.instanceId)
         {
            CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,_loc2_);
         }
      }
      
      private function get regiScreen() : MafiaRegistration
      {
         return disp as MafiaRegistration;
      }
   }
}
