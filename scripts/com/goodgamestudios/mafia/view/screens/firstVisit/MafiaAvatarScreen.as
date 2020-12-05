package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.BasicFirstVisitEvent;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.firstVisit.ExtraScreenMovieClip;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponent;
   import com.goodgamestudios.language.countryPicker.CountrySelectComponentEvent;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.event.panel.MafiaPanelEvent;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import com.goodgamestudios.tracking.TrackingCache;
   import com.goodgamestudios.utils.BrowserUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MafiaAvatarScreen extends ExtraScreenMovieClip
   {
       
      
      protected var choiceLanguageComponent:CountrySelectComponent;
      
      protected var currentColorTooltip:FirstVisitColorTooltipMovieclip;
      
      protected var tooltipManager:MafiaFirstVisitToolTipManager;
      
      protected var _onOKFunction:Function;
      
      protected var _onRegiAlrFunction:Function;
      
      protected var extraLayer:Sprite;
      
      protected var dispatcher:EventDispatcher;
      
      protected var registeredAlready:Boolean;
      
      protected var countAvatarChange:int = 0;
      
      protected var countAvatarRandom:int = 0;
      
      protected var countClassChange:int = 0;
      
      protected var countGenderChange:int = 0;
      
      protected var avaVO:AvatarVO = null;
      
      private const GAME_HEIGHT:int = 600;
      
      private const GAME_WIDTH:int = 800;
      
      protected var avatarComponent:MafiaAvatarComponent;
      
      public function MafiaAvatarScreen(param1:MovieClip, param2:BasicCustomCursor, param3:AvatarVO = null, param4:Function = null, param5:Function = null, param6:Sprite = null, param7:EventDispatcher = null, param8:Boolean = false)
      {
         if(BrowserUtil.getBrowserName().indexOf("IE") != -1 && this.env.loginIsKeyBased)
         {
            param2.hideForPerformance();
         }
         super(param1,param2);
         this._onOKFunction = param4;
         this._onRegiAlrFunction = param5;
         this.extraLayer = param6;
         if(!param7)
         {
            this.dispatcher = this;
         }
         else
         {
            this.dispatcher = param7;
         }
         this.registeredAlready = param8;
         BasicLanguageFontManager.getInstance().addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontLoadComplete);
         this.avaVO = param3;
         this.choiceLanguageComponent = new CountrySelectComponent(param1.mc_languagechoise,new Tooltip_Body(),GGSCountryController.instance.availableCountries,2,BasicModel.languageData.getTextById);
         param1.mc_languagechoise.addEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
         param1.mc_languagechoise.addEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         if(BasicModel.instanceProxy.selectedInstanceVO)
         {
            TrackingCache.getInstance().instanceId = BasicModel.instanceProxy.selectedInstanceVO.instanceId;
         }
         else
         {
            TrackingCache.getInstance().instanceId = BasicModel.instanceProxy.instanceMap[0].instanceId;
         }
         MovieClipHelper.clearMovieClip(param1.mc_avatar_holder);
      }
      
      override public function init() : void
      {
         this.initAvatar(CharacterGender.Male);
      }
      
      protected function initAvatar(param1:CharacterGender) : void
      {
         this.avatarComponent = new MafiaAvatarComponent(this.avaVO,0.5);
         this.avatarComponent.changeGender(param1);
         disp.mc_avatar_holder.addChild(this.avatarComponent);
         this.drawCharacter();
         this.changeCharacterClass(CharacterClass.getRandom());
      }
      
      override protected function onDispAddedToStage(param1:Event) : void
      {
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.reloadLanguage);
         super.onDispAddedToStage(param1);
         this.tooltipManager = new MafiaFirstVisitToolTipManager(this);
         this.tooltipManager.toolTip = new FirstVisitToolTipText();
         this.choiceLanguageComponent.setDefaultCountry(GGSCountryController.instance.currentCountry);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.addEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
         GGSCountryController.instance.newCountrySelected.add(this.onCountryChanged);
         disp.addEventListener(Event.ENTER_FRAME,this.show);
      }
      
      protected function onResize(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(disp.stage.stageWidth < disp.stage.stageHeight * 1.333)
         {
            _loc2_ = disp.stage.stageWidth / this.GAME_WIDTH;
         }
         else
         {
            _loc2_ = disp.stage.stageHeight / this.GAME_HEIGHT;
         }
         this.tooltipManager.toolTip.scaleX = this.tooltipManager.toolTip.scaleY = _loc2_ * 0.75;
      }
      
      protected function show(param1:Event) : void
      {
         disp.removeEventListener(Event.ENTER_FRAME,this.show);
         this.onResize(null);
         disp.stage.addEventListener(Event.RESIZE,this.onResize);
         BasicLanguageFontManager.getInstance().initFontSwf();
         if(MafiaDataHolder.instance.firstVisitCreationUsed || !this.env.loginIsKeyBased)
         {
            this.avatarComponent = new MafiaAvatarComponent(this.avaVO,0.5);
            disp.mc_avatar_holder.addChild(this.avatarComponent);
            this.drawCharacter();
         }
      }
      
      override protected function onRemoveDisp(param1:Event) : void
      {
         disp.mc_languagechoise.removeEventListener(MafiaPanelEvent.MOUSE_OVER,this.onMouseOverLanguage);
         disp.mc_languagechoise.removeEventListener(MafiaPanelEvent.MOUSE_OUT,this.onMouseOutLanguage);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_VIEW_OPENED,this.onOpenCountryList);
         this.choiceLanguageComponent.removeEventListener(CountrySelectComponentEvent.COUNTRY_CHANGED,this.onCountrySelected);
         GGSCountryController.instance.newCountrySelected.remove(this.onCountryChanged);
         if(this.extraLayer && this.extraLayer.parent)
         {
            this.extraLayer.parent.removeChild(this.extraLayer);
         }
         this.clearToolTips();
         disp.stage.removeEventListener(Event.RESIZE,this.onResize);
         this.tooltipManager.destroy();
         super.onRemoveDisp(param1);
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.reloadLanguage);
         BasicLanguageFontManager.getInstance().removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontLoadComplete);
         this.choiceLanguageComponent = null;
         this.dispatcher = null;
      }
      
      protected function onOpenCountryList(param1:CountrySelectComponentEvent) : void
      {
      }
      
      protected function onCountrySelected(param1:CountrySelectComponentEvent) : void
      {
         var _loc2_:AbstractGGSCountry = param1.selectedCountry as AbstractGGSCountry;
         CommandController.instance.executeCommand(BasicController.COMMAND_CHANGE_COUNTRY,_loc2_);
      }
      
      protected function onCountryChanged(param1:AbstractGGSCountry) : void
      {
      }
      
      private function onFontLoadComplete(param1:LanguageDataEvent) : void
      {
         this.fillTexts();
      }
      
      private function onMouseOverLanguage(param1:MafiaPanelEvent) : void
      {
         cursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onMouseOutLanguage(param1:MafiaPanelEvent) : void
      {
         cursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      protected function updateFonts() : void
      {
         BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.btn_ok.txt_label);
         disp.btn_ok.label = BasicModel.languageData.getTextById("MafiaRegisterScreen_register");
         if(this.tooltipManager)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(this.tooltipManager.disp.txt_text);
         }
         BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.btn_registered_already.txt_label);
         disp.btn_registered_already.txt_label.text = BasicModel.languageData.getTextById("MafiaCustomizeAvatarScreen_text_alreadyregistered");
         BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.sticker.txt_sticker);
         if(disp.txt_title)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.txt_title);
         }
         if(disp.txt_gender)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.txt_gender);
         }
         if(disp.txt_looking)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.txt_looking);
         }
         if(disp.txt_class)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.txt_class);
         }
      }
      
      private function reloadLanguage(param1:LanguageDataEvent) : void
      {
         BasicLanguageFontManager.getInstance().initFontSwf();
         if(BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            this.fillTexts();
         }
      }
      
      protected function fillTexts() : void
      {
         if(this.registeredAlready)
         {
            disp.btn_registered_already.visible = false;
         }
         if(disp.txt_title)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(18,disp.txt_title,BasicModel.languageData.getTextById("MafiaAvatarScreen_text_createavatar"));
         }
         if(disp.txt_gender)
         {
            disp.txt_gender.text = BasicModel.languageData.getTextById("MafiaAvatarScreen_text_gender");
         }
         if(disp.txt_looking)
         {
            disp.txt_looking.text = BasicModel.languageData.getTextById("MafiaAvatarScreen_text_look");
         }
         if(disp.txt_class)
         {
            disp.txt_class.text = BasicModel.languageData.getTextById("MafiaFamilyScreen_text_9");
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(10,disp.sticker.txt_sticker,BasicModel.languageData.getTextById("MafiaLoginScreen_text_forfree"),3);
         disp.btn_ok.label = BasicModel.languageData.getTextById("MafiaRegisterScreen_register");
         disp.btn_gender_male.toolTipText = BasicModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_male");
         disp.btn_gender_female.toolTipText = BasicModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_female");
         disp.btn_random.toolTipText = BasicModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_random");
         disp.mc_dmg.toolTipText = BasicModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_damage");
         disp.mc_hp.toolTipText = BasicModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_health");
         disp.btn_bully.toolTipText = BasicModel.languageData.getTextById("MafiaAvatarScreen_copy_1");
         disp.btn_rogue.toolTipText = BasicModel.languageData.getTextById("MafiaAvatarScreen_copy_2");
         disp.btn_tactican.toolTipText = BasicModel.languageData.getTextById("MafiaAvatarScreen_copy_3");
         disp.btn_registered_already.txt_label.text = BasicModel.languageData.getTextById("MafiaCustomizeAvatarScreen_text_alreadyregistered");
         this.updateFonts();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is ColorChoiceButton)
         {
            return;
         }
         switch(param1.target)
         {
            case disp.btn_gender_male:
               this.changeGender(CharacterGender.Male);
               break;
            case disp.btn_gender_female:
               this.changeGender(CharacterGender.Female);
               break;
            case disp.btn_random:
               this.createRandomCharacter(this.avatarComponent.avatarVO.gender);
               break;
            case disp.btn_ok:
               this.saveData();
               if(this._onOKFunction != null)
               {
                  this._onOKFunction();
               }
               dispatchEvent(new BasicFirstVisitEvent(BasicFirstVisitEvent.AVATARCREATION_FINISHED));
               CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.AVATAR_CREATION_FINISHED);
               if(disp && disp.parent)
               {
                  disp.parent.removeChild(disp);
               }
               return;
            case disp.btn_bully:
               this.changeCharacterClass(CharacterClass.Bully);
               break;
            case disp.btn_rogue:
               this.changeCharacterClass(CharacterClass.Rogue);
               break;
            case disp.btn_tactican:
               this.changeCharacterClass(CharacterClass.Tactician);
               break;
            case disp.btn_registered_already:
               if(this._onRegiAlrFunction != null)
               {
                  this._onRegiAlrFunction();
               }
               dispatchEvent(new BasicFirstVisitEvent(BasicFirstVisitEvent.AVATARCREATION_FINISHED));
               CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.HAS_ALREADY_LOGIN_DATA);
               if(disp && disp.parent)
               {
                  disp.parent.removeChild(disp);
               }
         }
         if(this.currentColorTooltip && !(param1.target is (getDefinitionByName("ColorPopup") as Class)))
         {
            this.clearToolTips();
         }
      }
      
      private function clearToolTips() : void
      {
         if(this.currentColorTooltip)
         {
            this.currentColorTooltip.destroy();
         }
         this.currentColorTooltip = null;
      }
      
      public function onClickColorButton(param1:uint, param2:uint = 0) : void
      {
         this.avatarComponent.setColorForPart(this.currentColorTooltip.type,param1,param2);
         this.drawCharacter();
      }
      
      protected function saveData() : void
      {
         MafiaDataHolder.instance.savedAvatarVO = this.avatarComponent.avatarVO;
         MafiaDataHolder.instance.firstVisitCreationUsed = true;
      }
      
      private function changeGender(param1:CharacterGender) : void
      {
         this.avatarComponent.changeGender(param1);
         this.drawCharacter();
      }
      
      protected function changeCharacterClass(param1:CharacterClass) : void
      {
         this.avatarComponent.changeCharacterClass(param1);
         this.drawCharacter();
      }
      
      private function createRandomCharacter(param1:CharacterGender) : void
      {
         this.avatarComponent.createRandomCharacter(param1);
         this.drawCharacter();
      }
      
      protected function drawCharacter() : void
      {
         disp.btn_ok.label = BasicModel.languageData.getTextById("MafiaRegisterScreen_register");
         if(this.avatarComponent == null)
         {
            return;
         }
         var _loc1_:AvatarVO = this.avatarComponent.avatarVO;
         this.avatarComponent.drawCharacter();
         if(this.avatarComponent.avatarVO.characterClass == null || this.avatarComponent.avatarVO.characterClass == CharacterClass.None)
         {
            this.avatarComponent.changeCharacterClass(CharacterClass.getRandom());
         }
         switch(_loc1_.gender)
         {
            case CharacterGender.Female:
               disp.btn_gender_male.isFixed = false;
               disp.btn_gender_female.isFixed = true;
               break;
            case CharacterGender.Male:
               disp.btn_gender_male.isFixed = true;
               disp.btn_gender_female.isFixed = false;
         }
         switch(_loc1_.characterClass)
         {
            case CharacterClass.Bully:
               disp.btn_bully.isFixed = true;
               disp.btn_rogue.isFixed = false;
               disp.btn_tactican.isFixed = false;
               disp.mc_dmg.gotoAndStop(1);
               disp.mc_hp.gotoAndStop(3);
               break;
            case CharacterClass.Rogue:
               disp.btn_rogue.isFixed = true;
               disp.btn_bully.isFixed = false;
               disp.btn_tactican.isFixed = false;
               disp.mc_dmg.gotoAndStop(2);
               disp.mc_hp.gotoAndStop(2);
               break;
            case CharacterClass.Tactician:
               disp.btn_tactican.isFixed = true;
               disp.btn_rogue.isFixed = false;
               disp.btn_bully.isFixed = false;
               disp.mc_dmg.gotoAndStop(3);
               disp.mc_hp.gotoAndStop(1);
         }
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.name.substr(0,7) == "country" || _loc2_ == disp.mc_languagechoise.btn_arrow)
            {
               cursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
         if(param1.target is NewBasicInterfaceButton)
         {
            if((param1.target as NewBasicInterfaceButton).enabled)
            {
               cursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
         if(param1.target == disp.btn_registered_already)
         {
            cursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            disp.btn_registered_already.txt_label.textColor = 15356484;
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         if(param1.target == disp.btn_registered_already)
         {
            disp.btn_registered_already.txt_label.textColor = 16777215;
         }
         cursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function get env() : MafiaEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
