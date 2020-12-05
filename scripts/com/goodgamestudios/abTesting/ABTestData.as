package com.goodgamestudios.abTesting
{
   import com.goodgamestudios.cookie.CookieHelper;
   import flash.net.SharedObject;
   
   public final class ABTestData
   {
      
      public static const STATUS_ALL_OK:int = 0;
      
      public static const STATUS_TIMEOUT_ERROR:int = 1;
      
      public static const STATUS_NOT_READY_ERROR:int = 2;
      
      static const TEST_ID:String = "t";
      
      static const CASE_ID:String = "c";
      
      static const CLIENT_ID:String = "ci";
      
      static const CONTENT:String = "content";
      
      static const ERROR_MSG:String = "errorMsg ";
      
      static const IS_VALID:String = "v";
      
      static const PLAYER_ID:String = "p";
      
      static const INSTANCE_ID:String = "i";
      
      static const NETWORK_ID:String = "n";
      
      static const GAME_ID:String = "g";
      
      static const REFERRER:String = "referrer";
      
      static const ACCOUNT_ID:String = "accountId";
      
      static const ERROR_CODE:String = "errorCode";
       
      
      private var _cookie:SharedObject;
      
      var _testID:uint = 0;
      
      var _caseID:uint = 0;
      
      var _clientID:String = "";
      
      var gameID:uint = 0;
      
      var instanceID:uint = 0;
      
      var networkID:uint = 0;
      
      var playerID:int = -1;
      
      var referrer:String = "";
      
      var content:String = "";
      
      var accountID:String = "";
      
      var errorMessage:String = "";
      
      var isValid:Boolean = false;
      
      var errorCode:int = 0;
      
      public function ABTestData()
      {
         super();
         this._cookie = SharedObject.getLocal("ABTest_" + this._testID + "_" + this.gameID,"/");
         if(CookieHelper.isCookieEmpty(this.cookie))
         {
            this.save();
         }
         else
         {
            this._testID = uint(this.cookie.data[TEST_ID]);
            this._caseID = uint(this.cookie.data[CASE_ID]);
            this.gameID = uint(this.cookie.data[GAME_ID]);
            this.instanceID = uint(this.cookie.data[INSTANCE_ID]);
            this.networkID = uint(this.cookie.data[NETWORK_ID]);
            this.playerID = uint(this.cookie.data[PLAYER_ID]);
            this.referrer = String(this.cookie.data[REFERRER]);
            this.accountID = String(this.cookie.data[ACCOUNT_ID]);
            this._clientID = String(this.cookie.data[CLIENT_ID]);
         }
      }
      
      public function get cookie() : SharedObject
      {
         return this._cookie;
      }
      
      public function get testID() : uint
      {
         return this._testID;
      }
      
      public function get caseID() : uint
      {
         return this._caseID;
      }
      
      public function get clientID() : String
      {
         return this._clientID;
      }
      
      public function save() : void
      {
         this.cookie.data[TEST_ID] = this._testID;
         this.cookie.data[CASE_ID] = this._caseID;
         this.cookie.data[CLIENT_ID] = this._clientID;
         this.cookie.data[GAME_ID] = this.gameID;
         this.cookie.data[INSTANCE_ID] = this.instanceID;
         this.cookie.data[NETWORK_ID] = this.networkID;
         this.cookie.data[PLAYER_ID] = this.playerID;
         this.cookie.data[REFERRER] = this.referrer;
         this.cookie.data[ACCOUNT_ID] = this.accountID;
         CookieHelper.checkAndSaveStatus(this.cookie);
      }
   }
}
