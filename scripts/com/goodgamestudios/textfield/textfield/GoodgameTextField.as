package com.goodgamestudios.textfield.textfield
{
   import com.goodgamestudios.language.fontManager.ILanguageFontManager;
   import com.goodgamestudios.textfield.FontConfigVO;
   import com.goodgamestudios.textfield.RuntimeLoadedFontConfigVO;
   import com.goodgamestudios.textfield.manager.GoodgameTextFieldManager;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class GoodgameTextField implements IAdvancedTextField
   {
       
      
      private var _textField:TextField;
      
      private var _textId:String;
      
      private var _textParams:Object;
      
      private var _getTextById:Function;
      
      private var _groupNumber:Boolean;
      
      private var _hasTextId:Boolean;
      
      private var _autoSize:Boolean;
      
      private var _fontManager:ILanguageFontManager;
      
      private var _textContent:String;
      
      private const debug:Boolean = false;
      
      private const DEBUG_COLOR_ORIGINAL:Number = 255;
      
      private const DEBUG_COLOR_RUNTIME:Number = 16711680;
      
      private var _originalFontConfig:FontConfigVO;
      
      private var _loadedFontConfig:RuntimeLoadedFontConfigVO;
      
      public function GoodgameTextField(param1:TextField)
      {
         super();
         this._textField = param1;
         this._textField.antiAliasType = AntiAliasType.ADVANCED;
         this._originalFontConfig = new FontConfigVO();
         this._originalFontConfig.fontName = param1.defaultTextFormat.font;
         this._originalFontConfig.setYPosition(param1.y);
         this._originalFontConfig.textFormat = param1.defaultTextFormat;
      }
      
      public function set fontManager(param1:ILanguageFontManager) : void
      {
         this._fontManager = param1;
      }
      
      public function displayText() : void
      {
         this.textField.text = this._textContent;
      }
      
      public function composeTextContent() : void
      {
         var _loc1_:String = null;
         var _loc3_:* = null;
         var _loc4_:String = null;
         if(GoodgameTextFieldManager.autoSize)
         {
            this._textField.autoSize = TextFieldAutoSize.RIGHT;
         }
         var _loc2_:Array = [];
         if(!this.hasTextId)
         {
            _loc1_ = this.textId;
            if(this.groupNumber && _loc1_.length > 0 && !isNaN(Number(_loc1_)))
            {
               _loc1_ = this.groupNumberToString(Number(_loc1_));
            }
            this._textContent = _loc1_;
            return;
         }
         if(this.textParams)
         {
            for(_loc3_ in this.textParams)
            {
               if(_loc3_.length > 0)
               {
                  _loc4_ = this.textParams[_loc3_];
                  _loc1_ = this.getTextById(_loc4_,null) as String;
                  if(_loc1_.length == 0)
                  {
                     if(!isNaN(Number(_loc4_)) && _loc4_ != "")
                     {
                        _loc2_[_loc3_] = !!this.groupNumber?this.groupNumberToString(Number(_loc4_)):String(_loc4_);
                     }
                     else
                     {
                        _loc2_[_loc3_] = _loc4_;
                     }
                  }
                  else
                  {
                     _loc2_[_loc3_] = _loc1_;
                  }
               }
               else
               {
                  _loc2_[_loc3_] = "";
               }
            }
         }
         if(this.textId || this.textId == "")
         {
            _loc1_ = this.getTextById(this.textId,_loc2_) as String;
            if(_loc1_.length == 0)
            {
               _loc1_ = this.textId;
            }
         }
         else
         {
            _loc1_ = this.textField.text;
         }
         this._textContent = _loc1_;
      }
      
      public function applyFontConfiguration(param1:FontConfigVO) : void
      {
         this.applyNewTextFormat(param1.textFormat);
         this._textField.y = param1.y;
      }
      
      private function applyNewTextFormat(param1:TextFormat) : void
      {
         this._textField.setTextFormat(param1);
         this._textField.defaultTextFormat = param1;
         this._textField.embedFonts = true;
      }
      
      private function groupNumberToString(param1:Number) : String
      {
         var _loc2_:String = param1.toString().substring(param1.toString().charAt(0) == "-"?Number(1):Number(0),param1.toString().indexOf(".") == -1?Number(int.MAX_VALUE):Number(param1.toString().indexOf(".")));
         var _loc3_:int = Math.floor(_loc2_.length / 3);
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.substr(_loc2_.length - 3,3) + _loc4_;
            _loc2_ = _loc2_.substr(0,_loc2_.length - 3);
            if(_loc2_.length > 0)
            {
               _loc4_ = this.getTextById("generic_decimalseparator") + _loc4_;
            }
            _loc5_++;
         }
         var _loc6_:String = param1.toString().indexOf(".") == -1?"":this.getTextById("generic_comma") + param1.toString().substr(param1.toString().indexOf(".") + 1);
         _loc4_ = (param1 < 0?"-":"") + _loc2_ + _loc4_ + _loc6_;
         return _loc4_;
      }
      
      public function recolorTextField(param1:uint) : void
      {
         var _loc2_:TextFormat = this.textField.getTextFormat();
         _loc2_.color = param1;
         this.textField.setTextFormat(_loc2_);
         this.textField.defaultTextFormat = _loc2_;
         this._originalFontConfig.textFormat = _loc2_;
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function set textId(param1:String) : void
      {
         this._textId = param1;
      }
      
      public function get textId() : String
      {
         return this._textId;
      }
      
      public function set textParams(param1:Object) : void
      {
         this._textParams = param1;
      }
      
      public function get textParams() : Object
      {
         return this._textParams;
      }
      
      public function set hasTextId(param1:Boolean) : void
      {
         this._hasTextId = param1;
      }
      
      public function get hasTextId() : Boolean
      {
         return this._hasTextId;
      }
      
      public function get groupNumber() : Boolean
      {
         return this._groupNumber;
      }
      
      public function set groupNumber(param1:Boolean) : void
      {
         this._groupNumber = param1;
      }
      
      public function get getTextById() : Function
      {
         return this._getTextById;
      }
      
      public function set getTextById(param1:Function) : void
      {
         this._getTextById = param1;
      }
      
      public function unregister() : void
      {
         this._textField = null;
         this._textId = null;
         this._textParams = null;
         this._originalFontConfig = null;
         this._loadedFontConfig = null;
      }
      
      public function get originalTextFormat() : TextFormat
      {
         return this._originalFontConfig.textFormat;
      }
      
      public function get textContent() : String
      {
         return this._textContent;
      }
      
      public function get originalFontConfig() : FontConfigVO
      {
         return this._originalFontConfig;
      }
      
      public function get loadedFontConfig() : FontConfigVO
      {
         return this._loadedFontConfig as FontConfigVO;
      }
      
      public function set loadedFontConfig(param1:FontConfigVO) : void
      {
         this._loadedFontConfig = param1 as RuntimeLoadedFontConfigVO;
      }
      
      public function get autoSize() : Boolean
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:Boolean) : void
      {
         this._autoSize = param1;
      }
   }
}
