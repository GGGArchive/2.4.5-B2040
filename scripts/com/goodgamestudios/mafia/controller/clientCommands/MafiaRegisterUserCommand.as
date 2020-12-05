package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.controller.clientCommands.BasicRegisterUserCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.tracking.BasicTrackingStringComposer;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class MafiaRegisterUserCommand extends BasicRegisterUserCommand
   {
       
      
      public function MafiaRegisterUserCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = param1 as Array;
         var _loc3_:String = _loc2_.shift();
         var _loc4_:String = _loc2_.shift();
         var _loc5_:String = _loc2_.shift();
         var _loc6_:String = _loc2_.shift();
         var _loc7_:int = _loc2_.shift();
         var _loc8_:Array = [_loc3_,_loc4_,_loc5_,this.env.referrer,GGSCountryController.instance.currentCountry.ggsLanguageCode,this.env.distributorId,this.env.accountId,_loc6_,_loc7_,this.env.campainVars.partnerId,this.env.campainVars.creative,this.env.campainVars.lp,this.env.campainVars.aid,BasicTrackingStringComposer.composeVarDataForRegistration(_loc4_,this.env.referrer)];
         trace("regParams: " + _loc8_);
         BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_REGISTER,_loc8_,BasicSmartfoxConstants.S2C_REGISTER);
         MafiaModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
         BasicModel.userData.loginPwd = _loc5_;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
