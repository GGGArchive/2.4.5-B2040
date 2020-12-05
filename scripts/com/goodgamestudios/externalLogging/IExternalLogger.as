package com.goodgamestudios.externalLogging
{
   import com.goodgamestudios.externalLogging.genericLO.AbstractLogObject;
   
   public interface IExternalLogger
   {
       
      
      function log(param1:AbstractLogObject, param2:String) : void;
   }
}
