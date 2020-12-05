package com.goodgamestudios.misc
{
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   
   public class SystemAnalyzer
   {
      
      public static const BROWSER_FIREFOX:String = "Firefox";
      
      public static const BROWSER_CHROME:String = "Chrome";
      
      public static const BROWSER_IE:String = "MSIE";
      
      public static const BROWSER_OPERA:String = "Opera";
      
      public static const BROWSER_SAFARI:String = "Safari";
      
      public static const BROWSER_UNKNOWN:String = "BrowserUnknown";
      
      public static const OS_WIN7:String = "Windows 7";
      
      public static const LANG_DE:String = "de";
      
      private static var _instance:SystemAnalyzer;
       
      
      private var browser:String;
      
      public function SystemAnalyzer()
      {
         super();
         if(_instance)
         {
            throw new Error("this is a singleton. cannot instanciate more than once");
         }
      }
      
      public static function get instance() : SystemAnalyzer
      {
         if(!_instance)
         {
            _instance = new SystemAnalyzer();
         }
         return _instance;
      }
      
      public function hasALTGRBug() : Boolean
      {
         if(this.analyseBrowser() == BROWSER_CHROME && Capabilities.os == OS_WIN7)
         {
            return true;
         }
         return false;
      }
      
      public function analyseBrowser() : String
      {
         var userAgent:String = null;
         if(ExternalInterface.available)
         {
            try
            {
               userAgent = ExternalInterface.call("window.navigator.userAgent.toString");
               if(userAgent.indexOf(BROWSER_FIREFOX) != -1)
               {
                  this.browser = BROWSER_FIREFOX;
               }
               else if(userAgent.indexOf(BROWSER_CHROME) != -1)
               {
                  this.browser = BROWSER_CHROME;
               }
               else if(userAgent.indexOf(BROWSER_IE) != -1)
               {
                  this.browser = BROWSER_IE;
               }
               else if(userAgent.indexOf(BROWSER_OPERA) != -1)
               {
                  this.browser = BROWSER_OPERA;
               }
               else if(userAgent.indexOf(BROWSER_SAFARI) != -1)
               {
                  this.browser = BROWSER_SAFARI;
               }
            }
            catch(e:SecurityError)
            {
               return "";
            }
            return this.browser;
         }
         return BROWSER_UNKNOWN;
      }
   }
}
