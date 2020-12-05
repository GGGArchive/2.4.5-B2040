package com.goodgamestudios.basic
{
   public class EnvGlobalsHandler
   {
      
      private static var _envGlobals:IEnvironmentGlobals;
       
      
      public function EnvGlobalsHandler()
      {
         super();
      }
      
      public static function get globals() : IEnvironmentGlobals
      {
         if(_envGlobals == null)
         {
            _envGlobals = new BasicEnvironmentGlobals();
         }
         return _envGlobals;
      }
      
      public static function setEnvGlobalsClass(param1:Class) : void
      {
         _envGlobals = new param1();
      }
   }
}
