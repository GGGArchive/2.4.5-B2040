package com.goodgamestudios.mafia.controller.commands.ranking
{
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchRequest;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchResponse;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.response.PBRankingRankingSearchResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SearchRankingCommand extends BasicProtobufCommand
   {
       
      
      public function SearchRankingCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:RankingListType, param2:String, param3:int) : void
      {
         var _loc4_:PBRankingRankingSearchRequest = new PBRankingRankingSearchRequest();
         _loc4_.listType = ProtobufEnumTranslator.translateRankingListTypeToProto(param1);
         _loc4_.listSize = param3;
         _loc4_.value = param2;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBRankingRankingSearchResponse = null;
         var _loc3_:RankingListType = null;
         _loc2_ = param1 as PBRankingRankingSearchResponse;
         switch(_loc2_.result)
         {
            case PBRankingRankingSearchResult.OK:
               _loc3_ = ProtobufEnumTranslator.translateProtoRankingListType(_loc2_.listType);
               switch(_loc3_)
               {
                  case RankingListType.PlayerDynamic:
                  case RankingListType.PlayerAlltime:
                     MafiaModel.userData.playerRankingData.parseData(_loc2_);
                     break;
                  case RankingListType.FamilyDynamic:
                  case RankingListType.FamilyAlltime:
                     MafiaModel.userData.familyRankingData.parseData(_loc2_);
                     break;
                  default:
                     return false;
               }
               return true;
            case PBRankingRankingSearchResult.INVALID_PARAMETER_VALUE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBRankingRankingSearchRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBRankingRankingSearchResponse;
      }
   }
}
