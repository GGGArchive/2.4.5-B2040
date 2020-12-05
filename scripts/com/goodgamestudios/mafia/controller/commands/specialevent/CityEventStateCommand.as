package com.goodgamestudios.mafia.controller.commands.specialevent
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.PBSpecialeventCityEventRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.PBSpecialeventCityEventResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class CityEventStateCommand extends BasicProtobufCommand
   {
       
      
      public function CityEventStateCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityEventRequest = new PBSpecialeventCityEventRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityEventResponse = param1 as PBSpecialeventCityEventResponse;
         MafiaModel.specialEvent.sicilianEvent.parseEventDetails(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityEventRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityEventResponse;
      }
   }
}
