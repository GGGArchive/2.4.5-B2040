package com.goodgamestudios.basic.controller.externalInterface.vo
{
   public class AbstractJavascriptFunctionCallVO
   {
       
      
      public var functionName:String;
      
      protected var _parameters:Array;
      
      public function AbstractJavascriptFunctionCallVO()
      {
         super();
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
      
      public function toString() : String
      {
         return "functionName: " + this.functionName + ", parameters: " + this._parameters;
      }
   }
}
