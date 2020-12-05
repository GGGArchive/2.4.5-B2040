package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.event.MafiaBuddyEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.BuddyVO;
   import flash.events.EventDispatcher;
   
   public class MafiaBuddyList extends EventDispatcher
   {
      
      private static const DELIMITER1:String = "|||";
      
      private static const DELIMITER2:String = "|";
      
      private static const INGAMEBUDDIES:int = 0;
       
      
      private var flashVarBuddyData:String = "";
      
      private var _preSocialBuddies:Array;
      
      private var _completeSocialBuddies:Array;
      
      public function MafiaBuddyList(param1:String = null)
      {
         super();
         this.flashVarBuddyData = param1;
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
      }
      
      public function getSocialBuddyData() : void
      {
         var _loc6_:BuddyVO = null;
         this._preSocialBuddies = [];
         this._completeSocialBuddies = [];
         var _loc1_:Array = new Array();
         if(this.flashVarBuddyData)
         {
            _loc1_ = this.flashVarBuddyData.split(DELIMITER1);
         }
         if(!this.flashVarBuddyData || this.flashVarBuddyData == "" || _loc1_[0] == "")
         {
            dispatchEvent(new MafiaBuddyEvent(MafiaBuddyEvent.CHANGE_BUDDYDATA));
            return;
         }
         var _loc2_:Array = _loc1_[0].split(DELIMITER2);
         if(_loc2_[0] == "")
         {
            return;
         }
         var _loc3_:Array = _loc1_[1].split(DELIMITER2);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = new BuddyVO();
            _loc6_.pln = String(_loc2_[_loc4_]);
            _loc6_.thumbUrl = _loc3_[_loc4_];
            this._preSocialBuddies.push(_loc6_);
            _loc4_++;
         }
         var _loc5_:String = String(_loc1_[0]).split("|").join("!");
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SOCIAL_BUDDIES,[_loc5_]);
      }
      
      public function addSocialBuddies(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:BuddyVO = null;
         param1.shift();
         var _loc2_:Array = String(param1.shift()).split("#");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.split("+");
            _loc5_ = parseInt(_loc4_.shift());
            _loc6_ = String(_loc4_.shift());
            for each(_loc7_ in this._preSocialBuddies)
            {
               if(_loc7_.pln == _loc6_)
               {
                  _loc7_.playerId = _loc5_;
                  _loc7_.isSocialFriend = true;
                  this._completeSocialBuddies.push(_loc7_);
               }
            }
         }
         this._completeSocialBuddies.sortOn("playerLevel",Array.NUMERIC | Array.DESCENDING);
         dispatchEvent(new MafiaBuddyEvent(MafiaBuddyEvent.CHANGE_BUDDYDATA));
      }
      
      public function addSocialBuddyAvatarInfo(param1:Array) : void
      {
         var _loc2_:BuddyVO = null;
         param1.shift();
         for each(_loc2_ in this._completeSocialBuddies)
         {
            if(_loc2_.playerId == param1[0])
            {
               param1.shift();
               _loc2_.playerName = param1.shift();
               _loc2_.playerLevel = param1.shift();
               _loc2_.playerGender = CharacterGender.getById(param1.shift());
               _loc2_.picString = param1.shift();
               _loc2_.characterClass = CharacterClass.getById(param1.shift());
               _loc2_.playerRank = param1.shift();
               dispatchEvent(new MafiaBuddyEvent(MafiaBuddyEvent.CHANGE_BUDDYAVATARDATA,[_loc2_]));
            }
         }
      }
      
      public function getBuddyByPlayerId(param1:int) : BuddyVO
      {
         var _loc2_:BuddyVO = null;
         for each(_loc2_ in this.socialBuddyList)
         {
            if(_loc2_.playerId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get socialBuddyList() : Array
      {
         return this._completeSocialBuddies;
      }
      
      public function get amountSocialFriends() : int
      {
         return this._completeSocialBuddies.length;
      }
   }
}
