package com.goodgamestudios.mafia.model.components.user.ranking
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.ProtobufVOTranslator;
   import com.goodgamestudios.mafia.controller.commands.ranking.SearchRankingCommand;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchFamilyRankingEntry;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchResponse;
   import com.goodgamestudios.mafia.event.model.MafiaRankingEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.vo.clan.ClanRankingVO;
   import com.goodgamestudios.math.MathBase;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaFamilyRankingData
   {
      
      public static const RANKING_LIST_LENGTH:int = 8;
      
      public static const TOP_RANKING_LENGTH:int = 3;
      
      private static const LIST_UPDATE_DELAY:int = 60;
       
      
      public var topClans:Vector.<ClanRankingVO>;
      
      public var listClans:Vector.<ClanRankingVO>;
      
      public var listType:RankingListType;
      
      public var listUpdateTimeInSeconds:Number;
      
      private var clientHonorReduceBuffer:Number;
      
      public function MafiaFamilyRankingData()
      {
         this.topClans = new Vector.<ClanRankingVO>();
         this.listClans = new Vector.<ClanRankingVO>();
         this.listType = RankingListType.FamilyDynamic;
         super();
         this.clientHonorReduceBuffer = LIST_UPDATE_DELAY + Math.round(MathBase.random(1,30));
      }
      
      public function parseData(param1:PBRankingRankingSearchResponse) : void
      {
         var _loc5_:PBRankingRankingSearchFamilyRankingEntry = null;
         var _loc6_:ClanRankingVO = null;
         this.listType = ProtobufEnumTranslator.translateProtoRankingListType(param1.listType);
         if(param1.hasListUpdateTimeInSecs && param1.listUpdateTimeInSecs > 0)
         {
            this.listUpdateTimeInSeconds = getTimer() + (param1.listUpdateTimeInSecs + this.clientHonorReduceBuffer) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_CLAN_RANKING_TIME,[]));
            this.listUpdateTimeInSeconds = 0;
         }
         var _loc2_:Array = param1.familyRankList;
         var _loc3_:* = _loc2_.length == TOP_RANKING_LENGTH;
         if(_loc3_)
         {
            this.topClans = new Vector.<ClanRankingVO>();
         }
         else
         {
            this.listClans = new Vector.<ClanRankingVO>();
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_] as PBRankingRankingSearchFamilyRankingEntry;
            _loc6_ = this.parseClanRankingEntry(_loc5_);
            if(_loc3_)
            {
               this.topClans.push(_loc6_);
            }
            else
            {
               this.listClans.push(_loc6_);
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_CLAN_RANKING_TOP_DATA));
         }
         else
         {
            BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_CLAN_RANKING_LIST_DATA));
         }
      }
      
      private function parseClanRankingEntry(param1:PBRankingRankingSearchFamilyRankingEntry) : ClanRankingVO
      {
         var _loc2_:ClanRankingVO = new ClanRankingVO();
         _loc2_.rank = param1.rank;
         _loc2_.clanID = param1.id;
         _loc2_.name = param1.name;
         _loc2_.founderID = param1.leaderId;
         _loc2_.leader = param1.leaderName;
         _loc2_.member = param1.memberCount;
         _loc2_.glory = param1.glory;
         _loc2_.level = param1.level;
         _loc2_.attackClanWarTimeInSeconds = getTimer() + param1.attackFamilyWarTime * Constants_Basic.SEC2MILLISEC;
         _loc2_.attackClanWarTime = TimeStringHelper.getDateToString(new Date().getTime() + (_loc2_.attackClanWarTimeInSeconds - getTimer()),TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
         _loc2_.attackingClanName = param1.attackFamilyName;
         _loc2_.defendClanWarTimeInSeconds = getTimer() + param1.defenseFamilyWarTime * Constants_Basic.SEC2MILLISEC;
         _loc2_.defendClanWarTime = TimeStringHelper.getDateToString(new Date().getTime() + (_loc2_.defendClanWarTimeInSeconds - getTimer()),TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
         _loc2_.defendingClanName = param1.defenseFamilyName;
         if(param1.hasCrest)
         {
            _loc2_.crest = ProtobufVOTranslator.translateProtoFamilyCrest(param1.crest);
         }
         return _loc2_;
      }
      
      public function checkRankingUpdateTime(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.listUpdateTimeInSeconds - param1));
         BasicController.getInstance().dispatchEvent(new MafiaRankingEvent(MafiaRankingEvent.CHANGE_CLAN_RANKING_TIME,_loc2_));
         if(param1 > this.listUpdateTimeInSeconds)
         {
            if(MafiaLayoutManager.getInstance().currentState != Constants_LayoutStates.STATE_CLANRANKING)
            {
               return;
            }
            if(MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
            {
               _loc3_ = MafiaModel.userData.userClan.clanName;
            }
            else
            {
               _loc3_ = String(1);
            }
            SearchRankingCommand.sendCommand(this.listType,"1",TOP_RANKING_LENGTH);
            SearchRankingCommand.sendCommand(this.listType,_loc3_,RANKING_LIST_LENGTH);
         }
      }
   }
}
