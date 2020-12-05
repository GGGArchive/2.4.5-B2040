package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.cookie.CookieHelper;
   import flash.net.SharedObject;
   
   public class BasicSharedObject
   {
       
      
      protected var so:SharedObject;
      
      public function BasicSharedObject()
      {
         super();
         this.readData();
      }
      
      public function writeData() : void
      {
         try
         {
            CookieHelper.checkAndSaveStatus(this.so);
            return;
         }
         catch(error:Error)
         {
            trace("Error...Could not write SharedObject to disk\n");
            return;
         }
      }
      
      public function readData() : void
      {
         this.so = SharedObject.getLocal(this.env.cookieName,"/");
      }
      
      public final function readLoginDataUsername() : String
      {
         if(this.so.data["username_" + this.readInstanceId()])
         {
            return this.so.data["username_" + this.readInstanceId()] as String;
         }
         if(this.so.data.username)
         {
            return this.so.data.username as String;
         }
         return "";
      }
      
      public final function readLoginDataEmail() : String
      {
         if(this.so.data["email_" + this.readInstanceId()])
         {
            return this.so.data["email_" + this.readInstanceId()] as String;
         }
         if(this.so.data.email)
         {
            return this.so.data.email as String;
         }
         return "";
      }
      
      public final function readLoginDataPass() : String
      {
         if(this.so.data["pass_" + this.readInstanceId()])
         {
            return this.decrypt(this.so.data["pass_" + this.readInstanceId()] as String);
         }
         if(this.so.data.pass)
         {
            return this.decrypt(this.so.data.pass as String);
         }
         return "";
      }
      
      public function readLoginDataSave() : Boolean
      {
         if(this.so.data.save)
         {
            return this.so.data.save == "true";
         }
         return false;
      }
      
      public function saveLoginDataSave() : void
      {
         this.so.data.save = "true";
      }
      
      public function readLoginDataLanguage() : String
      {
         if(this.so.data.language)
         {
            return this.so.data.language as String;
         }
         return "";
      }
      
      public function saveLoginData(param1:String, param2:String, param3:Boolean) : void
      {
         this.so.data["username_" + this.readInstanceId()] = param1;
         this.so.data["pass_" + this.readInstanceId()] = this.encrypt(param2);
         if(param1 == "")
         {
            this.so.data.username = param1;
            this.so.data.pass = this.encrypt(param2);
         }
         this.so.data.save = param3.toString();
         this.writeData();
      }
      
      public function saveLanguageData(param1:String) : void
      {
         this.so.data.language = param1;
         this.writeData();
      }
      
      public function saveCountryData(param1:String) : void
      {
         this.so.data.country = param1;
         this.writeData();
      }
      
      public function savePlayerID(param1:int) : void
      {
         this.so.data.playerID = param1;
         this.writeData();
      }
      
      public function readSelectedServer() : String
      {
         if(this.so.data.selectedServer)
         {
            return this.so.data.selectedServer as String;
         }
         return "";
      }
      
      public function saveSelectedServer(param1:String) : void
      {
         this.so.data.selectedServer = param1;
         this.writeData();
      }
      
      public function readSoundSettings() : Array
      {
         if(this.so.data.soundSettings)
         {
            return this.so.data.soundSettings as Array;
         }
         return null;
      }
      
      public function saveSoundSettings(param1:Array) : void
      {
         this.so.data.soundSettings = param1;
         this.writeData();
      }
      
      public function readInstanceId() : int
      {
         if(this.so.data.instanceId)
         {
            return this.so.data.instanceId as int;
         }
         return 0;
      }
      
      public function get hasInstanceId() : Boolean
      {
         if(this.so.data.instanceId)
         {
            return true;
         }
         return false;
      }
      
      public function saveInstanceId(param1:int) : void
      {
         if(param1 == -1)
         {
            param1 = 0;
         }
         this.so.data.instanceId = param1;
         this.writeData();
      }
      
      public function readComputerInstanceCookie() : int
      {
         if(this.so.data.computerinstance != null)
         {
            return this.so.data.computerinstance as int;
         }
         return -1;
      }
      
      public function saveComputerInstanceCookie(param1:int) : void
      {
         if(param1 >= 0)
         {
            this.so.data.computerinstance = param1;
            this.writeData();
         }
      }
      
      protected function encrypt(param1:String) : String
      {
         return this.invertString(param1);
      }
      
      protected function decrypt(param1:String) : String
      {
         return this.invertString(param1);
      }
      
      private function invertString(param1:String) : String
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(String.fromCharCode(param1.charCodeAt(_loc3_) ^ 255));
            _loc3_++;
         }
         return _loc2_.join("");
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
