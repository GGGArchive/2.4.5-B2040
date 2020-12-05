package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitServerListCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.proxy.InstanceVOProxy;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   
   public class MafiaInitServerListCommand extends BasicInitServerListCommand
   {
       
      
      public function MafiaInitServerListCommand()
      {
         super();
      }
      
      override protected function initAdditionalServer() : void
      {
         var _loc1_:InstanceVOProxy = null;
         if(EnvGlobalsHandler.globals.isTest || EnvGlobalsHandler.globals.isLocal || EnvGlobalsHandler.globals.isDevTest)
         {
            _loc1_ = BasicModel.instanceProxy;
            _loc1_.addInstance(this.createInstanceVO("95.211.105.35",443,"MafiaEx",false,0,"QA-TEST"));
            _loc1_.addInstance(this.createInstanceVO("95.211.105.35",443,"MafiaExVZ",false,0,"VZ-QA-TEST"));
            _loc1_.addInstance(this.createInstanceVO("95.211.60.104",443,"MafiaExBeta",false,99,"BETA"));
            _loc1_.addInstance(this.createInstanceVO("localhost",9339,"MafiaEx",false,-7,"localhost"));
            _loc1_.addInstance(this.createInstanceVO("10.16.0.20",9339,"MafiaEx",false,-2,"DEV"));
            _loc1_.addInstance(this.createInstanceVO("10.16.0.21",9339,"MafiaEx",false,-10,"Flash"));
            _loc1_.addInstance(this.createInstanceVO("10.0.6.14",9339,"MafiaEx",false,-12,"Mafia-DEV-Matthias"));
            _loc1_.addInstance(this.createInstanceVO("10.0.6.21",9339,"MafiaEx",false,-9,"Mafia-DEV-Martin"));
            _loc1_.addInstance(this.createInstanceVO("10.0.6.49",9339,"MafiaEx",false,-4,"Mafia-DEV-Ole"));
            _loc1_.addInstance(this.createInstanceVO("10.0.6.18",9339,"MafiaEx",false,-5,"Mafia-DEV-Chingiz"));
         }
      }
      
      private function createInstanceVO(param1:String, param2:int, param3:String, param4:Boolean, param5:int, param6:String) : InstanceVO
      {
         var _loc7_:InstanceVO = null;
         _loc7_ = new InstanceVO();
         _loc7_.ip = param1;
         _loc7_.port = param2;
         _loc7_.zone = param3;
         _loc7_.maintenance = param4;
         _loc7_.instanceId = param5;
         _loc7_.serverName = param6;
         _loc7_.isTestServer = true;
         return _loc7_;
      }
   }
}
