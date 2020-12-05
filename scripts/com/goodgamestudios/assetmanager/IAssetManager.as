package com.goodgamestudios.assetmanager
{
   public interface IAssetManager
   {
       
      
      function doesExist(param1:Object) : Boolean;
      
      function getDefinition(param1:Object) : Object;
      
      function getClass(param1:String) : Class;
   }
}
