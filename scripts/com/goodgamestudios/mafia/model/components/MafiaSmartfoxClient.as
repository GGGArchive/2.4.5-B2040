package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.components.BasicSmartfoxClient;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   
   public class MafiaSmartfoxClient extends BasicSmartfoxClient
   {
       
      
      public function MafiaSmartfoxClient()
      {
         super();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
