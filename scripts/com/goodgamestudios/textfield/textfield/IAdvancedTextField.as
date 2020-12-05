package com.goodgamestudios.textfield.textfield
{
   import com.goodgamestudios.language.fontManager.ILanguageFontManager;
   import com.goodgamestudios.textfield.FontConfigVO;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public interface IAdvancedTextField
   {
       
      
      function composeTextContent() : void;
      
      function displayText() : void;
      
      function get textContent() : String;
      
      function get textField() : TextField;
      
      function set textId(param1:String) : void;
      
      function set hasTextId(param1:Boolean) : void;
      
      function get hasTextId() : Boolean;
      
      function get textId() : String;
      
      function set textParams(param1:Object) : void;
      
      function get textParams() : Object;
      
      function set groupNumber(param1:Boolean) : void;
      
      function get groupNumber() : Boolean;
      
      function get getTextById() : Function;
      
      function set getTextById(param1:Function) : void;
      
      function unregister() : void;
      
      function set fontManager(param1:ILanguageFontManager) : void;
      
      function get originalTextFormat() : TextFormat;
      
      function applyFontConfiguration(param1:FontConfigVO) : void;
      
      function get originalFontConfig() : FontConfigVO;
      
      function get loadedFontConfig() : FontConfigVO;
      
      function set loadedFontConfig(param1:FontConfigVO) : void;
   }
}
