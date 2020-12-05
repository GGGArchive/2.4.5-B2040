package com.goodgamestudios.textfield.manager
{
   import com.goodgamestudios.language.fontManager.ILanguageFontManager;
   import com.goodgamestudios.textfield.textfield.IAdvancedTextField;
   import flash.text.TextField;
   
   public interface ITextFieldManager
   {
       
      
      function getTextField(param1:TextField) : IAdvancedTextField;
      
      function saveAndSetText(param1:TextField, param2:String, param3:Object = null, param4:Boolean = true) : void;
      
      function setText(param1:TextField, param2:String, param3:Boolean = true) : void;
      
      function updateTextInAllTextFields() : void;
      
      function dispose() : void;
      
      function get getTextById() : Function;
      
      function set getTextById(param1:Function) : void;
      
      function unregisterTextField(param1:TextField) : Boolean;
      
      function unregisterAllTextFields() : void;
      
      function set fontManager(param1:ILanguageFontManager) : void;
      
      function get registeredTextFieldAmount() : uint;
   }
}
