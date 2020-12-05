package com.goodgamestudios.utils
{
   import flash.external.ExternalInterface;
   
   public class JSUtils
   {
       
      
      public function JSUtils()
      {
         super();
      }
      
      public static function isJsAvailable() : Boolean
      {
         try
         {
            if(ExternalInterface.available)
            {
               if(ExternalInterface.call("Function(\"return true;\")"))
               {
                  return true;
               }
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      public static function checkIfJsFunctionExists(param1:String) : Boolean
      {
         return ExternalInterface.call("Function(\"" + "return (typeof " + param1 + " === \'function\');" + "\")");
      }
      
      public static function loadJS(param1:String) : void
      {
         ExternalInterface.call("document.getElementsByTagName(\'head\')[0].appendChild(document.createElement(\'script\'))");
         ExternalInterface.call("document.getElementsByTagName(\'script\')[document.getElementsByTagName(\'head\')[0].getElementsByTagName(\'script\').length-1].setAttribute(\'type\', \'text/javascript\')");
         ExternalInterface.call("document.getElementsByTagName(\'script\')[document.getElementsByTagName(\'head\')[0].getElementsByTagName(\'script\').length-1].setAttribute(\'src\', \'" + param1 + "\')");
      }
      
      public static function addJsCallback(param1:String, param2:Function) : Boolean
      {
         var callbackFunctionName:String = param1;
         var callbackFunction:Function = param2;
         try
         {
            ExternalInterface.addCallback(callbackFunctionName,callbackFunction);
            return true;
         }
         catch(e:Error)
         {
            trace(e.message);
            return false;
         }
         return false;
      }
   }
}
