package com.goodgamestudios.mafia.controller.commands.travels
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.PBTravelShowTravelPossibilitiesRequest;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.PBTravelShowTravelPossibilitiesResponse;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.response.PBTravelShowTravelPossibilitiesResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowTravelPossibilitiesCommand extends BasicProtobufCommand
   {
       
      
      public function ShowTravelPossibilitiesCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBTravelShowTravelPossibilitiesRequest = new PBTravelShowTravelPossibilitiesRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBTravelShowTravelPossibilitiesResponse = param1 as PBTravelShowTravelPossibilitiesResponse;
         switch(_loc2_.result)
         {
            case PBTravelShowTravelPossibilitiesResult.OK:
               MafiaModel.userData.travelsData.parseTravelPossibilitiesData(_loc2_);
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBTravelShowTravelPossibilitiesRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBTravelShowTravelPossibilitiesResponse;
      }
   }
}
