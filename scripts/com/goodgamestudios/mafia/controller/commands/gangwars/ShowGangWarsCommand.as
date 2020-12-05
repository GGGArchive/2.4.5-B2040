package com.goodgamestudios.mafia.controller.commands.gangwars
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.PBGangwarShowGangWarsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.PBGangwarShowGangWarsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response.PBGangwarShowGangWarsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowGangWarsCommand extends BasicProtobufCommand
   {
       
      
      public function ShowGangWarsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBGangwarShowGangWarsRequest = new PBGangwarShowGangWarsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBGangwarShowGangWarsResponse = param1 as PBGangwarShowGangWarsResponse;
         switch(_loc2_.result)
         {
            case PBGangwarShowGangWarsResult.OK:
               MafiaModel.userData.gangwarData.parseData(_loc2_.gangWars,_loc2_.city,_loc2_.recruitedFriends);
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBGangwarShowGangWarsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBGangwarShowGangWarsResponse;
      }
   }
}
