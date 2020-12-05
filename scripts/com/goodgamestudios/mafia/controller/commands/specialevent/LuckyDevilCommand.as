package com.goodgamestudios.mafia.controller.commands.specialevent
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.PBSpecialeventLuckydevilRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.PBSpecialeventLuckydevilResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class LuckyDevilCommand extends BasicProtobufCommand
   {
       
      
      public function LuckyDevilCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventLuckydevilRequest = new PBSpecialeventLuckydevilRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventLuckydevilResponse = param1 as PBSpecialeventLuckydevilResponse;
         MafiaModel.specialEvent.luckyDevilEvent.parseEventDetails(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventLuckydevilRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventLuckydevilResponse;
      }
   }
}
