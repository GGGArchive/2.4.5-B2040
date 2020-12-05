package com.goodgamestudios.basic.controller.externalInterface.vo
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.model.BasicModel;
   
   public class JavascriptCallOnLoginCompleteFactory extends AbstractJavascriptFunctionCallFactory
   {
       
      
      public function JavascriptCallOnLoginCompleteFactory()
      {
         super();
      }
      
      override public function createVO() : AbstractJavascriptFunctionCallVO
      {
         var _loc1_:JavascriptCallOnLoginCompleteVO = new JavascriptCallOnLoginCompleteVO(EnvGlobalsHandler.globals.accountId,BasicModel.userData.playerID,BasicModel.instanceProxy.selectedInstanceVO.instanceId,EnvGlobalsHandler.globals.networkId,EnvGlobalsHandler.globals.gameId);
         return _loc1_;
      }
   }
}
