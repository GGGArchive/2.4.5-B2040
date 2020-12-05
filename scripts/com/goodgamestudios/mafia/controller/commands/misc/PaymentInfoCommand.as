package com.goodgamestudios.mafia.controller.commands.misc
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.misc.paymentinfo.PBMiscPaymentInfoRequest;
   import com.goodgamestudios.mafia.controller.protobuf.misc.paymentinfo.PBMiscPaymentInfoResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class PaymentInfoCommand extends BasicProtobufCommand
   {
       
      
      public function PaymentInfoCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMiscPaymentInfoRequest = new PBMiscPaymentInfoRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMiscPaymentInfoResponse = param1 as PBMiscPaymentInfoResponse;
         MafiaModel.userData.isPayUser = _loc2_.isPayUser;
         MafiaModel.userData.paymentDoppler = _loc2_.dopplerCount;
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_PAYUSER_INFO));
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMiscPaymentInfoRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMiscPaymentInfoResponse;
      }
   }
}
