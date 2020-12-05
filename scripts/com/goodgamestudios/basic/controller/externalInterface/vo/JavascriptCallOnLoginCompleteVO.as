package com.goodgamestudios.basic.controller.externalInterface.vo
{
   import com.goodgamestudios.basic.controller.externalInterface.JavascriptFunctionName;
   
   public class JavascriptCallOnLoginCompleteVO extends AbstractJavascriptFunctionCallVO
   {
       
      
      public function JavascriptCallOnLoginCompleteVO(param1:String, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         functionName = JavascriptFunctionName.ON_LOGIN_COMPLETE;
         _parameters = arguments;
      }
   }
}
