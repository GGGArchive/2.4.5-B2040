package com.goodgamestudios.marketing.google
{
   public class CampaignVarsVO
   {
      
      public static const SOURCE_URL_PARAMETER:String = "urlParameter";
      
      public static const SOURCE_ACCOUNT_COOKIE:String = "accountCookie";
       
      
      public var data:Object;
      
      public var contextDescription:String;
      
      public var clientObjectClassName:String;
      
      public function CampaignVarsVO(param1:Object, param2:String, param3:String)
      {
         super();
         this.data = param1;
         this.contextDescription = param3;
         this.clientObjectClassName = param2;
      }
   }
}
