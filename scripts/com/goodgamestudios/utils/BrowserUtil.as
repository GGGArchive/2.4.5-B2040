package com.goodgamestudios.utils
{
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class BrowserUtil
   {
      
      private static var browserName:String = "";
       
      
      public function BrowserUtil()
      {
         super();
      }
      
      public static function openWindow(param1:URLRequest, param2:String = "_blank", param3:String = "") : void
      {
         var _loc4_:String = param1.url;
         var _loc5_:String = param1.data.toString();
         if(BrowserUtil.browserName == "")
         {
            BrowserUtil.browserName = BrowserUtil.getBrowserName();
         }
         switch(BrowserUtil.browserName)
         {
            case "Firefox":
               navigateToURL(param1,param2);
               break;
            case "IE9":
               ExternalInterface.call("function setWMWindow() {window.open(\'" + _loc4_ + _loc5_ + "\', \'" + param2 + "\', \'" + param3 + "\');}");
               break;
            case "Safari":
            case "Opera":
            case "Chrome":
            case "IE":
            case "IE7":
            case "IE8":
            default:
               navigateToURL(param1,param2);
         }
      }
      
      public static function getBrowserName() : String
      {
         var browser:String = null;
         var browserAgent:String = null;
         if(!ExternalInterface.available)
         {
            return "Undefined";
         }
         try
         {
            browserAgent = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
            if(browserAgent != null && browserAgent.indexOf("Firefox") >= 0)
            {
               browser = "Firefox";
            }
            else if(browserAgent != null && browserAgent.indexOf("Safari") >= 0)
            {
               browser = "Safari";
            }
            else if(browserAgent != null && browserAgent.indexOf("Chrome") >= 0)
            {
               browser = "Chrome";
            }
            else if(browserAgent != null && browserAgent.indexOf("MSIE") >= 0)
            {
               browser = "IE";
               if(browserAgent.indexOf("MSIE 7") >= 0)
               {
                  browser = "IE7";
               }
               if(browserAgent.indexOf("MSIE 8") >= 0)
               {
                  browser = "IE8";
               }
               if(browserAgent.indexOf("MSIE 9") >= 0)
               {
                  browser = "IE9";
               }
            }
            else if(browserAgent != null && browserAgent.indexOf("Opera") >= 0)
            {
               browser = "Opera";
            }
            else
            {
               browser = "Undefined";
            }
            return browser;
         }
         catch(error:SecurityError)
         {
            return "Undefined";
         }
         return "Undefined";
      }
      
      public static function getBrowserCapabilities() : Object
      {
         var itemVars:URLVariables = null;
         var tempStr:String = null;
         var i:String = null;
         var caps:Object = new Object();
         if(ExternalInterface.available)
         {
            try
            {
               tempStr = ExternalInterface.call("JS_getBrowserObjects");
               itemVars = new URLVariables(tempStr);
               for(i in itemVars)
               {
                  caps[i.substring(10,i.length)] = itemVars[i];
               }
            }
            catch(error:SecurityError)
            {
            }
         }
         return caps;
      }
      
      public static function getBrowserLanguage() : String
      {
         var lang:String = null;
         if(ExternalInterface.available)
         {
            try
            {
               lang = ExternalInterface.call("function getBrowserLang(){return navigator.language;}");
               if(lang == null || lang.length <= 1)
               {
                  lang = ExternalInterface.call("function getBrowserLang(){return navigator.browserLanguage;}");
               }
               return lang;
            }
            catch(error:SecurityError)
            {
               return "n.a.";
            }
            return "n.a.";
         }
         return "n.a.";
      }
      
      public static function addWindowEventCallback(param1:String, param2:Function) : void
      {
         var windowEvent:String = param1;
         var callbackFunction:Function = param2;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("informFlash",callbackFunction);
               ExternalInterface.call("function(){ window." + windowEvent + " = function () { " + "var result = document.getElementsByName(\'" + ExternalInterface.objectID + "\')[0].informFlash();" + "return result;" + " } } ()");
               return;
            }
            catch(e:Error)
            {
               trace("Adding javascript close callback failed!");
               return;
            }
         }
      }
      
      public static function addLanguageCallback(param1:Function) : void
      {
         var languageCallbackFunction:Function = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("getLanguage",languageCallbackFunction);
               return;
            }
            catch(e:Error)
            {
               trace("Adding javascript close callback failed!");
               return;
            }
         }
      }
      
      public static function getUrlVariables() : Object
      {
         var result:Object = null;
         var key:String = null;
         if(ExternalInterface.available)
         {
            try
            {
               result = ExternalInterface.call("function(){ var map = {};" + "var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {" + "\tmap[key] = value;" + "});" + "return map;" + "}");
            }
            catch(e:Error)
            {
               trace("Getting url variables from javascript failed!");
            }
         }
         for(key in result)
         {
            result[key] = decodeURI(result[key]);
         }
         return result;
      }
      
      public static function loadJsLibrary(param1:String) : void
      {
         var url:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("function(){ var body = document.body;" + "var script = document.createElement(\'script\');" + "var src = document.createAttribute(\'src\');" + "src.nodeValue = \'" + url + "\';" + "var type = document.createAttribute(\'type\');" + "type.nodeValue = \'text/javascript\';" + "var language = document.createAttribute(\'language\');" + "language.nodeValue = \'javascript\';" + "script.setAttributeNode(src);" + "script.setAttributeNode(type);" + "script.setAttributeNode(language);" + "body.appendChild(script);" + "}");
               return;
            }
            catch(e:Error)
            {
               trace("Loading javascript library (" + url + ") failed!");
               return;
            }
         }
      }
      
      public static function addDivElement(param1:String) : void
      {
         var id:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("function(){ var body = document.body;" + "var div = document.createElement(\'div\');" + "var id = document.createAttribute(\'id\');" + "id.nodeValue = \'" + id + "\';" + "div.setAttributeNode(id);" + "body.appendChild(div);" + "}");
               return;
            }
            catch(e:Error)
            {
               trace("Adding div element (" + id + ") failed!");
               return;
            }
         }
      }
      
      public static function addJsVars(param1:Object) : void
      {
         var functionString:String = null;
         var key:String = null;
         var vars:Object = param1;
         if(ExternalInterface.available)
         {
            try
            {
               functionString = "function(){";
               for(key in vars)
               {
                  functionString = functionString + ("window." + key + " = " + (vars[key] is String?"\'" + vars[key] + "\';":vars[key] + ";"));
               }
               functionString = functionString + "}";
               ExternalInterface.call(functionString);
               return;
            }
            catch(e:Error)
            {
               trace("Adding javascript vars failed! Error: " + e.message);
               return;
            }
         }
      }
      
      public static function reloadPage(param1:Event = null) : void
      {
         var e:Event = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("location.reload");
               return;
            }
            catch(e:Error)
            {
               trace("Reloading page failed!");
               return;
            }
         }
      }
      
      public static function retrieveReferrer(param1:String) : String
      {
         var loaderURL:String = param1;
         var referrer:String = "";
         try
         {
            referrer = ExternalInterface.call("function getLocation() {return document.referrer;}");
            if(referrer == null || referrer.indexOf("http") == -1)
            {
               referrer = ExternalInterface.call("document.location.toString");
            }
         }
         catch(e:Error)
         {
            trace("Script access denied!");
         }
         if(referrer == null || referrer.indexOf("http") == -1)
         {
            referrer = loaderURL;
         }
         return UrlUtil.getCleanReferrer(referrer);
      }
   }
}
