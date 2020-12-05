package com.goodgamestudios.assetmanager
{
   public class AssetManager
   {
      
      private static var _manager:IAssetManager;
       
      
      public function AssetManager()
      {
         super();
      }
      
      public static function get manager() : IAssetManager
      {
         if(AssetManager._manager == null)
         {
            AssetManager._manager = new DefaultAssetManager();
         }
         return _manager;
      }
      
      public static function set manager(param1:IAssetManager) : void
      {
         _manager = param1;
      }
   }
}
