package com.goodgamestudios.mafia.controller.commands.fight
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfight.PBFightShowCityFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfight.PBFightShowCityFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfight.response.PBFightShowCityFightResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowCityFightCommand extends BasicProtobufCommand
   {
       
      
      public function ShowCityFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFightShowCityFightRequest = new PBFightShowCityFightRequest();
         _loc2_.districtId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:PBFightShowCityFightResponse = param1 as PBFightShowCityFightResponse;
         switch(_loc2_.result)
         {
            case PBFightShowCityFightResult.OK:
               _loc3_ = 0;
               if(_loc2_.hasNextFreeFight)
               {
                  _loc3_ = _loc2_.nextFreeFight;
               }
               MafiaModel.userData.cityQuestFightData.parseCityFight(_loc2_.picId,_loc2_.level,_loc3_);
               return true;
            case PBFightShowCityFightResult.CITY_FIGHT_INVALID:
               break;
            case PBFightShowCityFightResult.CITY_FIGHT_UNAVAILABLE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightShowCityFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightShowCityFightResponse;
      }
   }
}
