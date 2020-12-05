package com.goodgamestudios.basic.model.vo
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   
   public final class InstanceVO
   {
       
      
      public var countries:Vector.<AbstractGGSCountry>;
      
      public var ip:String;
      
      public var port:int;
      
      public var zone:String;
      
      public var instanceId:int;
      
      public var serverName:String = "";
      
      public var maintenance:Boolean;
      
      public var instanceCountID:int = 0;
      
      public var isTestServer:Boolean = false;
      
      public var isInternationalServer:Boolean = false;
      
      public var defaultcountry:String;
      
      public var isFavorite:Boolean;
      
      public var instanceLocaId:String = "";
      
      public function InstanceVO()
      {
         this.countries = new Vector.<AbstractGGSCountry>();
         super();
      }
      
      public function get numCountries() : uint
      {
         return this.countries.length;
      }
      
      public function get isInternationalInstance() : Boolean
      {
         return this.isInternationalServer;
      }
   }
}
