package com.goodgamestudios.basic.startup
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   
   public class BasicFlashVariables
   {
       
      
      private var _flashVars:Object;
      
      public function BasicFlashVariables()
      {
         super();
      }
      
      public function readVariables(param1:Object) : void
      {
         this._flashVars = param1;
      }
      
      public function hasParameters() : Boolean
      {
         var _loc1_:* = null;
         for(_loc1_ in this._flashVars)
         {
            return true;
         }
         return false;
      }
      
      public function traceFlashVars() : void
      {
         var _loc1_:* = null;
         trace("[flashvars]");
         for(_loc1_ in this._flashVars)
         {
            trace("flashvar " + _loc1_ + " = " + this._flashVars[_loc1_]);
         }
         trace("[/flashvars]");
      }
      
      public function checkMaintenanceMode(param1:Object) : void
      {
         if(param1.ms == "off")
         {
            this.env.maintenanceMode = false;
         }
         if(param1.maintenance == "on")
         {
            this.env.maintenanceMode = true;
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return BasicEnvironmentGlobals.instance;
      }
   }
}
