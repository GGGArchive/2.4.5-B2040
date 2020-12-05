package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.PBSpecialeventCityCityEventProgressRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.PBSpecialeventCityCityEventProgressResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class CityEventProgressCommand extends BasicProtobufCommand
   {
       
      
      public function CityEventProgressCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityCityEventProgressRequest = new PBSpecialeventCityCityEventProgressRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityCityEventProgressResponse = param1 as PBSpecialeventCityCityEventProgressResponse;
         MafiaModel.specialEvent.sicilianEvent.parseProgressDetails(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityCityEventProgressRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityCityEventProgressResponse;
      }
   }
}
