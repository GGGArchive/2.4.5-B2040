package com.goodgamestudios.basic.startup
{
   import flash.external.ExternalInterface;
   
   public class BasicJSVariables
   {
       
      
      public var journeyHash:String;
      
      private var _initialized:Boolean;
      
      public function BasicJSVariables()
      {
         super();
      }
      
      public function readVariablesFromJavaScript() : void
      {
         if(this._initialized)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            this.journeyHash = this.callJavascriptGetter("journeyHash");
         }
         this._initialized = true;
      }
      
      private function callJavascriptGetter(param1:String) : String
      {
         var variableValue:String = null;
         var variableName:String = param1;
         try
         {
            variableValue = ExternalInterface.call(variableName);
         }
         catch(e:Error)
         {
            trace("BasicJSVariables, callJavascriptGetter() ERROR: ExternalInterface call failed. Cannot get " + variableName + " from javascript");
         }
         return variableValue;
      }
      
      public function toString() : String
      {
         return "journeyHash: " + this.journeyHash;
      }
   }
}
