package com.goodgamestudios.basic.model.proxy
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   
   public class AbstractProxy
   {
       
      
      public function AbstractProxy()
      {
         super();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
