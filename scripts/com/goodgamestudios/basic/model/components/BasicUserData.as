package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.externalLogging.ExternalLog;
   
   public class BasicUserData
   {
      
      public static const DEFAULT_USER_NAME:String = "user1";
      
      public static const DEFAULT_LOGIN_NAME:String = "user2";
      
      public static const DEFAULT_PW:String = "pass";
       
      
      protected var _userName:String = "user1";
      
      protected var _loginName:String = "user2";
      
      protected var _loginPwd:String = "pass";
      
      protected var _email:String = "";
      
      protected var _userID:int = -1;
      
      protected var _playerID:int = -1;
      
      public function BasicUserData()
      {
         super();
      }
      
      public function isGuest() : Boolean
      {
         return this.playerID == -1;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get userNameSet() : Boolean
      {
         return this._userName.length > 0 || this._userName != "";
      }
      
      public function set userName(param1:String) : void
      {
         this._userName = param1;
      }
      
      public function get loginName() : String
      {
         return this._loginName;
      }
      
      public function set loginName(param1:String) : void
      {
         this._loginName = param1;
      }
      
      public function get loginPwd() : String
      {
         return this._loginPwd;
      }
      
      public function set loginPwd(param1:String) : void
      {
         this._loginPwd = param1;
      }
      
      public function get email() : String
      {
         return this._email;
      }
      
      public function set email(param1:String) : void
      {
         this._email = param1;
      }
      
      public function get userID() : int
      {
         return this._userID;
      }
      
      public function set userID(param1:int) : void
      {
         this._userID = param1;
      }
      
      public function get playerID() : int
      {
         return this._playerID;
      }
      
      public final function set playerID(param1:int) : void
      {
         this._playerID = param1;
         BasicModel.localData.savePlayerID(param1);
         ExternalLog.playerId = this._playerID;
         ExternalLog.networkId = EnvGlobalsHandler.globals.networkId;
      }
   }
}
