package com.goodgamestudios.basic
{
   import br.com.stimuli.loading.BulkLoader;
   import br.com.stimuli.loading.BulkProgressEvent;
   import com.goodgamestudios.abTesting.ABTestController;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicChangeLanguageCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitAvailableCountriesCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitServerListCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicNetworkUpdateCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicProfilingTrackingCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicReloadNetworkCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicReplaceAvailableCountriesByInstanceCountriesCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicSendClientLoginTrackingCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicTrackGameLoadingSpeedCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicUsertunnelStateCommand;
   import com.goodgamestudios.basic.event.BasicAssetsEvent;
   import com.goodgamestudios.basic.event.BasicFirstVisitEvent;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.fb.connectlogin.BasicFacebookConnectCommand;
   import com.goodgamestudios.basic.fb.connectlogin.BasicInitializeFacebookConnectCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicFontData;
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.basic.model.components.BasicLoaderData;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.startup.BasicEnvironmentDetector;
   import com.goodgamestudios.basic.version.BasicVersions;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.debug.BasicDebugHud;
   import com.goodgamestudios.basic.view.firstVisit.ExtraScreenMovieClip;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.constants.GoodgamePartners;
   import com.goodgamestudios.cookie.AccountCookie;
   import com.goodgamestudios.cookie.CookieHelper;
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.genericLO.InstanceMappingErrorLO;
   import com.goodgamestudios.language.countryMapper.CountryDetectionEvent;
   import com.goodgamestudios.language.countryMapper.CountryDetectionVO;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.language.countryMapper.GGSCountryDetector;
   import com.goodgamestudios.loading.LoaderObject;
   import com.goodgamestudios.marketing.google.CampaignVarsVO;
   import com.goodgamestudios.tracking.ConnectionTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import com.goodgamestudios.tracking.WorldAssignmentTrackingEvent;
   import com.goodgamestudios.utils.BrowserUtil;
   import com.goodgamestudios.utils.TimezoneUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.SharedObject;
   import flash.net.URLLoaderDataFormat;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class BasicFrameOne extends MovieClip
   {
      
      public static const VERSION:String = "$Id: BasicFrameOne.as 4047 2012-11-28 09:09:19Z dirk.koehler $";
      
      public static const NAME:String = "BasicFrameOne";
       
      
      protected var preloaderView:BasicBackgroundComponent;
      
      protected var preloaderUpdateTimer:Timer;
      
      protected var firstVisitSreen:ExtraScreenMovieClip;
      
      private var networkCookie:SharedObject;
      
      private var _countryDetector:GGSCountryDetector;
      
      public function BasicFrameOne()
      {
         this.preloaderUpdateTimer = new Timer(100);
         super();
         Security.allowDomain("*");
         CommandController.instance.registerCommand(BasicController.COMMAND_TRACK_GAME_LOADING_SPEED,BasicTrackGameLoadingSpeedCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_USERTUNNEL_STATE,BasicUsertunnelStateCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_TRACK_LOGIN,BasicSendClientLoginTrackingCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_RELOAD_NETWORK,BasicReloadNetworkCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_UPDATE_NETWORK,BasicNetworkUpdateCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_TRACK_PROFILING,BasicProfilingTrackingCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REPLACE_AVAILABLE_COUNTRIES_BY_INSTANCE_COUNTRIES,BasicReplaceAvailableCountriesByInstanceCountriesCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CHANGE_LANGUAGE,BasicChangeLanguageCommand);
         this.initPreClientCommands();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function initPreClientCommands() : void
      {
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_COUNTRIES,BasicInitAvailableCountriesCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERLIST,BasicInitServerListCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_FACEBOOK_INITIALIZE,BasicInitializeFacebookConnectCommand);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.isAddedToStage();
         BasicDebugHud.showDebugInformationHud(stage);
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.FIRST_GAME_SCREEN);
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_COUNTRIES);
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         BasicEnvironmentDetector.detectRuntimeEnvironment(this,this.env);
         this.env.initBaseUrl(this.loaderInfo.url);
         this.env.urlVariables.readGETVariablesFromURL();
         this.env.jsVariables.readVariablesFromJavaScript();
         this.env.initCampaignVars(new CampaignVarsVO(this.env.urlVariables.urlGetParameters,getQualifiedClassName(this),CampaignVarsVO.SOURCE_URL_PARAMETER));
         this.env.networkId = !!stage.loaderInfo.parameters.network?int(int(stage.loaderInfo.parameters.network)):int(GoodgamePartners.NETWORK_GENERAL);
         this.env.presetInstanceId = !!stage.loaderInfo.parameters.instance?int(int(stage.loaderInfo.parameters.instance)):0;
         this.env.accessKey = !!stage.loaderInfo.parameters.key?stage.loaderInfo.parameters.key:"";
         this.env.gender = !!stage.loaderInfo.parameters.gender?stage.loaderInfo.parameters.gender:"";
         this.env.displayName = !!stage.loaderInfo.parameters.displayName?stage.loaderInfo.parameters.displayName:"";
         this.env.pln = !!stage.loaderInfo.parameters.pln?stage.loaderInfo.parameters.pln:"";
         this.env.sig = !!stage.loaderInfo.parameters.sig?stage.loaderInfo.parameters.sig:"";
         this.env.suk = !!stage.loaderInfo.parameters.suk?stage.loaderInfo.parameters.suk:"";
         this.env.isLandingpageClient = stage.loaderInfo.parameters.clp && stage.loaderInfo.parameters.clp == "1"?true:false;
         if(this.env.isLocal)
         {
            this.env.distributorId = "0";
            this.env.referrer = "localhost";
         }
         BasicModel.basicLoaderData = new BasicLoaderData();
         BasicModel.basicLoaderData.appLoader.loadingQueueElementStarted.add(this.handleNewLoadingElementStarted);
         BasicModel.basicLoaderData.appLoader.loadingQueueElementFinished.add(this.handleLoadingElementFinished);
         if(this.env.campainVars.isValid())
         {
            BasicModel.basicLoaderData.appLoader.addSWFLoader(BasicConstants.LANDING_PAGE_COOKIE_SAVER_LOADER,this.env.landingPageCookieSaverUrl,null,null,this.onLandingPageCookieSaverComplete);
         }
         else
         {
            BasicModel.basicLoaderData.appLoader.addSWFLoader(BasicConstants.GLOBAL_COOKIE_SAVER_LOADER,this.env.globalCookieSaverUrl,null,null,this.onGlobalCookieSaverComplete);
         }
         this.env.flashVars.checkMaintenanceMode(root.loaderInfo.parameters);
         BasicFacebookConnectCommand.gameID = this.env.gameId;
         this.isAddedToStageDone();
      }
      
      protected function isAddedToStage() : void
      {
      }
      
      protected function isAddedToStageDone() : void
      {
      }
      
      private function onLandingPageCookieSaverComplete() : void
      {
         var _loc1_:Object = null;
         var _loc2_:SharedObject = null;
         this.networkCookie = SharedObject.getLocal(this.env.cookieName,"/");
         if(this.env.isTest == false)
         {
            if(CookieHelper.isCookieEmpty(this.networkCookie))
            {
               _loc1_ = BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.LANDING_PAGE_COOKIE_SAVER_LOADER);
               _loc2_ = _loc1_.getSharedObject(this.env.cookieName);
               this.copyCookie(_loc2_);
            }
         }
         BasicModel.basicLoaderData.appLoader.addSWFLoader(BasicConstants.GLOBAL_COOKIE_SAVER_LOADER,this.env.globalCookieSaverUrl,null,null,this.onGlobalCookieSaverComplete);
      }
      
      private function onGlobalCookieSaverComplete() : void
      {
         var _loc1_:Object = null;
         var _loc2_:SharedObject = null;
         this.networkCookie = SharedObject.getLocal(this.env.cookieName,"/");
         if(this.env.isTest == false)
         {
            if(CookieHelper.isCookieEmpty(this.networkCookie))
            {
               _loc1_ = BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.GLOBAL_COOKIE_SAVER_LOADER);
               _loc2_ = _loc1_.getSharedObject(this.env.cookieName);
               this.copyCookie(_loc2_);
            }
         }
         this._countryDetector = new GGSCountryDetector();
         this._countryDetector.addEventListener(CountryDetectionEvent.LOAD_COUNTRIES_COMPLETE,this.onCountryConfigLoaded);
         this._countryDetector.loadCountryXML(this.env.countryConfigUrl);
      }
      
      private function onCountryConfigLoaded(param1:Event) : void
      {
         this.loadNetworkInfo();
      }
      
      private function loadNetworkInfo() : void
      {
         TrackingCache.getInstance().init(this.env.gameId,this.env.networkId,this.env.referrer,this.env.accountId,Capabilities.language);
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.NETWORK_INFO_LOADER,this.env.networkInfoUrl,URLLoaderDataFormat.BINARY,this.onNetworkInfoLoaded);
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.NETWORK_XML_START);
      }
      
      private function onNetworkInfoLoaded() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.NETWORK_XML_END);
         var _loc1_:XML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.NETWORK_INFO_LOADER));
         var _loc2_:XMLList = _loc1_["instances"].children();
         this.env.defaultInstanceId = parseInt(_loc1_.general.defaultinstance.text());
         this.env.allowedfullscreen = _loc1_.general.allowedfullscreen == "true"?true:false;
         this.env.networknameString = _loc1_.general.networkname.text();
         this.env.loginIsKeyBased = _loc1_.general.usekeybaselogin == "true"?true:false;
         this.env.hasNetworkBuddies = _loc1_.general.networkbuddies == "true"?true:false;
         this.env.enableFeedMessages = _loc1_.general.enablefeedmessages == "true"?true:false;
         this.env.enableLonelyCow = _loc1_.general.enablelonelycow == "true"?true:false;
         this.env.requestPayByJS = _loc1_.general.requestpaybyjs == "true"?true:false;
         this.env.networkNewsByJS = _loc1_.general.networknewsbyjs == "true"?true:false;
         this.env.earnCredits = parseInt(_loc1_.general.earncredits);
         this.env.useexternallinks = _loc1_.general.useexternallinks == "true"?true:false;
         this.env.invitefriends = _loc1_.general.invitefriends == "true"?true:false;
         this.env.maxUsernameLength = parseInt(_loc1_.general.maxusernamelength.text());
         this.env.usePayment = _loc1_.general.usepayment == "true"?true:false;
         this.env.showVersion = _loc1_.general.showversion == "true"?true:false;
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_SERVERLIST,{"serverInstances":_loc2_});
         if(this.env.presetInstanceId > 0)
         {
            this.env.forceInstanceConnect = true;
            BasicModel.instanceProxy.selectedInstanceVO = BasicModel.instanceProxy.getInstanceVOByID(this.env.presetInstanceId);
            CommandController.instance.executeCommand(BasicController.COMMAND_REPLACE_AVAILABLE_COUNTRIES_BY_INSTANCE_COUNTRIES);
         }
         ExternalLog.accountId = this.env.accountId;
         ExternalLog.gameId = this.env.gameId;
         ExternalLog.referrer = this.env.referrer;
         ExternalLog.networkId = this.env.networkId;
         this.onCookieSaverComplete();
      }
      
      private function onCookieSaverComplete() : void
      {
         if(this.env.isLocal == false)
         {
            this.env.isFirstVisit = this.isCookieEmpty(SharedObject.getLocal(this.env.cookieName,"/"));
         }
         this._countryDetector.addEventListener(CountryDetectionEvent.COUNTRY_DETECTION_COMPLETE,this.onCountryDetectionComplete);
         this.detectLanguageAndCountry();
      }
      
      private function onCountryDetectionComplete(param1:CountryDetectionEvent) : void
      {
         var _loc2_:WorldAssignmentTrackingEvent = null;
         this._countryDetector.removeEventListener(CountryDetectionEvent.COUNTRY_DETECTION_COMPLETE,this.onCountryDetectionComplete);
         if(this.env.accountId == "" || this.env.accountId == "-1")
         {
            BasicModel.basicLoaderData.appLoader.addSWFLoader(BasicConstants.ACCOUNT_COOKIE_LOADER,this.env.accountCookieUrl,null,null,this.onAccountCookieComplete);
         }
         else
         {
            this.checkForABTest();
         }
         if(!this.env.isLocal && (this.env.isFirstVisitOfGGS || this.env.campainVars.isValid()))
         {
            _loc2_ = TrackingCache.getInstance().getEvent(WorldAssignmentTrackingEvent.EVENT_ID) as WorldAssignmentTrackingEvent;
            _loc2_.accountID = this.env.accountId;
            _loc2_.currCountry = GGSCountryController.instance.currentCountry;
            _loc2_.cv = this.env.campainVars;
            TrackingCache.getInstance().sendEvent(WorldAssignmentTrackingEvent.EVENT_ID);
         }
         ExternalLog.countryCode = GGSCountryController.instance.currentCountry.ggsCountryCode;
         CommandController.instance.executeCommand(BasicController.COMMAND_TRACK_GAME_LOADING_SPEED,this.env.cacheBreakerInfo);
      }
      
      private function detectLanguageAndCountry() : void
      {
         var _loc1_:InstanceVO = BasicModel.instanceProxy.getInstanceVOByID(this.env.defaultInstanceId);
         var _loc2_:String = "default";
         if(_loc1_)
         {
            _loc2_ = _loc1_.defaultcountry;
         }
         var _loc3_:String = String(this.loaderInfo.parameters["selectedCountry"]);
         var _loc4_:String = "";
         if(_loc3_)
         {
            _loc4_ = _loc3_;
         }
         var _loc5_:CountryDetectionVO = new CountryDetectionVO(BrowserUtil.getBrowserLanguage(),Capabilities.language,TimezoneUtil.getUTCTimezoneWithoutDST(),this.networkCookie.data.country,_loc4_,_loc2_);
         this._countryDetector.detectCountry(_loc5_);
      }
      
      private function onAccountCookieComplete() : void
      {
         var cookieObject:Object = null;
         var accountCookie:AccountCookie = null;
         try
         {
            cookieObject = BasicModel.basicLoaderData.appLoader.getLoaderData("accountCookie") as Object;
            accountCookie = new AccountCookie(cookieObject.getSharedObject("GGSAccount"));
            this.env.accountId = accountCookie.accountId;
            this.env.isFirstVisitOfGGS = accountCookie.isNewAccount;
            this.env.accountCookie = accountCookie;
            ExternalLog.isFirstVisitOfGGS = accountCookie.isNewAccount;
            if(accountCookie)
            {
               this.env.initCampaignVars(new CampaignVarsVO(accountCookie.campaignData,getQualifiedClassName(this),CampaignVarsVO.SOURCE_ACCOUNT_COOKIE));
            }
         }
         catch(e:Error)
         {
         }
         this.checkForABTest();
      }
      
      private function checkForABTest() : void
      {
         if(this.env.useABTest)
         {
            this.loadABTestConfig();
         }
         else
         {
            this.loadItemVersionXML();
         }
      }
      
      protected function loadItemVersionXML() : void
      {
         if(this.env.useItemXML)
         {
            BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.ITEM_XML_VERSION,this.env.versionPropertiesUrl,URLLoaderDataFormat.BINARY,this.onVersionPropertiesLoaded);
         }
         else
         {
            this.onVersionPropertiesLoaded();
         }
      }
      
      private function loadABTestConfig() : void
      {
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.AB_CONFIG_LOADER,this.env.abTestConfigURL,URLLoaderDataFormat.BINARY,this.onABConfigLoaded);
      }
      
      private function onABConfigLoaded() : void
      {
         var _loc2_:int = 0;
         var _loc1_:XML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.AB_CONFIG_LOADER));
         if(this.networkCookie.data.playerID)
         {
            _loc2_ = int(this.networkCookie.data.playerID);
         }
         else
         {
            _loc2_ = -1;
         }
         ABTestController.instance.initialize(_loc1_,this.env.gameId,this.env.presetInstanceId,this.env.networkId,this.env.accountId,_loc2_,this.env.referrer);
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_ABTEST);
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.ITEM_XML_VERSION,this.env.versionPropertiesUrl,URLLoaderDataFormat.BINARY,this.onVersionPropertiesLoaded);
      }
      
      private function onVersionPropertiesLoaded() : void
      {
         var _loc1_:String = null;
         this.initFonts();
         if(this.env.useItemXML)
         {
            _loc1_ = BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.ITEM_XML_VERSION).toString();
            BasicVersions.itemXMLVersion = _loc1_.substr(_loc1_.indexOf("=") + 1);
         }
         this.createView();
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.LOADING_BAR);
         this.preloaderView.showProgressBar();
         addChild(this.preloaderView.disp);
         this.preloaderUpdateTimer.addEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
         this.preloaderUpdateTimer.start();
         this.preloaderView.show();
         this.preloaderView.showVersion();
         this.preloaderView.updatePosition();
         this.onLanguagePropertiesLoaded();
      }
      
      private function onLanguagePropertiesLoaded() : void
      {
         this.preselectInstance();
         this.initLanguage();
      }
      
      private function preselectInstance() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<InstanceVO> = null;
         var _loc3_:InstanceVO = null;
         var _loc4_:String = null;
         if(this.env.presetInstanceId == 0)
         {
            _loc2_ = BasicModel.instanceProxy.getInstancesForActualCountry();
            if(_loc2_.length > 0)
            {
               _loc3_ = _loc2_[0];
               if(_loc3_.isInternationalInstance)
               {
                  _loc1_ = this.env.defaultInstanceId;
               }
               else
               {
                  _loc1_ = _loc3_.instanceId;
               }
               BasicModel.instanceProxy.selectedInstanceVO = BasicModel.instanceProxy.getInstanceVOByID(_loc1_);
            }
            else
            {
               if(GGSCountryController.instance.currentCountry)
               {
                  _loc4_ = GGSCountryController.instance.currentCountry.toString();
               }
               ExternalLog.logger.log(new InstanceMappingErrorLO(_loc4_,InstanceMappingErrorLO.NO_INSTANCES_FOR_CURRENT_COUNTRY_FOUND),NAME);
               return;
            }
         }
      }
      
      private function initFonts() : void
      {
         this.initFontModel();
         BasicLanguageFontManager.getInstance().initalize(BasicModel.fontData);
      }
      
      protected function initFontModel() : void
      {
         BasicModel.fontData = new BasicFontData();
      }
      
      protected function initLanguage() : void
      {
         BasicModel.languageData = new BasicLanguageData();
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         BasicModel.languageData.loadLanguage();
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.LANG_XML_START);
      }
      
      protected function onLanguageXMLComplete(param1:LanguageDataEvent) : void
      {
         var savedCookie:SharedObject = null;
         var event:LanguageDataEvent = param1;
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.LANG_XML_END);
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         this.showFirstScreen();
         if(this.loaderInfo.bytesLoaded != this.loaderInfo.bytesTotal)
         {
            BasicModel.basicLoaderData.appLoader.addLoaderInfoObject(BasicConstants.BASIC_FRAME_ONE_LOADER,this.loaderInfo);
         }
         else if(this.loaderInfo.url == this.env.globalCookieSaverUrl)
         {
            try
            {
               savedCookie = (this.loaderInfo.content as Object).getSharedObject("Goodgame" + this.env.gameTitle);
               this.copyCookie(savedCookie);
            }
            catch(e:Error)
            {
            }
         }
         if(this.env.useItemXML)
         {
            CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.ITEM_XML_START);
            this.loadXMLs();
         }
         else
         {
            this.loadAssets();
         }
         BasicModel.basicLoaderData.appLoader.addQueueEndElement(BasicConstants.APP_LOADER,this.loadingQueueAppLoaderFinished);
      }
      
      protected function showFirstScreen() : void
      {
      }
      
      protected final function initFirstVisitScreen(param1:ExtraScreenMovieClip) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.AVATAR_CREATION_STARTED);
         this.firstVisitSreen = param1;
         this.firstVisitSreen.addEventListener(BasicFirstVisitEvent.AVATARCREATION_FINISHED,this.onFirstVisitAvatarCreationFinished);
         addChild(this.firstVisitSreen.disp);
         setChildIndex(this.preloaderView.disp,0);
         this.preloaderView.hideProgressBar();
         this.additionalFirstVisitScreenInitalization(param1);
      }
      
      protected function additionalFirstVisitScreenInitalization(param1:ExtraScreenMovieClip) : void
      {
      }
      
      private function onFirstVisitAvatarCreationFinished(param1:BasicFirstVisitEvent) : void
      {
         removeChild(this.firstVisitSreen.disp);
         this.firstVisitSreen.removeEventListener(BasicFirstVisitEvent.AVATARCREATION_FINISHED,this.onFirstVisitAvatarCreationFinished);
         this.firstVisitSreen = null;
         if(BasicModel.basicLoaderData.appLoader.hasQueEndElementFinished(BasicConstants.APP_LOADER))
         {
            this.goToSecondFrame();
         }
         else
         {
            this.preloaderView.showProgressBar();
         }
      }
      
      private function loadingQueueAppLoaderFinished(param1:String = "") : void
      {
         this.preloaderUpdateTimer.stop();
         this.preloaderUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.GAME_SWF_LOADED);
         this.checkForFirstVisitScreen();
      }
      
      protected function checkForFirstVisitScreen() : void
      {
         if(!this.firstVisitSreen)
         {
            this.goToSecondFrame();
         }
      }
      
      private final function isCookieEmpty(param1:SharedObject) : Boolean
      {
         var _loc2_:* = null;
         for(_loc2_ in param1.data)
         {
            return false;
         }
         return true;
      }
      
      protected function createView() : void
      {
      }
      
      protected function get mainGameClassName() : String
      {
         return "com.goodgamestudios.basic.BasicGame";
      }
      
      private function onBulkLoaderProgress(param1:BulkProgressEvent) : void
      {
         this.preloaderView.updateLoadingProgress(int(param1.percentLoaded * 100));
      }
      
      private function handleNewLoadingElementStarted(param1:String, param2:String) : void
      {
         var _loc3_:LoaderObject = null;
         if(this.preloaderView && this.preloaderView.disp && this.preloaderView.disp.visible)
         {
            if(param1 == BasicModel.basicLoaderData.appLoader.loaderID)
            {
               _loc3_ = BasicModel.basicLoaderData.appLoader.getLoaderObject(param2);
            }
            if(_loc3_)
            {
               if(_loc3_.totalBytes > BasicConstants.MAX_FILESIZE_REALTIMELOADING)
               {
                  this.preloaderUpdateTimer.stop();
                  this.preloaderUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
                  this.preloaderView.startProgressBar();
               }
               else
               {
                  this.preloaderView.stopProgressBar();
                  if(!this.preloaderUpdateTimer.running)
                  {
                     this.preloaderUpdateTimer.addEventListener(TimerEvent.TIMER,this.onUpdatePreloaderView);
                     this.preloaderUpdateTimer.start();
                  }
                  this.preloaderView.updateLoadingText(param2);
               }
            }
         }
      }
      
      private function onUpdatePreloaderView(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         if(BasicModel.basicLoaderData.appLoader.isLoading || BasicModel.basicLoaderData.assetLoader.isRunning)
         {
            _loc2_ = 0;
            if(BasicModel.basicLoaderData.appLoader.isLoading)
            {
               _loc2_ = BasicModel.basicLoaderData.appLoader.getProgressOfActualSubloader();
            }
            if(this.preloaderView && this.preloaderView.disp && this.preloaderView.disp.visible)
            {
               this.preloaderView.updateLoadingProgress(int(_loc2_ * 100));
            }
         }
      }
      
      protected function handleLoadingElementFinished(param1:String, param2:String) : void
      {
         if(this.preloaderView)
         {
            this.preloaderView.updateLoadingProgress(100);
         }
      }
      
      protected function goToSecondFrame(param1:Event = null) : void
      {
         var GameClass:Class = null;
         var event:ConnectionTrackingEvent = null;
         var game:DisplayObject = null;
         var e:Event = param1;
         try
         {
            nextFrame();
            GameClass = Class(getDefinitionByName(this.mainGameClassName));
            if(GameClass)
            {
               event = TrackingCache.getInstance().getEvent(ConnectionTrackingEvent.EVENT_ID) as ConnectionTrackingEvent;
               BasicModel.basicLoaderData.downloadRateFrameOne = BasicModel.basicLoaderData.appLoader.calculateDataRate().toString();
               if(event != null)
               {
                  event.downloadRate = BasicModel.basicLoaderData.downloadRateFrameOne;
               }
               game = new GameClass(this.preloaderView) as DisplayObject;
               addChild(game);
            }
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      protected function loadXMLs() : void
      {
      }
      
      protected final function itemXMLComplete() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.ITEM_XML_END);
         this.loadAssets();
      }
      
      protected function loadAssets() : void
      {
         BasicModel.basicLoaderData.assetLoader.addEventListener(BulkLoader.PROGRESS,this.onBulkLoaderProgress);
         BasicModel.basicLoaderData.assetLoader.addEventListener(BulkLoader.COMPLETE,this.handleAssetLoaderComplete);
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.ASSETS_START);
         this.loadAdditionalAssets();
         var _loc1_:LoaderContext = new LoaderContext();
         _loc1_.applicationDomain = ApplicationDomain.currentDomain;
         var _loc2_:int = 1;
         while(_loc2_ <= this.env.numOfItemLibs)
         {
            BasicModel.basicLoaderData.assetLoader.add(this.env.getItemSwfUrl(_loc2_),{
               "id":"itemLib" + _loc2_,
               "context":_loc1_
            });
            _loc2_++;
         }
         BasicModel.basicLoaderData.assetLoader.start();
      }
      
      private function handleAssetLoaderComplete(param1:Event) : void
      {
         BasicModel.basicLoaderData.assetLoader.removeEventListener(BulkLoader.COMPLETE,this.handleAssetLoaderComplete);
         BasicModel.basicLoaderData.assetLoader.removeEventListener(BulkLoader.PROGRESS,this.onBulkLoaderProgress);
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.ASSETS_END);
         BasicModel.basicLoaderData.dispatchEvent(new BasicAssetsEvent(BasicAssetsEvent.ASSETS_COMPLETE));
      }
      
      protected function loadAdditionalAssets() : void
      {
      }
      
      private function copyCookie(param1:SharedObject) : void
      {
         var property:String = null;
         var externalCookie:SharedObject = param1;
         if(externalCookie)
         {
            for(property in externalCookie.data)
            {
               this.networkCookie.data[property] = externalCookie.data[property];
            }
            try
            {
               CookieHelper.checkAndSaveStatus(this.networkCookie);
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
