package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicFontData;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.fontManager.ILanguageFontManager;
   import com.goodgamestudios.textfield.FontConfigVO;
   import com.goodgamestudios.textfield.RuntimeLoadedFontConfigVO;
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class BasicLanguageFontManager extends EventDispatcher implements ILanguageFontManager
   {
      
      private static var languageFontManager:BasicLanguageFontManager;
       
      
      private var _initalized:Boolean;
      
      private var _fontModel:BasicFontData;
      
      private var _fontDictionary:Dictionary;
      
      public function BasicLanguageFontManager()
      {
         this._fontDictionary = new Dictionary();
         super();
         this.updateAvailableFonts();
      }
      
      public static function getInstance() : BasicLanguageFontManager
      {
         if(!languageFontManager)
         {
            languageFontManager = new BasicLanguageFontManager();
         }
         return languageFontManager;
      }
      
      public function initalize(param1:BasicFontData) : void
      {
         if(this._initalized)
         {
            return;
         }
         this._initalized = true;
         this._fontModel = param1;
      }
      
      public function currentLanguageRequiresRuntimeLoadedFont(param1:String) : Boolean
      {
         return this._fontModel.currentLanguageRequiresRuntimeLoadedFont(param1);
      }
      
      public function isRuntimeLoadedFont(param1:String = "") : Boolean
      {
         return this._fontModel.isRuntimeLoadedFont(param1);
      }
      
      public function getFontNameByGGSLanguageCode(param1:String) : String
      {
         return this._fontModel.getFontNameByGGSLanguageCode(param1);
      }
      
      public function changeFontByLanguage(param1:TextField) : void
      {
         var _loc2_:TextFormat = param1.defaultTextFormat;
         var _loc3_:BasicFontData = BasicModel.fontData;
         var _loc4_:String = _loc3_.getFontNameByGGSLanguageCode(GGSCountryController.instance.currentCountry.ggsLanguageCode);
         if(!this.useDefaultFont && !param1.styleSheet)
         {
            if(this.isRuntimeLoadedFont(_loc4_) && !this.isRuntimeLoadedFont(_loc2_.font))
            {
               param1.y = param1.y - 3;
            }
            _loc2_.font = _loc4_;
            param1.defaultTextFormat = _loc2_;
            param1.setTextFormat(_loc2_);
            param1.embedFonts = true;
         }
      }
      
      public function initFontSwf() : void
      {
         if(this.useDefaultFont)
         {
            this.onLanguageFontReady();
         }
         else
         {
            this.loadFontSWF(this.env.fontSWFUrl);
         }
      }
      
      public function get useDefaultFont() : Boolean
      {
         var _loc3_:RuntimeLoadedFontConfigVO = null;
         var _loc1_:String = GGSCountryController.instance.currentCountry.ggsLanguageCode;
         var _loc2_:Boolean = true;
         for each(_loc3_ in this._fontModel.runtimeLoadedFontsConfigurations)
         {
            if(_loc1_ == _loc3_.ggsLanguageCode)
            {
               _loc2_ = false;
            }
         }
         return _loc2_;
      }
      
      public function getFontConfigVOByFontName(param1:String) : FontConfigVO
      {
         var _loc2_:RuntimeLoadedFontConfigVO = null;
         for each(_loc2_ in this._fontModel.runtimeLoadedFontsConfigurations)
         {
            if(param1 == _loc2_.fontName)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function loadFontSWF(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontSWFLoadComplete);
         _loc2_.load(_loc3_,_loc4_);
         dispatchEvent(new LanguageDataEvent(LanguageDataEvent.FONT_LOAD_START));
      }
      
      private function onErrorEvent(param1:Event) : void
      {
         throw new Error(param1.type);
      }
      
      protected function onFontSWFLoadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         _loc2_.removeEventListener(Event.COMPLETE,this.onFontSWFLoadComplete);
         var _loc3_:Class = getDefinitionByName(this.env.gameTitle + "Fonts_" + GGSCountryController.instance.currentCountry.ggsLanguageCode + "_" + this.env.gameTitle + "Font1_" + GGSCountryController.instance.currentCountry.ggsLanguageCode) as Class;
         Font.registerFont(_loc3_);
         this.updateAvailableFonts();
         this.onLanguageFontReady();
      }
      
      protected function onLanguageFontReady() : void
      {
         dispatchEvent(new LanguageDataEvent(LanguageDataEvent.FONT_LOAD_COMPLETE));
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
      
      private function updateAvailableFonts() : void
      {
         var _loc1_:Font = null;
         for each(_loc1_ in Font.enumerateFonts())
         {
            this._fontDictionary[_loc1_.fontName] = _loc1_;
         }
      }
      
      public function getFontByFontName(param1:String) : Font
      {
         if(DictionaryUtil.containsKey(this._fontDictionary,param1))
         {
            return this._fontDictionary[param1];
         }
         return null;
      }
      
      public function isFontAbleToDisplayGlyphs(param1:String, param2:String) : Boolean
      {
         var _loc3_:Font = this.getFontByFontName(param1);
         if(_loc3_)
         {
            return _loc3_.hasGlyphs(param2);
         }
         return false;
      }
   }
}
