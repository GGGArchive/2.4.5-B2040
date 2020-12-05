package com.goodgamestudios.basic
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.basic.startup.BasicFlashVariables;
   import com.goodgamestudios.basic.startup.BasicJSVariables;
   import com.goodgamestudios.basic.startup.BasicURLVariables;
   import com.goodgamestudios.basic.version.BasicVersions;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.cookie.AccountCookie;
   import com.goodgamestudios.marketing.google.CampaignVars;
   import com.goodgamestudios.marketing.google.CampaignVarsVO;
   import flash.utils.Dictionary;
   
   public class BasicEnvironmentGlobals implements IEnvironmentGlobals
   {
      
      private static var _network:int;
      
      private static var _presetInstanceId:int;
      
      private static var _forceInstanceConnect:Boolean = false;
      
      private static var _defaultInstance:int;
      
      private static var _distributorId:String = "";
      
      private static var _referrer:String = "";
      
      private static var _invitedBy:String;
      
      private static var _isTest:Boolean;
      
      private static var _isDevTest:Boolean;
      
      private static var _isUsabilityTest:Boolean;
      
      private static var _isPreClient:Boolean;
      
      private static var _isLocal:Boolean;
      
      private static var _baseURL:String;
      
      private static var _accountId:String;
      
      private static var _accessKey:String;
      
      private static var _campainVars:CampaignVars;
      
      private static var _urlVariables:BasicURLVariables;
      
      private static var _flashVars:BasicFlashVariables;
      
      private static var _jsVariables:BasicJSVariables;
      
      private static var _gender:String;
      
      private static var _displayName:String;
      
      private static var _langVersionDict:Dictionary;
      
      private static var _hasNetworkBuddies:Boolean;
      
      private static var _networknameString:String;
      
      private static var _enableFeedMessages:Boolean;
      
      private static var _enablelonelyCow:Boolean;
      
      private static var _requestPayByJS:Boolean;
      
      private static var _networkNewsByJS:Boolean;
      
      private static var _earnCredits:int;
      
      private static var _allowedfullscreen:Boolean;
      
      private static var _loginIsKeyBased:Boolean;
      
      private static var _useexternallinks:Boolean;
      
      private static var _invitefriends:Boolean;
      
      private static var _minUsernameLength:int;
      
      private static var _maxUsernameLength:int;
      
      private static var _usePayment:Boolean;
      
      private static var _isFirstVisit:Boolean;
      
      private static var _showVersion:Boolean;
      
      private static var _pln:String;
      
      private static var _sig:String;
      
      private static var _buildNumberServer:int;
      
      private static var _isLoggingActive:Boolean = true;
      
      private static var _showLoadingText:Boolean = false;
      
      private static var _clientInstanceHash:int;
      
      private static var _useZipXMLs:Boolean = true;
      
      private static var _useABTest:Boolean = false;
      
      private static var _cdnSubDomain:String = "content";
      
      private static var _isPrivateTestServer:Boolean = false;
      
      private static var _suk:String = "";
      
      private static var _registered:Boolean = false;
      
      private static var _sessionStartTime:Number;
      
      private static var _isFirstVisitOfGGS:Boolean = true;
      
      private static var _configUrlMaintenance:Boolean = true;
      
      private static var _currentCountryLanguageCode:String;
      
      private static var _instance:BasicEnvironmentGlobals;
      
      private static var _isCoreTest:Boolean;
      
      private static var _isCoreDev:Boolean;
      
      private static var _isCooleSpiele:Boolean;
      
      private static var _isLandingpageClient:Boolean;
      
      private static var _useVersionedFontSWF:Boolean = true;
      
      private static var _accountCookie:AccountCookie;
      
      private static var _firstLoaderURL:String;
      
      private static var _cacheBreakerInfo:CachebreakerInfoObject;
       
      
      private var _userTunnelActive:Boolean = true;
      
      private var _sessionId:String;
      
      public function BasicEnvironmentGlobals()
      {
         super();
      }
      
      public static function get instance() : BasicEnvironmentGlobals
      {
         if(!_instance)
         {
            _instance = new BasicEnvironmentGlobals();
         }
         return _instance;
      }
      
      public function initBaseUrl(param1:String) : void
      {
         this.baseURL = param1.slice(0,param1.lastIndexOf("/"));
      }
      
      public function get urlAGB() : String
      {
         return BasicConstants.uniqueAgbLink(_currentCountryLanguageCode);
      }
      
      public function get gameId() : int
      {
         return -1;
      }
      
      public function get gameTitle() : String
      {
         return "Basic";
      }
      
      public function get gameDir() : String
      {
         return this.gameTitle.toLowerCase();
      }
      
      public function get availableLanguages() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for each(_loc2_ in DictionaryUtil.getKeys(this.langVersionDict))
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get domain() : String
      {
         return "goodgamestudios.com";
      }
      
      public function get itemLibName() : String
      {
         return this.gameTitle + "ItemLib";
      }
      
      public function get buildNumberGame() : String
      {
         return null;
      }
      
      public function get versionNumberGame() : String
      {
         return null;
      }
      
      public function get versionText() : String
      {
         return "V" + this.versionNumberGame + " B" + this.buildNumberGame + (this.buildNumberServer != 0?" S" + this.buildNumberServer:"");
      }
      
      public function get versionNumberItemsXML() : String
      {
         return BasicVersions.itemXMLVersion;
      }
      
      public function get versionNumberAchievementXML() : String
      {
         return null;
      }
      
      public function get versionNumberLevelXpXML() : String
      {
         return null;
      }
      
      public function get versionDateGame() : String
      {
         return null;
      }
      
      public function get numOfItemLibs() : int
      {
         return 1;
      }
      
      public function get versionNumberItemLib1() : String
      {
         return null;
      }
      
      public function get cookieName() : String
      {
         return "Goodgame" + this.gameTitle + "_" + this.networkId;
      }
      
      public function get globalCookieSaverUrl() : String
      {
         return "http://content." + this.domain + this.cookieSaverFile;
      }
      
      public function get landingPageCookieSaverUrl() : String
      {
         return "http://media." + this.domain + this.cookieSaverFile;
      }
      
      public function get accountCookieUrl() : String
      {
         if(this.isCoreTest || this.isCoreDev)
         {
            return "http://account.goodgamestudios.com/loader-coretest/cookieTester" + this.cookieSaverFile;
         }
         return "http://account." + this.domain + this.cookieSaverFile;
      }
      
      private function get cookieSaverFile() : String
      {
         return "/CookieSaver.swf";
      }
      
      public function get gameSwfUrl() : String
      {
         return this.baseURL + "/" + this.prefix + this.gameTitle + "Game_" + this.buildNumberGame + ".swf";
      }
      
      public function get refCounterUrl() : String
      {
         var _loc1_:String = "refcount.php";
         if(this.isUsabilityTest)
         {
            return "http://files." + this.domain + "/loader" + "-usability/" + _loc1_;
         }
         if(this.isTest)
         {
            return "http://files." + this.domain + "/loader" + "-test/" + _loc1_;
         }
         return "http://files." + this.domain + "/loader" + "/" + _loc1_;
      }
      
      public function get cacheBreakerUrl() : String
      {
         var _loc2_:String = null;
         var _loc1_:String = "CacheBreakerSwf.swf";
         if(_firstLoaderURL.indexOf("filetest.ggs-hh.net") != -1)
         {
            this.isTest = true;
            _loc2_ = _firstLoaderURL.substring(0,_firstLoaderURL.lastIndexOf("/"));
            _loc2_ = _loc2_.replace("/games/","/loader/");
            _loc2_ = _loc2_ + "/" + this.prefix + this.gameTitle + _loc1_;
            _loc2_ = _loc2_.replace("filetest.ggs-hh.net","alternative-filetest.ggs-hh.net");
            return _loc2_;
         }
         if(this.isPrivateTestServer)
         {
            return "../../loader-test/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
         }
         if(this.isUsabilityTest)
         {
            return "http://alternative-files." + this.domain + "/loader" + "-usability/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
         }
         if(this.isTest)
         {
            if(this.isLocal)
            {
               return "../loader/" + this.prefix + this.gameTitle + _loc1_;
            }
            if(this.isDevTest)
            {
               return "http://alternative-files." + this.domain + "/loader" + "-dev/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
            }
            if(this.isCoreTest)
            {
               return "http://alternative-files." + this.domain + "/loader" + "-coretest/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
            }
            if(this.isCoreDev)
            {
               return "http://alternative-files." + this.domain + "/loader" + "-coredev/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
            }
            return "http://alternative-files." + this.domain + "/loader" + "-test/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
         }
         if(this.isPreClient)
         {
            return "http://" + this.cdnSubDomain + "." + this.domain + BasicConstants.PRECLIENT_FOLDER + this.prefix + this.gameTitle + _loc1_;
         }
         return "http://" + this.cdnSubDomain + "." + this.domain + "/loader" + "/" + this.gameDir + "/" + this.prefix + this.gameTitle + _loc1_;
      }
      
      public function get languageXMLUrl() : String
      {
         if(this.isTest)
         {
            return "http://files." + this.domain + "/games-languages-test/" + this.gameId + "/" + _currentCountryLanguageCode + "." + this.zipSuffix;
         }
         return "http://" + this.cdnSubDomain + "." + this.domain + "/games-languages/" + this.gameId + "/" + _currentCountryLanguageCode + "." + this.zipSuffix;
      }
      
      public function get fontSWFUrl() : String
      {
         if(this.useVersionedFontSWF)
         {
            return this.baseURL + "/fonts/" + this.gameTitle + "Fonts_" + _currentCountryLanguageCode + "_v" + this.langVersionDict[_currentCountryLanguageCode] + ".swf";
         }
         return this.baseURL + "/fonts/" + this.gameTitle + "Fonts_" + _currentCountryLanguageCode + ".swf";
      }
      
      public function get networkInfoUrl() : String
      {
         if(this.isTest || this.isLocal)
         {
            return "http://files." + this.domain + "/games-netconf-test/" + this.gameId + "/" + this.networkId + ".xml";
         }
         return "http://" + this.cdnSubDomain + "." + this.domain + "/games-netconf/" + this.gameId + "/" + this.networkId + ".xml";
      }
      
      public function get languagePropertiesUrl() : String
      {
         return this.baseURL + "/" + this.gameTitle + "LangVersion.properties";
      }
      
      public function get versionPropertiesUrl() : String
      {
         return this.baseURL + "/" + this.gameTitle + "Version.properties";
      }
      
      public function getItemSwfUrl(param1:int) : String
      {
         return this.baseURL + "/" + this.prefix + this.gameTitle + "ItemLib" + param1 + "_" + this["versionNumberItemLib" + param1] + ".swf";
      }
      
      public function get prefix() : String
      {
         return "";
      }
      
      public function get analyticsTrackingPath() : String
      {
         return "/goodgameBasic";
      }
      
      public function get gameTrackingURL() : String
      {
         return "http://files.goodgamestudios.com/loader/clienttracker.php";
      }
      
      public function get zipSuffix() : String
      {
         if(_useZipXMLs)
         {
            return "ggs";
         }
         return "xml";
      }
      
      public function get blueboxPort() : int
      {
         return 80;
      }
      
      public function get blueboxPollSpeed() : int
      {
         return 500;
      }
      
      public function get useAutoLogin() : Boolean
      {
         return false;
      }
      
      public function get useZipXMLs() : Boolean
      {
         return _useZipXMLs;
      }
      
      public function set useZipXMLs(param1:Boolean) : void
      {
         _useZipXMLs = param1;
      }
      
      public function get clientInstanceHash() : int
      {
         return _clientInstanceHash;
      }
      
      public function set clientInstanceHash(param1:int) : void
      {
         _clientInstanceHash = param1;
      }
      
      public function get showVersion() : Boolean
      {
         return _showVersion;
      }
      
      public function set showVersion(param1:Boolean) : void
      {
         _showVersion = param1;
      }
      
      public function get buildNumberServer() : int
      {
         return _buildNumberServer;
      }
      
      public function set buildNumberServer(param1:int) : void
      {
         _buildNumberServer = param1;
      }
      
      public function get minUsernameLength() : int
      {
         return _minUsernameLength;
      }
      
      public function set minUsernameLength(param1:int) : void
      {
         _minUsernameLength = param1;
      }
      
      public function get maxUsernameLength() : int
      {
         return _maxUsernameLength;
      }
      
      public function set maxUsernameLength(param1:int) : void
      {
         _maxUsernameLength = param1;
      }
      
      public function get useexternallinks() : Boolean
      {
         return _useexternallinks;
      }
      
      public function set useexternallinks(param1:Boolean) : void
      {
         _useexternallinks = param1;
      }
      
      public function get invitefriends() : Boolean
      {
         return _invitefriends;
      }
      
      public function set invitefriends(param1:Boolean) : void
      {
         _invitefriends = param1;
      }
      
      public function get loginIsKeyBased() : Boolean
      {
         return _loginIsKeyBased;
      }
      
      public function set loginIsKeyBased(param1:Boolean) : void
      {
         _loginIsKeyBased = param1;
      }
      
      public function get isFirstVisit() : Boolean
      {
         return _isFirstVisit;
      }
      
      public function set isFirstVisit(param1:Boolean) : void
      {
         _isFirstVisit = param1;
      }
      
      public function get enableFeedMessages() : Boolean
      {
         return _enableFeedMessages;
      }
      
      public function set enableFeedMessages(param1:Boolean) : void
      {
         _enableFeedMessages = param1;
      }
      
      public function get enableLonelyCow() : Boolean
      {
         return _enablelonelyCow;
      }
      
      public function set enableLonelyCow(param1:Boolean) : void
      {
         _enablelonelyCow = param1;
      }
      
      public function get requestPayByJS() : Boolean
      {
         return _requestPayByJS;
      }
      
      public function set requestPayByJS(param1:Boolean) : void
      {
         _requestPayByJS = param1;
      }
      
      public function get networkNewsByJS() : Boolean
      {
         return _networkNewsByJS;
      }
      
      public function set networkNewsByJS(param1:Boolean) : void
      {
         _networkNewsByJS = param1;
      }
      
      public function get earnCredits() : int
      {
         return _earnCredits;
      }
      
      public function set earnCredits(param1:int) : void
      {
         _earnCredits = param1;
      }
      
      public function get networkId() : int
      {
         return _network;
      }
      
      public function set networkId(param1:int) : void
      {
         _network = param1;
      }
      
      public function get presetInstanceId() : int
      {
         return _presetInstanceId;
      }
      
      public function set presetInstanceId(param1:int) : void
      {
         _presetInstanceId = param1;
      }
      
      public function get forceInstanceConnect() : Boolean
      {
         return _forceInstanceConnect;
      }
      
      public function set forceInstanceConnect(param1:Boolean) : void
      {
         _forceInstanceConnect = param1;
      }
      
      public function get defaultInstanceId() : int
      {
         return _defaultInstance;
      }
      
      public function set defaultInstanceId(param1:int) : void
      {
         _defaultInstance = param1;
      }
      
      public function get pln() : String
      {
         return _pln;
      }
      
      public function set pln(param1:String) : void
      {
         _pln = param1;
      }
      
      public function get sig() : String
      {
         return _sig;
      }
      
      public function set sig(param1:String) : void
      {
         _sig = param1;
      }
      
      public function get networknameString() : String
      {
         return _networknameString;
      }
      
      public function set networknameString(param1:String) : void
      {
         _networknameString = param1;
      }
      
      public function get hasNetworkBuddies() : Boolean
      {
         return _hasNetworkBuddies;
      }
      
      public function set hasNetworkBuddies(param1:Boolean) : void
      {
         _hasNetworkBuddies = param1;
      }
      
      public function get allowedfullscreen() : Boolean
      {
         return _allowedfullscreen;
      }
      
      public function set allowedfullscreen(param1:Boolean) : void
      {
         _allowedfullscreen = param1;
      }
      
      public function get referrer() : String
      {
         return _referrer;
      }
      
      public function set referrer(param1:String) : void
      {
         _referrer = param1;
      }
      
      public function get invitedBy() : String
      {
         return _invitedBy;
      }
      
      public function set invitedBy(param1:String) : void
      {
         _invitedBy = param1;
      }
      
      public function get accessKey() : String
      {
         return _accessKey;
      }
      
      public function set accessKey(param1:String) : void
      {
         _accessKey = param1;
      }
      
      public function get accountId() : String
      {
         return !!_accountId?_accountId:"-1";
      }
      
      public function set accountId(param1:String) : void
      {
         _accountId = param1;
      }
      
      public function get campainVars() : CampaignVars
      {
         return _campainVars;
      }
      
      public function initCampaignVars(param1:CampaignVarsVO) : void
      {
         if(!_campainVars)
         {
            _campainVars = new CampaignVars();
         }
         _campainVars.initialize(param1);
      }
      
      public function get urlVariables() : BasicURLVariables
      {
         if(!_urlVariables)
         {
            _urlVariables = new BasicURLVariables();
         }
         return _urlVariables;
      }
      
      public function get jsVariables() : BasicJSVariables
      {
         if(!_jsVariables)
         {
            _jsVariables = new BasicJSVariables();
         }
         return _jsVariables;
      }
      
      public function get flashVars() : BasicFlashVariables
      {
         if(!_flashVars)
         {
            _flashVars = new BasicFlashVariables();
         }
         return _flashVars;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function set gender(param1:String) : void
      {
         _gender = param1;
      }
      
      public function get displayName() : String
      {
         return _displayName;
      }
      
      public function set displayName(param1:String) : void
      {
         _displayName = param1;
      }
      
      public function get isTest() : Boolean
      {
         return _isTest;
      }
      
      public function set isTest(param1:Boolean) : void
      {
         _isTest = param1;
      }
      
      public function get isDevTest() : Boolean
      {
         return _isDevTest;
      }
      
      public function set isDevTest(param1:Boolean) : void
      {
         _isDevTest = param1;
         if(_isDevTest == true)
         {
            _isTest = true;
         }
      }
      
      public function get isCoreTest() : Boolean
      {
         return _isCoreTest;
      }
      
      public function set isCoreTest(param1:Boolean) : void
      {
         _isCoreTest = param1;
         if(_isCoreTest == true)
         {
            _isTest = true;
         }
      }
      
      public function get isCoreDev() : Boolean
      {
         return _isCoreDev;
      }
      
      public function set isCoreDev(param1:Boolean) : void
      {
         _isCoreDev = param1;
         if(_isCoreDev == true)
         {
            _isTest = true;
         }
      }
      
      public function get isPreClient() : Boolean
      {
         return _isPreClient;
      }
      
      public function set isPreClient(param1:Boolean) : void
      {
         _isPreClient = param1;
      }
      
      public function get isPrivateTestServer() : Boolean
      {
         return _isPrivateTestServer;
      }
      
      public function set isPrivateTestServer(param1:Boolean) : void
      {
         _isPrivateTestServer = param1;
         if(_isPrivateTestServer == true)
         {
            _isTest = true;
         }
      }
      
      public function get isLocal() : Boolean
      {
         return _isLocal;
      }
      
      public function set isLocal(param1:Boolean) : void
      {
         _isLocal = param1;
         if(_isLocal)
         {
            this.isTest = true;
         }
      }
      
      public function get distributorId() : String
      {
         return _distributorId;
      }
      
      public function set distributorId(param1:String) : void
      {
         _distributorId = param1;
      }
      
      public function get baseURL() : String
      {
         return _baseURL;
      }
      
      public function set baseURL(param1:String) : void
      {
         _baseURL = param1;
      }
      
      public function get langVersionDict() : Dictionary
      {
         return _langVersionDict;
      }
      
      public function set langVersionDict(param1:Dictionary) : void
      {
         _langVersionDict = param1;
      }
      
      public function set usePayment(param1:Boolean) : void
      {
         _usePayment = param1;
      }
      
      public function get usePayment() : Boolean
      {
         return _usePayment;
      }
      
      public function get isLoggingActive() : Boolean
      {
         return _isLoggingActive;
      }
      
      public function set isLoggingActive(param1:Boolean) : void
      {
         _isLoggingActive = param1;
      }
      
      public function get showLoadingText() : Boolean
      {
         return _showLoadingText;
      }
      
      public function set showLoadingText(param1:Boolean) : void
      {
         _showLoadingText = param1;
      }
      
      public function get useABTest() : Boolean
      {
         return _useABTest;
      }
      
      public function get abTestConfigURL() : String
      {
         return "http://" + this.cdnSubDomain + "." + this.domain + "/abFlash/config/abTests_" + this.gameId + ".xml";
      }
      
      public function get cdnSubDomain() : String
      {
         return _cdnSubDomain;
      }
      
      public function set cdnSubDomain(param1:String) : void
      {
         _cdnSubDomain = param1;
      }
      
      public function get isUsabilityTest() : Boolean
      {
         return _isUsabilityTest;
      }
      
      public function set isUsabilityTest(param1:Boolean) : void
      {
         _isUsabilityTest = param1;
      }
      
      public function get isRegistered() : Boolean
      {
         return _registered;
      }
      
      public function set isRegistered(param1:Boolean) : void
      {
         _registered = param1;
      }
      
      public function get sessionStartTime() : Number
      {
         return _sessionStartTime;
      }
      
      public function set sessionStartTime(param1:Number) : void
      {
         _sessionStartTime = param1;
      }
      
      public function get suk() : String
      {
         return _suk;
      }
      
      public function set suk(param1:String) : void
      {
         _suk = param1;
      }
      
      public function get isFirstVisitOfGGS() : Boolean
      {
         return _isFirstVisitOfGGS;
      }
      
      public function set isFirstVisitOfGGS(param1:Boolean) : void
      {
         _isFirstVisitOfGGS = param1;
      }
      
      public function get useItemXML() : Boolean
      {
         return true;
      }
      
      public function get maintenanceMode() : Boolean
      {
         return _configUrlMaintenance;
      }
      
      public function set maintenanceMode(param1:Boolean) : void
      {
         _configUrlMaintenance = param1;
      }
      
      public function get isBeta() : Boolean
      {
         return false;
      }
      
      public function get currentCountryLanguageCode() : String
      {
         return _currentCountryLanguageCode;
      }
      
      public function set currentCountryLanguageCode(param1:String) : void
      {
         _currentCountryLanguageCode = param1;
      }
      
      public function get useAwsTestTracking() : Boolean
      {
         return false;
      }
      
      public function get isCooleSpiele() : Boolean
      {
         return _isCooleSpiele;
      }
      
      public function set isCooleSpiele(param1:Boolean) : void
      {
         _isCooleSpiele = param1;
      }
      
      public function get countryConfigUrl() : String
      {
         if(this.isTest || this.isLocal)
         {
            return "http://files." + this.domain + "/games-config/country_new2.xml";
         }
         return "http://" + this.cdnSubDomain + "." + this.domain + "/games-config/country_new2.xml";
      }
      
      public function get isFacebook() : Boolean
      {
         return _network == GoodgamePartners.NETWORK_FACEBOOK;
      }
      
      public function get doUserTunnelTracking() : Boolean
      {
         if(this.isFirstVisitOfGGS || this.campainVars.isValid() && this.accountCookie != null && this.accountCookie.campaignData != null)
         {
            return true;
         }
         return false;
      }
      
      public function deactivateUserTunnelTracking() : void
      {
         this._userTunnelActive = false;
      }
      
      public function get isLandingpageClient() : Boolean
      {
         return _isLandingpageClient;
      }
      
      public function set isLandingpageClient(param1:Boolean) : void
      {
         _isLandingpageClient = param1;
      }
      
      public function get useVersionedFontSWF() : Boolean
      {
         return _useVersionedFontSWF;
      }
      
      public function set useVersionedFontSWF(param1:Boolean) : void
      {
         _useVersionedFontSWF = param1;
      }
      
      public function get accountCookie() : AccountCookie
      {
         return _accountCookie;
      }
      
      public function set accountCookie(param1:AccountCookie) : void
      {
         _accountCookie = param1;
      }
      
      public function get sessionId() : String
      {
         if(!this._sessionId)
         {
            this._sessionId = (Math.random() * uint.MAX_VALUE).toFixed();
         }
         return this._sessionId;
      }
      
      public function set firstLoaderURL(param1:String) : void
      {
         _firstLoaderURL = param1;
      }
      
      public function get cacheBreakerInfo() : CachebreakerInfoObject
      {
         if(_cacheBreakerInfo == null)
         {
            _cacheBreakerInfo = new CachebreakerInfoObject();
         }
         return _cacheBreakerInfo;
      }
      
      public function get useLegacyFontManagement() : Boolean
      {
         return true;
      }
   }
}
