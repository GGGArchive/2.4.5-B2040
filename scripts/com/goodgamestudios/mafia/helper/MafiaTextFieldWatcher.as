package com.goodgamestudios.mafia.helper
{
   import com.adobe.utils.StringUtil;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class MafiaTextFieldWatcher
   {
      
      private static var _textFieldWatcher:MafiaTextFieldWatcher;
      
      public static const ERRORCODE_ALL_OK:int = 0;
      
      public static const ERRORCODE_TOO_SHORT:int = 1;
      
      public static const ERRORCODE_INVALID_CHARS:int = 2;
      
      public static const ERRORCODE_NO_EMAIL:int = 3;
      
      public static const ERRORCODE_EMPTY_TEXTFIELD:int = 5;
      
      public static const RULE_EMAIL:int = 1;
      
      public static const RULE_TEXT:int = 2;
      
      public static const RULE_USERNAME:int = 3;
      
      private static const DICTIONARY_RULES:String = "_rules";
      
      private static const DICTIONARY_CHANGE_FUNCTION:String = "_functionOk";
      
      private static const DICTIONARY_MIN_LENGTH:String = "_minLength";
      
      private static const DICTIONARY_VALIDATE_ON_INPUT:String = "_validate";
      
      private static var textFieldParams:Dictionary;
      
      private static var invalidChars:Array = ["+","%","&","*","/","(",")","[","]","{","}","\"","\'","\\","´","`","^","°","§","€","²","³",",",";","µ","$","|","#","<",">",":"];
      
      private static var invalidEmailChars:Array = ["%","&","*","/","(",")","[","]","{","}","\"","\'","\\","´","`","^","°","§","€","²","³",",",";","µ","$","|","#","<",">",":"];
      
      private static var additionalInvalidUsernameChars:Array = ["=","?","!"];
       
      
      private const MIN_MAIL_LENGTH:int = 6;
      
      private const MAX_MAIL_LENGTH:int = 50;
      
      public function MafiaTextFieldWatcher()
      {
         super();
         textFieldParams = new Dictionary();
      }
      
      public static function watchTextField(param1:TextField, param2:int, param3:Function, param4:int = 0, param5:Boolean = false) : void
      {
         param1.addEventListener(FocusEvent.FOCUS_OUT,instance.onFocusOut);
         param1.addEventListener(FocusEvent.FOCUS_IN,instance.onValueChanged);
         param1.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,instance.onFocusOut);
         param1.addEventListener(Event.CHANGE,instance.onValueChanged);
         param1.addEventListener(Event.REMOVED_FROM_STAGE,instance.onTextFieldRemoved);
         trace("Watching TextField " + param1.name);
         textFieldParams[param1] = [];
         textFieldParams[param1][DICTIONARY_RULES] = param2;
         textFieldParams[param1][DICTIONARY_CHANGE_FUNCTION] = param3;
         textFieldParams[param1][DICTIONARY_MIN_LENGTH] = param4;
         textFieldParams[param1][DICTIONARY_VALIDATE_ON_INPUT] = param5;
      }
      
      public static function stopWatchingTextField(param1:TextField) : void
      {
         if(textFieldParams && textFieldParams[param1])
         {
            if(param1.hasEventListener(TextEvent.TEXT_INPUT))
            {
               param1.removeEventListener(TextEvent.TEXT_INPUT,instance.onValueChanged);
            }
            if(param1.hasEventListener(FocusEvent.FOCUS_IN))
            {
               param1.removeEventListener(FocusEvent.FOCUS_IN,instance.onValueChanged);
            }
            if(param1.hasEventListener(FocusEvent.FOCUS_OUT))
            {
               param1.removeEventListener(FocusEvent.FOCUS_OUT,instance.onFocusOut);
            }
            if(param1.hasEventListener(FocusEvent.KEY_FOCUS_CHANGE))
            {
               param1.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,instance.onFocusOut);
            }
            if(param1.hasEventListener(Event.REMOVED_FROM_STAGE))
            {
               param1.addEventListener(Event.REMOVED_FROM_STAGE,instance.onTextFieldRemoved);
            }
            trace("Stopped watching TextField " + param1.name);
            delete textFieldParams[param1];
         }
      }
      
      public static function validateString(param1:String, param2:int, param3:int) : int
      {
         return Math.max(instance.checkCharacters(param1,param2),instance.checkValidity(param1,param2,param3));
      }
      
      public static function clearInvalidCharactersList() : void
      {
         invalidChars = new Array();
      }
      
      public static function addInvalidChars(param1:String) : void
      {
         invalidChars = invalidChars.concat(param1.split(""));
      }
      
      private static function get instance() : MafiaTextFieldWatcher
      {
         if(!_textFieldWatcher)
         {
            _textFieldWatcher = new MafiaTextFieldWatcher();
         }
         return _textFieldWatcher;
      }
      
      private function onFocusOut(param1:Event = null) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:int = textFieldParams[_loc2_][DICTIONARY_MIN_LENGTH];
         var _loc4_:int = textFieldParams[_loc2_][DICTIONARY_RULES];
         var _loc5_:int = Math.max(this.checkCharacters(_loc2_.text,_loc4_),this.checkValidity(_loc2_.text,_loc4_,_loc3_));
         (textFieldParams[_loc2_][DICTIONARY_CHANGE_FUNCTION] as Function)(_loc5_);
      }
      
      private function onValueChanged(param1:Event = null) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:int = textFieldParams[_loc2_][DICTIONARY_MIN_LENGTH];
         var _loc4_:int = textFieldParams[_loc2_][DICTIONARY_RULES];
         var _loc5_:int = this.checkCharacters(_loc2_.text,_loc4_);
         if(textFieldParams[_loc2_][DICTIONARY_VALIDATE_ON_INPUT])
         {
            _loc5_ = Math.max(_loc5_,this.checkValidity(_loc2_.text,_loc4_,_loc3_));
         }
         (textFieldParams[_loc2_][DICTIONARY_CHANGE_FUNCTION] as Function)(_loc5_);
      }
      
      private function checkValidity(param1:String, param2:int, param3:int = 0) : int
      {
         var _loc4_:String = this.trimString(param1);
         if(_loc4_.length <= 0)
         {
            return ERRORCODE_EMPTY_TEXTFIELD;
         }
         if(_loc4_.length < param3)
         {
            return ERRORCODE_TOO_SHORT;
         }
         if(param2 == RULE_EMAIL && !this.isEmailString(_loc4_))
         {
            return ERRORCODE_NO_EMAIL;
         }
         return ERRORCODE_ALL_OK;
      }
      
      private function onTextFieldRemoved(param1:Event = null) : void
      {
         stopWatchingTextField(param1.target as TextField);
      }
      
      public function isSmartFoxValide(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(StringUtil.trim(param1) == "")
         {
            return false;
         }
         for each(_loc2_ in invalidChars)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function isValidUsername(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in additionalInvalidUsernameChars)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function isEmailString(param1:String) : Boolean
      {
         if(param1.length < this.MIN_MAIL_LENGTH || param1.length > this.MAX_MAIL_LENGTH)
         {
            return false;
         }
         var _loc2_:RegExp = /^[\w\-]+(\.[\w\-]+)*+(\+[\w\-]+)*@([A-Za-z0-9-]+\.)+[A-Za-z]{2,4}$/;
         return _loc2_.test(param1);
      }
      
      public function trimString(param1:String) : String
      {
         return StringUtil.ltrim(StringUtil.rtrim(param1));
      }
      
      public function checkCharacters(param1:String, param2:int) : int
      {
         var _loc3_:String = this.trimString(param1);
         if(_loc3_.length > 0 && param2 != RULE_EMAIL && !this.isSmartFoxValide(_loc3_))
         {
            return ERRORCODE_INVALID_CHARS;
         }
         if(_loc3_.length > 0 && param2 == RULE_EMAIL && !this.isValidEmail(_loc3_))
         {
            return ERRORCODE_INVALID_CHARS;
         }
         if(_loc3_.length > 0 && param2 == RULE_USERNAME && !this.isValidUsername(_loc3_))
         {
            return ERRORCODE_INVALID_CHARS;
         }
         return ERRORCODE_ALL_OK;
      }
      
      public function isValidEmail(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(StringUtil.trim(param1) == "")
         {
            return false;
         }
         for each(_loc2_ in invalidEmailChars)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return false;
            }
         }
         return true;
      }
   }
}
