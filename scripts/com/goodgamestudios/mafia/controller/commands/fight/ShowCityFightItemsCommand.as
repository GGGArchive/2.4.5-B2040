package com.goodgamestudios.mafia.controller.commands.fight
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.PBFightShowCityFightItemsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.PBFightShowCityFightItemsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.response.PBFightShowCityFightItemsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowCityFightItemsCommand extends BasicProtobufCommand
   {
       
      
      public function ShowCityFightItemsCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFightShowCityFightItemsRequest = new PBFightShowCityFightItemsRequest();
         _loc2_.districtId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightShowCityFightItemsResponse = param1 as PBFightShowCityFightItemsResponse;
         switch(_loc2_.result)
         {
            case PBFightShowCityFightItemsResult.OK:
               MafiaModel.userData.cityQuestFightData.parseCityFightItems(_loc2_.items,_loc2_.picId,_loc2_.level);
               return true;
            case PBFightShowCityFightItemsResult.CITY_FIGHT_INVALID:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightShowCityFightItemsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightShowCityFightItemsResponse;
      }
   }
}
