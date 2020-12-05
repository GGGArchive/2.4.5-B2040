package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response.PBMessageReadMessagesClanInvitation;
   import com.goodgamestudios.mafia.controller.protobuf.message.shownews.response.PBMessageShowNewsMessage;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.NewsVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.clan.ClanInvitiationVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaMessageData
   {
      
      public static const LISTTYPE_TEXT:int = 1;
      
      public static const LISTTYPE_FIGHT:int = 2;
       
      
      public var newMessages:int;
      
      public var readMessagesData:MafiaReadMsgData;
      
      public var normalMessages:Vector.<NewsVO>;
      
      public var fightMessages:Vector.<NewsVO>;
      
      public var clanInvitiationVO:ClanInvitiationVO;
      
      public var replayFightData:MafiaFightResultData;
      
      public var duelResultLogData:MafiaFightResultData;
      
      public var nextMailRefreshTime:int;
      
      public var reward:RewardVO;
      
      public function MafiaMessageData()
      {
         super();
         this.normalMessages = new Vector.<NewsVO>();
         this.fightMessages = new Vector.<NewsVO>();
         this.readMessagesData = new MafiaReadMsgData();
      }
      
      public function parseNewMessages(param1:int) : void
      {
         this.newMessages = param1;
         if(this.newMessages > 0)
         {
            BasicController.getInstance().dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_NEWNEWSDATA));
         }
      }
      
      public function parseMessages(param1:Array) : void
      {
         var _loc8_:PBMessageShowNewsMessage = null;
         var _loc9_:NewsVO = null;
         this.nextMailRefreshTime = getTimer() + 5000;
         var _loc2_:Array = param1;
         var _loc3_:Date = new Date();
         var _loc4_:Number = Math.round(_loc3_.getTime() / 1000);
         this.normalMessages = new Vector.<NewsVO>();
         this.fightMessages = new Vector.<NewsVO>();
         this.newMessages = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc8_ = _loc2_[_loc7_] as PBMessageShowNewsMessage;
            _loc9_ = new NewsVO();
            _loc9_.msgID = _loc8_.messageID;
            _loc9_.msgType = ProtobufEnumTranslator.translateProtoMessageType(_loc8_.messageType);
            _loc9_.fromPlayerID = _loc8_.fromplayerID;
            _loc9_.fromPlayerName = _loc8_.fromPlayerName;
            _loc9_.secondTillSend = _loc8_.secondSinceSend;
            _loc9_.sendDate = TimeStringHelper.getDateToString((_loc4_ - _loc9_.secondTillSend) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_DAY_FORMAT,MafiaModel.languageData.getTextById);
            _loc9_.sendDate = _loc9_.sendDate + (" " + TimeStringHelper.getDateToString((_loc4_ - _loc9_.secondTillSend) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById));
            if(_loc9_.msgType == MessageType.FightWon || _loc9_.msgType == MessageType.FightLost)
            {
               _loc9_.listPos = _loc6_;
               _loc6_++;
               _loc9_.listType = LISTTYPE_FIGHT;
               this.fightMessages.push(_loc9_);
            }
            else
            {
               _loc9_.listPos = _loc5_;
               _loc5_++;
               _loc9_.listType = LISTTYPE_TEXT;
               this.normalMessages.push(_loc9_);
            }
            _loc7_++;
         }
         this.normalMessages.sort(this.sortNews);
         this.fightMessages.sort(this.sortNews);
         this.reOrgNews();
         BasicController.getInstance().dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_NEWSDATA));
         BasicController.getInstance().dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_NEWNEWSDATA));
      }
      
      private function sortNews(param1:NewsVO, param2:NewsVO) : Number
      {
         if(param1.secondTillSend < param2.secondTillSend)
         {
            return -1;
         }
         if(param1.secondTillSend > param2.secondTillSend)
         {
            return 1;
         }
         return 0;
      }
      
      public function checkNextMailRefreshTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         if(param1 >= this.nextMailRefreshTime)
         {
            _loc2_[0] = -1;
            this.nextMailRefreshTime = 0;
         }
         else
         {
            _loc2_[0] = TimeStringHelper.getShortTimeString(this.nextMailRefreshTime - param1);
         }
         BasicController.getInstance().dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_MAILREFRESHTIME,_loc2_));
      }
      
      public function deleteMsg(param1:int, param2:int) : void
      {
         if(param2 == 1)
         {
            this.normalMessages.splice(param1,1);
         }
         else
         {
            this.fightMessages.splice(param1,1);
         }
         this.reOrgNews();
      }
      
      private function reOrgNews() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.normalMessages.length)
         {
            this.normalMessages[_loc1_].listPos = _loc1_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.fightMessages.length)
         {
            this.fightMessages[_loc1_].listPos = _loc1_;
            _loc1_++;
         }
      }
      
      public function parseMsg(param1:Array) : void
      {
      }
      
      public function parseClanwarInvitation(param1:PBMessageReadMessagesClanInvitation) : void
      {
         this.clanInvitiationVO = new ClanInvitiationVO();
         this.clanInvitiationVO.clanID = param1.clanId;
         this.clanInvitiationVO.clanName = param1.clanName;
         this.clanInvitiationVO.invitiationHashCode = param1.invitationHashCode;
      }
      
      public function parseText(param1:String) : void
      {
         this.readMessagesData.readMsgText = param1.replace(/&percnt;/g,"%");
      }
      
      public function setDopplerCount(param1:int) : void
      {
         this.readMessagesData.doppler_count = param1;
      }
      
      public function parseReplayFightData(param1:PBFight, param2:PBReward) : void
      {
         this.replayFightData = new MafiaFightResultData();
         this.duelResultLogData = new MafiaFightResultData();
         this.replayFightData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.replayFightData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         this.replayFightData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.replayFightData.isLeftFighterWinner = param1.winner == MafiaFightResultData.FIGHTER_LEFT;
         this.duelResultLogData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.duelResultLogData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.duelResultLogData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.duelResultLogData.isLeftFighterWinner = param1.winner == MafiaFightResultData.FIGHTER_LEFT;
         this.duelResultLogData.left_ammunition = MafiaFightDataParser.parseFightAmmunition(param1.leftAmmunition);
         this.duelResultLogData.right_ammunition = MafiaFightDataParser.parseFightAmmunition(param1.rightAmmunition);
      }
   }
}
