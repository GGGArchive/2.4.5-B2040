package com.goodgamestudios.basic.controller.externalInterface
{
   import com.goodgamestudios.basic.controller.externalInterface.vo.AbstractJavascriptFunctionCallFactory;
   import com.goodgamestudios.basic.controller.externalInterface.vo.AbstractJavascriptFunctionCallVO;
   import flash.external.ExternalInterface;
   
   public class ExternalInterfaceController
   {
      
      public static const VERSION:String = "$Id: ExternalInterfaceController.as 1487 2012-10-04 15:01:10Z patrick.burst $";
      
      public static const NAME:String = "ExternalInterfaceController";
      
      private static var _externalInterfaceController:ExternalInterfaceController;
       
      
      private var _javascriptFunctionCallDefaultFactory:JavascriptCallDefaultFactory;
      
      public function ExternalInterfaceController()
      {
         super();
         this._javascriptFunctionCallDefaultFactory = new JavascriptCallDefaultFactory();
      }
      
      public static function get instance() : ExternalInterfaceController
      {
         if(_externalInterfaceController == null)
         {
            _externalInterfaceController = new ExternalInterfaceController();
         }
         return _externalInterfaceController;
      }
      
      public function executeJavaScriptFunction(param1:Object) : *
      {
         var _loc2_:AbstractJavascriptFunctionCallVO = null;
         if(!param1)
         {
            return;
         }
         if(param1 is AbstractJavascriptFunctionCallFactory)
         {
            _loc2_ = (param1 as AbstractJavascriptFunctionCallFactory).createVO();
         }
         else if(param1 is String)
         {
            _loc2_ = this._javascriptFunctionCallDefaultFactory.createVO(param1 as String);
         }
         else
         {
            return;
         }
         if(!_loc2_)
         {
            return;
         }
         return this.executeExternalInterfaceCall(_loc2_);
      }
      
      private function executeExternalInterfaceCall(param1:AbstractJavascriptFunctionCallVO) : *
      {
         var returnValue:Object = null;
         var javascriptFunctionVO:AbstractJavascriptFunctionCallVO = param1;
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            javascriptFunctionVO.parameters.unshift(javascriptFunctionVO.functionName);
            returnValue = ExternalInterface.call.apply(null,javascriptFunctionVO.parameters);
         }
         catch(error:Error)
         {
         }
         if(returnValue)
         {
            return returnValue;
         }
      }
   }
}
