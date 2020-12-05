package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LogOutputVO;
   import com.goodgamestudios.misc.EnhancedDate;
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   
   public class AbstractLogObject
   {
       
      
      public var logData:URLVariables;
      
      public var logOutput:LogOutputVO;
      
      public function AbstractLogObject(param1:String, param2:int, param3:int)
      {
         var logMessage:String = param1;
         var logID:int = param2;
         var logType:int = param3;
         this.logOutput = new LogOutputVO();
         super();
         this.logData = new URLVariables();
         this.logData["type"] = logType;
         this.logData["eventId"] = logID;
         if(ExternalInterface.available)
         {
            try
            {
               this.logData["http_user_agent"] = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
            }
            catch(e:Error)
            {
               trace(e.message);
            }
         }
         var dateNow:EnhancedDate = new EnhancedDate();
         this.logOutput.utcTimeStamp = dateNow.getUTCTimestamp();
         this.logOutput.logMessage = logMessage;
         this.parseMessageID(logMessage);
         this.logData["data"] = com.adobe.serialization.json.JSON.encode(this.logOutput);
      }
      
      protected function parseMessageID(param1:String) : void
      {
         var _loc2_:int = param1.indexOf("#");
         if(_loc2_ != -1)
         {
            this.logOutput.errorCode = param1.substr(_loc2_ + 1,4);
         }
      }
   }
}
