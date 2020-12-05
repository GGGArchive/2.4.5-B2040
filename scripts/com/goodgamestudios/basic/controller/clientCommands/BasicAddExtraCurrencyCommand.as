package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.constants.PaymentConstants;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class BasicAddExtraCurrencyCommand extends SimpleCommand
   {
       
      
      protected var paymentHash:String;
      
      public function BasicAddExtraCurrencyCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(!param1)
         {
            param1 = "";
         }
         this.paymentHash = param1.toString();
         this.layoutManager.revertFullscreen();
         if(this.env.requestPayByJS)
         {
            this.onOpenPaymentByJS();
         }
         else
         {
            this.onOpenPayment();
         }
      }
      
      protected function onOpenPaymentByJS() : void
      {
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            ExternalInterface.call("requestPayment");
            return;
         }
         catch(error:SecurityError)
         {
            throw new Error("external interdafe not available");
         }
      }
      
      protected function onOpenPayment() : void
      {
         var urlRequest:URLRequest = null;
         try
         {
            urlRequest = PaymentConstants.getPaymentURLRequest(GGSCountryController.instance.currentCountry.ggsLanguageCode,this.env.gameId,this.env.networkId,BasicModel.instanceProxy.selectedInstanceVO.instanceId,this.paymentHash);
            navigateToURL(urlRequest,"_blank");
            return;
         }
         catch(e:Error)
         {
            throw new Error("navigateToURL error");
         }
      }
      
      protected function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
