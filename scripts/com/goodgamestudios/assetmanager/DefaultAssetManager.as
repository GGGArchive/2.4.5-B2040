package com.goodgamestudios.assetmanager
{
   import flash.utils.getDefinitionByName;
   
   public class DefaultAssetManager implements IAssetManager
   {
       
      
      public function DefaultAssetManager()
      {
         super();
      }
      
      public function doesExist(param1:Object) : Boolean
      {
         var identifier:Object = param1;
         try
         {
            this.getDefinition(identifier);
         }
         catch(error:Error)
         {
            return false;
         }
         return true;
      }
      
      public function getDefinition(param1:Object) : Object
      {
         var objDef:Object = null;
         var identifier:Object = param1;
         try
         {
            objDef = getDefinitionByName(String(identifier));
         }
         catch(e:ReferenceError)
         {
            trace("DefaultAssetManager, getDefinition() -> ERROR for identifier: " + identifier);
         }
         return objDef;
      }
      
      public function getClass(param1:String) : Class
      {
         return this.getDefinition(param1) as Class;
      }
   }
}
