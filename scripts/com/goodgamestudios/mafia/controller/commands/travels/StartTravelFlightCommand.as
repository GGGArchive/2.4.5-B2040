package com.goodgamestudios.mafia.controller.commands.travels
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.travel.starttravelflight.PBTravelStartTravelFlightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.travel.starttravelflight.PBTravelStartTravelFlightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.travel.starttravelflight.response.PBTravelStartTravelFlightResult;
   import com.goodgamestudios.mafia.view.panels.MafiaChooseTravelPanel;
   import com.netease.protobuf.Message;
   
   public class StartTravelFlightCommand extends BasicProtobufCommand
   {
       
      
      public function StartTravelFlightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBTravelStartTravelFlightRequest = new PBTravelStartTravelFlightRequest();
         _loc2_.target = ProtobufEnumTranslator.translateCityToProto(param1);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBTravelStartTravelFlightResponse = param1 as PBTravelStartTravelFlightResponse;
         switch(_loc2_.result)
         {
            case PBTravelStartTravelFlightResult.OK:
               layoutManager.hidePanel(MafiaChooseTravelPanel.NAME);
               return true;
            case PBTravelStartTravelFlightResult.NOT_ENOUGH_ENERGY:
               break;
            case PBTravelStartTravelFlightResult.NOT_FREE:
               break;
            case PBTravelStartTravelFlightResult.TARGET_IS_ORIGIN:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBTravelStartTravelFlightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBTravelStartTravelFlightResponse;
      }
   }
}
