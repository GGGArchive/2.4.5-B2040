package com.goodgamestudios.basic.controller.externalInterface.vo
{
   import flash.errors.IllegalOperationError;
   
   public class AbstractJavascriptFunctionCallFactory
   {
       
      
      public function AbstractJavascriptFunctionCallFactory()
      {
         super();
      }
      
      public function createVO() : AbstractJavascriptFunctionCallVO
      {
         throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
      }
   }
}
