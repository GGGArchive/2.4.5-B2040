package com.goodgamestudios.basic.controller.externalInterface
{
   import com.goodgamestudios.basic.controller.externalInterface.vo.AbstractJavascriptFunctionCallVO;
   import com.goodgamestudios.basic.controller.externalInterface.vo.JavascriptCallDefaultVO;
   
   public class JavascriptCallDefaultFactory
   {
       
      
      public function JavascriptCallDefaultFactory()
      {
         super();
      }
      
      public function createVO(param1:String = "") : AbstractJavascriptFunctionCallVO
      {
         var _loc2_:AbstractJavascriptFunctionCallVO = null;
         if(param1 && param1 != "")
         {
            _loc2_ = new JavascriptCallDefaultVO(param1);
         }
         return _loc2_;
      }
   }
}
