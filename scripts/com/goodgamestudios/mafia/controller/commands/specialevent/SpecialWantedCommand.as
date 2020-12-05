package com.goodgamestudios.mafia.controller.commands.specialevent
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialwanted.PBSpecialeventSpecialWantedRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialwanted.PBSpecialeventSpecialWantedResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SpecialWantedCommand extends BasicProtobufCommand
   {
       
      
      public function SpecialWantedCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventSpecialWantedRequest = new PBSpecialeventSpecialWantedRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventSpecialWantedResponse = param1 as PBSpecialeventSpecialWantedResponse;
         if(MafiaModel.specialEvent.capoVitoEvent.isEventActive)
         {
            MafiaModel.specialEvent.capoVitoEvent.parseEventDetails(_loc2_);
         }
         else if(MafiaModel.specialEvent.nightOfHorrorEvent.isEventActive)
         {
            MafiaModel.specialEvent.nightOfHorrorEvent.parseEventDetails(_loc2_);
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventSpecialWantedRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventSpecialWantedResponse;
      }
   }
}
