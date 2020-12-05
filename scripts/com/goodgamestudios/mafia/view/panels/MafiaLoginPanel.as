package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.input.KeyCode;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponent;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponentEvent;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.event.panel.MafiaPanelEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaComboboxComponent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaLostPasswordDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaLostPasswordDialogProperties;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaAvatarScreen;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Bounce;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class MafiaLoginPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaLogin";
       
      
      private var choiceLanguageComponent:CountrySelectComponent;
      
      private var lastLanguage:String;
      
      private var isWaitingForServerMessage:Boolean;
      
      private var worldSelection:MafiaComboboxComponent;
      
      private var _defaultNameString:String = "";
      
      private var _defaultPasswordString:String = "";
      
      private const BETA_INSTANCE_ID:int = 99;
      
      public function MafiaLoginPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_LOGIN;
         this.choiceLanguageComponent = new CountrySelectComponent(this.mafiaLogin.mc_language,new CountrySelectionTooltip(),GGSCountryController.instance.availableCountries,2,BasicModel.languageData.getTextById);
         this.choiceLanguageComponent.glowFilter = new GlowFilter(6709596,1,4,4,100);
         this.worldSelection = new MafiaComboboxComponent(this.mafiaLogin.loginLayer.worldSelection);
         this.worldSelection.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeWorld);
      }
      
      override protected function init() : void
      {
         super.init();
         MafiaModel.localData.readData();
         this.lastLanguage = MafiaModel.localData.readLoginDataLanguage();
         this.fillWorldSelection();
         this.mafiaLogin.btn_play.minWidth = 200;
         this.mafiaLogin.loginLayer.loginName.inputField.tabIndex = 1;
         this.mafiaLogin.loginLayer.loginPassword.inputField.tabIndex = 2;
         this.mafiaLogin.loginLayer.loginPassword.inputField.maxChars = Constants_Basic.MAX_NAMELENGTH;
         if(MafiaModel.localData.readLoginDataSave())
         {
            this.mafiaLogin.loginLayer.btn_checkData.selected();
         }
         else
         {
            this.mafiaLogin.loginLayer.btn_checkData.deselected();
         }
         this.choiceLanguageComponent.setDefaultCountry(GGSCountryController.instance.currentCountry);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
         GGSCountryController.instance.newCountrySelected.add(this.onCountryChanged);
         controller.addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.updateFonts);
         if(!this.mafiaLogin.mc_language.hasEventListener(MafiaPanelEvent.MOUSE_OVER))
         {
            this.mafiaLogin.mc_language.addEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
            this.mafiaLogin.mc_language.addEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         }
         this.mafiaLogin.loginLayer.loginName.inputField.addEventListener(KeyboardEvent.KEY_DOWN,this.onTextfieldKeyDown);
         this.mafiaLogin.loginLayer.loginPassword.inputField.addEventListener(KeyboardEvent.KEY_DOWN,this.onTextfieldKeyDown);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOver(param1);
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.name.substr(0,7) == "country" || _loc2_ == this.mafiaLogin.mc_language.btn_arrow)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         super.onMouseOut(param1);
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.name.substr(0,7) == "country" || _loc2_ == this.mafiaLogin.mc_language.btn_arrow)
            {
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            }
         }
      }
      
      private function onTextfieldKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == KeyCode.ENTER)
         {
            this.onLogin();
         }
      }
      
      override public function show() : void
      {
         var _loc1_:GTween = null;
         super.show();
         layoutManager.onEndProgressbar();
         this.mafiaLogin.ship.stop();
         this.mafiaLogin.plain.stop();
         this.update();
         this.mafiaLogin.logo.logoShine.play();
         this.mafiaLogin.logo.logoSpark.play();
         this.mafiaLogin.logo.scaleX = 2.5;
         this.mafiaLogin.logo.scaleY = 2.5;
         this.mafiaLogin.logo.alpha = 0.1;
         _loc1_ = new GTween(this.mafiaLogin.logo,0.8,{
            "scaleY":0.65,
            "scaleX":0.65,
            "alpha":1
         });
         _loc1_.ease = Bounce.easeOut;
         _loc1_.delay = 0.3;
         this.mafiaLogin.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.mafiaLogin.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         BasicController.getInstance().addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.clearLayoutManager);
         controller.addEventListener(MafiaUserEvent.CHANGE_CONNECTION,this.onConnection);
         controller.addEventListener(MafiaUserEvent.CHANGE_NO_CONNECTION,this.onNoConnection);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.mafiaLogin.ship.stop();
         this.mafiaLogin.plain.stop();
         this.mafiaLogin.logo.logoShine.stop();
         this.mafiaLogin.logo.logoSpark.stop();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.mafiaLogin.mc_language.removeEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
         this.mafiaLogin.mc_language.removeEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
         GGSCountryController.instance.newCountrySelected.remove(this.onCountryChanged);
         this.worldSelection.disp.removeEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeWorld);
         this.mafiaLogin.loginLayer.loginName.inputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onTextfieldKeyDown);
         this.mafiaLogin.loginLayer.loginPassword.inputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onTextfieldKeyDown);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         this.mafiaLogin.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
         this.mafiaLogin.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
         BasicController.getInstance().removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.clearLayoutManager);
         controller.removeEventListener(MafiaUserEvent.CHANGE_CONNECTION,this.onConnection);
         controller.removeEventListener(MafiaUserEvent.CHANGE_NO_CONNECTION,this.onNoConnection);
         controller.removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.updateFonts);
      }
      
      private function onMouseOverLanguage(param1:MafiaPanelEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onMouseOutLanguage(param1:MafiaPanelEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      protected function onOpenCountryList(param1:CountrySelectComponentEvent) : void
      {
         if(this.worldSelection.isOpen)
         {
            this.worldSelection.hideItems();
         }
      }
      
      protected function onCountryChanged(param1:AbstractGGSCountry) : void
      {
         if(this.choiceLanguageComponent)
         {
            this.choiceLanguageComponent.setDefaultCountry(param1);
         }
      }
      
      protected function onCountrySelected(param1:CountrySelectComponentEvent) : void
      {
         var _loc2_:AbstractGGSCountry = param1.selectedCountry as AbstractGGSCountry;
         CommandController.instance.executeCommand(BasicController.COMMAND_CHANGE_COUNTRY,_loc2_);
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
            _loc4_ = {
               "label":_loc3_.serverName,
               "data":_loc3_
            };
            this.worldSelection.addItem(_loc4_);
            _loc2_++;
         }
         this.selectInstance(BasicModel.instanceProxy.selectedInstanceVO.instanceId,BasicModel.instanceProxy.selectedInstanceVO.zone);
         updateAllTextFields();
      }
      
      private function selectInstance(param1:int, param2:String) : void
      {
         var _loc4_:InstanceVO = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.worldSelection.itemData.length)
         {
            _loc4_ = this.worldSelection.itemData[_loc3_].data as InstanceVO;
            if(_loc4_.instanceId == param1 && _loc4_.zone == param2)
            {
               this.worldSelection.selectItemIndex(_loc3_);
               return;
            }
            _loc3_++;
         }
         this.worldSelection.selectItemIndex(1);
      }
      
      private function onChangeWorld(param1:Event) : void
      {
         var _loc2_:InstanceVO = this.worldSelection.selectedData as InstanceVO;
         if(_loc2_.instanceId != BasicModel.instanceProxy.selectedInstanceVO.instanceId)
         {
            CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,_loc2_);
         }
      }
      
      private function onNoConnection(param1:MafiaUserEvent) : void
      {
         this.mafiaLogin.btn_play.enableButton = false;
         this.mafiaLogin.loginLayer.btn_login.enableButton = false;
      }
      
      private function onConnection(param1:MafiaUserEvent) : void
      {
         layoutManager.onEndProgressbar();
         this.mafiaLogin.btn_play.enableButton = true;
         this.mafiaLogin.loginLayer.btn_login.enableButton = true;
         this.updateLogin();
         updateAllTextFields();
         this.updateAllButtons();
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         super.onFontsLoaded(param1);
         if(isVisible())
         {
            this.update();
         }
      }
      
      private function updateFonts(param1:LanguageDataEvent) : void
      {
         this.update();
      }
      
      override protected function update() : void
      {
         this.updateLogin();
         this.fillWorldSelection();
         updateAllTextFields();
         this.updateAllButtons();
      }
      
      private function updateLogin() : void
      {
         this._defaultNameString = MafiaModel.languageData.getTextById("generic_login_loginname");
         this._defaultPasswordString = MafiaModel.languageData.getTextById("generic_login_password");
         if(MafiaModel.localData.readLoginDataUsername() != "" && MafiaModel.localData.readLoginDataUsername() != null)
         {
            this.mafiaLogin.loginLayer.loginPassword.inputField.displayAsPassword = true;
            this.mafiaLogin.loginLayer.loginName.inputField.text = MafiaModel.localData.readLoginDataUsername();
            this.mafiaLogin.loginLayer.loginPassword.inputField.text = TextValide.trimPassword(MafiaModel.localData.readLoginDataPass());
         }
         else
         {
            this.mafiaLogin.loginLayer.loginPassword.inputField.displayAsPassword = false;
            this.mafiaLogin.loginLayer.loginPassword.inputField.text = this._defaultPasswordString;
            this.mafiaLogin.loginLayer.loginName.inputField.text = this._defaultNameString;
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(10,this.mafiaLogin.sticker.txt_sticker,MafiaModel.languageData.getTextById("MafiaLoginScreen_text_forfree"),3);
         this.mafiaLogin.loginLayer.btn_login.label = MafiaModel.languageData.getTextById("generic_login_login");
         this.mafiaLogin.btn_play.label = MafiaModel.languageData.getTextById("MafiaLoginScreen_btn_newplayer");
         this.mafiaLogin.loginLayer.btn_lostpass.label = MafiaModel.languageData.getTextById("generic_login_lostpassword");
         this.mafiaLogin.loginLayer.txt_save.text = MafiaModel.languageData.getTextById("generic_login_rememberpassword");
         unLockPanel();
         this.isWaitingForServerMessage = false;
      }
      
      private function updateAllButtons() : void
      {
         this.mafiaLogin.loginLayer.btn_login.update();
         this.mafiaLogin.btn_play.update();
         this.mafiaLogin.loginLayer.btn_lostpass.update();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.mafiaLogin.loginLayer.btn_login:
               if(!this.mafiaLogin.loginLayer.btn_login.enabled)
               {
                  return;
               }
               this.onLogin();
               break;
            case this.mafiaLogin.loginLayer.btn_checkData:
               if(this.mafiaLogin.loginLayer.btn_checkData.isSelected)
               {
                  this.mafiaLogin.loginLayer.btn_checkData.deselected();
                  MafiaModel.localData.saveLoginData("","",false);
               }
               else
               {
                  this.mafiaLogin.loginLayer.btn_checkData.selected();
               }
               break;
            case this.mafiaLogin.btn_play:
               if(!this.mafiaLogin.btn_play.enabled)
               {
                  return;
               }
               this.onCreateAvatar();
               break;
            case this.mafiaLogin.loginLayer.btn_lostpass:
               layoutManager.showDialog(MafiaLostPasswordDialog.NAME,new MafiaLostPasswordDialogProperties(MafiaModel.languageData.getTextById("generic_login_lostpassword_title"),MafiaModel.languageData.getTextById("generic_login_lostpassword_copy"),this.onSendLostName,null,MafiaModel.languageData.getTextById("generic_btn_okay"),MafiaModel.languageData.getTextById("generic_btn_goback")));
         }
      }
      
      private function onCreateAvatar() : void
      {
         this.hide();
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "extraSprite";
         layoutManager.panelSprite.addChild(new MafiaAvatarScreen(new MafiaNWAvatarCreation(),layoutManager.customCursor,null,this.onCustomOK,this.onRegisteredAlready,_loc1_,controller).disp);
         layoutManager.panelSprite.addChild(_loc1_);
      }
      
      private function onRegisteredAlready() : void
      {
         if(layoutManager.panelSprite.getChildByName("extraSprite") && layoutManager.panelSprite.contains(layoutManager.panelSprite.getChildByName("extraSprite")))
         {
            layoutManager.panelSprite.removeChild(layoutManager.panelSprite.getChildByName("extraSprite"));
         }
         layoutManager.showPanel(NAME);
      }
      
      private function onCustomOK() : void
      {
         layoutManager.state = BasicLayoutManager.STATE_REGISTRATION;
         if(layoutManager.panelSprite.getChildByName("extraSprite") && layoutManager.panelSprite.contains(layoutManager.panelSprite.getChildByName("extraSprite")))
         {
            layoutManager.panelSprite.removeChild(layoutManager.panelSprite.getChildByName("extraSprite"));
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
            case this.mafiaLogin.loginLayer.loginName.inputField:
               if(this.mafiaLogin.loginLayer.loginName.inputField.text == this._defaultNameString)
               {
                  this.mafiaLogin.loginLayer.loginName.inputField.text = "";
               }
               break;
            case this.mafiaLogin.loginLayer.loginPassword.inputField:
               if(TextValide.trimPassword(this.mafiaLogin.loginLayer.loginPassword.inputField.text) == this._defaultPasswordString)
               {
                  this.mafiaLogin.loginLayer.loginPassword.inputField.text = "";
               }
               this.mafiaLogin.loginLayer.loginPassword.inputField.displayAsPassword = true;
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
            case this.mafiaLogin.loginLayer.loginName.inputField:
               if(this.mafiaLogin.loginLayer.loginName.inputField.text == "")
               {
                  this.mafiaLogin.loginLayer.loginName.inputField.text = this._defaultNameString;
               }
               break;
            case this.mafiaLogin.loginLayer.loginPassword.inputField:
               if(TextValide.trimPassword(this.mafiaLogin.loginLayer.loginPassword.inputField.text) == "")
               {
                  this.mafiaLogin.loginLayer.loginPassword.inputField.text = this._defaultPasswordString;
                  this.mafiaLogin.loginLayer.loginPassword.inputField.displayAsPassword = false;
               }
         }
      }
      
      private function onLogin() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         if(this.mafiaLogin.loginLayer.loginName.inputField.text == "")
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("generic_login_wronglogin"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return;
         }
         if(this.mafiaLogin.loginLayer.loginName.inputField.text == this._defaultNameString)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("generic_login_wronglogin"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return;
         }
         if(TextValide.trimPassword(this.mafiaLogin.loginLayer.loginPassword.inputField.text) == "")
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("generic_change_password_faild_specialcharacters"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return;
         }
         if(TextValide.trimPassword(this.mafiaLogin.loginLayer.loginPassword.inputField.text) == this._defaultPasswordString)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_bug"),MafiaModel.languageData.getTextById("generic_change_password_faild_specialcharacters"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return;
         }
         if(!this.mafiaLogin.loginLayer.loginPassword.inputField.displayAsPassword)
         {
            return;
         }
         MafiaModel.userData.loginName = this.mafiaLogin.loginLayer.loginName.inputField.text;
         MafiaModel.userData.loginPwd = TextValide.trimPassword(this.mafiaLogin.loginLayer.loginPassword.inputField.text);
         MafiaModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
         this.isWaitingForServerMessage = true;
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == BasicSmartfoxConstants.S2C_LOGIN)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      private function onSendLostName(param1:Array) : void
      {
         if(param1 && param1.length > 0)
         {
            MafiaModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_LOST_PASSWORD,[param1[0],param1[1],param1[2]]);
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
            disp.y = disp.stage.stageHeight;
            disp.x = disp.stage.stageWidth * 0.5;
         }
      }
      
      private function clearLayoutManager(param1:Event) : void
      {
         layoutManager.clearAllLayoutContent();
         layoutManager.state = BasicLayoutManager.STATE_LOGIN;
      }
      
      private function get mafiaLogin() : MafiaLogin
      {
         return disp as MafiaLogin;
      }
      
      public function get saveSelected() : Boolean
      {
         return this.mafiaLogin.loginLayer.btn_checkData.isSelected;
      }
   }
}
