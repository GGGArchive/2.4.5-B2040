package com.goodgamestudios.basic.startup
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import flash.display.Sprite;
   
   public class BasicEnvironmentDetector
   {
       
      
      public function BasicEnvironmentDetector()
      {
         super();
      }
      
      public static function detectRuntimeEnvironment(param1:Sprite, param2:IEnvironmentGlobals) : void
      {
         if(param1.loaderInfo.parameters[BasicConstants.IS_TEST_PARAMETER])
         {
            param2.isTest = Boolean(param1.loaderInfo.parameters[BasicConstants.IS_TEST_PARAMETER]);
         }
         else
         {
            param2.isTest = param1.loaderInfo.url.indexOf(BasicConstants.TEST_FOLDER) != -1;
            param2.isTest = param2.isTest || param1.loaderInfo.url.indexOf("/gamesocial-test/") != -1;
            param2.isTest = param2.isTest || param1.loaderInfo.url.indexOf("filetest.ggs-hh.net") != -1;
         }
         if(param1.loaderInfo.parameters[BasicConstants.IS_LOCALE_PARAMETER])
         {
            param2.isTest = Boolean(param1.loaderInfo.parameters[BasicConstants.IS_LOCALE_PARAMETER]);
         }
         param2.isLocal = param1.loaderInfo.url.indexOf(BasicConstants.LOCALE_URL) == 0;
         param2.isPrivateTestServer = param1.loaderInfo.url.indexOf(BasicConstants.PRIVATE_TEST_SERVER_URL) != -1;
         param2.isUsabilityTest = param1.loaderInfo.url.indexOf(BasicConstants.USABILITYTEST_FOLDER) != -1;
         param2.isPreClient = param1.loaderInfo.url.indexOf(BasicConstants.PRECLIENT_FOLDER) != -1;
         param2.isDevTest = param1.loaderInfo.url.indexOf(BasicConstants.DEV_TEST_FOLDER) != -1;
         if(param1.loaderInfo.url.indexOf(BasicConstants.CORE_TEST_FOLDER) != -1)
         {
            param2.isCoreTest = true;
         }
         if(param1.loaderInfo.url.indexOf(BasicConstants.CORE_DEV_FOLDER) != -1)
         {
            param2.isCoreDev = true;
         }
      }
   }
}
