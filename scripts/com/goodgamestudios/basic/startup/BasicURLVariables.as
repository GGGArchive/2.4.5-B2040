package com.goodgamestudios.basic.startup
{
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.utils.BrowserUtil;
   
   public class BasicURLVariables
   {
       
      
      private var _urlGetParameters:Object;
      
      public var selectedCountry:String;
      
      public var forceToShowTestServers:Boolean = false;
      
      public var websiteId:String = "0";
      
      public function BasicURLVariables()
      {
         super();
      }
      
      public function readGETVariablesFromURL() : void
      {
         this._urlGetParameters = BrowserUtil.getUrlVariables();
         if(!this._urlGetParameters)
         {
            return;
         }
         this.parseURLParameters();
      }
      
      private function parseURLParameters() : void
      {
         if(this._urlGetParameters && this._urlGetParameters[BasicConstants.COUNTRY_PARAMETER])
         {
            this.selectedCountry = this._urlGetParameters[BasicConstants.COUNTRY_PARAMETER];
         }
         if(this._urlGetParameters && this._urlGetParameters[BasicConstants.FORCE_TO_SHOW_TEST_SERVERS])
         {
            this.forceToShowTestServers = this._urlGetParameters[BasicConstants.FORCE_TO_SHOW_TEST_SERVERS];
         }
         if(this._urlGetParameters && this._urlGetParameters[BasicConstants.PARTNER_WEBSITE])
         {
            this.websiteId = this._urlGetParameters[BasicConstants.PARTNER_WEBSITE];
         }
      }
      
      public function hasParameters() : Boolean
      {
         var _loc1_:* = null;
         for(_loc1_ in this._urlGetParameters)
         {
            return true;
         }
         return false;
      }
      
      public function traceURLGetParameter(param1:String = "") : void
      {
         var _loc2_:* = null;
         trace("[url GET parameters] " + param1);
         for(_loc2_ in this._urlGetParameters)
         {
            trace("GET parameter: " + _loc2_ + " = " + this._urlGetParameters[_loc2_]);
         }
         trace("[/url GET parameters]");
      }
      
      public function get urlGetParameters() : Object
      {
         return this._urlGetParameters;
      }
   }
}
