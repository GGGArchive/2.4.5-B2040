package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   
   public class BuddyVO
   {
       
      
      public var thumbUrl:String = "";
      
      public var isSocialFriend:Boolean;
      
      private var _pln:String;
      
      private var _playerId:Number;
      
      private var _playerName:String = "";
      
      private var _playerLevel:Number;
      
      private var _picString:String;
      
      private var _rank:int;
      
      private var _characterClass:CharacterClass;
      
      private var _gender:CharacterGender;
      
      public function BuddyVO()
      {
         super();
      }
      
      public function get playerId() : int
      {
         return this._playerId;
      }
      
      public function set playerId(param1:int) : void
      {
         this._playerId = param1;
      }
      
      public function get userId() : int
      {
         return -1;
      }
      
      public function set userId(param1:int) : void
      {
      }
      
      public function set playerName(param1:String) : void
      {
         this._playerName = param1;
      }
      
      public function get playerName() : String
      {
         return this._playerName;
      }
      
      public function set playerLevel(param1:int) : void
      {
         this._playerLevel = param1;
      }
      
      public function get playerLevel() : int
      {
         return this._playerLevel;
      }
      
      public function isEqual(param1:int, param2:int) : Boolean
      {
         if(param1 >= 0)
         {
            return this.playerId == param1;
         }
         return this.userId == param2;
      }
      
      public function get pln() : String
      {
         return this._pln;
      }
      
      public function set pln(param1:String) : void
      {
         this._pln = param1;
      }
      
      public function get picString() : String
      {
         return this._picString;
      }
      
      public function set picString(param1:String) : void
      {
         this._picString = param1;
      }
      
      public function get characterClass() : CharacterClass
      {
         return this._characterClass;
      }
      
      public function set characterClass(param1:CharacterClass) : void
      {
         this._characterClass = param1;
      }
      
      public function get playerRank() : int
      {
         return this._rank;
      }
      
      public function set playerRank(param1:int) : void
      {
         this._rank = param1;
      }
      
      public function get playerGender() : CharacterGender
      {
         return this._gender;
      }
      
      public function set playerGender(param1:CharacterGender) : void
      {
         this._gender = param1;
      }
   }
}
