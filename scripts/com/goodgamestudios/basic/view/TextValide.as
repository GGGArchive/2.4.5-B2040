package com.goodgamestudios.basic.view
{
   import com.adobe.utils.StringUtil;
   
   public class TextValide
   {
      
      public static var SUBST_PERCENT:String = "&percnt;";
      
      public static var SUBST_QUOTE:String = "&quot;";
      
      public static var SUBST_APOSTROPHE:String = "&#145;";
      
      public static var SUBST_NEWLINE:String = "<br />";
      
      public static var invalidChars:Array = ["%","&","*","/","(",")","[","]","{","}","\"","\'","\\","´","`","^","°","§","€","²","³",",",";","µ","$"];
      
      public static var invalidChatChars:Array = ["\\+","#","<",">","\"","\\$"];
      
      public static var invalidUsernameChars:Array = ["!","=","?","+","#","<",">","|"];
       
      
      public function TextValide()
      {
         super();
      }
      
      public static function isSmartFoxValide(param1:String) : Boolean
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
      
      public static function isUsernameValide(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(StringUtil.trim(param1) == "")
         {
            return false;
         }
         if(!isSmartFoxValide(param1))
         {
            return false;
         }
         for each(_loc2_ in invalidUsernameChars)
         {
            if(param1.indexOf(_loc2_) >= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getValidUsername(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:RegExp = null;
         var _loc5_:RegExp = null;
         for each(_loc2_ in invalidUsernameChars)
         {
            _loc4_ = new RegExp("\\" + _loc2_,"gismx");
            param1 = param1.replace(_loc4_,"");
         }
         for each(_loc3_ in invalidChars)
         {
            _loc5_ = new RegExp("\\" + _loc3_,"gismx");
            param1 = param1.replace(_loc5_,"");
         }
         return getValideSmartFoxText(param1);
      }
      
      public static function getSmartFoxInvalideChar(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         if(StringUtil.trim(param1) == "")
         {
            return _loc2_;
         }
         for each(_loc3_ in invalidChars)
         {
            if(param1.indexOf(_loc3_) >= 0)
            {
               _loc2_ = _loc2_ + _loc3_;
            }
         }
         return _loc2_;
      }
      
      public static function getCleanText(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         for each(_loc2_ in invalidChars)
         {
            _loc3_ = new RegExp("\\" + _loc2_,"gismx");
            param1 = param1.replace(_loc3_,"");
         }
         return getValideSmartFoxText(param1);
      }
      
      public static function getCleanChatText(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         for each(_loc2_ in invalidChatChars)
         {
            _loc3_ = new RegExp("\\" + _loc2_,"gs");
            param1 = param1.replace(_loc3_,"");
         }
         return getValideSmartFoxText(param1);
      }
      
      public static function getValideSmartFoxText(param1:String) : String
      {
         var _loc2_:RegExp = /%/g;
         var _loc3_:RegExp = /'/g;
         param1 = param1.replace(_loc2_,SUBST_PERCENT);
         param1 = param1.replace(_loc3_,"");
         return param1;
      }
      
      public static function getValideSmartFoxJSONTextMessage(param1:String) : String
      {
         var _loc2_:RegExp = /%/g;
         var _loc3_:RegExp = /'/g;
         var _loc4_:RegExp = /"/g;
         var _loc5_:RegExp = /\r/g;
         var _loc6_:RegExp = /\\/g;
         var _loc7_:RegExp = /\n/g;
         param1 = param1.replace(_loc2_,SUBST_PERCENT);
         param1 = param1.replace(_loc3_,SUBST_APOSTROPHE);
         param1 = param1.replace(_loc4_,SUBST_QUOTE);
         param1 = param1.replace(_loc5_,SUBST_NEWLINE);
         param1 = param1.replace(_loc6_,"");
         param1 = param1.replace(_loc7_,SUBST_NEWLINE);
         return param1;
      }
      
      public static function parseChatMessage(param1:String) : String
      {
         var _loc2_:RegExp = /&percnt;/g;
         param1 = param1.replace(_loc2_,"%");
         return param1;
      }
      
      public static function parseChatJSONMessage(param1:String) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc2_:RegExp = /&percnt;/g;
         var _loc3_:RegExp = /&quot;/g;
         var _loc4_:RegExp = /&#145;/g;
         var _loc5_:RegExp = /<br \/>/g;
         param1 = param1.replace(_loc2_,"%").replace(_loc3_,"\"").replace(_loc4_,"\'").replace(_loc5_,"\r");
         return param1;
      }
      
      public static function isEmailString(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^[A-Za-z0-9\-+_]+(\.[A-Za-z0-9\-+_]+)*@([A-Za-z0-9\-]+\.)+[A-Za-z]{2,}$/;
         return _loc2_.test(param1);
      }
      
      public static function trimPassword(param1:String) : String
      {
         return StringUtil.ltrim(StringUtil.rtrim(param1));
      }
   }
}
