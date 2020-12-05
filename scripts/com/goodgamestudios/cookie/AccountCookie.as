package com.goodgamestudios.cookie
{
   import flash.net.SharedObject;
   
   public class AccountCookie
   {
      
      public static const NAME:String = "GGSAccount";
       
      
      private var so:SharedObject;
      
      private var _isNewAccount:Boolean = false;
      
      private var _campaignData:Object;
      
      public function AccountCookie(param1:SharedObject)
      {
         super();
         if(!param1)
         {
            throw new Error("Cookie must not be null!");
         }
         this.so = param1;
      }
      
      public function get isNewAccount() : Boolean
      {
         return this._isNewAccount;
      }
      
      public function get accountId() : String
      {
         if(!this.so.data.accountId)
         {
            this._isNewAccount = true;
            this.so.data.accountId = new Date().time.toString() + (Math.random() * 999999).toFixed();
         }
         this._campaignData = !!this.so.data.campaignData?this.so.data.campaignData:null;
         this.so.data.campaignData = null;
         try
         {
            CookieHelper.checkAndSaveStatus(this.so);
         }
         catch(e:Error)
         {
            throw Error("AccountCookie -> Saving Account-Cookie failed!");
         }
         return this.so.data.accountId;
      }
      
      public function get campaignData() : Object
      {
         return this._campaignData;
      }
      
      public function set campaignData(param1:Object) : void
      {
         this._campaignData = param1;
      }
   }
}
