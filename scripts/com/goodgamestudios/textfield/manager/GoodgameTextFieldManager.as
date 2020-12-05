package com.goodgamestudios.textfield.manager
{
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.fontManager.ILanguageFontManager;
   import com.goodgamestudios.textfield.FontConfigVO;
   import com.goodgamestudios.textfield.RuntimeLoadedFontConfigVO;
   import com.goodgamestudios.textfield.textfield.IAdvancedTextField;
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class GoodgameTextFieldManager implements ITextFieldManager
   {
      
      protected static var textFieldManager:ITextFieldManager;
      
      private static var _autoSize:Boolean = false;
       
      
      private var _advancedTextFieldFactory:IAdvancedTextFieldFactory;
      
      private var textFieldList:Dictionary;
      
      private var _getTextById:Function;
      
      private var _fontManager:ILanguageFontManager;
      
      public function GoodgameTextFieldManager()
      {
         super();
         this.init();
         if(textFieldManager)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : ITextFieldManager
      {
         if(!textFieldManager)
         {
            textFieldManager = new GoodgameTextFieldManager();
         }
         return textFieldManager as ITextFieldManager;
      }
      
      public static function get autoSize() : Boolean
      {
         return _autoSize;
      }
      
      public static function set autoSize(param1:Boolean) : void
      {
         _autoSize = param1;
      }
      
      private function init() : void
      {
         this.textFieldList = new Dictionary();
      }
      
      public function set getTextById(param1:Function) : void
      {
         this._getTextById = param1;
      }
      
      public function get getTextById() : Function
      {
         return this._getTextById;
      }
      
      public function get countryController() : GGSCountryController
      {
         return GGSCountryController.instance;
      }
      
      public function get advancedTextFieldFactory() : IAdvancedTextFieldFactory
      {
         if(!this._advancedTextFieldFactory)
         {
            this._advancedTextFieldFactory = new GoodgameAdvancedTextFieldFactory();
         }
         return this._advancedTextFieldFactory;
      }
      
      public function set advancedTextFieldFactory(param1:IAdvancedTextFieldFactory) : void
      {
         this._advancedTextFieldFactory = param1;
      }
      
      public function getTextField(param1:TextField) : IAdvancedTextField
      {
         var _loc2_:IAdvancedTextField = null;
         if(DictionaryUtil.containsKey(this.textFieldList,param1))
         {
            _loc2_ = this.textFieldList[param1] as IAdvancedTextField;
         }
         else
         {
            _loc2_ = this.referenceTextField(param1);
         }
         return _loc2_;
      }
      
      private function referenceTextField(param1:TextField) : IAdvancedTextField
      {
         var _loc2_:IAdvancedTextField = null;
         _loc2_ = this.advancedTextFieldFactory.createAdvancedTextField(param1);
         _loc2_.getTextById = this.getTextById;
         _loc2_.fontManager = this._fontManager;
         this.textFieldList[param1] = _loc2_;
         return _loc2_;
      }
      
      public function unregisterTextField(param1:TextField) : Boolean
      {
         var _loc2_:IAdvancedTextField = null;
         if(DictionaryUtil.containsKey(this.textFieldList,param1))
         {
            _loc2_ = this.textFieldList[param1] as IAdvancedTextField;
            delete this.textFieldList[param1];
            _loc2_.unregister();
            return true;
         }
         return false;
      }
      
      public function get registeredTextFieldAmount() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:IAdvancedTextField = null;
         for each(_loc2_ in this.textFieldList)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function unregisterAllTextFields() : void
      {
         var _loc1_:IAdvancedTextField = null;
         for each(_loc1_ in this.textFieldList)
         {
            delete this.textFieldList[_loc1_.textField];
            _loc1_.unregister();
         }
         this.init();
      }
      
      public function saveAndSetText(param1:TextField, param2:String, param3:Object = null, param4:Boolean = true) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == null)
         {
            return;
         }
         var _loc5_:IAdvancedTextField = this.getTextField(param1);
         _loc5_.textId = param2;
         _loc5_.hasTextId = true;
         _loc5_.textParams = param3;
         _loc5_.groupNumber = param4;
         this.displayText(_loc5_);
      }
      
      private function applyTextFormatByLanguage(param1:IAdvancedTextField) : void
      {
         var _loc3_:FontConfigVO = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         if(!this._fontManager)
         {
            return;
         }
         var _loc2_:String = GGSCountryController.instance.currentCountry.ggsLanguageCode;
         if(this._fontManager.currentLanguageRequiresRuntimeLoadedFont(_loc2_))
         {
            _loc4_ = this._fontManager.getFontNameByGGSLanguageCode(_loc2_);
            _loc5_ = this._fontManager.isFontAbleToDisplayGlyphs(param1.originalTextFormat.font,param1.textContent);
            if(!_loc5_)
            {
               if(!param1.loadedFontConfig)
               {
                  _loc3_ = this._fontManager.getFontConfigVOByFontName(_loc4_) as RuntimeLoadedFontConfigVO;
                  _loc3_.debugColor = 16711680;
                  _loc3_.textFormat = param1.originalFontConfig.textFormat;
                  _loc3_.setYPosition(param1.originalFontConfig.y);
                  param1.loadedFontConfig = _loc3_;
               }
            }
         }
         if(!_loc3_)
         {
            _loc3_ = param1.originalFontConfig;
         }
         param1.applyFontConfiguration(_loc3_);
      }
      
      public function setText(param1:TextField, param2:String, param3:Boolean = true) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = "";
         }
         var _loc4_:IAdvancedTextField = this.getTextField(param1);
         _loc4_.textId = param2;
         _loc4_.hasTextId = false;
         _loc4_.textParams = null;
         _loc4_.groupNumber = param3;
         this.displayText(_loc4_);
      }
      
      private function displayText(param1:IAdvancedTextField) : void
      {
         param1.composeTextContent();
         this.applyTextFormatByLanguage(param1);
         param1.displayText();
      }
      
      public function updateTextInAllTextFields() : void
      {
         var _loc1_:IAdvancedTextField = null;
         for each(_loc1_ in this.textFieldList)
         {
            this.displayText(_loc1_);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function set fontManager(param1:ILanguageFontManager) : void
      {
         this._fontManager = param1;
      }
   }
}
