package com.goodgamestudios.marketing.google
{
   public class CampaignVars
   {
      
      public static const PARTNER_ID:String = "pid";
      
      public static const CHANNEL_ID:String = "cid";
      
      public static const TRAFFIC_SOURCE:String = "tid";
      
      public static const CREATIVE:String = "creative";
      
      public static const PLACEMENT:String = "placement";
      
      public static const KEYWORD:String = "keyword";
      
      public static const NETWORK:String = "network";
      
      public static const LP:String = "lp";
      
      public static const AID:String = "aid";
      
      public static const CAMP:String = "camp";
      
      public static const ADGR:String = "adgr";
      
      public static const MATCHTYPE:String = "matchtype";
      
      public static const LANGUAGE:String = "lang";
      
      public static const COUNTRY:String = "country";
       
      
      private var _partnerId:String = "-1";
      
      private var _channelId:String = "";
      
      private var _trafficSource:String = "";
      
      private var _creative:String = "-1";
      
      private var _placement:String = "";
      
      private var _keyword:String = "";
      
      private var _network:String = "";
      
      private var _lp:String = "-1";
      
      private var _aid:String = "-1";
      
      private var _camp:String = "";
      
      private var _adgr:String = "";
      
      private var _matchtype:String = "";
      
      private var _lang:String = "";
      
      private var _country:String = "";
      
      private var _initialized:Boolean;
      
      public function CampaignVars()
      {
         super();
      }
      
      public function initialize(param1:CampaignVarsVO) : void
      {
         var l_pid:String = null;
         var l_cid:String = null;
         var l_trafficSource:String = null;
         var l_creative:Number = NaN;
         var l_placement:String = null;
         var l_keyword:String = null;
         var l_network:String = null;
         var l_lp:Number = NaN;
         var l_aid:Number = NaN;
         var l_camp:String = null;
         var l_adgr:String = null;
         var l_matchtype:String = null;
         var l_lang:String = null;
         var l_country:String = null;
         var campaignVarsVO:CampaignVarsVO = param1;
         var vars:Object = campaignVarsVO.data;
         if(!vars)
         {
            trace("CampaignVars, initialize(): vars are null");
            return;
         }
         if(this._initialized)
         {
            return;
         }
         try
         {
            l_pid = vars[PARTNER_ID];
            this._partnerId = l_pid && l_pid != ""?l_pid:this._partnerId;
            l_cid = vars[CHANNEL_ID];
            this._channelId = l_cid && l_cid != ""?l_cid:this._channelId;
            l_trafficSource = vars[TRAFFIC_SOURCE];
            this._trafficSource = l_trafficSource && l_trafficSource != ""?l_trafficSource:this._trafficSource;
            l_creative = Number(vars[CREATIVE]);
            this._creative = !isNaN(l_creative) && l_creative > 0?l_creative.toString():this._creative;
            l_placement = vars[PLACEMENT];
            this._placement = l_placement && l_placement != ""?l_placement:this._placement;
            l_keyword = vars[KEYWORD];
            this._keyword = l_keyword && l_keyword != ""?l_keyword:this._keyword;
            l_network = vars[NETWORK];
            this._network = l_network && l_network != ""?l_network:this._network;
            l_lp = Number(vars[LP]);
            this._lp = !isNaN(l_lp) && l_lp > 0?l_lp.toString():this._lp;
            l_aid = Number(vars[AID]);
            this._aid = !isNaN(l_aid) && l_aid > 0?l_aid.toString():this._aid;
            l_camp = vars[CAMP];
            this._camp = l_camp && l_camp != ""?l_camp:this._camp;
            l_adgr = vars[ADGR];
            this._adgr = l_adgr && l_adgr != ""?l_adgr:this._adgr;
            l_matchtype = vars[MATCHTYPE];
            this._matchtype = l_matchtype && l_matchtype != ""?l_matchtype:this._matchtype;
            l_lang = vars[LANGUAGE];
            this._lang = l_lang && l_lang != ""?l_lang:this._lang;
            l_country = vars[COUNTRY];
            this._country = l_country && l_country != ""?l_country:this._country;
            if(this.isValid())
            {
               this._initialized = true;
            }
            return;
         }
         catch(e:Error)
         {
            trace("Failed constructing campaign vars.");
            return;
         }
      }
      
      public function toString() : String
      {
         return "partnerId: " + this._partnerId + ", channelId: " + this._channelId + ", trafficSource: " + this._trafficSource + ", creative: " + this._creative + ", placement: " + this._placement + ", keyword: " + this._keyword + ", network: " + this._network + ", lp: " + this._lp + ", aid: " + this._aid + ", camp: " + this._camp + ", adgr: " + this._adgr + ", matchtype: " + this._matchtype + ", lang: " + this._lang + ", country: " + this._country;
      }
      
      public function get channelId() : String
      {
         if(this._channelId)
         {
            return this._channelId;
         }
         return "";
      }
      
      public function set channelId(param1:String) : void
      {
         this._channelId = param1;
      }
      
      public function get trafficSource() : String
      {
         if(this._trafficSource)
         {
            return this._trafficSource;
         }
         return "";
      }
      
      public function set trafficSource(param1:String) : void
      {
         this._trafficSource = param1;
      }
      
      public function get partnerId() : String
      {
         if(this._partnerId)
         {
            return this._partnerId;
         }
         return "-1";
      }
      
      public function get creative() : String
      {
         if(this._creative)
         {
            return this._creative;
         }
         return "-1";
      }
      
      public function get placement() : String
      {
         if(this._placement)
         {
            return this._placement;
         }
         return "";
      }
      
      public function get keyword() : String
      {
         if(this._keyword)
         {
            return this._keyword;
         }
         return "";
      }
      
      public function get network() : String
      {
         if(this._network)
         {
            return this._network;
         }
         return "";
      }
      
      public function get lp() : String
      {
         if(this._lp)
         {
            return this._lp;
         }
         return "-1";
      }
      
      public function set lp(param1:String) : void
      {
         this._lp = param1;
      }
      
      public function isValid() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = parseInt(this._partnerId);
         if(!isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get aid() : String
      {
         if(this._aid)
         {
            return this._aid;
         }
         return "-1";
      }
      
      public function get camp() : String
      {
         if(this._camp)
         {
            return this._camp;
         }
         return "";
      }
      
      public function get adgr() : String
      {
         if(this._adgr)
         {
            return this._adgr;
         }
         return "";
      }
      
      public function get matchtype() : String
      {
         if(this._matchtype)
         {
            return this._matchtype;
         }
         return "";
      }
      
      public function get lang() : String
      {
         return this._lang;
      }
      
      public function get country() : String
      {
         return this._country;
      }
   }
}
