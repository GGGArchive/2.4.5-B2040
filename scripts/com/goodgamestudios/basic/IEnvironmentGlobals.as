package com.goodgamestudios.basic
{
   import com.goodgamestudios.basic.startup.BasicFlashVariables;
   import com.goodgamestudios.basic.startup.BasicJSVariables;
   import com.goodgamestudios.basic.startup.BasicURLVariables;
   import com.goodgamestudios.cookie.AccountCookie;
   import com.goodgamestudios.marketing.google.CampaignVars;
   import com.goodgamestudios.marketing.google.CampaignVarsVO;
   import flash.utils.Dictionary;
   
   public interface IEnvironmentGlobals
   {
       
      
      function get gameId() : int;
      
      function get gameTitle() : String;
      
      function get gameDir() : String;
      
      function get domain() : String;
      
      function get buildNumberGame() : String;
      
      function get buildNumberServer() : int;
      
      function set buildNumberServer(param1:int) : void;
      
      function get versionText() : String;
      
      function get versionDateGame() : String;
      
      function get refCounterUrl() : String;
      
      function get gameSwfUrl() : String;
      
      function get cacheBreakerUrl() : String;
      
      function get languageXMLUrl() : String;
      
      function get fontSWFUrl() : String;
      
      function get networkInfoUrl() : String;
      
      function get countryConfigUrl() : String;
      
      function get languagePropertiesUrl() : String;
      
      function get versionPropertiesUrl() : String;
      
      function get prefix() : String;
      
      function get blueboxPort() : int;
      
      function get blueboxPollSpeed() : int;
      
      function get numOfItemLibs() : int;
      
      function get analyticsTrackingPath() : String;
      
      function get availableLanguages() : Array;
      
      function get globalCookieSaverUrl() : String;
      
      function get landingPageCookieSaverUrl() : String;
      
      function get accountCookieUrl() : String;
      
      function get cookieName() : String;
      
      function get urlAGB() : String;
      
      function get useAutoLogin() : Boolean;
      
      function getItemSwfUrl(param1:int) : String;
      
      function get accountId() : String;
      
      function set accountId(param1:String) : void;
      
      function get campainVars() : CampaignVars;
      
      function initCampaignVars(param1:CampaignVarsVO) : void;
      
      function get urlVariables() : BasicURLVariables;
      
      function get flashVars() : BasicFlashVariables;
      
      function get jsVariables() : BasicJSVariables;
      
      function get invitedBy() : String;
      
      function set invitedBy(param1:String) : void;
      
      function get accessKey() : String;
      
      function set accessKey(param1:String) : void;
      
      function get gender() : String;
      
      function set gender(param1:String) : void;
      
      function get displayName() : String;
      
      function set displayName(param1:String) : void;
      
      function get networkId() : int;
      
      function set networkId(param1:int) : void;
      
      function set usePayment(param1:Boolean) : void;
      
      function get usePayment() : Boolean;
      
      function get presetInstanceId() : int;
      
      function set presetInstanceId(param1:int) : void;
      
      function get defaultInstanceId() : int;
      
      function set defaultInstanceId(param1:int) : void;
      
      function get pln() : String;
      
      function set pln(param1:String) : void;
      
      function get sig() : String;
      
      function set sig(param1:String) : void;
      
      function get distributorId() : String;
      
      function set distributorId(param1:String) : void;
      
      function get referrer() : String;
      
      function set referrer(param1:String) : void;
      
      function get isTest() : Boolean;
      
      function set isTest(param1:Boolean) : void;
      
      function get isDevTest() : Boolean;
      
      function set isDevTest(param1:Boolean) : void;
      
      function set isCoreTest(param1:Boolean) : void;
      
      function get isCoreTest() : Boolean;
      
      function set isCoreDev(param1:Boolean) : void;
      
      function get isCoreDev() : Boolean;
      
      function get isBeta() : Boolean;
      
      function get isUsabilityTest() : Boolean;
      
      function set isUsabilityTest(param1:Boolean) : void;
      
      function get isPreClient() : Boolean;
      
      function set isPreClient(param1:Boolean) : void;
      
      function get isPrivateTestServer() : Boolean;
      
      function set isPrivateTestServer(param1:Boolean) : void;
      
      function get isLocal() : Boolean;
      
      function set isLocal(param1:Boolean) : void;
      
      function get langVersionDict() : Dictionary;
      
      function set langVersionDict(param1:Dictionary) : void;
      
      function get baseURL() : String;
      
      function set baseURL(param1:String) : void;
      
      function initBaseUrl(param1:String) : void;
      
      function get hasNetworkBuddies() : Boolean;
      
      function set hasNetworkBuddies(param1:Boolean) : void;
      
      function get loginIsKeyBased() : Boolean;
      
      function set loginIsKeyBased(param1:Boolean) : void;
      
      function get isFirstVisit() : Boolean;
      
      function set isFirstVisit(param1:Boolean) : void;
      
      function get useexternallinks() : Boolean;
      
      function set useexternallinks(param1:Boolean) : void;
      
      function get invitefriends() : Boolean;
      
      function set invitefriends(param1:Boolean) : void;
      
      function set minUsernameLength(param1:int) : void;
      
      function get minUsernameLength() : int;
      
      function get maxUsernameLength() : int;
      
      function set maxUsernameLength(param1:int) : void;
      
      function get networknameString() : String;
      
      function set networknameString(param1:String) : void;
      
      function get allowedfullscreen() : Boolean;
      
      function set allowedfullscreen(param1:Boolean) : void;
      
      function get enableFeedMessages() : Boolean;
      
      function set enableFeedMessages(param1:Boolean) : void;
      
      function get enableLonelyCow() : Boolean;
      
      function set enableLonelyCow(param1:Boolean) : void;
      
      function get requestPayByJS() : Boolean;
      
      function set requestPayByJS(param1:Boolean) : void;
      
      function get networkNewsByJS() : Boolean;
      
      function set networkNewsByJS(param1:Boolean) : void;
      
      function get earnCredits() : int;
      
      function set earnCredits(param1:int) : void;
      
      function get showVersion() : Boolean;
      
      function set showVersion(param1:Boolean) : void;
      
      function get forceInstanceConnect() : Boolean;
      
      function set forceInstanceConnect(param1:Boolean) : void;
      
      function get isLoggingActive() : Boolean;
      
      function set isLoggingActive(param1:Boolean) : void;
      
      function get showLoadingText() : Boolean;
      
      function set showLoadingText(param1:Boolean) : void;
      
      function get clientInstanceHash() : int;
      
      function set clientInstanceHash(param1:int) : void;
      
      function get useZipXMLs() : Boolean;
      
      function set useZipXMLs(param1:Boolean) : void;
      
      function get useABTest() : Boolean;
      
      function get abTestConfigURL() : String;
      
      function get cdnSubDomain() : String;
      
      function set cdnSubDomain(param1:String) : void;
      
      function set isRegistered(param1:Boolean) : void;
      
      function get isRegistered() : Boolean;
      
      function set sessionStartTime(param1:Number) : void;
      
      function get sessionStartTime() : Number;
      
      function get suk() : String;
      
      function set suk(param1:String) : void;
      
      function set isFirstVisitOfGGS(param1:Boolean) : void;
      
      function get isFirstVisitOfGGS() : Boolean;
      
      function get useItemXML() : Boolean;
      
      function set maintenanceMode(param1:Boolean) : void;
      
      function get maintenanceMode() : Boolean;
      
      function get currentCountryLanguageCode() : String;
      
      function set currentCountryLanguageCode(param1:String) : void;
      
      function get isCooleSpiele() : Boolean;
      
      function set isCooleSpiele(param1:Boolean) : void;
      
      function get useAwsTestTracking() : Boolean;
      
      function get isFacebook() : Boolean;
      
      function get doUserTunnelTracking() : Boolean;
      
      function deactivateUserTunnelTracking() : void;
      
      function get isLandingpageClient() : Boolean;
      
      function set isLandingpageClient(param1:Boolean) : void;
      
      function get useVersionedFontSWF() : Boolean;
      
      function set useVersionedFontSWF(param1:Boolean) : void;
      
      function get accountCookie() : AccountCookie;
      
      function set accountCookie(param1:AccountCookie) : void;
      
      function get sessionId() : String;
      
      function set firstLoaderURL(param1:String) : void;
      
      function get cacheBreakerInfo() : CachebreakerInfoObject;
      
      function get useLegacyFontManagement() : Boolean;
   }
}
