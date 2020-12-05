package com.goodgamestudios.mafia.model.components.user.ranking
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchPlayerRankingEntry;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchResponse;
   import com.goodgamestudios.mafia.event.model.MafiaRankingEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.PlayerRankingVO;
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaPlayerRankingData
   {
      
      public static const RANKING_LIST_LENGTH:int = 8;
      
      public static const TOP_RANKING_LENGTH:int = 3;
      
      private static const LIST_UPDATE_DELAY:int = 60;
       
      
      public var players:Vector.<PlayerRankingVO>;
      
      public var topThreePlayers:Vector.<PlayerRankingVO>;
      
      public var listType:RankingListType;
      
      public var listUpdateTimeInSeconds:Number;
      
      private var clientHonorReduceBuffer:Number;
      
      public function MafiaPlayerRankingData()
      {
         this.players = new Vector.<PlayerRankingVO>(3);
         this.topThreePlayers = new Vector.<PlayerRankingVO>();
         this.listType = RankingListType.PlayerDynamic;
         super();
         this.clientHonorReduceBuffer = LIST_UPDATE_DELAY + Math.round(MathBase.random(1,30));
         this.topThreePlayers = new Vector.<PlayerRankingVO>();
         this.topThreePlayers.push(null,null,null);
      }
      
      public function parseData(param1:PBRankingRankingSearchResponse) : void
      {
         var _loc5_:PBRankingRankingSearchPlayerRankingEntry = null;
         var _loc6_:PlayerRankingVO = null;
         this.listType = ProtobufEnumTranslator.translateProtoRankingListType(param1.listType);
         if(param1.hasListUpdateTimeInSecs && param1.listUpdateTimeInSecs > 0)
         {
            this.listUpdateTimeInSeconds = getTimer() + (param1.listUpdateTimeInSecs + this.clientHonorReduceBuffer) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_PLAYER_RANKING_TIME,[]));
            this.listUpdateTimeInSeconds = 0;
         }
         var _loc2_:Array = param1.playerRankList;
         var _loc3_:* = _loc2_.length <= TOP_RANKING_LENGTH;
         if(!_loc3_)
         {
            if(this.players.length == 12)
            {
               this.players = this.players.slice(0,2);
            }
            else
            {
               this.players = new Vector.<PlayerRankingVO>();
            }
            MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_PLAYERRANKING;
         }
         else
         {
            _loc2_.reverse();
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_] as PBRankingRankingSearchPlayerRankingEntry;
            _loc6_ = new PlayerRankingVO();
            _loc6_.rank = _loc5_.rank;
            _loc6_.playerID = _loc5_.id;
            _loc6_.name = _loc5_.name;
            _loc6_.characterClass = CharacterClass.getById(_loc5_.typeId);
            _loc6_.clanID = _loc5_.familyId;
            _loc6_.clanName = _loc5_.familyName;
            _loc6_.level = _loc5_.level;
            _loc6_.glory = _loc5_.glory;
            if(!_loc3_)
            {
               this.players.push(_loc6_);
            }
            else
            {
               if(this.topThreePlayers[_loc4_])
               {
                  if(this.topThreePlayers[_loc4_].rank == _loc6_.rank)
                  {
                     if(this.topThreePlayers[_loc4_].playerID != _loc6_.playerID || this.topThreePlayers[_loc4_].glory != _loc6_.glory)
                     {
                        this.topThreePlayers[_loc4_] = _loc6_;
                        PlayerProfileCommand.sendCommand(_loc6_.playerID,true);
                     }
                  }
               }
               else
               {
                  this.topThreePlayers[_loc4_] = _loc6_;
                  PlayerProfileCommand.sendCommand(_loc6_.playerID,true);
               }
               if(_loc4_ == _loc2_.length - 1)
               {
                  return;
               }
            }
            _loc4_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_PLAYERRANKINGDATA));
      }
      
      public function checkRankingUpdateTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.listUpdateTimeInSeconds - param1));
         BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_PLAYER_RANKING_TIME,_loc2_));
         if(param1 > this.listUpdateTimeInSeconds)
         {
            if(MafiaLayoutManager.getInstance().currentState != Constants_LayoutStates.STATE_PLAYERRANKING)
            {
               return;
            }
            SearchRankingCommand.sendCommand(this.listType,"1",TOP_RANKING_LENGTH);
            SearchRankingCommand.sendCommand(this.listType,MafiaModel.userData.profileData.name,RANKING_LIST_LENGTH);
         }
      }
   }
}
